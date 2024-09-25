import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class SparePart {
  @required
  final int? id;
  @required
  final String? partName;
  @required
  late final int? partPrice;
  @required
  final int? partQuantity;
  @required
  final String? bikeModelNo;

  SparePart(
      {this.id,
      this.partName,
      this.partPrice,
      this.partQuantity,
      this.bikeModelNo});

  SparePart.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        partName = map['part_name'],
        partPrice = map['part_price'],
        partQuantity = map['part_quantity'],
        bikeModelNo = map['bike_model'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['part_name'] = partName;
    map['part_price'] = partPrice;
    map['part_quantity'] = partQuantity;
    map['bike_model'] = bikeModelNo;
    return map;
  }
}

class SparePartDatabase {
  static final SparePartDatabase _instance = SparePartDatabase._();
  static Database? _database;

  SparePartDatabase._();

  factory SparePartDatabase() {
    return _instance;
  }

  Future<Database> get db async {
    if (_database != null) {
      return _database!;
    }

    _database = await init();

    return _database!;
  }

  Future<Database> init() async {
    Directory directory = await getApplicationDocumentsDirectory();
    String dbPath = join(directory.path, 'database.db');

    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE spare_part(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        part_name TEXT,
        part_price INTEGER,
        part_quantity INTEGER,
        bike_model TEXT)
    ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addProduct(SparePart product) async {
    var client = await db;
    return client.insert('spare_part', product.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SparePart> fetch(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query('spare_part', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return SparePart.fromDb(maps.first);
    }

    return null!;
  }

  Future<List<SparePart>> fetchAll() async {
    var client = await db;
    var res = await client.query('spare_part');

    if (res.isNotEmpty) {
      var Products =
          res.map((ProductMap) => SparePart.fromDb(ProductMap)).toList();
      return Products;
    }
    return [];
  }

  Future<int> updateProduct(SparePart newProduct) async {
    var client = await db;
    return client.update('spare_part', newProduct.toMapForDb(),
        where: 'id = ?',
        whereArgs: [newProduct.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Future<int>> removeProduct(int id) async {
    var client = await db;
    return client.delete('spare_part', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}
