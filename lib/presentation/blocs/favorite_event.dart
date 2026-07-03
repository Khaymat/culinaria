part of 'favorite_bloc.dart';
abstract class FavoriteEvent extends Equatable {
  const FavoriteEvent();
  @override
  List<Object> get props => [];
}
class LoadFavorites extends FavoriteEvent {}
class ToggleFavorite extends FavoriteEvent {
  final Meal meal;
  const ToggleFavorite(this.meal);
  @override
  List<Object> get props => [meal];
}
class CheckFavorite extends FavoriteEvent {
  final String id;
  const CheckFavorite(this.id);
  @override
  List<Object> get props => [id];
}
