import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class AdminDatabase {
  @required
  final int? id;
  @required
  final String? adminName;
  @required
  final String? businessName;
  @required
  final int? mobileNumber;
  @required
  final String? businessAddress;

  AdminDatabase(
      {this.id,
      this.adminName,
      this.businessName,
      this.mobileNumber,
      this.businessAddress});

  AdminDatabase.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        adminName = map['admin_name'],
        businessName = map['business_name'],
        mobileNumber = map['mobile_number'],
        businessAddress = map['business_address'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['admin_name'] = adminName;
    map['business_name'] = businessName;
    map['mobile_number'] = mobileNumber;
    map['business_address'] = businessAddress;

    return map;
  }
}

class AdminProfileDatabase {
  static final AdminProfileDatabase _instance = AdminProfileDatabase._();
  static Database? _database;

  AdminProfileDatabase._();

  factory AdminProfileDatabase() {
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
    String dbPath = join(directory.path, 'a_database.db');

    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE admin_profile(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        admin_name TEXT,
        business_name TEXT,
        mobile_number INTEGER,
        business_address TEXT)
    ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addData(AdminDatabase product) async {
    var client = await db;

    return client.insert('admin_profile', product.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<AdminDatabase> fetchData(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query('admin_profile', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return AdminDatabase.fromDb(maps.first);
    }

    return null!;
  }

  Future<List<AdminDatabase>> fetchProfileAll() async {
    var client = await db;
    var res = await client.query('admin_profile');

    if (res.isNotEmpty) {
      var products =
          res.map((productsMap) => AdminDatabase.fromDb(productsMap)).toList();
      return products;
    }
    return [];
  }

  Future<int> update(AdminDatabase newProduct) async {
    var client = await db;
    return client.update('admin_profile', newProduct.toMapForDb(),
        where: 'id = ?',
        whereArgs: [newProduct.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Future<int>> remove(int id) async {
    var client = await db;
    return client.delete('admin_profile', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}
