// // ignore_for_file: depend_on_referenced_packages

// import 'dart:async';
// import 'dart:io';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:meta/meta.dart';

// class RevenueDataStore {
//   @required
//   final int? id;
//   @required
//   final int? totalProducts;
//   @required
//   final int? totalCustomers;
//   @required
//   final int? totalRevenue;
//   @required
//   final int? totalPaid;
//   @required
//   final int? totalDue;

//   RevenueDataStore({
//     this.id,
//     this.totalProducts,
//     this.totalCustomers,
//     this.totalRevenue,
//     this.totalPaid,
//     this.totalDue,
//   });

//   RevenueDataStore.fromDb(Map<String, dynamic> map)
//       : id = map['id'],
//         totalProducts = map['total_products'],
//         totalCustomers = map['total_customers'],
//         totalRevenue = map['total_revenue'],
//         totalPaid = map['total_paid'],
//         totalDue = map['total_due'];

//   Map<String, dynamic> toMapForDb() {
//     var map = Map<String, dynamic>();
//     map['id'] = id;
//     map['total_products'] = totalProducts;
//     map['total_customers'] = totalCustomers;
//     map['total_revenue'] = totalRevenue;
//     map['total_paid'] = totalPaid;
//     map['total_due'] = totalDue;

//     return map;
//   }
// }

// class RevenueDatabase {
//   static final RevenueDatabase _instance = RevenueDatabase._();
//   static Database? _database;

//   RevenueDatabase._();

//   factory RevenueDatabase() {
//     return _instance;
//   }

//   Future<Database> get db async {
//     if (_database != null) {
//       return _database!;
//     }

//     _database = await init();

//     return _database!;
//   }

//   Future<Database> init() async {
//     Directory directory = await getApplicationDocumentsDirectory();
//     String dbPath = join(directory.path, 'revenue_database.db');

//     var database = openDatabase(dbPath,
//         version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

//     return database;
//   }

//   void _onCreate(Database db, int version) {
//     db.execute('''
//       CREATE TABLE revenue(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         total_products TEXT,
//         total_customers TEXT,
//         total_revenue TEXT,
//         total_paid TEXT,
//         total_due TEXT
//         )
//     ''');
//     print("Database was created!");
//   }

//   void _onUpgrade(Database db, int oldVersion, int newVersion) {
//     // Run migration according database versions
//   }

//   Future<int> addData(RevenueDataStore detail) async {
//     var client = await db;

//     return client.insert('revenue', detail.toMapForDb(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<RevenueDataStore> fetchData(int id) async {
//     var client = await db;
//     final Future<List<Map<String, dynamic>>> futureMaps =
//         client.query('revenue', where: 'id = ?', whereArgs: [id]);
//     var maps = await futureMaps;

//     if (maps.length != 0) {
//       return RevenueDataStore.fromDb(maps.first);
//     }

//     return null!;
//   }

//   Future<List<RevenueDataStore>> fetchAll() async {
//     var client = await db;
//     var res = await client.query('revenue');

//     if (res.isNotEmpty) {
//       var products = res
//           .map((productsMap) => RevenueDataStore.fromDb(productsMap))
//           .toList();
//       return products;
//     }
//     return [];
//   }

//   Future<int> update(RevenueDataStore newProduct) async {
//     var client = await db;
//     return client.update('revenue', newProduct.toMapForDb(),
//         where: 'id = ?',
//         whereArgs: [newProduct.id],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<Future<int>> remove(int id) async {
//     var client = await db;
//     return client.delete('revenue', where: 'id = ?', whereArgs: [id]);
//   }

//   Future closeDb() async {
//     var client = await db;
//     client.close();
//   }
// }
