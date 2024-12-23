import 'package:dio/dio.dart';
import 'package:balap_in/models/model_notifikasi.dart';

class ApiServiceNotifikasi {
  final Dio _dio = Dio();

  Future<List<Notifikasi>> fetchNotifikasi() async {
    try{
      Response response = await _dio.get('http://10.0.2.2:8000/notifikasi/');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((item) => Notifikasi.fromJson(item)).toList();
      } else {
        throw Exception('Gagal mendapatkan Notifikasi: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error notifikasi:, $e');
    }
  }
}