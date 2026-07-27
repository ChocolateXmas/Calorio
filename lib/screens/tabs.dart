import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorio/screens/categories.dart';
import 'package:calorio/screens/meals.dart';
import 'package:calorio/screens/filters.dart';
import 'package:calorio/models/meal.dart';
import 'package:calorio/widgets/drawer/main_drawer.dart';

import 'package:calorio/providers/meal_provider.dart';
import 'package:calorio/providers/favorites_provider.dart';

// Constant fallback to default filters settings
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends ConsumerStatefulWidget {
  const TabsScreen({super.key});

  @override
  ConsumerState<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends ConsumerState<TabsScreen> {
  int _selectedPageIndex = 0;
  Map<Filter, bool> _filterSelections = kInitialFilters;

  void _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // close the side drawer before pushing
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            currentFilters: _filterSelections,
          ),
        ),
      );
      setState(() {
        _filterSelections = result ?? kInitialFilters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final List<Meal> meals = ref.watch(mealsProvider);
    final List<Meal> availableMeals = meals.where((meal) {
      if (_filterSelections[Filter.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (_filterSelections[Filter.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (_filterSelections[Filter.vegan]! && !meal.isVegan) {
        return false;
      }
      if (_filterSelections[Filter.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      return true;
    }).toList();
    Widget selectedPage = CategoriesScreen(
      mealList: availableMeals,
    );
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      final List<Meal> favoriteMeals = ref.watch(favoriteMealProvider);
      selectedPage = MealsScreen(
        meals: favoriteMeals,
      );
      activePageTitle = 'Your Favorite Meals';
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(activePageTitle),
        centerTitle: true,
      ),
      drawer: MainDrawer(
        onSelectScreen: _setScreen,
      ),
      body: selectedPage,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        items: [
          const BottomNavigationBarItem(
            icon: Icon(Icons.set_meal),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
