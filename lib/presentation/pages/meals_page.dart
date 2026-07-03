import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../blocs/meal_bloc.dart';
import 'meal_detail_page.dart';

class MealsPage extends StatelessWidget {
  final String category;

  const MealsPage({required this.category});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MealBloc>()..add(FetchMealsByCategory(category)),
      child: Scaffold(
        appBar: AppBar(title: Text('$category Meals')),
        body: BlocBuilder<MealBloc, MealState>(
          builder: (context, state) {
            if (state is MealLoading) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MealError) {
              return Center(child: Text(state.message));
            } else if (state is MealLoaded) {
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
                      );
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
