// ignore_for_file: depend_on_referenced_packages

import 'dart:async';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:meta/meta.dart';

class BillingDatabase {
  @required
  final int? id;
  @required
  final String? customerName;
  @required
  final String? paymentType;
  @required
  final String? registerNumber;
  @required
  final String? date;
  final String? totalAmount;
  @required
  final String? labourCharges;
  @required
  final String? dueAmount;
  @required
  final String? paidAmount;
  BillingDatabase(
      {this.id,
      this.customerName,
      this.paymentType,
      this.registerNumber,
      this.date,
      this.totalAmount,
      this.labourCharges,
      this.dueAmount,
      this.paidAmount});

  BillingDatabase.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        customerName = map['customer_name'],
        paymentType = map['payment_type'],
        registerNumber = map['register_number'],
        date = map['date'],
        totalAmount = map['total_amount'],
        labourCharges = map['labour_charge'],
        dueAmount = map['due_amount'],
        paidAmount = map['paid_amount'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['customer_name'] = customerName;
    map['payment_type'] = paymentType;
    map['register_number'] = registerNumber;
    map['date'] = date;
    map['total_amount'] = totalAmount;
    map['labour_charge'] = labourCharges;
    map['due_amount'] = dueAmount;
    map['paid_amount'] = paidAmount;

    return map;
  }
}

class DetailBillingDatabase {
  static final DetailBillingDatabase _instance = DetailBillingDatabase._();
  static Database? _database;

  DetailBillingDatabase._();

  factory DetailBillingDatabase() {
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
    String dbPath = join(directory.path, 'billing_database.db');

    var database = openDatabase(dbPath,
        version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

    return database;
  }

  void _onCreate(Database db, int version) {
    db.execute('''
      CREATE TABLE customer_billing(
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        customer_name TEXT,
        payment_type TEXT,
        register_number TEXT,
        date TEXT,total_amount TEXT,
        labour_charge TEXT,
        due_amount TEXT,
        paid_amount TEXT)
    ''');
    print("Database was created!");
  }

  void _onUpgrade(Database db, int oldVersion, int newVersion) {
    // Run migration according database versions
  }

  Future<int> addData(BillingDatabase detail) async {
    var client = await db;

    return client.insert('customer_billing', detail.toMapForDb(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<BillingDatabase> fetchData(int id) async {
    var client = await db;
    final Future<List<Map<String, dynamic>>> futureMaps =
        client.query('customer_billing', where: 'id = ?', whereArgs: [id]);
    var maps = await futureMaps;

    if (maps.length != 0) {
      return BillingDatabase.fromDb(maps.first);
    }

    return null!;
  }

  Future<List<BillingDatabase>> fetchAll() async {
    var client = await db;
    var res = await client.query('customer_billing');

    if (res.isNotEmpty) {
      var products = res
          .map((productsMap) => BillingDatabase.fromDb(productsMap))
          .toList();
      return products;
    }
    return [];
  }

  Future<int> update(BillingDatabase newProduct) async {
    var client = await db;
    return client.update('customer_billing', newProduct.toMapForDb(),
        where: 'id = ?',
        whereArgs: [newProduct.id],
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<Future<int>> remove(int id) async {
    var client = await db;
    return client.delete('customer_billing', where: 'id = ?', whereArgs: [id]);
  }

  Future closeDb() async {
    var client = await db;
    client.close();
  }
}
