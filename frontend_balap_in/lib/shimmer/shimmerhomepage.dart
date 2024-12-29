import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class Shimmerhomepage extends StatefulWidget {
  const Shimmerhomepage({super.key});

  @override
  State<Shimmerhomepage> createState() => _ShimmerhomepageState();
}

class _ShimmerhomepageState extends State<Shimmerhomepage> {
  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[400]!,
      highlightColor: Colors.grey[100]!,
      child: SizedBox(
        height: 50,
        width: 250,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 120,
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2
                      ),
                    child: Container(
                      width: 60,
                      height: 10,
                      color: Colors.grey[400]!,
                    ),
                  ),
                  Container(
                    width: 20,
                    height: 20,
                    color: Colors.grey[400]!,
                  ),
                ],
              ),
            ),
            const SizedBox(
              width: 10,
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: VerticalDivider(
                      color: Colors.black,
                      thickness: 2,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 120,
              height: 40,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 2,
                      bottom: 2
                      ),
                    child: Container(
                      width: 60,
                      height: 10,
                      color: Colors.grey[400]!,
                    ),
                  ),
                  Container(
                    width: 55,
                    height: 20,
                    color: Colors.grey[400]!,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}