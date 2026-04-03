import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:latlong2/latlong.dart';
import 'package:http/http.dart' as http;
import 'package:material_symbols_icons/symbols.dart';
import 'package:get/get.dart';
import 'package:cakli/app/routes/app_pages.dart';

import '../controllers/tambahalamat_controller.dart';

class TambahalamatView extends GetView<TambahalamatController> {
  const TambahalamatView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFEBE8E8),
      body: Stack(
        children: [
          Positioned.fill(child: MapView()),
          Positioned(
            left: 20,
            top: MediaQuery.of(context).padding.top * 6,
            child: ButtonBack(),
          ),
          BottomView(), // 🔥 LANGSUNG TANPA COLUMN / CONTAINER
        ],
      ),
    );
  }
}

class _HeaderedClient extends http.BaseClient {
  final Map<String, String> headers;
  final http.Client _inner = http.Client();

  _HeaderedClient(this.headers);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers.addAll(headers);
    return _inner.send(request);
  }
}

class MapView extends StatelessWidget {
  const MapView({super.key});

  @override
  Widget build(BuildContext context) {
    return FlutterMap(
      options: MapOptions(
        initialCenter: LatLng(-7.96662, 112.632632),
        initialZoom: 9.2,
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.cakli.app',
          tileProvider: NetworkTileProvider(
            httpClient: _HeaderedClient({'User-Agent': 'com.cakli.app/1.0'}),
          ),
        ),
        RichAttributionWidget(
          attributions: [
            TextSourceAttribution('OpenStreetMap contributors', onTap: () {}),
          ],
        ),
      ],
    );
  }
}

class BottomView extends StatelessWidget {
  const BottomView({super.key});

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.6,
      minChildSize: 0.6,
      maxChildSize: 0.6,
      builder: (context, scrollController) {
        return Container(
          alignment: Alignment.center,
          padding: const EdgeInsets.only(
            left: 20,
            right: 20,
            top: 0,
            bottom: 0,
          ), // 👈 pindah ke sini
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
          ),
          child: ListView(
            controller: scrollController,
            padding: EdgeInsets.only(top: 20),
            children: const [
              SizedBox(height: 10),
              TextTittle(),
              SizedBox(height: 20),
              SeacrhButton(),
              SizedBox(height: 20),
              ContainerAdress(),
              SizedBox(height: 20),
              FormField(),
              SizedBox(height: 20),
              ButtonSubmit(),
            ],
          ),
        );
      },
    );
  }
}

class TextTittle extends StatelessWidget {
  const TextTittle({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      "Tambah Alamat",
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
      textAlign: TextAlign.left,
    );
  }
}

class SeacrhButton extends StatelessWidget {
  const SeacrhButton({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Get.toNamed(Routes.SETLOKASI);
      },
      borderRadius: BorderRadius.circular(30),
      child: Container(
        height: 56,
        padding: const EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xFFCFCFCF), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            const Icon(
              Symbols.circle_circle,
              fill: 1,
              color: Color(0xFFF36200),
            ),
            const SizedBox(width: 12),
            const Expanded(
              child: Text(
                "Cari lokasi tujuan",
                style: TextStyle(color: Colors.grey, fontSize: 16),
              ),
            ),
            const Icon(Symbols.search),
          ],
        ),
      ),
    );
  }
}

class ContainerAdress extends StatelessWidget {
  const ContainerAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        border: Border.all(color: Color(0xFFCFCFCF), width: 1),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ICON + TEXT BLOCK
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(Icons.location_on, color: Color(0xFFD46A2E), size: 28),
              const SizedBox(width: 12),
              AdressContainerAdress(),
            ],
          ),

          const SizedBox(height: 20),

          TextFieldAddPatokan(),
        ],
      ),
    );
  }
}

class AdressContainerAdress extends StatelessWidget {
  const AdressContainerAdress({super.key});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SMKN 4 Malang",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 6),

          Text(
            "Jl. Tanimbar No. 22 Lorem Ipsum dolor sit Amet "
            "blablaskdkjieygdyt Curabitur ut finibus metus, "
            "aliquet tempus sem.",
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
        ],
      ),
    );
  }
}

class TextFieldAddPatokan extends StatelessWidget {
  const TextFieldAddPatokan({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 3),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          border: Border.all(color: Color(0xFFCFCFCF), width: 1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              blurRadius: 5,
              offset: const Offset(0, 2),
            ),
          ],
        ),
      child: TextField(
        decoration: InputDecoration(
          contentPadding: EdgeInsets.symmetric(horizontal: 70),
          hintText: "Tambah Patokan",
          prefixIcon: Icon(
            Symbols.personal_places,
            fill: 1,
            color: Color(0xFFF36200),
          ),
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }
}

class FormField extends StatelessWidget {
  const FormField({super.key});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: "pecfel pak muls",
      style: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: Colors.black87,
      ),
      decoration: InputDecoration(
        label: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              "Nama Alamat",
              style: TextStyle(fontSize: 18, color: Colors.black54),
            ),
            SizedBox(width: 4),
            Text("*", style: TextStyle(color: Colors.red)),
          ],
        ),
        floatingLabelBehavior: FloatingLabelBehavior.always,
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.black),
        ),
      ),
    );
  }
}

class ButtonSubmit extends StatelessWidget {
  const ButtonSubmit({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: TextButton(
        onPressed: () {
          Get.toNamed(Routes.EDITALAMAT);
        },
        style: TextButton.styleFrom(
          backgroundColor: const Color(0xFFE04D04),
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: const Text(
          'Simpan',
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}

class ButtonBack extends StatelessWidget {
  const ButtonBack({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(),
      elevation: 4,
      child: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () {
          Get.back();
        },
      ),
    );
  }
}
