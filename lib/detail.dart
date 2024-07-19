import 'package:flutter/material.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/produk.dart';
import 'package:myapp/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.data});

  final Produk data;

  void _kembali(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 8, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: GridTile(
                  header: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () => _kembali(context),
                      icon: const Icon(Icons.arrow_back_ios),
                    ),
                  ),
                  child: Image.network(
                    data.image,
                  ),
                ),
              ),
              Text(data.category.toUpperCase()),
              Text(
                data.title,
                style: TextStyle(fontSize: 16),
              ),
              Text(
                formatRupiah(data.price),
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text(data.rate.toString()),
                      const Icon(
                        Icons.star,
                        color: Colors.amber,
                      )
                    ],
                  ),
                  Text('${data.count} Terjual'),
                ],
              ),
              Card(
                color: Colors.amber.shade100,
                child: Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  child: Text(data.description),
                ),
              ),
              const Text(
                'Produk Serupa',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              BagianProdukSerupa(
                category: data.category,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// tampilan produk serupa
class BagianProdukSerupa extends StatelessWidget {
  const BagianProdukSerupa({super.key, required this.category});
  final String category;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 130,
      child: FutureBuilder(
          future: ambilProdukKategori(category),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: LinearProgressIndicator());
            }
            List<Produk> listProduk = snapshot.data!;
            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: listProduk.length,
              itemBuilder: (context, index) {
                Produk produk = listProduk[index];
                return Container(
                  width: 130,
                  child: Card(
                    child: Column(
                      children: [
                        Expanded(child: Image.network(produk.image)),
                        Text(
                          produk.title,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(formatRupiah(produk.price)),
                      ],
                    ),
                  ),
                );
              },
            );
          }),
    );
  }
}
