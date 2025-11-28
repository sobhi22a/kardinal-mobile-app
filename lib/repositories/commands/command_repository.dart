import 'package:e_commerce_app/database/ecommerce_database.dart';
import 'package:e_commerce_app/database/models/command_model.dart';
import 'package:sqflite/sqflite.dart';

class CommandRepository {
  final db = ECommerceDatabase.instance;

  Future<bool> insertCommand(Command command) async {
    try {
      final database = await db.database;
      final result = await database.insert(
        'commands',
        command.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      return result > 0;
    } catch (e) {
      print('❌ Error inserting command: $e');
      return false;
    }
  }

  Future<List<Command>> getAllCommands() async {
    final database = await db.database;
    final result = await database.query('commands');
    return result.map((e) => Command.fromMap(e)).toList();
  }

  Future<List<Command>> getAllCommandsNotSync() async {
    final database = await db.database;
    final result = await database.query('commands', where: 'syncRow = ? and status = ?', whereArgs: ['N', 2]);
    return result.map((e) => Command.fromMap(e)).toList();
  }

  Future<List<Command>> getAllCommandsSync() async {
    final database = await db.database;
    final result = await database.query('commands', where: 'syncRow = ? and status = ?', whereArgs: ['Y', 2]);
    return result.map((e) => Command.fromMap(e)).toList();
  }

  Future<Command?> getCommandIsNewByClientId({required String clientId}) async {
    final database = await db.database;
    final result = await database.query(
      'commands',
      where: 'clientId = ? AND status = ?',
      whereArgs: [clientId, 1],
    );
    return result.isNotEmpty ? Command.fromMap(result.first) : null;
  }

  Future<Command?> getCommandById(String id) async {
    final database = await db.database;
    final result = await database.query(
      'commands',
      where: 'id = ?',
      whereArgs: [id],
    );
    return result.isNotEmpty ? Command.fromMap(result.first) : null;
  }

  Future<int> deleteCommand(String id) async {
    final database = await db.database;
    return await database.delete('commands', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateCommand(Command command) async {
    final database = await db.database;
    return await database.update('commands', command.toMap(), where: 'id = ?', whereArgs: [command.id]);
  }
}
