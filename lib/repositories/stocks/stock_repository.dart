import 'package:e_commerce_app/database/ecommerce_database.dart';
import 'package:e_commerce_app/database/models/stock_model.dart';
import 'package:sqflite/sqflite.dart';

class StockRepository {
  final db = ECommerceDatabase.instance;

  Future<bool> insertStock(Stock stock) async {
    try {
      final database = await db.database;
      final result = await database.insert('stock', stock.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
      return result > 0;
    } catch (e) {
      print('❌ Error inserting Stock: $e');
      return false;
    }
  }

  Future<List<Stock>> getAllStocks() async {
    final database = await db.database;
    final result = await database.query('stock');
    return result.map((e) => Stock.fromMap(e)).toList();
  }

  Future<List<Stock>> getAllStocksNotSync() async {
    final database = await db.database;
    final result = await database.query('stock', where: 'syncRow = ?', whereArgs: ['N']);
    return result.map((e) => Stock.fromMap(e)).toList();
  }

  Future<List<Stock>> getAllStocksSync() async {
    final database = await db.database;
    final result = await database.query('stock', where: 'syncRow = ?', whereArgs: ['Y']);
    return result.map((e) => Stock.fromMap(e)).toList();
  }

  Future<Stock?> getStockIsNewByClientId({required String clientId}) async {
    final database = await db.database;
    final result = await database.query(
      'stock',
      where: 'clientId = ?',
      whereArgs: [clientId],
    );
    return result.isNotEmpty ? Stock.fromMap(result.first) : null;
  }

  Future<Stock?> getStockById(String id) async {
    final database = await db.database;
    final result = await database.query(
      'stock',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? Stock.fromMap(result.first) : null;
  }

  Future<int> deleteStock(String id) async {
    final database = await db.database;
    return await database.delete('stock', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateStock(Stock stock) async {
    final database = await db.database;
    return await database.update('stock', stock.toMap(), where: 'id = ?', whereArgs: [stock.id]);
  }
}