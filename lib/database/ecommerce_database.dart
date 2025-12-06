import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class ECommerceDatabase {
  static final ECommerceDatabase instance = ECommerceDatabase._init();
  static Database? _database;

  ECommerceDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('ecommerce24.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);
    return await openDatabase(
      path,
      version: 1,
      onCreate: _createDB,
    );
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE commands (
        id TEXT PRIMARY KEY,
        documentno TEXT,
        dateOrdered TEXT,
        clientId TEXT,
        clientName TEXT,
        status INTEGER,
        type INTEGER,
        totalLine REAL,
        discount REAL,
        grandTotal REAL,
        visitPlanId TEXT,
        latitude REAL,
        longitude REAL,
        suppliers TEXT,
        description TEXT,
        syncRow Text DEFAULT N, 
        createdBy TEXT
      )
    ''');

    // ✅ Create command_lines table
    await db.execute('''
      CREATE TABLE command_lines (
        id TEXT PRIMARY KEY,
        commandId TEXT,
        productId TEXT,
        productName Text,
        quantity INTEGER,
        bonus INTEGER,
        totalQuantity INTEGER,
        price REAL,
        description TEXT,
        totalLine REAL,
        syncRow Text DEFAULT N,
        createdBy TEXT
      )
    ''');

    await db.execute('''
        CREATE TABLE stock (
        id TEXT PRIMARY KEY,
        documentno TEXT,
        dateOrdered TEXT,
        clientId TEXT,
        clientName TEXT,
        visitPlanId TEXT,
        description TEXT,
        grandTotal REAL,
        syncRow TEXT DEFAULT 'N',
        createdBy TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE stock_lines (
      id TEXT PRIMARY KEY,
      stockId TEXT,
      productId TEXT,
      productName TEXT,
      quantity INTEGER,
      description TEXT,
      price REAL,
      totalLine REAL,
      syncRow TEXT DEFAULT 'N',
      createdBy TEXT,
      createdAt TEXT DEFAULT CURRENT_TIMESTAMP
       )
    ''');


  }

  Future close() async {
    final db = await instance.database;
    db.close();
  }
}
