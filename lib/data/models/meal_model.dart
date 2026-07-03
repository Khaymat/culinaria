import '../../domain/entities/meal.dart';

class MealModel extends Meal {
  const MealModel({
    required super.idMeal,
    required super.strMeal,
    required super.strMealThumb,
    super.strCategory,
    super.strArea,
    super.strInstructions,
    super.strYoutube,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      idMeal: json['idMeal'],
      strMeal: json['strMeal'],
      strMealThumb: json['strMealThumb'],
      strCategory: json['strCategory'],
      strArea: json['strArea'],
      strInstructions: json['strInstructions'],
      strYoutube: json['strYoutube'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'idMeal': idMeal,
      'strMeal': strMeal,
      'strMealThumb': strMealThumb,
      'strCategory': strCategory,
      'strArea': strArea,
      'strInstructions': strInstructions,
      'strYoutube': strYoutube,
    };
  }
}
