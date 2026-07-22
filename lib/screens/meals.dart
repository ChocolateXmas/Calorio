import 'package:flutter/material.dart';
import 'package:calorio/models/meal.dart';
import 'package:calorio/widgets/meal_widgets/meal_item.dart';
import 'package:calorio/widgets/meal_widgets/meal_details.dart';

class MealsScreen extends StatelessWidget {
  const MealsScreen({
    super.key,
    this.title,
    required this.meals,
  });

  final String? title;
  final List<Meal> meals;

  void _selectMeal(BuildContext context, Meal meal) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => MealDetailsScreen(meal: meal),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Widget content = (meals.isNotEmpty)
        ? ListView.builder(
            itemCount: meals.length,
            itemBuilder: (context, index) => MealItem(
              meal: meals[index],
              onSelectMeal: (meal) {
                _selectMeal(context, meal);
              },
            ),
          )
        : Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Nothing to show here ...',
                  style: Theme.of(context).textTheme.headlineLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
                const SizedBox(height: 15),
                Text(
                  'Try another different category!',
                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          );
    if (title == null) return content;

    return Scaffold(
      appBar: AppBar(
        title: Text(title!),
      ),
      body: content,
    );
  }
}
