
import 'package:shared_preferences/shared_preferences.dart';

class ControllerDraft {
    

    Future draftLaporan(judulController, deskripsiController) async {
    if (judulController.text.isNotEmpty | deskripsiController.text.isNotEmpty) {
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
      
      return 'Laporan berhasil disimpan';
  
  } else {
      throw 'Salah satu field wajib diisi sebelum menyimpan laporan. Mohon isi salah satu field data terlebih dahulu.';
  }
  }
  
}