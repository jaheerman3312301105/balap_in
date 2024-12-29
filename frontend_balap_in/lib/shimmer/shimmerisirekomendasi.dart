import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class Shimmerisirekomendasi extends StatefulWidget {
  const Shimmerisirekomendasi({super.key});

  @override
  State<Shimmerisirekomendasi> createState() => _ShimmerisirekomendasiState();
}

class _ShimmerisirekomendasiState extends State<Shimmerisirekomendasi> {
  @override
  Widget build(BuildContext context) {
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
        title: Shimmer.fromColors(
              baseColor: Colors.grey[400]!,
              highlightColor: Colors.grey[100]!,
              child: Container(
                color: Colors.grey[400]!,
                width: MediaQuery.of(context).size.width * 0.8,
                height: MediaQuery.of(context).size.height * 0.02, 
              ),
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
                Padding(
                      padding: const EdgeInsets.only(
                      top: 15,
                      right: 130
                      ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[400]!,
                        width: 250,
                        height: 15,
                        ),
                    ),
                  ),
                Padding(
                      padding: const EdgeInsets.only(
                      top: 10,
                      ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[400]!,
                        width: 380,
                        height: 15,
                        ),
                    ),
                ),
               Padding(
                      padding: const EdgeInsets.only(
                      top: 5,
                      right: 260
                      ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[400]!,
                        width: 120,
                        height: 15,
                        ),
                    ),
                ),

                Padding(
                      padding: const EdgeInsets.only(
                      top: 10,
                      bottom: 10,
                      right: 260
                      ),
                    child: Shimmer.fromColors(
                      baseColor: Colors.grey[400]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        color: Colors.grey[400]!,
                        width: 120,
                        height: 15,
                        ),
                    ),
                ),
                
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

                Padding(
                      padding: const EdgeInsets.only(
                        top: 12,
                        bottom: 12
                        ),

                        child:  SizedBox(
                        width: 380,
                        child: Wrap(
                          spacing: 9.0,
                          runSpacing: 12.0, 
                          children: List.generate(10, (index) {
                              return Shimmer.fromColors(
                                baseColor: Colors.grey[400]!,
                                highlightColor: Colors.grey[100]!,
                                child: Container(
                                  color: Colors.grey[400]!,
                                  width: 185,
                                  height: 110,
                                ),
                              );
                          }
                      )
                    )
                  )
                )
              ]
            )
          )
        )
      ]
      )
    );
  }
}