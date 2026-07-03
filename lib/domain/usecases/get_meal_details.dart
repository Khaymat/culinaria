import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/meal.dart';
import '../repositories/meal_repository.dart';

class GetMealDetails implements UseCase<Meal, String> {
  final MealRepository repository;

  GetMealDetails(this.repository);

  @override
  Future<Either<Failure, Meal>> call(String id) async {
    return await repository.getMealDetails(id);
  }
}
