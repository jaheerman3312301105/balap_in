import 'dart:convert';
import 'dart:typed_data';

import 'package:balap_in/screens/homepage.dart';
import 'package:flutter/material.dart';
import 'package:balap_in/api/api_service_laporan.dart';
import 'package:balap_in/models/model_laporan.dart';

class HomeWidget extends StatelessWidget {
  final int selectedChipAnalisisIndex;
  final String searchController;
  HomeWidget({Key? key, required this.selectedChipAnalisisIndex, required this.searchController}) : super(key: key);
  
  @override
  Widget build(BuildContext context) {
    final apiService = ApiServiceLaporan();
    return FutureBuilder<LaporanResponse>(
      future: apiService.fetchLaporan(selectedChipAnalisisIndex, searchController), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (snapshot.data!.laporan!.length == 0) {
          return const Center(child: Text('Tidak ada laporan'),);
        } else {
          List<Laporan> laporanList = snapshot.data!.laporan!;
          
          return SizedBox(
            width: 350,
            child: ListView.builder(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              itemCount: laporanList.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
              final laporan = laporanList[index];

              if (laporan.status == 'selesai') {
                Uint8List gambar = base64Decode(laporan.gambar!);
              final int idLaporan = laporan.idlaporan;
              String jenislaporan = '';
            
              if (laporan.jenis == 'jalan') {
                jenislaporan = "Jalan Rusak";
              }else if(laporan.jenis == 'lampu_jalan') {
                jenislaporan = "Lampu Jalan Rusak";
              }else if(laporan.jenis == 'jembatan') {
                jenislaporan = "Jembatan Rusak";
              }
            
              return InkWell(
                onTap: () {
                  Navigator.pushNamed(
                    context, 
                    '/isilapor',
                    arguments: idLaporan);
                },
                child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 5),
                child: Container(
                  height: 115,
                  width: 340,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 250, 204, 204),
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: const [
                        BoxShadow(
                        offset: Offset(1.0, 5.0),
                        blurRadius: 5.0, 
                        color: Colors.black26, 
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start, 
                        children: <Widget>[
                          Container(
                            width: 170,
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 15,
                            ),
                            child: Text(
                              laporan.judul!,
                              style: const TextStyle(
                                fontSize: 8,
                                fontFamily: "Poppins",
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            width: 170,
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                            ),
                            child: Text(
                              jenislaporan,
                              style: const TextStyle(
                                fontSize: 8,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                          Container(
                            width: 170,
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 5,
                            ),
                            child: Text(
                              laporan.peta!.alamat,
                              style: const TextStyle(
                                fontSize: 8,
                                fontFamily: "Poppins",
                              ),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        child: Container(
                          margin: const EdgeInsets.only(
                            left: 1, 
                            right: 5
                            ),
                          height: 100,
                          width: 150,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            image: DecorationImage(
                              image: MemoryImage(gambar),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                ),
              );
              } else {
                return SizedBox.shrink();
              }
            } 
            ),
          );
        }
        
      }
      );
  }
} 