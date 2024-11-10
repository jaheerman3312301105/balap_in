import 'dart:convert';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:balap_in/api/api_service_laporan.dart';
import 'package:balap_in/models/model_laporan.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final apiService = ApiServiceLaporan();

    return FutureBuilder<List<Laporan>>(
      future: apiService.fetchLaporan(), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text('Tidak ada laporan'),);
        } else {
          List<Laporan> laporanList = snapshot.data!;

          return ListView.builder(
            shrinkWrap: true,
            itemCount: laporanList.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
            final laporan = laporanList[index];

            Uint8List gambar = base64Decode(laporan.gambar);
            
            String jenislaporan = '';

            if (laporan.jenis == 'jalan') {
              jenislaporan = "Jalan Rusak";
            }else if(laporan.jenis == 'lampu_jalan') {
              jenislaporan = "Lampu Jalan Rusak";
            }else if(laporan.jenis == 'jembatan') {
              jenislaporan = "Jembatan Rusak";
            }

            return Padding(
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
                          laporan.judul,
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
                        child: const Text(
                          'Jl. Sudirman No.3, Sukajadi, Kec. Batam Kota, Kota Batam, Kepulauan Riau 29432',
                          style: TextStyle(
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
                        image: const DecorationImage(
                          image: AssetImage('assets/images/jalan.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
          }
          );
        }
        
      }
      );
  }
} 