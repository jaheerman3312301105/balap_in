
import 'package:shared_preferences/shared_preferences.dart';

class ControllerDraft {
    

    Future draftLaporan(judulController,String selectedJenis ,deskripsiController, String selectedCuaca, currentSliderValue) async {
    if (judulController.text.isNotEmpty || selectedJenis != 'Jalan' ||deskripsiController.text.isNotEmpty || selectedCuaca != 'Hujan' || currentSliderValue != 0.0) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (judulController.text.isNotEmpty) {
        await prefs.remove('judul');
        await prefs.setString('judul', judulController.text);
          final judul = prefs.getString('judul');
          print('judul : $judul');

      } 
      
      if (deskripsiController.text.isNotEmpty) {
        await prefs.remove('deskripsi');
        await prefs.setString('deskripsi', deskripsiController.text);
          final deskripsi = prefs.getString('deskripsi');
          print('deskripsi : $deskripsi');
      }

      if (selectedJenis != 'Jalan') {
        await prefs.remove('jenis');
        await prefs.setString('jenis', selectedJenis);
          final jenis = prefs.getString('jenis');
          print('jenis : $jenis');
      }

      if (selectedCuaca != 'Hujan') {
        await prefs.remove('cuaca');
        await prefs.setString('cuaca', selectedCuaca);
          final cuaca = prefs.getString('cuaca');
          print('cuaca : $cuaca');
      }

      if (currentSliderValue != 0.0) {
        await prefs.remove('persentase');
        await prefs.setDouble('persentase', currentSliderValue);
          final persentase = prefs.getDouble('persentase');
          print('persentase : $persentase');
      }
      
      return 'Laporan berhasil disimpan';
  
  } else {
      throw 'Salah satu field wajib diisi sebelum menyimpan laporan. Mohon isi salah satu data terlebih dahulu.';
  }
  }
  
}