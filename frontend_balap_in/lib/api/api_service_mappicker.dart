// Nama File: api_service_mappicker.dart
// Deskripsi: File ini berfungsi untuk menangani layanan konversi latitude dan longitude menjadi alamat dan lainnya (geocode)
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Nov 10, 2024

import 'package:dio/dio.dart';

class ApiServiceMappicker {
  final dio = Dio();
  

  Future buatPeta(pickedLocation) async {
    
    final lat = pickedLocation.latitude;
    final lon = pickedLocation.longitude;
    
    Response getGeoLocation = await dio.get(
      'https://nominatim.openstreetmap.org/reverse?format=geojson&lat=$lat&lon=$lon'
      );

    final jalan = getGeoLocation.data['features'][0]['properties']['address']['road'];
    final alamat = getGeoLocation.data['features'][0]['properties']['display_name'];

    try {
      return {
        "alamat" : alamat,
        "jalan" : jalan,
        "latitude" : lat,
        "longitude" : lon,
      };
      
      // final response = await dio.post(
      //   'http://10.0.2.2:8000/laporan/buat',
      //   data: dataMap
      //   );

      // if (response.statusCode == 200) {
      //   print('Peta berhasil dibuat');
      // } else {
      //   print('Gagal membuat peta');
      // }

    } catch (e) {
      'Error $e';
    }
  }

}