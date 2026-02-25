import 'package:flutter/material.dart';
import 'package:material_symbols_icons/symbols.dart';
import 'package:get/get.dart';

import '../controllers/carialamat_controller.dart';

class CarialamatView extends GetView<CarialamatController> {
  const CarialamatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      appBar: AppBar(
        title: const Text('Cari Alamat'),
        backgroundColor: const Color(0xFFEBE8E8),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),

          /// TEXTFIELD (pakai padding)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: TextField(
              decoration: InputDecoration(
                contentPadding: const EdgeInsets.symmetric(
                  vertical: 18,
                  horizontal: 20,
                ),
                hintText: "Cari lokasi tujuan",
                prefixIcon: const Icon(
                  Icons.location_on,
                  color: Color(0xFFD46A2E),
                ),
                suffixIcon: const Icon(Symbols.search),
                filled: true,
                fillColor: Colors.white,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),

          const SizedBox(height: 24),

          /// ROW TOMBOL (pakai padding)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Row(
              children: [
                Expanded(
                  child: _buildRoundedButton(
                    icon: Symbols.map,
                    iconColor: Colors.blue,
                    text: "Pilih lewat peta",
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: _buildRoundedButton(
                    icon: Symbols.my_location,
                    iconColor: const Color(0xFFD46A2E),
                    text: "Lokasimu sekarang",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),

          /// ✅ Divider FULL LAYAR
          const Divider(thickness: 1, color: Colors.grey),
        ],
      ),
    );
  }

  Widget _buildRoundedButton({
    required IconData icon,
    required Color iconColor,
    required String text,
  }) {
    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: iconColor, fill: 1),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }
}
