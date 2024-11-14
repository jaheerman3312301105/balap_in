import 'package:dio/dio.dart';
import 'package:balap_in/models/model_laporan.dart';

class DetailApiService {
  Future<Laporan> fetchLaporan(int id) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get('http://10.0.2.2:8000/laporan/$id');

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
