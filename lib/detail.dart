import 'package:flutter/material.dart';
import 'package:myapp/produk.dart';

class DetailPage extends StatelessWidget {
  const DetailPage({super.key, required this.data});

  final Produk data;

  void _kembali(context) {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 8, vertical: 40),
        child: Column(
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
          ],
        ),
      ),
    );
  }
}
