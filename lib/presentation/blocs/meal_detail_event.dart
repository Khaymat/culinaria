part of 'meal_detail_bloc.dart';
abstract class MealDetailEvent extends Equatable {
  const MealDetailEvent();
  @override
  List<Object> get props => [];
}
class FetchMealDetail extends MealDetailEvent {
  final String id;
  const FetchMealDetail(this.id);
  @override
  List<Object> get props => [id];
}
