import 'package:cakli/app/modules/voucher/views/voucher_view.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:cakli/app/modules/voucher/model/voucher_model.dart';

class VoucherController extends GetxController {
  final RxString voucherCode = ''.obs;
  final TextEditingController textController = TextEditingController();

  final RxList<VoucherModel> vouchers = <VoucherModel>[
    VoucherModel(
      id: '1',
      discountAmount: 'Rp 5.000',
      usagePeriod: 'Digunakan Juni 1 - 4',
      isActive: true,
      description:
          'Voucher diskon hingga Rp 5.000 untuk pemesanan layanan. '
          'Berlaku untuk semua jenis layanan selama periode Juni 1 - 4. '
          'Tidak dapat digabungkan dengan promo lain.',
    ),
    VoucherModel(
      id: '2',
      discountAmount: 'Rp 5.000',
      usagePeriod: 'Digunakan Juni 1 - 4',
      isActive: false,
      description:
          'Voucher diskon hingga Rp 5.000 untuk pemesanan layanan. '
          'Berlaku untuk semua jenis layanan selama periode Juni 1 - 4. '
          'Tidak dapat digabungkan dengan promo lain.',
    ),
  ].obs;

  void showVoucherDetail(VoucherModel voucher) {
    Get.dialog(
      VoucherDetailDialog(voucher: voucher),
      barrierDismissible: true,
    );
  }

  @override
  void onClose() {
    textController.dispose();
    super.onClose();
  }
}
