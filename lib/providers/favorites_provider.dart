import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorio/models/meal.dart';

class FavoriteMealNotifier extends Notifier<List<Meal>> {
  @override
  List<Meal> build() {
    return []; // Initial empty state
  }

  /// return True if new favorite meal was added
  /// return False if favorite meal was removed
  bool toggleFavoriteMeal(Meal meal) {
    if (state.contains(meal)) {
      // Remove a meal from the favorite list
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    } else {
      // Add a meal to the favorite list
      state = [...state, meal];
      return true;
    }
  }
}

final favoriteMealProvider = NotifierProvider<FavoriteMealNotifier, List<Meal>>(
  FavoriteMealNotifier.new,
);
