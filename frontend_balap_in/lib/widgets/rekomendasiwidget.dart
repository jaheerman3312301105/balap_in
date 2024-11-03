import 'package:flutter/material.dart';

class RekomendasiWidget extends StatelessWidget {
  final Color color;

  const RekomendasiWidget({super.key, required this.color});

  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 5),
        child: Container(
          height: MediaQuery.of(context).size.height * 0.16,
          width: MediaQuery.of(context).size.width * 0.85,
          decoration: BoxDecoration(
            color: color,
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
                    width: MediaQuery.of(context).size.width * 0.415,
                    margin: const EdgeInsets.only(
                      left: 10,
                      top: 15,
                    ),
                    child: const Text(
                      'Jl. Sudirman No.3, Sukajadi, Kec. Batam Kota, Kota Batam, Kepulauan Riau 29432',
                      style: TextStyle(
                        fontSize: 8,
                        fontFamily: "Poppins",
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.415,
                    margin: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: const Text(
                      'Jalan Rusak',
                      style: TextStyle(
                        fontSize: 8,
                        fontFamily: "Poppins",
                      ),
                    ),
                  ),
                  Container(
                    width: MediaQuery.of(context).size.width * 0.415,
                    margin: const EdgeInsets.only(
                      left: 10,
                      top: 5,
                    ),
                    child: const Row(
                      children: [
                        Image(
                          image: AssetImage('assets/images/warningshield.png')
                        ),
                        SizedBox(width: 2,),
                        Text(
                          '24 Report',
                          style: TextStyle(
                            fontSize: 8,
                            fontFamily: "Poppins",
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                child: Container(
                  margin: const EdgeInsets.only(
                    left: 10, 
                    right: 5
                    ),
                  height: MediaQuery.of(context).size.height * 0.14,
                  width: MediaQuery.of(context).size.width * 0.365,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    image: const DecorationImage(
                      image: AssetImage('assets/images/peta.png'),
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
  }
}
