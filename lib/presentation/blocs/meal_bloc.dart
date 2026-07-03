import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/get_meals_by_category.dart';
import '../../domain/usecases/search_meals.dart';

part 'meal_event.dart';
part 'meal_state.dart';

class MealBloc extends Bloc<MealEvent, MealState> {
  final GetMealsByCategory getMealsByCategory;
  final SearchMeals searchMeals;

  MealBloc({required this.getMealsByCategory, required this.searchMeals}) : super(MealInitial()) {
    on<FetchMealsByCategory>((event, emit) async {
      emit(MealLoading());
      final result = await getMealsByCategory(event.category);
      result.fold(
        (failure) => emit(MealError(failure.message)),
        (meals) => emit(MealLoaded(meals)),
      );
    });

    on<SearchMealsEvent>((event, emit) async {
      emit(MealLoading());
      final result = await searchMeals(event.query);
      result.fold(
        (failure) => emit(MealError(failure.message)),
        (meals) => emit(MealLoaded(meals)),
      );
    });
  }
}
