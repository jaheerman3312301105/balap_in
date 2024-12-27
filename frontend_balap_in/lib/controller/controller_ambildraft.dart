import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter_osm_plugin/flutter_osm_plugin.dart';  

class ControllerAmbildraft {
  final Completer<bool> completer = Completer<bool>();

  Future showambildraftdialog(BuildContext context) async {
    showDialog(
      barrierDismissible: false,
      context: context, 
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Anda memiliki Draft Laporan'),
          content: const Text('Apakah Anda ingin memuat Draft Laporan Anda?'),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                completer.complete(false); 
              },
              child: const Text('Tidak'),
            ),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
                completer.complete(true);
              },
              child: const Text('Ya'),
            ),
          ],
        );
      }
    );
    return completer.future;
  }

  Future<Map<String, dynamic>> ambilDraft(context) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    final String? getjudul = prefs.getString('judul');
    final String? getdeskripsi = prefs.getString('deskripsi');
    final String? getjenis = prefs.getString('jenis');
    final String? getcuaca = prefs.getString('cuaca');
    final double? getpersentase = prefs.getDouble('persentase');
    
    final double? latitude = prefs.getDouble('latitude');
    final double? longitude = prefs.getDouble('longitude');
    GeoPoint? pickedLocation;

    if (latitude != null && longitude != null) {
      pickedLocation = GeoPoint(latitude: latitude, longitude: longitude);
    }

    bool hasDraftData = getjudul != null || getdeskripsi != null || getjenis != null || getcuaca != null || (getpersentase != null && getpersentase != 0.0) || pickedLocation != null;

    if (hasDraftData) {
      bool loadDraft = await showambildraftdialog(context);
      if (loadDraft) {
        return {
          'judul': getjudul,
          'deskripsi': getdeskripsi,
          'jenis': getjenis,
          'cuaca': getcuaca,
          'persentase': getpersentase,
          'latitude': latitude,
          'longitude': longitude
        };
      } else {
        await prefs.remove('judul');
        await prefs.remove('deskripsi');
        await prefs.remove('jenis');
        await prefs.remove('cuaca');
        await prefs.remove('persentase');
        await prefs.remove('latitude');  
        await prefs.remove('longitude');  
      }
    }

    return {
      'judul': null,
      'deskripsi': null,
      'jenis': 'Jalan',
      'cuaca': 'Hujan',
      'persentase': 0.0,
      'latitude': null,
      'longitude': null,
    };
  }

  Future<void> simpanDraft(String judul, String deskripsi, String jenis, String cuaca, double persentase, GeoPoint? location) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    
    await prefs.setString('judul', judul);
    await prefs.setString('deskripsi', deskripsi);
    await prefs.setString('jenis', jenis);
    await prefs.setString('cuaca', cuaca);
    await prefs.setDouble('persentase', persentase);
    
    if (location != null) {
      await prefs.setDouble('latitude', location.latitude);
      await prefs.setDouble('longitude', location.longitude);
    }
  }
}
