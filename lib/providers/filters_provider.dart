import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorio/providers/meal_provider.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersProvider extends Notifier<Map<Filter, bool>> {
  /// build method: gets a Map of \<Filter, bool>
  /// instantiation of every filter to False
  @override
  Map<Filter, bool> build() => {
    for (final filter in Filter.values) filter: false,
  };

  void setFilters(Map<Filter, bool> chosenFilters) => state = chosenFilters;

  void setFilter(Filter filter, bool isActive) =>
      state = {...state, filter: isActive};
}

final filtersProvider = NotifierProvider<FiltersProvider, Map<Filter, bool>>(
  FiltersProvider.new,
);

final filteredMealsProvider = Provider((ref) {
  final meals = ref.watch(mealsProvider);
  final availableFilters = ref.watch(filtersProvider);
  return meals.where((meal) {
    if (availableFilters[Filter.glutenFree]! && !meal.isGlutenFree) {
      return false;
    }
    if (availableFilters[Filter.lactoseFree]! && !meal.isLactoseFree) {
      return false;
    }
    if (availableFilters[Filter.vegan]! && !meal.isVegan) {
      return false;
    }
    if (availableFilters[Filter.vegetarian]! && !meal.isVegetarian) {
      return false;
    }
    return true;
  }).toList();
});
