import 'dart:async';
import 'dart:developer';

import 'package:sensor_track/data/models/item.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class ItemRepository {
  late Database _database;
  late StreamController<List<Item>> _itemStreamController;

  ItemRepository() {
    _itemStreamController = StreamController<List<Item>>.broadcast();
    initialize();
  }

  Future<void> initialize() async {
    final path = await getDatabasesPath();
    final databasePath = join(path, 'item.db');

    _database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE item(id INTEGER PRIMARY KEY AUTOINCREMENT, name TEXT, createdAt TEXT)',
        );
      },
    );

    _fetchItemData();
  }

  Stream<List<Item>> getAllItem() {
    return _itemStreamController.stream;
  }

  Future<void> _fetchItemData() async {
    final List<Map<String, dynamic>> maps = await _database.query('item');
    log(maps.toString());
    final items = maps
        .map(
          (e) => Item(
            id: e['id'],
            name: e['name'],
            createdAt: DateTime.parse(e['createdAt']),
          ),
        )
        .toList();
    _itemStreamController.add(items);
  }

  Future<void> addItem(Item item) async {
    log('${item.toMap()}');
    await _database.insert(
      'item',
      item.toMap(),
    );
    _fetchItemData();
  }

  Future<void> updateItem(Item item) async {
    await _database.update(
      'item',
      {
        'name': item.name,
        'createdAt': item.createdAt!.toIso8601String(),
      },
      where: 'id = ?',
      whereArgs: [item.id],
    );
    _fetchItemData();
  }

  Future<void> deleteItem(int id) async {
    await _database.delete(
      'item',
      where: 'id = ?',
      whereArgs: [id],
    );
    _fetchItemData();
  }

  void dispose() {
    _itemStreamController.close();
  }
}
