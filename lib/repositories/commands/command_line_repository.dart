import 'package:e_commerce_app/database/ecommerce_database.dart';
import 'package:e_commerce_app/database/models/command_line_model.dart';
import 'package:sqflite/sqflite.dart';

class CommandLineRepository {
  final db = ECommerceDatabase.instance;

  Future<bool> insertCommandLine(CommandLine line) async {
    final database = await db.database;
    await database.insert('command_lines', line.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
    return true;
  }

  Future<List<CommandLine>> getCommandLinesByCommandId(String commandId) async {
    final database = await db.database;
    final result = await database.query('command_lines', where: 'commandId = ?', whereArgs: [commandId]);
    return result.map((e) => CommandLine.fromMap(e)).toList();
  }

  Future<List<CommandLine>> getAllCommandLinesNotSync() async {
    final database = await db.database;
    final result = await database.query('command_lines', where: 'syncRow = ?', whereArgs: ['N']);
    return result.map((e) => CommandLine.fromMap(e)).toList();
  }

  Future<List<CommandLine>> getAllCommandLinesSync() async {
    final database = await db.database;
    final result = await database.query('command_lines', where: 'syncRow = ?', whereArgs: ['Y']);
    return result.map((e) => CommandLine.fromMap(e)).toList();
  }

  Future<CommandLine?> getCommandLineById(String id) async {
    final database = await db.database;
    final result = await database.query('command_lines', where: 'id = ?', whereArgs: [id]);
    return result.isNotEmpty ? CommandLine.fromMap(result.first) : null;
  }

  Future<int> updateCommandLine(CommandLine commandLine) async {
    final database = await db.database;
    return await database.update('command_lines', commandLine.toMap(), where: 'id = ?', whereArgs: [commandLine.id]);
  }

  Future<int> deleteCommandLine(String id) async {
    final database = await db.database;
    return await database.delete('command_lines', where: 'id = ?', whereArgs: [id]);
  }
}
