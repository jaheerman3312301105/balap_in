// Nama File: model_rekomendasi.dart
// Deskripsi: File ini berfungsi untuk menampilkan marker lokasi dan menampilkan detail lokasi dan menyimpan data lokasi
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal:  Dec 22, 2024

import 'package:balap_in/models/model_peta.dart';

class Rekomendasi {
  final int idrekomendasi;
  final String? statusurgent;
  final int? jumlahlaporan;
  final LaporanRekomendasi? laporan; 
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
      laporan: json['id_laporan'] != null ? LaporanRekomendasi.fromJson(json['id_laporan']) : null,
      peta: json['id_peta'] != null ? Peta.fromJson(json['id_peta']) : null,
    );
  }
}

class LaporanRekomendasi {
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

  LaporanRekomendasi({
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

  factory LaporanRekomendasi.fromJson(Map<String, dynamic> json) {
    return LaporanRekomendasi(
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
