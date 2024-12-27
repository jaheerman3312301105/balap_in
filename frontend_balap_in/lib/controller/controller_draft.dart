import 'package:shared_preferences/shared_preferences.dart';

class ControllerDraft {
  Future draftLaporan(
    judulController, 
    String selectedJenis, 
    deskripsiController, 
    String selectedCuaca, 
    currentSliderValue, 
    pickedLocationaLat, 
    pickedLocationLong,
    gambarfix
  ) async {
    if (judulController.text.isNotEmpty || selectedJenis != 'Jalan' || deskripsiController.text.isNotEmpty || selectedCuaca != 'Hujan' || currentSliderValue != 0.0 || pickedLocationaLat != 0.0 || pickedLocationLong != 0.0 || gambarfix != null) {
      final SharedPreferences prefs = await SharedPreferences.getInstance();

      if (judulController.text.isNotEmpty) {
        await prefs.remove('judul');
        await prefs.setString('judul', judulController.text);
      } 
      
      if (deskripsiController.text.isNotEmpty) {
        await prefs.remove('deskripsi');
        await prefs.setString('deskripsi', deskripsiController.text);
      }

      if (selectedJenis != 'Jalan') {
        await prefs.remove('jenis');
        await prefs.setString('jenis', selectedJenis);
      }

      if (selectedCuaca != 'Hujan') {
        await prefs.remove('cuaca');
        await prefs.setString('cuaca', selectedCuaca);
      }

      if (currentSliderValue != 0.0) {
        await prefs.remove('persentase');
        await prefs.setDouble('persentase', currentSliderValue);
      }

      if (pickedLocationaLat != 0.0 && pickedLocationLong != 0.0) {
        await prefs.remove('latitude');
        await prefs.remove('longitude');
        await prefs.setDouble('latitude', pickedLocationaLat);
        await prefs.setDouble('longitude', pickedLocationLong);
      }

      if (gambarfix != null) {
        await prefs.remove('gambar');
        await prefs.setString('gambar', gambarfix);
      }
      
      return 'Laporan berhasil disimpan';
    } else {
      throw 'Salah satu field wajib diisi sebelum menyimpan laporan. Mohon isi salah satu data terlebih dahulu.';
    }
  }
}
