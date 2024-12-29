import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';

class Shimmernotification extends StatefulWidget {
  const Shimmernotification({super.key});

  @override
  State<Shimmernotification> createState() => _ShimmernotificationState();
}

class _ShimmernotificationState extends State<Shimmernotification> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 6,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        return Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.85,
                height: MediaQuery.of(context).size.height * 0.15,
                color: Colors.grey[200]!,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.15,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(
                            bottom: 35
                          ),
                          child: Shimmer.fromColors(
                          baseColor: Colors.grey[400]!,
                          highlightColor: Colors.grey[100]!,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: Container(
                                color: Colors.grey[400]!,
                                height: MediaQuery.of(context).size.height * 0.0475,
                                width: MediaQuery.of(context).size.width * 0.1
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                       width: MediaQuery.of(context).size.width * 0.68,
                       child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 30,
                              right: 80
                              ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: MediaQuery.of(context).size.height * 0.019,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              right: 20
                              ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.65,
                                height: MediaQuery.of(context).size.height * 0.012,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 5,
                              right: 200
                              ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.012,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                              top: 15,
                              right: 200
                              ),
                            child: Shimmer.fromColors(
                              baseColor: Colors.grey[400]!,
                              highlightColor: Colors.grey[100]!,
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.2,
                                height: MediaQuery.of(context).size.height * 0.012,
                                color: Colors.grey[400]!,
                              ),
                            ),
                          )
                        ],
                       ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      }
    );
  }
}