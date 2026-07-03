import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class SearchMeals implements UseCase<List<Meal>, String> {
  final MealRepository repository;

  SearchMeals(this.repository);

  @override
  Future<Either<Failure, List<Meal>>> call(String query) async {
    return await repository.searchMeals(query);
  }
}
