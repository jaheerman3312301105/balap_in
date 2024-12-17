import 'package:balap_in/models/model_pengguna.dart';

import 'model_peta.dart';

class LaporanResponse {
  final List<Laporan>? laporan;
  final String? dominantjenis;

  LaporanResponse({
    this.laporan,
    this.dominantjenis
  });

  factory LaporanResponse.fromJson(Map<String, dynamic> json) {
    return LaporanResponse(
      laporan:  (json['laporan'] as List)
          .map((item) => Laporan.fromJson(item))
          .toList(), 
      dominantjenis: json['dominant_jenis'],);
  }
}

class Laporan {
  
  final int idlaporan;
  final String? gambar;
  final String? jenis; 
  final String? judul;     
  final String? deskripsi;
  final double? persentase;
  final String? cuaca;  
  final String status;   
  final String tgllapor;
  final num? tingkaturgent;
  final Peta? peta;
  final Pengguna? pengguna;
  final int? cluster;


  Laporan({
    required this.idlaporan,
    required this.gambar,
    required this.jenis,
    required this.judul,
    required this.deskripsi,
    required this.persentase,
    required this.cuaca,
    required this.status,
    required this.tgllapor,
    required this.tingkaturgent,
    required this.peta,
    required this.pengguna,
    required this.cluster
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      idlaporan: json['id_laporan'],
      gambar: json['gambar'],
      jenis: json['jenis'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      persentase: json['persentase'], 
      cuaca: json['cuaca'],
      status: json['status'],
      tgllapor: json['tgl_lapor'],
      tingkaturgent: json['tingkat_urgent'],
      peta: json['id_peta'] != null ? Peta.fromJson(json['id_peta']) : null,
      pengguna: json['id_pengguna'] != null ? Pengguna.fromJson(json['id_pengguna']) : null,
      cluster: json['cluster'],
    );
  }
}
