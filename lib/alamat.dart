import 'dart:async';

import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class Alamat {
  final int? id;
  final String namaPenerima;
  final String alamatPengiriman;

  Alamat({this.id, required this.namaPenerima, required this.alamatPengiriman});

  factory Alamat.fromMap(Map<String, dynamic> map) {
    return Alamat(
        id: map['id'],
        namaPenerima: map['namaPenerima'],
        alamatPengiriman: map['alamatPengiriman']);
  }

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'namaPenerima': namaPenerima,
      'alamatPengiriman': alamatPengiriman,
    };
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'Alamat{id: $id, namaPenerima: $namaPenerima, alamatPengiriman: $alamatPengiriman}';
  }
}

Future<Database> _koneksiDatabase() async {
  final database = openDatabase(join(await getDatabasesPath(), 'db_alamat.db'),
      onCreate: (db, version) => db.execute(
          'CREATE TABLE alamat(id INTEGER PRIMARY KEY, namaPenerima TEXT, alamatPengiriman TEXT)'),
      version: 1);
  return database;
}

class AlamatProvider extends ChangeNotifier {
  List<Alamat> _listAlamat = [];

  List<Alamat> get listAlamat => _listAlamat;

  AlamatProvider() {
    _loadData();
  }

  Future<void> _loadData() async {
    await _getAlamat();
  }

  Future<void> _getAlamat() async {
    final db = await _koneksiDatabase();
    final List<Map<String, Object?>> listMapAlamat = await db.query('alamat');
    List<Alamat> listAlamat = listMapAlamat
        .map(
          (e) => Alamat.fromMap(e),
        )
        .toList();
    _listAlamat = listAlamat;
    notifyListeners();
  }

  Future<void> insertAlamat(Alamat alamat) async {
    final db = await _koneksiDatabase();

    await db.insert('alamat', alamat.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    await _loadData();
  }

  Future<void> deleteAlamat(Alamat alamat) async {
    final db = await _koneksiDatabase();
    await db.delete('alamat', where: 'id = ?', whereArgs: [alamat.id]);
    await _loadData();
  }
}
