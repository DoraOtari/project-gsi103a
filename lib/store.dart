import 'package:flutter/material.dart';
import 'package:myapp/produk.dart';
import 'package:myapp/provider.dart';

class MyStore extends StatelessWidget {
  const MyStore({super.key});

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
              return Column(
                children: [
                  Text(produk.title),
                  Text(produk.price.toString()),
                ],
              );
            },
          );
        },
      ),
    );
  }
}