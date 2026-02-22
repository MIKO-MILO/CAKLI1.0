import 'dart:convert';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:http/http.dart' as http;
import 'package:latlong2/latlong.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {
  var count = 0.obs;
  var searchQuery = ''.obs;
  var searchResults = <Map<String, dynamic>>[].obs;
  var center = LatLng(-7.9553, 112.6280).obs;

  /// 🔥 Data Lokasi Reactive
  var locations = [
    {"title": "Jl. Gadang Gg. 12A", "subtitle": "Lorem Ipsum"},

    {"title": "Jl. Gadang Gg. 15A", "subtitle": "Lorem Ipsum"},

    {"title": "Jl. Gadang Gg. 19A", "subtitle": "Lorem Ipsum"},

    {"title": "Jl. Gadang Gg. 19A", "subtitle": "SMKN 4 MALANG"},
  ].obs;

  @override
  void onReady() {
    super.onReady();
    FlutterNativeSplash.remove();
  }

  void increment() => count.value++;

  Future<void> searchPlaces(String query) async {
    searchQuery.value = query;
    if (query.trim().isEmpty) {
      searchResults.clear();
      return;
    }
    final uri = Uri.https('nominatim.openstreetmap.org', '/search', {
      'q': query,
      'format': 'json',
      'addressdetails': '1',
      'limit': '10',
      'countrycodes': 'id',
    });
    try {
      final resp = await http.get(
        uri,
        headers: {'User-Agent': 'com.cakli.app/1.0'},
      );
      if (resp.statusCode == 200) {
        final data = json.decode(resp.body) as List<dynamic>;
        searchResults.value = data
            .map(
              (e) => {
                'title': e['display_name'] ?? '',
                'lat': e['lat'],
                'lon': e['lon'],
              },
            )
            .toList();
      } else {
        searchResults.clear();
      }
    } catch (_) {
      searchResults.clear();
    }
  }

  void selectPlace(Map<String, dynamic> place) {
    final lat = double.tryParse(place['lat'].toString()) ?? 0;
    final lon = double.tryParse(place['lon'].toString()) ?? 0;
    center.value = LatLng(lat, lon);
    final title = place['title']?.toString() ?? 'Lokasi';
    locations.insert(0, {'title': title, 'subtitle': 'Hasil pencarian'});
  }
}
