import 'package:balap_in/screens/lapor.dart';
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

  Future<void> buatLaporan(String judul, jenis, deskripsi, status, persentase, cuaca) async {
    if (jenis == 'Jalan') {
      jenis = 'jalan';
    } else if (jenis == 'Lampu Jalan') {
      jenis = 'lampu_jalan';
    } else if (jenis == 'Jembatan') {
      jenis = 'jembatan';
    }

    persentase = persentase/100;

    if (cuaca == 'Cerah') {
      cuaca = 'cerah';
    } else if (cuaca == 'Hujan') {
      cuaca = 'hujan';
    }

    try {
      final data = {
        "gambar": null,
        "jenis": jenis,
        "judul": judul,
        "deskripsi": deskripsi,
        "persentase": persentase,
        "cuaca": cuaca,
        "status": status,
        "tingkat_urgent": null,
        "id_pengguna": null,
        "id_peta": null,
    };

      print(data);

      final response = await dio.post(
        '/',
        data: data,
      );

      if (response.statusCode == 201) {
        print('Laporan berhasil dibuat');
      } else {
        print('Gagal membuat laporan');
      }
    } catch (e) {
      print('Error: $e');
    }
  }
  
}
