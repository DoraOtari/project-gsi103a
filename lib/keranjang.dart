import 'package:flutter/material.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/produk.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  const KeranjangPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Keranjang'),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          children: [
            Expanded(
              child: Consumer<Keranjang>(
                builder: (context, value, child) => ListView.builder(
                  itemCount: value.jumlahProduk,
                  itemBuilder: (context, index) {
                    Produk produk = value.listProduk[index];
                    return Dismissible(
                      confirmDismiss: (_) async {
                        bool confirm = await showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            content: const Text(
                                'Apakah Kamu yakin ingin menghapus produk ini?'),
                            actions: [
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(false),
                                  child: const Text('Tidak')),
                              TextButton(
                                  onPressed: () =>
                                      Navigator.of(context).pop(true),
                                  child: const Text('Ya')),
                            ],
                          ),
                        );
                        return confirm;
                      },
                      onDismissed: (_) =>
                          Provider.of<Keranjang>(context, listen: false)
                              .hapus(produk),
                      direction: DismissDirection.endToStart,
                      background: Container(
                        color: Colors.red,
                        alignment: Alignment.centerRight,
                        child: const Icon(
                          Icons.delete,
                          size: 28,
                          color: Colors.white,
                        ),
                      ),
                      key: GlobalKey(),
                      child: ListTile(
                        leading: AspectRatio(
                          aspectRatio: 3 / 4,
                          child: Image.network(produk.image),
                        ),
                        title: Text(produk.title),
                        subtitle: Text(formatRupiah(produk.price)),
                      ),
                    );
                  },
                ),
              ),
            ),
            const Text(
              'Detail Pembayaran',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text('Total Barang'),
                Consumer<Keranjang>(
                    builder: (context, value, child) =>
                        Text('${value.jumlahProduk}')),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Total Bayar'),
                Consumer<Keranjang>(
                    builder: (context, value, child) =>
                        Text(formatRupiah(value.totalBayar))),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
