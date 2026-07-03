import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../core/usecase/usecase.dart';
import '../entities/category.dart';
import '../repositories/meal_repository.dart';

class GetCategories implements UseCase<List<Category>, NoParams> {
  final MealRepository repository;

  GetCategories(this.repository);

  @override
  Future<Either<Failure, List<Category>>> call(NoParams params) async {
    return await repository.getCategories();
  }
}
