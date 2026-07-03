import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../core/usecase/usecase.dart';
import '../../domain/entities/meal.dart';
import '../../domain/usecases/manage_favorites.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final GetFavoriteMeals getFavoriteMeals;
  final SaveFavoriteMeal saveFavoriteMeal;
  final RemoveFavoriteMeal removeFavoriteMeal;
  final CheckFavoriteStatus checkFavoriteStatus;

  FavoriteBloc({
    required this.getFavoriteMeals,
    required this.saveFavoriteMeal,
    required this.removeFavoriteMeal,
    required this.checkFavoriteStatus,
  }) : super(FavoriteInitial()) {
    on<LoadFavorites>((event, emit) async {
      emit(FavoriteLoading());
      final result = await getFavoriteMeals(NoParams());
      result.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (meals) => emit(FavoritesLoaded(meals)),
      );
    });

    on<ToggleFavorite>((event, emit) async {
      final isFav = await checkFavoriteStatus(event.meal.idMeal);
      bool currentlyFav = false;
      isFav.fold((l) => null, (r) => currentlyFav = r);

      if (currentlyFav) {
        await removeFavoriteMeal(event.meal.idMeal);
      } else {
        await saveFavoriteMeal(event.meal);
      }


      final newStatus = await checkFavoriteStatus(event.meal.idMeal);
      newStatus.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (status) => emit(FavoriteStatusLoaded(status)),
      );
    });

    on<CheckFavorite>((event, emit) async {
      final result = await checkFavoriteStatus(event.id);
      result.fold(
        (failure) => emit(FavoriteError(failure.message)),
        (status) => emit(FavoriteStatusLoaded(status)),
      );
    });
  }
}
