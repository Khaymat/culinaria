import '../../domain/entities/category.dart';

class CategoryModel extends Category {
  const CategoryModel({
    required super.idCategory,
    required super.strCategory,
    required super.strCategoryThumb,
    required super.strCategoryDescription,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      idCategory: json['idCategory'],
      strCategory: json['strCategory'],
      strCategoryThumb: json['strCategoryThumb'],
      strCategoryDescription: json['strCategoryDescription'],
    );
  }
}
