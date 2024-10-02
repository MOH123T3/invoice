import 'package:meta/meta.dart';

class CustomerProfile {
  @required
  final int? id;
  @required
  final String? customerName;
  @required
  final String? bikeModel;
  @required
  final int? mobileNumber;
  @required
  final String? registerNumber;
  @required
  final String? date;

  CustomerProfile(
      {this.id,
      this.customerName,
      this.bikeModel,
      this.mobileNumber,
      this.registerNumber,
      this.date});

  CustomerProfile.fromDb(Map<String, dynamic> map)
      : id = map['id'],
        customerName = map['customer_name'],
        bikeModel = map['bike_model'],
        mobileNumber = map['mobile_number'],
        registerNumber = map['register_number'],
        date = map['date'];

  Map<String, dynamic> toMapForDb() {
    var map = Map<String, dynamic>();
    map['id'] = id;
    map['customer_name'] = customerName;
    map['bike_model'] = bikeModel;
    map['mobile_number'] = mobileNumber;
    map['register_number'] = registerNumber;
    map['date'] = date;

    return map;
  }
}

// class CustomerProDatabase {
//   static final CustomerProDatabase _instance = CustomerProDatabase._();
//   static Database? _database;

//   CustomerProDatabase._();

//   factory CustomerProDatabase() {
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
//     String dbPath = join(directory.path, 'profile_database.db');

//     var database = openDatabase(dbPath,
//         version: 1, onCreate: _onCreate, onUpgrade: _onUpgrade);

//     return database;
//   }

//   void _onCreate(Database db, int version) {
//     db.execute('''
//       CREATE TABLE customer_profile(
//         id INTEGER PRIMARY KEY AUTOINCREMENT,
//         customer_name TEXT,
//         bike_model TEXT,
//         mobile_number INTEGER,
//         register_number TEXT,
//         date TEXT)
//     ''');
//     print("Database was created!");
//   }

//   void _onUpgrade(Database db, int oldVersion, int newVersion) {
//     // Run migration according database versions
//   }

//   Future<int> addData(CustomerProfile product) async {
//     var client = await db;

//     return client.insert('customer_profile', product.toMapForDb(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<CustomerProfile> fetchData(int id) async {
//     var client = await db;
//     final Future<List<Map<String, dynamic>>> futureMaps =
//         client.query('customer_profile', where: 'id = ?', whereArgs: [id]);
//     var maps = await futureMaps;

//     if (maps.length != 0) {
//       return CustomerProfile.fromDb(maps.first);
//     }

//     return null!;
//   }

//   Future<List<CustomerProfile>> fetchProfileAll() async {
//     var client = await db;
//     var res = await client.query('customer_profile');

//     if (res.isNotEmpty) {
//       var products = res
//           .map((productsMap) => CustomerProfile.fromDb(productsMap))
//           .toList();
//       return products;
//     }
//     return [];
//   }

//   Future<int> update(CustomerProfile newProduct) async {
//     var client = await db;
//     return client.update('customer_profile', newProduct.toMapForDb(),
//         where: 'id = ?',
//         whereArgs: [newProduct.id],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }

//   Future<Future<int>> remove(int id) async {
//     var client = await db;
//     return client.delete('customer_profile', where: 'id = ?', whereArgs: [id]);
//   }

//   Future closeDb() async {
//     var client = await db;
//     client.close();
//   }
// }
