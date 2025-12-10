import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/recipe_provider.dart';
import '../widgets/recipe_form.dart';

class AddRecipeScreen extends StatelessWidget {
  const AddRecipeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Додати рецепт'),
      ),
      body: RecipeForm(
        onSave: (recipe) {
          recipeProvider.addRecipe(recipe);
          Navigator.pop(context);
        },
      ),
    );
  }
}