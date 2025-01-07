import 'package:flutter/material.dart';

class Searchwidget extends StatefulWidget {
  final Function(String) onSearch;
  const Searchwidget({super.key, required this.onSearch});

  @override
  State<Searchwidget> createState() => _SearchwidgetState();
}


class _SearchwidgetState extends State<Searchwidget> {
  final TextEditingController searchController = TextEditingController();
  
  // fungsi membersihkan input pencarian ketika widget tidak terpakai
  @override
  void dispose() {
    searchController.dispose();// TODO: implement dispose
    super.dispose();
  }
  
  String searchQuery = '';

  void performSearch() {
    final newQuery = searchController.text;
    widget.onSearch(newQuery);
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: searchController,
      onSubmitted: (_) => performSearch(),
      style: const TextStyle(
        fontFamily: 'Poppins',
        fontSize: 11
      ),
      cursorColor: Colors.black,
      cursorHeight: 20,
      decoration: const InputDecoration(
        fillColor: Colors.white,
        filled: true,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(9)
          ),
          borderSide: BorderSide.none
        ),
        hintText: 'Cari Laporan',
        hintStyle: TextStyle(
          fontFamily: "Poppins",
          fontSize: 11,
        ),
        suffixIcon: Icon(
            Icons.search,
            color: Colors.black,
        )
      ),
    );
  }
}