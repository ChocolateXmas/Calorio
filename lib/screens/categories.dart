import 'package:flutter/material.dart';
import 'package:calorio/models/category.dart';
import 'package:calorio/models/meal.dart';
import 'package:calorio/screens/meals.dart';
import 'package:calorio/widgets/category_widgets/category_grid_item.dart';
import 'package:calorio/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({super.key, required this.onToggleFavorite});
  final void Function(Meal meal) onToggleFavorite;

  void _selectCategory(BuildContext ctx, Category category) {
    final List<Meal> mealsByCategory = dummyMeals
        .where(
          (meal) => meal.categories.contains(category.id),
        )
        .toList();
    Navigator.push(
      ctx,
      MaterialPageRoute(
        builder: (BuildContext context) => MealsScreen(
          title: category.title,
          meals: mealsByCategory,
          onToggleFavorite: onToggleFavorite,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView(
        padding: EdgeInsets.all(20),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 20,
        ),
        children: [
          for (final category in availableCategories)
            CategoryGridItem(
              category: category,
              onSelectedCategory: () {
                _selectCategory(context, category);
              },
            ),
        ],
      ),
    );
  }
}
