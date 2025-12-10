import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_form.dart';
import '../models/recipe.dart';

class EditRecipeScreen extends StatelessWidget {
  final Recipe recipe;

  const EditRecipeScreen({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Редагувати рецепт'),
      ),
      body: RecipeForm(
        existingRecipe: recipe,
        onSave: (updatedRecipe) {
          recipeProvider.editRecipe(recipe.id, updatedRecipe);
          Navigator.pop(context);
        },
      ),
    );
  }
}