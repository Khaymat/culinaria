import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMealsByCategory implements UseCase<List<Meal>, String> {
  final MealRepository repository;

  GetMealsByCategory(this.repository);

  @override
  Future<Either<Failure, List<Meal>>> call(String category) async {
    return await repository.getMealsByCategory(category);
  }
}
