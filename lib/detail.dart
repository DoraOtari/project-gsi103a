import 'package:flutter/material.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/keranjang.dart';
import 'package:myapp/produk.dart';
import 'package:myapp/provider_produk.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:provider/provider.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.data});

  final Produk data;

  void _pindahKeranjang(context) {
    Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const KeranjangPage(),
        ));
  }

  void _masukKeranjang(context, produk) {
    Provider.of<Keranjang>(context, listen: false).tambah(produk);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: ElevatedButton.icon(
        style: const ButtonStyle(
          foregroundColor: WidgetStatePropertyAll(Colors.white),
          backgroundColor: WidgetStatePropertyAll(Colors.orange),
        ),
        onPressed: () => _masukKeranjang(context, data),
        label: const Text('Add'),
        icon: const Icon(Icons.add),
      ),
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => _pindahKeranjang(context),
              icon: Badge(
                label: Consumer<Keranjang>(
                  builder: (context, value, child) =>
                      Text(value.jumlahProduk.toString()),
                ),
                child: const Icon(Icons.shopping_bag),
              ))
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 200,
                child: Align(
                  child: Image.network(
                    data.image,
                  ),
                ),
              ),
              Text(data.category.toUpperCase()),
              Text(
                data.title,
                style: const TextStyle(fontSize: 16),
              ),
              Text(
                formatRupiah(data.price),
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
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
class BagianProdukSerupa extends StatefulWidget {
  const BagianProdukSerupa({super.key, required this.category});
  final String category;

  @override
  State<BagianProdukSerupa> createState() => _BagianProdukSerupaState();
}

class _BagianProdukSerupaState extends State<BagianProdukSerupa> {
  @override
  void initState() {
    final provider = Provider.of<ProviderProduk>(context, listen: false);
    provider.ambilProdukKategori(widget.category);
    super.initState();
  }

  void _pindahDetail(context, produk) {
    Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (context) => DetailPage(data: produk),
        ));
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 130,
        child: Consumer<ProviderProduk>(
          builder: (context, providerProduk, child) {
            if (providerProduk.isLoading) {
              return const Center(
                child: LinearProgressIndicator(),
              );
            }

            return ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: providerProduk.jumlahProdukKategori,
              itemBuilder: (context, index) {
                Produk produk = providerProduk.listProdukKategori[index];
                return GestureDetector(
                  onTap: () => _pindahDetail(context, produk),
                  child: SizedBox(
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
                  ),
                );
              },
            );
          },
        ));
  }
}
