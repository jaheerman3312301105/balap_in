class Peta {

  final int idpeta;
  final String alamat;
  final String jalan;
  final double latitude;
  final double longitude;

  Peta({
    required this.idpeta,
    required this.alamat,
    required this.jalan,
    required this.latitude,
    required this.longitude,
  });

  factory Peta.fromJson(Map<String, dynamic> json) {
    return Peta(
      idpeta: json['id_peta'],
      alamat: json['alamat'],
      jalan: json['jalan'],
      latitude: json['latitude'],
      longitude: json['longitude']
      );
  }

}