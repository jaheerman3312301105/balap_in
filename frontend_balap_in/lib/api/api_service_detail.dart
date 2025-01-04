// Nama File: api_service_detail.dart
// Deskripsi: File ini berfungsi untuk menangani layanan data detail dari laporan
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Nov 10, 2024

import 'package:balap_in/api/host.dart';
import 'package:dio/dio.dart';
import 'package:balap_in/models/model_laporan.dart';

class DetailApiService {
  Future<Laporan> fetchLaporan(int id) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('$host/laporan/$id');

      if (response.statusCode == 200) {
        final data = response.data; 
        return Laporan.fromJson(data); 
      } else {
        throw Exception('Failed to load laporan');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
