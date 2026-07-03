import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../blocs/meal_detail_bloc.dart';
import '../blocs/favorite_bloc.dart';

class MealDetailPage extends StatelessWidget {
  final String mealId;

  const MealDetailPage({required this.mealId});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => sl<MealDetailBloc>()..add(FetchMealDetail(mealId))),
        BlocProvider(create: (_) => sl<FavoriteBloc>()..add(CheckFavorite(mealId))),
      ],
      child: Scaffold(
        appBar: AppBar(
          title: Text('Meal Detail'),
          actions: [
            BlocBuilder<MealDetailBloc, MealDetailState>(
              builder: (context, detailState) {
                if (detailState is MealDetailLoaded) {
                  return BlocBuilder<FavoriteBloc, FavoriteState>(
                    builder: (context, favState) {
                      bool isFav = false;
                      if (favState is FavoriteStatusLoaded) {
                        isFav = favState.isFavorite;
                      }
                      return IconButton(
                        icon: Icon(isFav ? Icons.favorite : Icons.favorite_border),
                        onPressed: () {
                          context.read<FavoriteBloc>().add(ToggleFavorite(detailState.meal));
                        },
                      );
                    },
                  );
                }
                return Container();
              },
            )
          ],
        ),
        body: BlocBuilder<MealDetailBloc, MealDetailState>(
          builder: (context, state) {
            if (state is MealDetailLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MealDetailError) {
              return Center(child: Text(state.message));
            } else if (state is MealDetailLoaded) {
              final meal = state.meal;
              return SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Image.network(meal.strMealThumb, width: double.infinity, fit: BoxFit.cover),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(meal.strMeal, style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          if (meal.strCategory != null) Text('Category: ${meal.strCategory}'),
                          if (meal.strArea != null) Text('Area: ${meal.strArea}'),
                          SizedBox(height: 16),
                          Text('Instructions', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                          SizedBox(height: 8),
                          Text(meal.strInstructions ?? 'No instructions available.'),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
