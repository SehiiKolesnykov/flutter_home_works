import 'package:flutter/cupertino.dart';
import 'package:hw_9/models/recipe.dart';
import 'package:uuid/uuid.dart';

class RecipeProvider with ChangeNotifier {
  final List<Recipe> _recipes = [];
  final List<String> _categories = ['Сніданок', 'Обід', 'Вечеря', 'Десерт', 'Інше'];

  List<Recipe> get recipes => List.unmodifiable(_recipes);
  List<String> get categories => List.unmodifiable(_categories);

  void addRecipe(Recipe recipe) {
    final newRecipe = Recipe(
        id: const Uuid().v4(),
        title: recipe.title,
        description: recipe.description,
        ingredients: recipe.ingredients,
        instructions: recipe.instructions,
        category: recipe.category
    );

    _recipes.add(newRecipe);
    notifyListeners();
  }

  void editRecipe(String id, Recipe updatedRecipe) {

    final index = _recipes.indexWhere((r) => r.id == id);

    if (index != -1) {
      _recipes[index] = Recipe(
          id: id,
          title: updatedRecipe.title,
          description: updatedRecipe.description,
          ingredients: updatedRecipe.ingredients,
          instructions: updatedRecipe.instructions,
          category: updatedRecipe.category
      );

      notifyListeners();
    }
  }

  List<Recipe> getFilteredRecipes(String searchQuery, String? selectedCategory) {
    return _recipes.where((recipe) {
      final matchesSearch = recipe.title.toLowerCase().contains(searchQuery.toLowerCase());
      final matchesCategory = selectedCategory == null || selectedCategory == 'Усі' || recipe.category == selectedCategory;
      return matchesSearch && matchesCategory;
    }).toList();
  }
}