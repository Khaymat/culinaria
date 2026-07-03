part of 'meal_bloc.dart';
abstract class MealState extends Equatable {
  const MealState();
  @override
  List<Object> get props => [];
}
class MealInitial extends MealState {}
class MealLoading extends MealState {}
class MealLoaded extends MealState {
  final List<Meal> meals;
  const MealLoaded(this.meals);
  @override
  List<Object> get props => [meals];
}
class MealError extends MealState {
  final String message;
  const MealError(this.message);
  @override
  List<Object> get props => [message];
}
