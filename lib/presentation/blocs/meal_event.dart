part of 'meal_bloc.dart';
abstract class MealEvent extends Equatable {
  const MealEvent();
  @override
  List<Object> get props => [];
}
class FetchMealsByCategory extends MealEvent {
  final String category;
  const FetchMealsByCategory(this.category);
  @override
  List<Object> get props => [category];
}
class SearchMealsEvent extends MealEvent {
  final String query;
  const SearchMealsEvent(this.query);
  @override
  List<Object> get props => [query];
}
