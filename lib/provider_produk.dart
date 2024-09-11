import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:myapp/produk.dart';

class ProviderProduk extends ChangeNotifier {
  List<Produk> _listProduk = [];
  List<Produk> _listProdukKategori = [];
  bool isLoading = false;

  List<Produk> get listProduk => _listProduk;
  List<Produk> get listProdukKategori => _listProdukKategori;
  int get jumlahProduk => _listProduk.length;
  int get jumlahProdukKategori => _listProdukKategori.length;

  ProviderProduk() {
    _ambilProduk();
  }

  void _ambilProduk() async {
    isLoading = true;
    notifyListeners();

    final respon =
        await http.get(Uri.parse('https://fakestoreapi.com/products'));
    if (respon.statusCode == 200) {
      final List data = jsonDecode(respon.body);
      _listProduk = data
          .map(
            (json) => Produk.fromJson(json),
          )
          .toList();
      isLoading = false;
      notifyListeners();
    }
    throw Exception('Gagal ambil data dari internet');
  }

  void ambilProdukKategori(category) async {
    isLoading = true;
    notifyListeners();

    final respon = await http
        .get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
    if (respon.statusCode == 200) {
      final List<dynamic> data = jsonDecode(respon.body);
      _listProdukKategori = data
          .map(
            (json) => Produk.fromJson(json),
          )
          .toList();
      isLoading = false;
      notifyListeners();
    }
    throw Exception('Gagal ambil kategori dari internet');
  }
}
