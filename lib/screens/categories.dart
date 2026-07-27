import 'package:flutter/material.dart';
import 'package:calorio/models/category.dart';
import 'package:calorio/models/meal.dart';
import 'package:calorio/screens/meals.dart';
import 'package:calorio/widgets/category_widgets/category_grid_item.dart';
import 'package:calorio/data/dummy_data.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({
    super.key,
    required this.mealList,
  });

  final List<Meal> mealList;

  void _selectCategory(BuildContext ctx, Category category) {
    final List<Meal> mealsByCategory = mealList
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
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
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
    );
  }
}
