class Pengguna {
    final int idPengguna;
    final String token;
    final String tglpengguna;


    Pengguna({
        required this.idPengguna,
        required this.token,
        required this.tglpengguna
    });
    
    factory Pengguna.fromJson(Map<String, dynamic> json) {
        return Pengguna(
            idPengguna: json['id_pengguna'], 
            token: json['token'],
            tglpengguna: json['tgl_pengguna']
        );
    }
}