import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../injection_container.dart';
import '../blocs/meal_bloc.dart';
import 'meal_detail_page.dart';

class SearchPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<MealBloc>(),
      child: Scaffold(
        appBar: AppBar(title: Text('Search Meals')),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Builder(
                builder: (context) {
                  return TextField(
                    decoration: InputDecoration(
                      labelText: 'Search',
                      border: OutlineInputBorder(),
                      suffixIcon: Icon(Icons.search),
                    ),
                    onSubmitted: (query) {
                      context.read<MealBloc>().add(SearchMealsEvent(query));
                    },
                  );
                }
              ),
            ),
            Expanded(
              child: BlocBuilder<MealBloc, MealState>(
                builder: (context, state) {
                  if (state is MealLoading) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is MealError) {
                    return Center(child: Text(state.message));
                  } else if (state is MealLoaded) {
                    if (state.meals.isEmpty) return Center(child: Text('No meals found'));
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
                  return Center(child: Text('Enter a search term'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
