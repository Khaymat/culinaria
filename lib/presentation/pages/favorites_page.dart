import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../blocs/favorite_bloc.dart';
import 'meal_detail_page.dart';

class FavoritesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<FavoriteBloc>()..add(LoadFavorites()),
      child: Scaffold(
        appBar: AppBar(title: Text('Favorite Meals')),
        body: BlocBuilder<FavoriteBloc, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is FavoriteError) {
              return Center(child: Text(state.message));
            } else if (state is FavoritesLoaded) {
              if (state.meals.isEmpty) return Center(child: Text('No favorite meals yet.'));
              return ListView.builder(
                itemCount: state.meals.length,
                itemBuilder: (context, index) {
                  final meal = state.meals[index];
                  return ListTile(
                    leading: Image.network(meal.strMealThumb, width: 50, height: 50, fit: BoxFit.cover),
                    title: Text(meal.strMeal),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => MealDetailPage(mealId: meal.idMeal)),
                      ).then((_) {

                        context.read<FavoriteBloc>().add(LoadFavorites());
                      });
                    },
                  );
                },
              );
            }
            return Container();
          },
        ),
      ),
    );
  }
}
