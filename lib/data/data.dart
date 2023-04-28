import 'package:regwalls/model/categories_model.dart';

String apiKey = "01dV8NfN3Eve12VlKutbryGYulaFRbftOYYU5ev09mmG0JCSjD978reo";

List<CategoriesModel> getCategories() {

  List<CategoriesModel> categories = [];
  CategoriesModel categoryModel = CategoriesModel();


  categoryModel.categoryName = "Minimal";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "Pastel";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "Dark";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "Street Art";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "Nature";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "City";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "Football";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();


  categoryModel.categoryName = "Cars";
  categories.add(categoryModel);
  categoryModel = CategoriesModel();



  return categories;
}