// Nama File: shimmerhomewidget.dart
// Deskripsi: File ini berfungsi untuk menampilkan efek loading pada halaman laporan atau halaman utama
// Dibuat oleh: Farhan Ramadhan - NIM: 3312301105
// Tanggal: Dec 29, 2024


import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmerhomewidget extends StatefulWidget {
  const Shimmerhomewidget({super.key});

  @override
  State<Shimmerhomewidget> createState() => _ShimmerhomewidgetState();
}

class _ShimmerhomewidgetState extends State<Shimmerhomewidget> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 350,
      child: ListView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: 4,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                height: 115,
                width: 340,
                color: Colors.grey[200]!,
                child: Row(
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[100]!,
                          child: Container(
                            color: Colors.grey[400]!,
                            width: 170,
                            height: 20,
                            margin: const EdgeInsets.only(
                              left: 10,
                              top: 15,
                              right: 10
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            right: 90
                          ),
                          child: SizedBox(
                            width: 80,
                            height: 20,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[400]!,
                                width: 80,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: SizedBox(
                            width: 170,
                            height: 10,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[400]!,
                                width: 80,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                          ),
                          child: SizedBox(
                            width: 170,
                            height: 10,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[400]!,
                                width: 80,
                                height: 20,
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                            top: 5,
                            right: 70
                          ),
                          child: SizedBox(
                            width: 100,
                            height: 10,
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                color: Colors.grey[400]!,
                                width: 100,
                                height: 10,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Container(
                          color: Colors.grey[400]!,
                          height: 100,
                          width: 150,
                          margin: const EdgeInsets.only(
                            top: 2,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
        ),
    );
  }
}