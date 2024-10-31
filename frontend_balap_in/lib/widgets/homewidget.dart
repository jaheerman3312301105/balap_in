import 'package:flutter/material.dart';

class HomeWidget extends StatelessWidget {
  const HomeWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
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
                    child: const Text(
                      'Jalan Berlobang parah sudah 5 bulan',
                      style: TextStyle(
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
                    child: const Text(
                      'Jalan Rusak',
                      style: TextStyle(
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
      ),
    );
  }
}
