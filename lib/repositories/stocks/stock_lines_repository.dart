import 'package:e_commerce_app/database/ecommerce_database.dart';
import 'package:e_commerce_app/database/models/Stock_line_model.dart';
import 'package:sqflite/sqflite.dart';

class StockLineRepository {
  final db = ECommerceDatabase.instance;

  Future<bool> insertStockLine(StockLine line) async {
    final database = await db.database;
    await database.insert('stock_lines', line.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<StockLine>> getStockLinesByStockId(String stockId) async {
    final database = await db.database;
    final result = await database.query('stock_lines', where: 'stockId = ?', orderBy: 'createdAt DESC', whereArgs: [stockId]);
    return result.map((e) => StockLine.fromMap(e)).toList();
  }

  Future<double> getStockLinesTotalByStockId(String stockId) async {
    final database = await db.database;

    // Use SUM in SQL to calculate total
    final result = await database.rawQuery(
      'SELECT SUM(totalLine) as total FROM stock_lines WHERE stockId = ?',
      [stockId],
    );

    // result is a list with one map
    double total = 0.0;
    if (result.isNotEmpty && result.first['total'] != null) {
      // SQLite returns int or double depending on data
      total = (result.first['total'] as num).toDouble();
    }

    return total;
  }

  Future<List<StockLine>> getAllStockLinesNotSync() async {
    final database = await db.database;
    final result = await database.query('stock_lines', where: 'syncRow = ?', whereArgs: ['N']);
    return result.map((e) => StockLine.fromMap(e)).toList();
  }

  Future<List<StockLine>> getAllStockLinesSync() async {
    final database = await db.database;
    final result = await database.query('stock_lines', where: 'syncRow = ?', whereArgs: ['Y']);
    return result.map((e) => StockLine.fromMap(e)).toList();
  }

  Future<StockLine?> getStockLineById(String id) async {
    final database = await db.database;
    final result = await database.query('stock_lines', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? StockLine.fromMap(result.first) : null;
  }

  Future<int> updateStockLine(StockLine StockLine) async {
    final database = await db.database;
    return await database.update('stock_lines', StockLine.toMap(), where: 'id = ?', whereArgs: [StockLine.id]);
  }

  Future<int> deleteStockLine(String id) async {
    final database = await db.database;
    return await database.delete('stock_lines', where: 'id = ?', whereArgs: [id]);
  }
}
