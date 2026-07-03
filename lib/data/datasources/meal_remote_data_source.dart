import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../core/error/exceptions.dart';
import '../models/category_model.dart';
import '../models/meal_model.dart';

abstract class MealRemoteDataSource {
  Future<List<CategoryModel>> getCategories();
  Future<List<MealModel>> getMealsByCategory(String category);
  Future<List<MealModel>> searchMeals(String query);
  Future<MealModel> getMealDetails(String id);
}

class MealRemoteDataSourceImpl implements MealRemoteDataSource {
  final http.Client client;
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  MealRemoteDataSourceImpl({required this.client});

  @override
  Future<List<CategoryModel>> getCategories() async {
    final response = await client.get(Uri.parse('$baseUrl/categories.php'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return (data['categories'] as List).map((e) => CategoryModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MealModel>> getMealsByCategory(String category) async {
    final response = await client.get(Uri.parse('$baseUrl/filter.php?c=$category'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List).map((e) => MealModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<MealModel>> searchMeals(String query) async {
    final response = await client.get(Uri.parse('$baseUrl/search.php?s=$query'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null) return [];
      return (data['meals'] as List).map((e) => MealModel.fromJson(e)).toList();
    } else {
      throw ServerException();
    }
  }

  @override
  Future<MealModel> getMealDetails(String id) async {
    final response = await client.get(Uri.parse('$baseUrl/lookup.php?i=$id'));
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      if (data['meals'] == null || data['meals'].isEmpty) throw ServerException();
      return MealModel.fromJson(data['meals'][0]);
    } else {
      throw ServerException();
    }
  }
}
