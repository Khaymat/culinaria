part of 'favorite_bloc.dart';
abstract class FavoriteState extends Equatable {
  const FavoriteState();
  @override
  List<Object> get props => [];
}
class FavoriteInitial extends FavoriteState {}
class FavoriteLoading extends FavoriteState {}
class FavoritesLoaded extends FavoriteState {
  final List<Meal> meals;
  const FavoritesLoaded(this.meals);
  @override
  List<Object> get props => [meals];
}
class FavoriteStatusLoaded extends FavoriteState {
  final bool isFavorite;
  const FavoriteStatusLoaded(this.isFavorite);
  @override
  List<Object> get props => [isFavorite];
}
class FavoriteError extends FavoriteState {
  final String message;
  const FavoriteError(this.message);
  @override
  List<Object> get props => [message];
}
