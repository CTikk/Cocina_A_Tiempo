import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'ingredient_model.dart';
import 'timer_model.dart';

class DBHelper {
  static final DBHelper _instance = DBHelper._internal();
  factory DBHelper() => _instance;
  DBHelper._internal();

  static Database? _db;

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'cocina_tiempo.db');

    return await openDatabase(
      path,
      version: 2,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE ingredients (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            time TEXT,
            image TEXT,
            types TEXT
          )
        ''');
        await db.execute('''
          CREATE TABLE timers (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT,
            totalSeconds INTEGER,
            remainingSeconds INTEGER,
            isRunning INTEGER
          )
        ''');
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await db.execute('''
            CREATE TABLE IF NOT EXISTS timers (
              id INTEGER PRIMARY KEY AUTOINCREMENT,
              name TEXT,
              totalSeconds INTEGER,
              remainingSeconds INTEGER,
              isRunning INTEGER
            )
          ''');
        }
      },
    );
  }

  // INGREDIENTES

  Future<int> insertIngredient(Ingredient ingredient) async {
    final db = await database;
    return await db.insert('ingredients', ingredient.toMap());
  }

  Future<List<Ingredient>> getIngredients() async {
    final db = await database;
    final result = await db.query('ingredients');
    return result.map((e) => Ingredient.fromMap(e)).toList();
  }

  Future<void> insertDefaultIngredients() async {
    final db = await database;
    final result = await db.query('ingredients');
    if (result.isEmpty) {
      final List<Ingredient> defaultIngredients = [
        Ingredient(name: 'Carne de res', time: '30 min', image: 'food_meat.png', types: ['Frito', 'Asado']),
        Ingredient(name: 'Pollo', time: '25 min', image: 'food_chicken.png', types: ['Horneado', 'Asado']),
        Ingredient(name: 'Arroz', time: '18 min', image: 'food_rice.png', types: ['Hervido']),
        Ingredient(name: 'Huevo', time: '10 min', image: 'food_eggs.png', types: ['Hervido', 'Frito']),
      ];

      for (var ingredient in defaultIngredients) {
        await db.insert('ingredients', ingredient.toMap());
      }
    }
  }

  Future<int> deleteIngredient(int id) async {
    final db = await database;
    return await db.delete('ingredients', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> updateIngredient(Ingredient ingredient) async {
    final db = await database;
    return await db.update(
      'ingredients',
      ingredient.toMap(),
      where: 'id = ?',
      whereArgs: [ingredient.id],
    );
  }

  // TEMPORIZADORES

  Future<int> insertTimer(TimerEntry timer) async {
    final db = await database;
    return await db.insert('timers', timer.toMap());
  }

  Future<List<TimerEntry>> getTimers() async {
    final db = await database;
    final result = await db.query('timers');
    return result.map((e) => TimerEntry.fromMap(e)).toList();
  }

  Future<int> updateTimer(TimerEntry timer) async {
    final db = await database;
    return await db.update(
      'timers',
      timer.toMap(),
      where: 'id = ?',
      whereArgs: [timer.id],
    );
  }

  Future<int> deleteTimer(int id) async {
    final db = await database;
    return await db.delete(
      'timers',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}
