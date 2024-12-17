import 'dart:convert';
import 'dart:typed_data';

import 'package:balap_in/api/api_service_laporan.dart';
import 'package:balap_in/api/api_service_rekomendasi.dart';
import 'package:balap_in/models/model_rekomendasi.dart';
import 'package:balap_in/screens/lapor.dart';
import 'package:flutter/material.dart';

class IsiRekomendasiScreen extends StatefulWidget {
  const IsiRekomendasiScreen({super.key});

  @override
  _IsiRekomendasiScreenState createState() => _IsiRekomendasiScreenState();
}

class _IsiRekomendasiScreenState extends State<IsiRekomendasiScreen> {
  late int? idrekomendasi;

  @override
  Widget build(BuildContext context) {
    final int idrekomendasi = ModalRoute.of(context)?.settings.arguments as int;
    final apiService = ApiServiceRekomendasi();

    return FutureBuilder <Rekomendasi>(
      future: apiService.fetchDetailRekomendasi(idrekomendasi),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (!snapshot.hasData) {
          return const Center(
            child: Text('Tidak ada detail Rekomendasi'),
          );
        } else {
        
        final datarekomendasi = snapshot.data!;
        final cluster = datarekomendasi.laporan!.cluster!;

        String? jenisconvert;

        jenisconvert = datarekomendasi.laporan!.jenis;

        if (jenisconvert == 'jalan') {
          jenisconvert = 'Jalan Rusak';
        } else if (jenisconvert == 'lampu_jalan') {
          jenisconvert = 'Lampu Jalan Rusak';
        } else if (jenisconvert == 'jembatan') {
          jenisconvert = 'Jembatan Rusak';
        }

        return Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            leading: IconButton(
              onPressed: () {
                 Navigator.of(context).pop();
              }, 
              icon: const Icon(Icons.keyboard_arrow_left),
              color: const Color.fromRGBO(5, 5, 5, 0.612),
              iconSize: 40,),
              titleSpacing: 0,
              title: SizedBox(
              width: 320,
              child: FittedBox(
                  child: Text(
                datarekomendasi.laporan!.judul.toString(),
                style: const TextStyle(
                color: Color.fromRGBO(5, 5, 5, 0.612),
                fontFamily: 'Poppins',
                fontWeight: FontWeight.bold,
                fontSize: 18,
                 shadows: [Shadow(
                  offset: Offset(1.0, 6.0),
                  blurRadius: 10,
                  color: Colors.black26,
                      ),
                      ]
                    ),
                  ),
                )
              )
          ),
          body: Stack(
            children: [
              Positioned(
                top: -50, 
                left: -75,
                child: Container(
                  width: 250,
                  height: 250,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF7E0E0),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
        
              SingleChildScrollView(
              child: Center(
                child: Column(
                  children: [
            
                    //KODE TEXT KATEGORI
                    Padding(
                      padding: const EdgeInsets.only(
                      top: 20
                      ),
                    child: SizedBox(
                      width: 380,
                      height: 20,
                      child: Text('Kategori: ${jenisconvert}',
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 9
                        ),
                        ),
                      ),
                    ),
            
                    //KODE TEKS ALAMAT
                    Padding(
                      padding: const EdgeInsets.only(
                      bottom: 15
                      ),
                    child: SizedBox(
                      width: 380,
                      height: 30,
                      child: Text( datarekomendasi.peta!.alamat,
                      style: const TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 9
                        ),
                        ),
                      ),
                    ),
            
                    //KODE TEKS DOKUMENTASI LAPORAN
                    const Padding(
                      padding: EdgeInsets.only(
                      ),
                    child: SizedBox(
                      width: 380,
                      height: 17,
                      child: Text('Dokumentasi Laporan',
                      style: TextStyle(
                        fontFamily: "Poppins",
                        fontSize: 9
                        ),
                        ),
                      ),
                    ),
                    
                    //KODE GARIS BATAS TEKS DOKUMENTASI LAPORAN DENGAN GAMBAR
                    const SizedBox(
                      height: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            child: Divider(
                              color: Colors.black,
                              thickness: 1.5,
                            )
                          )
                        ],
                      ),
                    ),
            
                    //KODE GAMBAR DOKUMENTASI LAPORAN
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12
                        ),
                      child: FutureBuilder(
                        future: ApiServiceLaporan().getClusterLaporan(cluster),
                        builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.waiting) {
                          return const Center(child: CircularProgressIndicator(),);
                        } else if(!snapshot.hasData || snapshot.data == null) {
                          return const Center(child: Text('Tidak ada data tersedia'));
                        } else {
                        final datacluster = snapshot.data!;

                        return SizedBox(
                        width: 380,
                        child: Wrap(
                          spacing: 9.0,
                          runSpacing: 12.0, 
                          children: List.generate(datacluster.length, (index) {
                            
                            Uint8List gambar = base64Decode(datacluster[index].gambar!);
                            
                            return InkWell(
                              onTap: () {
                                Navigator.pushNamed(context, '/isilapor', arguments: datacluster[index].idlaporan);
                              },
                              child: SizedBox(
                                width: 185,
                                height: 110,
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image(
                                    image: MemoryImage(gambar) 
                                    ),
                                ),
                              ),
                            );
                          }),
                        ),
                       );
                       }
                       }
                      ),
                    )
            
            
                  ],
                ),
              ),
            ),
            ]
          ),
        
        );
      }
      }
    );
  }
}