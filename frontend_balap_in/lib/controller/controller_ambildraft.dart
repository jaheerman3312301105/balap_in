import 'package:shared_preferences/shared_preferences.dart';

class ControllerAmbildraft {
  
  Future ambilDraft() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (prefs.getString('judul') != null) {
      
    }
  }

}