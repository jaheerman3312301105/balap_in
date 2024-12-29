import 'package:flutter/services.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class Shimmerisilapor extends StatefulWidget {
  const Shimmerisilapor({super.key});

  @override
  State<Shimmerisilapor> createState() => _ShimmerisilaporState();
}

class _ShimmerisilaporState extends State<Shimmerisilapor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: SystemUiOverlayStyle(
          statusBarColor: Colors.white,
          statusBarIconBrightness: Brightness.dark,
          ),
          backgroundColor: Colors.transparent,
          titleSpacing: 0,
          leading: IconButton(
            onPressed: () {
              Navigator.of(context).pop();
            }, 
            icon: const Icon(Icons.keyboard_arrow_left),
            color: const Color.fromRGBO(5, 5, 5, 0.612),
            iconSize: 40,),
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
              
              Shimmer.fromColors(
                baseColor: Colors.grey[400]!,
                highlightColor: Colors.grey[100]!,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8), 
                    child: Container(
                      width: double.infinity, 
                      height: 200, 
                      color: Colors.grey[400]!,
                    ),
                  ),
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  color: Colors.grey[400]!,
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  color: Colors.grey[400]!,
                  width: MediaQuery.of(context).size.width * 0.75,
                  height: MediaQuery.of(context).size.height * 0.02,
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  color: Colors.grey[400]!,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.018,
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  color: Colors.grey[400]!,
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: MediaQuery.of(context).size.height * 0.018,
                )
              ),
              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Container(
                  color: Colors.grey[400]!,
                  width: MediaQuery.of(context).size.width * 0.5,
                  height: MediaQuery.of(context).size.height * 0.015,
                )
              ),
            ],
          ),
        ),
      ])
    );
  }
}