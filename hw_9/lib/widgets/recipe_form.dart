import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:uuid/uuid.dart';
import '../models/recipe.dart';
import '../providers/recipe_provider.dart';

class RecipeForm extends StatefulWidget {
  final Recipe? existingRecipe;
  final Function(Recipe) onSave;

  const RecipeForm({
    super.key,
    this.existingRecipe,
    required this.onSave,
  });

  @override
  State<RecipeForm> createState() => _RecipeFormState();
}

class _RecipeFormState extends State<RecipeForm> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  late final TextEditingController _ingredientsController;
  late final TextEditingController _instructionsController;
  String? _selectedCategory;

  @override
  void initState() {
    super.initState();
    final recipe = widget.existingRecipe;
    _titleController = TextEditingController(text: recipe?.title ?? '');
    _descriptionController = TextEditingController(text: recipe?.description ?? '');
    _ingredientsController = TextEditingController(
      text: recipe?.ingredients.join(', ') ?? '',
    );
    _instructionsController = TextEditingController(
      text: recipe?.instructions.join(', ') ?? '',
    );
    _selectedCategory = recipe?.category;
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    _ingredientsController.dispose();
    _instructionsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final recipeProvider = Provider.of<RecipeProvider>(context, listen: false);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Padding(
          padding: EdgeInsets.fromLTRB(20, 16, 20, 20),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Назва рецепту'),
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _descriptionController,
              decoration: const InputDecoration(labelText: 'Короткий опис',
                alignLabelWithHint: true,
              ),
              maxLines: 3,
              minLines: 1,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Інгредієнти (через кому)',
              ),
              maxLines: 5,
              minLines: 1,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: _instructionsController,
              decoration: const InputDecoration(
                labelText: 'Інструкції (через кому)',
              ),
              maxLines: 5,
              minLines: 1,
            ),
            const SizedBox(height: 16),
            DropdownButton<String>(
              value: _selectedCategory,
              hint: const Text('Виберіть категорію'),
              isExpanded: true,
              items: recipeProvider.categories.map((String category) {
                return DropdownMenuItem<String>(
                  value: category,
                  child: Text(category),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedCategory = newValue;
                });
              },
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () {
                final title = _titleController.text.trim();
                final description = _descriptionController.text.trim();
                final ingredients = _ingredientsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();
                final instructions = _instructionsController.text
                    .split(',')
                    .map((e) => e.trim())
                    .where((e) => e.isNotEmpty)
                    .toList();

                if (title.isNotEmpty && description.isNotEmpty) {
                  final recipe = Recipe(
                    id: widget.existingRecipe?.id ?? Uuid().v4(),
                    title: title,
                    description: description,
                    ingredients: ingredients,
                    instructions: instructions,
                    category: _selectedCategory,
                  );
                  widget.onSave(recipe);
                }
              },
              child: Text(widget.existingRecipe == null ? 'Додати рецепт' : 'Зберегти зміни'),
            ),
          ],
        ),
      ),
    );
  }
}