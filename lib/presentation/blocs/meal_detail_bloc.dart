import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/get_meal_details.dart';

part 'meal_detail_event.dart';
part 'meal_detail_state.dart';

class MealDetailBloc extends Bloc<MealDetailEvent, MealDetailState> {
  final GetMealDetails getMealDetails;

  MealDetailBloc({required this.getMealDetails}) : super(MealDetailInitial()) {
    on<FetchMealDetail>((event, emit) async {
      emit(MealDetailLoading());
      final result = await getMealDetails(event.id);
      result.fold(
        (failure) => emit(MealDetailError(failure.message)),
        (meal) => emit(MealDetailLoaded(meal)),
      );
    });
  }
}
