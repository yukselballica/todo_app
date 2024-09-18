import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class VeritabaniLog {
  static Future<Database> veritabaniErisim() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, 'todo_app.db');

    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE login(id INTEGER PRIMARY KEY, username TEXT, password TEXT)',
        );
      },
      version: 1,
    );
  }

  static Future<void> kullaniciEkle(String username, String password) async {
    try {
      final db = await veritabaniErisim();
      await db.insert(
        'login',
        {'username': username, 'password': password},
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      print("Kullanıcı ekleme hatası: $e");
    }
  }

  static Future<bool> kullaniciKontrol(String username, String password) async {
    try {
      final db = await veritabaniErisim();
      final List<Map<String, dynamic>> maps = await db.query(
        'login',
        where: 'username = ? AND password = ?',
        whereArgs: [username, password],
      );
      return maps.isNotEmpty;
    } catch (e) {
      print("Kullanıcı kontrol hatası: $e");
      return false;
    }
  }

  static Future<bool> kullaniciVarMi(String username) async {
    try {
      final db = await veritabaniErisim();
      final List<Map<String, dynamic>> maps = await db.query(
        'login',
        where: 'username = ?',
        whereArgs: [username],
      );
      return maps.isNotEmpty;
    } catch (e) {
      print("Kullanıcı var mı hatası: $e");
      return false;
    }
  }

  static Future<void> sifreGuncelle(String username, String newPassword) async {
    try {
      final db = await veritabaniErisim();
      await db.update(
        'login',
        {'password': newPassword},
        where: 'username = ?',
        whereArgs: [username],
      );
    } catch (e) {
      print("Şifre güncelleme hatası: $e");
    }
  }
}
