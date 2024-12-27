import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

    if (getjudul != null || getdeskripsi != null || getjenis != null || getcuaca != null || (getpersentase != null && getpersentase != 0.0)) {
      bool loadDraft = await showambildraftdialog(context);
      if (loadDraft) {
          return {
          'judul': getjudul,
          'deskripsi': getdeskripsi,
          'jenis': getjenis,
          'cuaca': getcuaca,
          'persentase': getpersentase,
        };
      } else {
          await prefs.remove('judul');
          await prefs.remove('deskripsi');
          await prefs.remove('jenis');
          await prefs.remove('cuaca');
          await prefs.remove('persentase');
      }
    }

    return {
      'judul': null,
      'deskripsi': null,
      'jenis': 'Jalan',
      'cuaca': 'Hujan',
      'persentase': 0.0,
    };
  }
}