import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetFavoriteMeals implements UseCase<List<Meal>, NoParams> {
  final MealRepository repository;
  GetFavoriteMeals(this.repository);
  @override
  Future<Either<Failure, List<Meal>>> call(NoParams params) async {
    return await repository.getFavoriteMeals();
  }
}

class SaveFavoriteMeal implements UseCase<void, Meal> {
  final MealRepository repository;
  SaveFavoriteMeal(this.repository);
  @override
  Future<Either<Failure, void>> call(Meal meal) async {
    return await repository.saveFavoriteMeal(meal);
  }
}

class RemoveFavoriteMeal implements UseCase<void, String> {
  final MealRepository repository;
  RemoveFavoriteMeal(this.repository);
  @override
  Future<Either<Failure, void>> call(String id) async {
    return await repository.removeFavoriteMeal(id);
  }
}

class CheckFavoriteStatus implements UseCase<bool, String> {
  final MealRepository repository;
  CheckFavoriteStatus(this.repository);
  @override
  Future<Either<Failure, bool>> call(String id) async {
    return await repository.isFavorite(id);
  }
}
