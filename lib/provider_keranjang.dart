import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/produk.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Keranjang extends ChangeNotifier {
  List<Produk> _listProduk = [];

  List<Produk> get listProduk => _listProduk;

  int get jumlahProduk => _listProduk.length;

  num get totalBayar => _hitungTotal();

  Keranjang() {
    _muatData();
  }

  num _hitungTotal() {
    num totalBayar = 0;
    for (var produk in _listProduk) {
      totalBayar += produk.price;
    }
    return totalBayar;
  }

  void _muatData() async {
    final prefs = await SharedPreferences.getInstance();
    final List<String> listString = prefs.getStringList('listKeranjang') ?? [];
    _listProduk = listString
        .map(
          (e) => Produk.fromJson(jsonDecode(e)),
        )
        .toList();
    notifyListeners();
  }

  void tambah(Produk produk) {
    _listProduk.add(produk);
    _simpanData();
    notifyListeners();
  }

  void hapus(Produk produk) {
    _listProduk.remove(produk);
    _simpanData();
    notifyListeners();
  }

  void _simpanData() async {
    final prefs = await SharedPreferences.getInstance();
    List<String> listString = _listProduk
        .map(
          (e) => jsonEncode(e.toJson()),
        )
        .toList();
    await prefs.setStringList('listKeranjang', listString);
  }
}
