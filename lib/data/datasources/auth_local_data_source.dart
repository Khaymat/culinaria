import 'package:sqflite/sqflite.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../core/error/exceptions.dart';
import '../models/user_model.dart';

abstract class AuthLocalDataSource {
  Future<UserModel> register(String name, String email, String password);
  Future<UserModel> login(String email, String password);
  Future<void> logout();
  Future<UserModel?> getCurrentUser();
}

class AuthLocalDataSourceImpl implements AuthLocalDataSource {
  final Database database;
  final SharedPreferences sharedPreferences;

  AuthLocalDataSourceImpl({
    required this.database,
    required this.sharedPreferences,
  });

  @override
  Future<UserModel> register(String name, String email, String password) async {
    try {
      final existing = await database.query(
        'users',
        where: 'email = ?',
        whereArgs: [email],
      );
      if (existing.isNotEmpty) {
        throw CacheException();
      }
      final id = await database.insert('users', {
        'name': name,
        'email': email,
        'password': password,
      });
      final user = UserModel(id: id, name: name, email: email);
      await sharedPreferences.setInt('current_user_id', id);
      return user;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException();
    }
  }

  @override
  Future<UserModel> login(String email, String password) async {
    try {
      final maps = await database.query(
        'users',
        where: 'email = ? AND password = ?',
        whereArgs: [email, password],
      );
      if (maps.isEmpty) {
        throw CacheException();
      }
      final user = UserModel.fromJson(maps.first);
      await sharedPreferences.setInt('current_user_id', user.id);
      return user;
    } catch (e) {
      if (e is CacheException) rethrow;
      throw CacheException();
    }
  }

  @override
  Future<void> logout() async {
    await sharedPreferences.remove('current_user_id');
  }

  @override
  Future<UserModel?> getCurrentUser() async {
    final userId = sharedPreferences.getInt('current_user_id');
    if (userId == null) return null;
    final maps = await database.query(
      'users',
      where: 'id = ?',
      whereArgs: [userId],
    );
    if (maps.isEmpty) return null;
    return UserModel.fromJson(maps.first);
  }
}
