import 'package:flutter/material.dart';
import '../models/recipe.dart';
import 'detail_section.dart';

class RecipeDetailsBody extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailsBody({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [

          DetailSection(
            title: 'Опис',
            child: Text(recipe.description),
          ),

          DetailSection(
            title: 'Інгредієнти',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.ingredients
                  .map((ing) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2.0),
                child: Text('- $ing'),
              ))
                  .toList(),
            ),
          ),

          DetailSection(
            title: 'Інструкції',
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: recipe.instructions.asMap().entries.map((entry) {
                final index = entry.key + 1;
                final instruction = entry.value;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4.0),
                  child: Text('$index. $instruction'),
                );
              }).toList(),
            ),
          ),

          if (recipe.category != null)
            DetailSection(
              title: 'Категорія',
              padding: EdgeInsets.zero,
              child: Text(recipe.category!),
            ),
        ],
      ),
    );
  }
}