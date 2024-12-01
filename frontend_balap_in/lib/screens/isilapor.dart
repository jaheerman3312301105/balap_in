import 'dart:convert';
import 'dart:typed_data';

import 'package:balap_in/api/api_service_detail.dart';
import 'package:balap_in/models/model_laporan.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IsilaporScreen extends StatelessWidget {
  final int? idLaporan;
  const IsilaporScreen({Key? key, this.idLaporan}) : super(key: key);

  
  @override
  Widget build(BuildContext context) {
    final int id = idLaporan ?? ModalRoute.of(context)?.settings.arguments as int;
    final apiService = DetailApiService();

    return FutureBuilder<Laporan>(
      future: apiService.fetchLaporan(id), 
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator(),);
        } else if (!snapshot.hasData) {
          return const Center(child: Text('Detail laporan tidak ada'),);
        } else {
          final laporan = snapshot.data!;

              final tgllaporformat = DateTime.parse(laporan.tgllapor);
              
              String formattedDate = DateFormat('dd MMMM yyyy').format(tgllaporformat);
              
              Uint8List gambar = base64Decode(laporan.gambar!);

              return MaterialApp(
              debugShowCheckedModeBanner: false,
              home: Scaffold(
                extendBodyBehindAppBar: true,
                appBar: AppBar(
                systemOverlayStyle: const SystemUiOverlayStyle(
                  statusBarColor: Colors.white,
                  statusBarIconBrightness: Brightness.dark,
                ),
                backgroundColor: Colors.transparent,
                titleSpacing: 0,
                leading: IconButton(
                  onPressed: () {
                    Navigator.of(context).popUntil((route) => route.isFirst);
                  }, 
                  icon: const Icon(Icons.keyboard_arrow_left),
                  color: const Color.fromRGBO(5, 5, 5, 0.612),
                  iconSize: 40,),
                  title: SizedBox(
                    child: Row(
                      children: [
                        Text.rich(
                          TextSpan(
                            text: laporan.judul,
                            style: const TextStyle(
                              color: Color.fromRGBO(5, 5, 5, 0.612),
                              fontFamily: "Poppins",
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              shadows: [Shadow(
                                offset: Offset(1.0, 6.0),
                                blurRadius: 10,
                                color: Colors.black26,
                              ),
                              ]
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                body: Stack(
                  children: 
                  [
                    Positioned(
                    top: -40, 
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

                    Padding(
                        padding: EdgeInsets.only(
                          top: MediaQuery.of(context).size.height * 0.097
                        ), 
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            
                            Container(
                              width: double.infinity, 
                              height: 200, 
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(8), 
                                boxShadow: [
                                  BoxShadow(
                                    color:
                                        Colors.black.withOpacity(0.3), 
                                    blurRadius: 10,
                                    offset: const Offset(0, 4), 
                                  ),
                                ],
                              ),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(8), 
                                child: Image(
                                  image: MemoryImage(
                                    gambar
                                  ),
                                  fit: BoxFit.cover,
                                  )
                              ),
                            ),
                            const SizedBox(height: 16),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                laporan.deskripsi!,
                                style: const TextStyle(
                                  fontFamily: 'Poppins', 
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                laporan.peta!.alamat,
                                style: const TextStyle(
                                  fontFamily: 'Poppins', 
                                  fontSize: 16,
                                ),
                              ),
                            ),
                            const SizedBox(height: 8),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: 16.0),
                              child: Text(
                                "Dilaporkan: $formattedDate",
                                style: const TextStyle(
                                  fontFamily: 'Poppins', 
                                  fontSize: 14,
                                  color: Colors.grey,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                  ]
                ),
              ),
            );
            }

        }
      );
  }
}