import 'dart:io';

import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perpus_online/app/modules/staff/views/staff_model.dart';
import 'package:sqflite/sqflite.dart';

class DbHelper {
  static final _databaseName = "aprilmart.db";
  static final _databaseVersion = 1;

  final String tabel1 = 'daftarBuku';
  final String tabel2 = 'daftarPinjam';

  final String idBuku = 'id_buku';
  final String namaBuku = 'namaBuku';
  final String jumlahBuku = 'jumlahBuku';

  final String idPinjam = 'id_pinjam';
  final String namaBukup = 'namaBukup';
  final String namaPeminjam = 'namaPeminjam';
  final String tanggalPinjam = 'tanggalPinjam';

  static Database? _database;
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _createDb);
  }

  void _createDb(Database db, int version) async {
    await db.execute('''
      CREATE TABLE $tabel1 (
        $idBuku INTEGER PRIMARY KEY AUTOINCREMENT,
        $namaBuku TEXT NULL,
        $jumlahBuku INTEGER NULL
      );  
    ''');
    await db.execute('''
      CREATE TABLE $tabel2 (
        $idPinjam INTEGER PRIMARY KEY AUTOINCREMENT,
        $namaBukup TEXT NULL,
        $namaPeminjam TEXT NULL,
        $tanggalPinjam TEXT NULL
      );  
    ''');
  }

  //Daftar Buku
  Future<List<BukuModel>> allBuku() async {
    final data = await _database!.query(tabel1);
    List<BukuModel> result = data.map((e) => BukuModel.fromjson(e)).toList();
    print(result);
    return result;
  }

  Future<int> insertBuku(Map<String, dynamic> row) async {
    final query = await _database!.insert(tabel1, row);
    return query;
  }

  //Daftar Pimjam
  Future<List<PinjamModel>> allPinjam() async {
    final data = await _database!.query(tabel2);
    List<PinjamModel> result =
        data.map((e) => PinjamModel.fromjson(e)).toList();
    print(result);
    return result;
  }

  Future<int> insertPinjam(Map<String, dynamic> row) async {
    final query = await _database!.insert(tabel2, row);
    return query;
  }
}
