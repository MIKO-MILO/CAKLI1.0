class VoucherModel {
  final String id;
  final String discountAmount;
  final String usagePeriod;
  final bool isActive;
  final String description;

  VoucherModel({
    required this.id,
    required this.discountAmount,
    required this.usagePeriod,
    required this.isActive,
    required this.description,
  });
}