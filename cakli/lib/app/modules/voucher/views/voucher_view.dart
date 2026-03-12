import 'package:cakli/app/modules/voucher/model/voucher_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:material_symbols_icons/material_symbols_icons.dart';

import '../controllers/voucher_controller.dart';

class VoucherView extends GetView<VoucherController> {
  const VoucherView({super.key});
  @override
  Widget build(BuildContext context) {
    final controller = Get.put(VoucherController());

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F5),
      appBar: AppBar(
        backgroundColor: const Color(0xFFD84315),
        foregroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Get.back(),
        ),
        title: const Text(
          'Voucher',
          style: TextStyle(
            color: Colors.white,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Container(
            color: const Color(0xFFD84315),
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 20),
            child: TextField(
              controller: controller.textController,
              onChanged: (value) => controller.voucherCode.value = value,
              style: const TextStyle(fontSize: 14),
              decoration: InputDecoration(
                hintText: 'Masukkan Kode Voucher',
                hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
                filled: true,
                fillColor: Colors.white,
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(6),
                  borderSide: const BorderSide(
                    color: Color(0xFFD84315),
                    width: 1.5,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: Obx(
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
    final Color amountColor = voucher.isActive
        ? const Color(0xFF212121)
        : const Color(0xFF9E9E9E);
    final Color periodColor = voucher.isActive
        ? const Color(0xFFD84315)
        : const Color(0xFF9E9E9E);

    final Image logo = voucher.isActive
        ? Image.asset('assets/images/logo.png', width: 5, height: 5)
        : Image.asset('assets/images/logobw.png', width: 5, height: 5);

    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(14, 12, 8, 12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon
            SizedBox(
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
            ),
            const SizedBox(width: 14),

            // Text content
            Expanded(
              child: SizedBox(
                height: 95,
                child: Center(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Diskon Hingga',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey[600],
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                      Text(
                        voucher.discountAmount,
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w900,
                          color: amountColor,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // Three-dot menu
            Align(
              alignment: Alignment.topRight,
              child: SizedBox(
                height: 92, // samakan dengan tinggi icon box kiri
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      width: 25,
                      height: 10,
                      child: IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        icon: const Icon(Symbols.more_horiz, size: 20, weight: 900, fill: 1,),
                        color: Colors.grey[600],
                        onPressed: onMenuTap,
                      ),
                    ),

                   const Spacer(),

                    Row(
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
                          style: TextStyle(
                            fontSize: 11,
                            color: periodColor,
                            fontWeight: FontWeight.w900,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
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
                const Text(
                  'Detail Voucher',
                  style: TextStyle(
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
            const Text(
              'Syarat & Ketentuan',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
                color: Color(0xFF424242),
              ),
            ),
            const SizedBox(height: 4),
            Text(
              voucher.description,
              style: const TextStyle(
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
                child: const Text(
                  'Tutup',
                  style: TextStyle(fontWeight: FontWeight.w600),
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
            style: const TextStyle(fontSize: 12.5, color: Color(0xFF9E9E9E)),
          ),
        ),
        Text(
          ':  ',
          style: const TextStyle(fontSize: 12.5, color: Color(0xFF9E9E9E)),
        ),
        Expanded(
          child: Text(
            value,
            style: TextStyle(
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
