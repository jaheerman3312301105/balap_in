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
    if (judulController.text.isNotEmpty || selectedJenis != 'Jalan' || deskripsiController.text.isNotEmpty || selectedCuaca != 'Hujan' || currentSliderValue != 0.0 || pickedLocationaLat != null || pickedLocationLong != null || gambarfix != null) {
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

      if (pickedLocationaLat != null && pickedLocationLong != null && pickedLocationaLat != 0.0 && pickedLocationLong != 0.0) {
        await prefs.remove('latitude');
        await prefs.remove('longitude');
        await prefs.setDouble('latitude', pickedLocationaLat);
        await prefs.setDouble('longitude', pickedLocationLong);

        final latitude = prefs.getDouble('latitude');
        final longitude = prefs.getDouble('longitude');
        print('latitude : $latitude');
        print('longitude : $longitude');
      }

      if (gambarfix != null) {
        await prefs.remove('gambar');
        await prefs.setString('gambar', gambarfix);
        final gambar = prefs.getString('gambar');
        print('gambar : $gambar');
      }
      
      return 'Laporan berhasil disimpan';
    } else {
      throw 'Salah satu field wajib diisi sebelum menyimpan laporan. Mohon isi salah satu data terlebih dahulu.';
    }
  }
}
