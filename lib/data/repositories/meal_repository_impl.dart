import 'package:dartz/dartz.dart';
import '../../core/error/exceptions.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/category.dart';
import '../../domain/entities/meal.dart';
import '../../domain/repositories/meal_repository.dart';
import '../datasources/meal_local_data_source.dart';
import '../datasources/meal_remote_data_source.dart';
import '../models/meal_model.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDataSource remoteDataSource;
  final MealLocalDataSource localDataSource;

  MealRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
  });

  @override
  Future<Either<Failure, List<Category>>> getCategories() async {
    try {
      final categories = await remoteDataSource.getCategories();
      return Right(categories);
    } on ServerException {
      return Left(ServerFailure('Failed to load categories'));
    }
  }

  @override
  Future<Either<Failure, List<Meal>>> getMealsByCategory(String category) async {
    try {
      final meals = await remoteDataSource.getMealsByCategory(category);
      return Right(meals);
    } on ServerException {
      return Left(ServerFailure('Failed to load meals for category'));
    }
  }

  @override
  Future<Either<Failure, List<Meal>>> searchMeals(String query) async {
    try {
      final meals = await remoteDataSource.searchMeals(query);
      return Right(meals);
    } on ServerException {
      return Left(ServerFailure('Failed to search meals'));
    }
  }

  @override
  Future<Either<Failure, Meal>> getMealDetails(String id) async {
    try {
      final meal = await remoteDataSource.getMealDetails(id);
      return Right(meal);
    } on ServerException {
      return Left(ServerFailure('Failed to load meal details'));
    }
  }

  @override
  Future<Either<Failure, List<Meal>>> getFavoriteMeals() async {
    try {
      final meals = await localDataSource.getFavoriteMeals();
      return Right(meals);
    } on CacheException {
      return Left(CacheFailure('Failed to load favorites'));
    }
  }

  @override
  Future<Either<Failure, void>> saveFavoriteMeal(Meal meal) async {
    try {
      final mealModel = MealModel(
        idMeal: meal.idMeal,
        strMeal: meal.strMeal,
        strMealThumb: meal.strMealThumb,
        strCategory: meal.strCategory,
        strArea: meal.strArea,
        strInstructions: meal.strInstructions,
        strYoutube: meal.strYoutube,
      );
      await localDataSource.saveFavoriteMeal(mealModel);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure('Failed to save favorite'));
    }
  }

  @override
  Future<Either<Failure, void>> removeFavoriteMeal(String id) async {
    try {
      await localDataSource.removeFavoriteMeal(id);
      return Right(null);
    } on CacheException {
      return Left(CacheFailure('Failed to remove favorite'));
    }
  }

  @override
  Future<Either<Failure, bool>> isFavorite(String id) async {
    try {
      final isFav = await localDataSource.isFavorite(id);
      return Right(isFav);
    } on CacheException {
      return Left(CacheFailure('Failed to check favorite status'));
    }
  }
}
