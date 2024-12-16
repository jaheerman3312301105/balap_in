import 'package:dio/dio.dart';
import 'package:balap_in/models/model_rekomendasi.dart';

class ApiServiceRekomendasi {
  final Dio _dio = Dio();

  Future<List<Rekomendasi>> fetchRekomendasi() async {
    try {
      Response response = await _dio.get('http://10.0.2.2:8000/rekomendasi/');

      if (response.statusCode == 200) {
        final data = response.data as List;
        return data.map((item) => Rekomendasi.fromJson(item)).toList();
      } else {
        throw Exception('Failed to fetch recommendations: ${response.statusCode}');
      }
    } catch (e) {
      throw Exception('Error fetching data: $e');
    }
  }
}
