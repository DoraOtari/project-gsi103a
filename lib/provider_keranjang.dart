import 'package:flutter/material.dart';
import 'package:myapp/produk.dart';

class Keranjang extends ChangeNotifier {
  final List<Produk> _listProduk = [];

  List<Produk> get listProduk => _listProduk;

  int get jumlahProduk => _listProduk.length;

  void tambah(Produk produk) {
    _listProduk.add(produk);
    notifyListeners();
  }

  void hapus(Produk produk) {
    _listProduk.remove(produk);
    notifyListeners();
  }
}
