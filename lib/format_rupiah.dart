import 'package:intl/intl.dart';

String formatRupiah(harga) {
  final rupiah = NumberFormat.currency(locale: 'id_ID', symbol: 'Rp. ');
  return rupiah.format(harga * 16000);
}
