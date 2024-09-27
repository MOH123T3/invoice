import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class SelectedBillingProductDatabase {
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

  SelectedBillingProductDatabase(
      {this.id,
      this.partName,
      this.partPrice,
      this.partQuantity,
      this.bikeModelNo});

  SelectedBillingProductDatabase.fromDb(Map<String, dynamic> map)
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

class BillingProductDatabaseDatabase {
  static final BillingProductDatabaseDatabase _instance =
      BillingProductDatabaseDatabase._();
  static Database? _database;

  BillingProductDatabaseDatabase._();

  factory BillingProductDatabaseDatabase() {
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
    String dbPath = join(directory.path, 'selected_billing_product.db');

    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE selected_product(
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

  Future<int> addProduct(SelectedBillingProductDatabase product) async {
    var client = await db;
    return client.insert('selected_product', product.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<SelectedBillingProductDatabase> fetch(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query('selected_product', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return SelectedBillingProductDatabase.fromDb(maps.first);
    }

    return null!;
  }

  Future<List<SelectedBillingProductDatabase>> fetchAll() async {
    var client = await db;
    var res = await client.query('selected_product');

    if (res.isNotEmpty) {
      var Products = res
          .map(
              (ProductMap) => SelectedBillingProductDatabase.fromDb(ProductMap))
          .toList();
      return Products;
    }
    return [];
  }

  Future<int> updateProduct(SelectedBillingProductDatabase newProduct) async {
    var client = await db;
    return client.update('selected_product', newProduct.toMapForDb(),
        where: 'id = ?',
        whereArgs: [newProduct.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Future<int>> removeProduct(int id) async {
    var client = await db;
    return client.delete('selected_product', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}
