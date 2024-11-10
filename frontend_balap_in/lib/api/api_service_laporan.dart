import 'package:dio/dio.dart';
import '../models/model_laporan.dart';  


class ApiServiceLaporan {
  final dio = Dio();

  Future<List<Laporan>>fetchLaporan() async {
    try {
      Response response = await dio.get('http://10.0.2.2:8000/laporan/');
      if (response.statusCode == 200) {
        List data = response.data;
        return data.map((json) => Laporan.fromJson(json)).toList();
      } else {
        throw Exception("gagal memberikan data laporan");
      }
    } catch (e) {
      throw Exception("gagal mengambil data laporan: $e");
    }
  }
} 
  

