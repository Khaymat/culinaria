import 'package:equatable/equatable.dart';

class Meal extends Equatable {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strCategory;
  final String? strArea;
  final String? strInstructions;
  final String? strYoutube;

  const Meal({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
    this.strArea,
    this.strInstructions,
    this.strYoutube,
  });

  @override
  List<Object?> get props => [idMeal, strMeal, strMealThumb, strCategory, strArea, strInstructions, strYoutube];
}
