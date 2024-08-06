import 'package:flutter/material.dart';
import 'package:myapp/alamat.dart';
import 'package:myapp/format_rupiah.dart';
import 'package:myapp/produk.dart';
import 'package:myapp/provider_keranjang.dart';
import 'package:provider/provider.dart';

class KeranjangPage extends StatelessWidget {
  KeranjangPage({super.key});
  final _namaPenerimaCon = TextEditingController();
  final _alamatPengirimanCon = TextEditingController();
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
            SizedBox(
              height: 80,
              child: Consumer<AlamatProvider>(
                builder: (context, provider, child) => ListView.builder(
                  itemCount: provider.listAlamat.length,
                  itemBuilder: (context, index) {
                    Alamat alamat = provider.listAlamat[index];
                    return Card(
                      child: Column(
                        children: [
                          const Text('Alamat Pengiriman'),
                          Text(alamat.namaPenerima),
                          Text(alamat.alamatPengiriman),
                        ],
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
      bottomNavigationBar: InkWell(
        onTap: () => showModalBottomSheet(
          isScrollControlled: true,
          context: context,
          builder: (context) => FractionallySizedBox(
            heightFactor: 0.9,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8),
              child: Column(
                children: [
                  const SizedBox(
                    width: 100,
                    child: Divider(
                      thickness: 5,
                    ),
                  ),
                  const Text(
                    'Informasi Pemesanan',
                    style: TextStyle(fontSize: 24),
                  ),
                  TextFormField(
                    controller: _namaPenerimaCon,
                    decoration: InputDecoration(label: Text('Nama Penerima')),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    controller: _alamatPengirimanCon,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      label: Text('Alamat Pengiriman'),
                      border: OutlineInputBorder(),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: () async {
                          Alamat alamat = Alamat.fromMap({
                            'namaPenerima': _namaPenerimaCon.text,
                            'alamatPengiriman': _alamatPengirimanCon.text,
                          });
                          Provider.of<AlamatProvider>(context, listen: false)
                              .insertAlamat(alamat);
                          _namaPenerimaCon.clear();
                          _alamatPengirimanCon.clear();
                          Navigator.pop(context);
                        },
                        style: const ButtonStyle(
                            foregroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.orange)),
                        child: Text('Pesan')),
                  )
                ],
              ),
            ),
          ),
        ),
        child: Container(
          alignment: Alignment.center,
          height: 45,
          color: Colors.teal,
          child: const Text(
            'Buat Pesanan',
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
        ),
      ),
    );
  }
}
