import 'package:sqflite/sqflite.dart';
import '../../core/error/exceptions.dart';
import '../models/meal_model.dart';

abstract class MealLocalDataSource {
  Future<List<MealModel>> getFavoriteMeals();
  Future<void> saveFavoriteMeal(MealModel meal);
  Future<void> removeFavoriteMeal(String id);
  Future<bool> isFavorite(String id);
}

class MealLocalDataSourceImpl implements MealLocalDataSource {
  final Database database;

  MealLocalDataSourceImpl({required this.database});

  @override
  Future<List<MealModel>> getFavoriteMeals() async {
    try {
      final List<Map<String, dynamic>> maps = await database.query('favorites');
      return maps.map((e) => MealModel.fromJson(e)).toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> saveFavoriteMeal(MealModel meal) async {
    try {
      await database.insert(
        'favorites',
        meal.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> removeFavoriteMeal(String id) async {
    try {
      await database.delete(
        'favorites',
        where: 'idMeal = ?',
        whereArgs: [id],
      );
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<bool> isFavorite(String id) async {
    try {
      final List<Map<String, dynamic>> maps = await database.query(
        'favorites',
        where: 'idMeal = ?',
        whereArgs: [id],
      );
      return maps.isNotEmpty;
    } catch (e) {
      throw CacheException();
    }
  }
}
