import 'package:balap_in/models/model_peta.dart';

class Rekomendasi {
  final int idrekomendasi;
  final String? statusurgent;
  final int? jumlahlaporan;
  final Laporan? laporan; 
  final Peta? peta;

  Rekomendasi({
    required this.idrekomendasi,
    required this.statusurgent,
    required this.jumlahlaporan,
    required this.laporan,
    required this.peta,
  });

  factory Rekomendasi.fromJson(Map<String, dynamic> json) {
    return Rekomendasi(
      idrekomendasi: json['id_rekomendasi'],
      statusurgent: json['status_urgent'],
      jumlahlaporan: json['jumlah_laporan'],
      laporan: json['id_laporan'] != null ? Laporan.fromJson(json['id_laporan']) : null,
      peta: json['id_peta'] != null ? Peta.fromJson(json['id_peta']) : null,
    );
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
  final int? cluster;
  final int? idpengguna;
  final int? idpeta;

  Laporan({
    required this.idlaporan,
    this.gambar,
    this.jenis,
    this.judul,
    this.deskripsi,
    this.persentase,
    this.cuaca,
    required this.status,
    required this.tgllapor,
    this.tingkaturgent,
    this.cluster,
    this.idpengguna,
    this.idpeta,
  });

  factory Laporan.fromJson(Map<String, dynamic> json) {
    return Laporan(
      idlaporan: json['id_laporan'],
      gambar: json['gambar'],
      jenis: json['jenis'],
      judul: json['judul'],
      deskripsi: json['deskripsi'],
      persentase: json['persentase']?.toDouble(),
      cuaca: json['cuaca'],
      status: json['status'],
      tgllapor: json['tgl_lapor'],
      tingkaturgent: json['tingkat_urgent'],
      cluster: json['cluster'],
      idpengguna: json['id_pengguna'],
      idpeta: json['id_peta'],
    );
  }
}
