import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:myapp/produk.dart';

Future<List<Produk>> ambilProduk() async {
  final respon = await http.get(Uri.parse('https://fakestoreapi.com/products'));
  if (respon.statusCode == 200) {
    final List data = jsonDecode(respon.body);
    return data
        .map(
          (json) => Produk.fromJson(json),
        )
        .toList();
  }
  throw Exception('Gagal ambil data dari internet');
}

Future<List<Produk>> ambilProdukKategori(category) async {
  final respon = await http
      .get(Uri.parse('https://fakestoreapi.com/products/category/$category'));
  if (respon.statusCode == 200) {
    final List<dynamic> data = jsonDecode(respon.body);
    return data
        .map(
          (json) => Produk.fromJson(json),
        )
        .toList();
  }
  throw Exception('Gagal ambil kategori dari internet');
}
