import 'package:cakli/app/modules/voucher/model/voucher_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../controllers/voucher_controller.dart';

class VoucherView extends GetView<VoucherController> {
  const VoucherView({super.key});
  @override
  Widget build(BuildContext context) {
    Get.put(VoucherController());

    return Scaffold(
      backgroundColor: Color(0xFFE04D04),
      appBar: CustomAppBar(title: 'Voucher'),
      body: MasterView(),
    );
  }
}

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final VoidCallback? onBackPressed;
  final List<Widget>? actions;

  const CustomAppBar({
    super.key,
    required this.title,
    this.onBackPressed,
    this.actions,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      bottom: false,
      child: Container(
        height: preferredSize.height,
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: const Offset(0, 2),
              blurRadius: 4,
            ),
          ],
          color: Color(0xFFE04D04),
        ),
        child: Column(
          children: [
            Row(
              children: [
                // Tombol Back
                IconButton(
                  onPressed: onBackPressed ?? () => Navigator.of(context).pop(),
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
                // Title
                Expanded(
                  child: Text(
                    title,
                    style: GoogleFonts.poppins(
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
                // Actions (opsional)
                if (actions != null) ...actions!,
              ],
            ),
            TextBox(),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(120);
}

class TextBox extends StatelessWidget {
  const TextBox({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VoucherController());
    return Container(
      color: const Color(0xFFD84315),
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
      child: TextField(
        controller: controller.textController,
        onChanged: (value) => controller.voucherCode.value = value,
        style: GoogleFonts.poppins(fontSize: 14),
        decoration: InputDecoration(
          hintText: 'Masukkan Kode Voucher',
          hintStyle: GoogleFonts.poppins(color: Colors.grey[400], fontSize: 14),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 12,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: const BorderSide(color: Color(0xFFD84315), width: 1.5),
          ),
        ),
      ),
    );
  }
}

class MasterView extends StatelessWidget {
  const MasterView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VoucherController());
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Obx(
        () => ListView.builder(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          itemCount: controller.vouchers.length,
          itemBuilder: (context, index) {
            final voucher = controller.vouchers[index];
            return VoucherCard(
              voucher: voucher,
              onMenuTap: () => controller.showVoucherDetail(voucher),
            );
          },
        ),
      ),
    );
  }
}

class VoucherCard extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback onMenuTap;

  const VoucherCard({
    super.key,
    required this.voucher,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(14, 12, 14, 12),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ImageView(voucher: voucher, onMenuTap: onMenuTap),
          const SizedBox(width: 14),

          Expanded(
            // 👈 WAJIB ADA
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // TOP ROW
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Expanded(child: TextTop()), // 👈 dorong icon ke kanan
                    IconRight(voucher: voucher, onMenuTap: onMenuTap),
                  ],
                ),

                const SizedBox(height: 0),

                // NOMINAL
                TextMountVoucher(voucher: voucher, onMenuTap: onMenuTap),

                const SizedBox(height: 10),

                // PERIOD (pojok kanan bawah)
                Align(
                  alignment: Alignment.centerRight,
                  child: TextPeriodVoucher(
                    voucher: voucher,
                    onMenuTap: onMenuTap,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class VoucherDetailDialog extends StatelessWidget {
  final VoucherModel voucher;
  const VoucherDetailDialog({super.key, required this.voucher});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(
                  Icons.confirmation_number_outlined,
                  color: Color(0xFFD84315),
                  size: 22,
                ),
                const SizedBox(width: 8),
                Text(
                  'Detail Voucher',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: Color(0xFF212121),
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => Get.back(),
                  child: const Icon(Icons.close, size: 20, color: Colors.grey),
                ),
              ],
            ),
            const Divider(height: 20),
            _InfoRow(label: 'Diskon Hingga', value: voucher.discountAmount),
            const SizedBox(height: 8),
            _InfoRow(label: 'Periode', value: voucher.usagePeriod),
            const SizedBox(height: 8),
            _InfoRow(
              label: 'Status',
              value: voucher.isActive ? 'Aktif' : 'Tidak Aktif',
              valueColor: voucher.isActive
                  ? const Color(0xFF388E3C)
                  : const Color(0xFF9E9E9E),
            ),
            const SizedBox(height: 12),
            Text(
              'Syarat & Ketentuan',
              style: GoogleFonts.poppins(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              voucher.description,
              style: GoogleFonts.poppins(
                fontSize: 12.5,
                color: Color(0xFF757575),
                height: 1.5,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => Get.back(),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFD84315),
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Text(
                  'Tutup',
                  style: GoogleFonts.poppins(fontWeight: FontWeight.w600),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;
  final Color? valueColor;

  const _InfoRow({required this.label, required this.value, this.valueColor});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 90,
          child: Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 12.5,
              color: Color(0xFF9E9E9E),
            ),
          ),
        ),
        Text(
          ':  ',
          style: GoogleFonts.poppins(fontSize: 12.5, color: Color(0xFF9E9E9E)),
        ),
        Expanded(
          child: Text(
            value,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: valueColor ?? const Color(0xFF212121),
            ),
          ),
        ),
      ],
    );
  }
}

class ImageView extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback onMenuTap;

  const ImageView({super.key, required this.voucher, required this.onMenuTap});

  @override
  Widget build(BuildContext context) {
    final Image logo = voucher.isActive
        ? Image.asset('assets/images/logo.png', width: 5, height: 5)
        : Image.asset('assets/images/logobw.png', width: 5, height: 5);

    return SizedBox(
      width: 92,
      height: 92,
      child: Container(
        decoration: BoxDecoration(
          color: const Color(0xFFF1F1F1),
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(10),
        child: logo,
      ),
    );
  }
}

class TextTop extends StatelessWidget {
  const TextTop({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Diskon Hingga',
      style: GoogleFonts.poppins(
        fontSize: 13,
        color: Colors.grey[600],
        fontWeight: FontWeight.w400,
      ),
    );
  }
}

class TextMountVoucher extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback onMenuTap;

  const TextMountVoucher({
    super.key,
    required this.voucher,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color amountColor = voucher.isActive
        ? const Color(0xFF212121)
        : const Color(0xFF9E9E9E);
    return Text(
      voucher.discountAmount,
      style: GoogleFonts.poppins(
        fontSize: 30,
        fontWeight: FontWeight.w700,
        color: amountColor,
      ),
    );
  }
}

class TextPeriodVoucher extends StatelessWidget {
  final VoucherModel voucher;
  final VoidCallback onMenuTap;

  const TextPeriodVoucher({
    super.key,
    required this.voucher,
    required this.onMenuTap,
  });

  @override
  Widget build(BuildContext context) {
    final Color periodColor = voucher.isActive
        ? const Color(0xFFD84315)
        : const Color(0xFF9E9E9E);
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          Symbols.access_time_rounded,
          size: 12,
          color: periodColor,
          fill: 1,
        ),
        const SizedBox(width: 4),
        Text(
          voucher.usagePeriod,
          style: GoogleFonts.poppins(
            fontSize: 11,
            color: periodColor,
            fontWeight: FontWeight.w700,
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }
}

class IconRight extends StatelessWidget {
  const IconRight({super.key, required this.voucher, required this.onMenuTap});

  final VoucherModel voucher;
  final VoidCallback onMenuTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onMenuTap,
      child: const Icon(Symbols.more_horiz, size: 20, weight: 900),
    );
  }
}
