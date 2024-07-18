import 'package:flutter/material.dart';
import 'package:myapp/detail.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/produk.dart';
import 'package:myapp/provider.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

  void _pindahKeDetail(context, produk) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(
            data: produk,
          ),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: ambilProduk(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final List<Produk> listProduk = snapshot.data!;

          return GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2),
            itemCount: listProduk.length,
            itemBuilder: (context, index) {
              Produk produk = listProduk[index];
              return GestureDetector(
                onTap: () => _pindahKeDetail(context, produk),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Align(
                          child: AspectRatio(
                              aspectRatio: 3 / 4,
                              child: Image.network(produk.image)),
                        ),
                      ),
                      Container(
                          padding: EdgeInsets.all(4),
                          color: Colors.teal,
                          child: Text(
                            produk.category.toUpperCase(),
                            style: TextStyle(color: Colors.white),
                          )),
                      Text(
                        produk.title,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Text(
                        formatRupiah(produk.price),
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
