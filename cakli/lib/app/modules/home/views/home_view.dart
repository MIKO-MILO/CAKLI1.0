import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'package:get/get.dart';
import 'package:latlong2/latlong.dart';

import '../controllers/home_controller.dart';

class HomeView extends GetView<HomeController> {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3E3E3),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            SvgPicture.asset(
              'assets/images/home/ilustrasi.svg',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),

            Positioned(
              top: 200, // atur sesuai kebutuhan
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Mau ke mana, Aul ?',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 32,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 245, // atur sesuai kebutuhan
              left: 0,
              right: 0,
              child: Center(
                child: Text(
                  'Jl Gadang omah e uztazah',
                  style: TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 20,
                    fontWeight: FontWeight.w400,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            Positioned(
              top: 300, // atur sesuai kebutuhan
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  width: 350,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                  ),

                  child: Expanded(
                    child: FlutterMap(
                      options: MapOptions(
                        initialCenter: LatLng(-6.200000, 106.816666),
                        initialZoom: 14,
                      ),
                      children: [
                        TileLayer(
                          urlTemplate:
                              'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                          userAgentPackageName: 'com.example.app',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
