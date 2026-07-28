import 'package:flutter/material.dart';
import 'package:calorio/models/category.dart';
import 'package:calorio/models/meal.dart';
import 'package:calorio/screens/meals.dart';
import 'package:calorio/widgets/category_widgets/category_grid_item.dart';
import 'package:calorio/data/dummy_data.dart';

class CategoriesScreen extends StatefulWidget {
  const CategoriesScreen({
    super.key,
    required this.mealList,
  });

  final List<Meal> mealList;

  @override
  State<CategoriesScreen> createState() {
    return _CategoriesScreenState();
  }
}

class _CategoriesScreenState extends State<CategoriesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 350),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _selectCategory(BuildContext ctx, Category category) {
    final mealsByCategory = widget.mealList
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
    return AnimatedBuilder(
      animation: _animationController,
      child: GridView(
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
      builder: (BuildContext context, Widget? child) => SlideTransition(
        position:
            Tween(
              begin: const Offset(0, 1),
              end: const Offset(0, 0),
            ).animate(
              CurvedAnimation(
                parent: _animationController,
                curve: Curves.easeInOut,
              ),
            ),

        child: child,
      ),
      // child:
    );
  }
}
