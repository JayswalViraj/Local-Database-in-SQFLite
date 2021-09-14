import 'package:sqflite/sqflite.dart';
import 'dart:io';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';


class User {
  final int? id;
  final String name;
  final String email;
  final String mob;

  User ({ this.id, required this.name, required this.email, required this.mob });

  factory User .fromMap(Map<String, dynamic> json) => new User (
    id: json['id'],
    name: json['name'],
    email: json['email'],
    mob: json['mob']
  );

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,

      'email': email,
      'mob': mob,
    };
  }
}

class DatabaseHelper {

  DatabaseHelper._privateConstructor();
  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database? _database;
  Future<Database> get database async => _database ??= await _initDatabase();

  Future<Database> _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, 'userdatabase.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: _onCreate,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE userdatabase(
          id INTEGER PRIMARY KEY,
          name TEXT,
          email TEXT,
          mob TEXT
      )
      ''');
  }

  Future<List<User>> getUserdata() async {
    Database db = await instance.database;
    var userdata = await db.query('userdatabase');
    List<User> userList = userdata.isNotEmpty
        ? userdata.map((c) => User.fromMap(c)).toList()
        : [];
    return userList;
  }

  Future<int> add(User data) async {
    Database db = await instance.database;
    return await db.insert('userdatabase', data.toMap());
  }

  Future<int> remove(int id) async {
    Database db = await instance.database;
    return await db.delete('userdatabase', where: 'id = ?', whereArgs: [id]);
  }

  Future<int> update(User data) async {
    Database db = await instance.database;
    return await db.update('userdatabase', data.toMap(),
        where: "id = ?", whereArgs: [data.id]);
  }

}