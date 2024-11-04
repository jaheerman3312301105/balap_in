import 'package:dio/dio.dart';

final dio = Dio();

// Run the app like this: dart run args.dart 1 test
void main(List arguments) async{
  final response = await dio.get('http://127.0.0.1:8000/laporan/');  
  
  List idLaporan = [];
  List judulList = [];

  for (var item in response.data['results']){
    idLaporan.add(item['idLaporan']);
    judulList.add(item['judul']);;
  }
  

  List listLaporan = [
    idLaporan,
    judulList
  ];
  
  print(listLaporan);

}