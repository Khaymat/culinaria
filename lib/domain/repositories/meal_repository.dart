import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/category.dart';
import '../entities/meal.dart';

abstract class MealRepository {
  Future<Either<Failure, List<Category>>> getCategories();
  Future<Either<Failure, List<Meal>>> getMealsByCategory(String category);
  Future<Either<Failure, List<Meal>>> searchMeals(String query);
  Future<Either<Failure, Meal>> getMealDetails(String id);

  Future<Either<Failure, List<Meal>>> getFavoriteMeals();
  Future<Either<Failure, void>> saveFavoriteMeal(Meal meal);
  Future<Either<Failure, void>> removeFavoriteMeal(String id);
  Future<Either<Failure, bool>> isFavorite(String id);
}
