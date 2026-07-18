import 'package:flutter/material.dart';
import 'package:calorio/models/category.dart';
import 'package:calorio/data/dummy_data.dart';
import 'package:calorio/screens/meals.dart';

class CategoryGridItem extends StatelessWidget {
  const CategoryGridItem({super.key, required this.category});

  final Category category;

  final BorderRadius _itemBorder = const BorderRadius.all(Radius.circular(10));

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) => MealsScreen(
              title: category.title,
              meals: dummyMeals,
            ),
          ),
        );
      },
      splashColor: Theme.of(context).primaryColor,
      borderRadius: _itemBorder,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: _itemBorder,
          gradient: LinearGradient(
            colors: [
              category.color.withAlpha(140),
              category.color.withAlpha(230),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Text(
          category.title,
          style: Theme.of(context).textTheme.titleLarge!.copyWith(
            color: Theme.of(context).colorScheme.onSurface,
          ),
        ),
      ),
    );
  }
}
