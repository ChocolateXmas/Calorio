import 'package:flutter/material.dart';
import 'package:calorio/screens/categories.dart';
import 'package:calorio/screens/meals.dart';
import 'package:calorio/screens/filters.dart';
import 'package:calorio/models/meal.dart';
import 'package:calorio/widgets/drawer/main_drawer.dart';
import 'package:calorio/data/dummy_data.dart';

// Constant fallback to default filters settings
const kInitialFilters = {
  Filter.glutenFree: false,
  Filter.lactoseFree: false,
  Filter.vegan: false,
  Filter.vegetarian: false,
};

class TabsScreen extends StatefulWidget {
  const TabsScreen({super.key});

  @override
  State<TabsScreen> createState() {
    return _TabsScreenState();
  }
}

class _TabsScreenState extends State<TabsScreen> {
  int _selectedPageIndex = 0;
  final List<Meal> _favoriteMeals = [];
  Map<Filter, bool> _filterSelections = kInitialFilters;

  void _toggleMealFavoriteStatus(String msg) {
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(msg),
      ),
    );
  }

  bool _isFavorite(Meal meal) => _favoriteMeals.contains(meal);

  void _toggleFavoriteMeal(Meal meal) {
    setState(() {
      if (_isFavorite(meal)) {
        _favoriteMeals.remove(meal);
        _toggleMealFavoriteStatus('Meal Removed From Favorites');
      } else {
        _favoriteMeals.add(meal);
        _toggleMealFavoriteStatus('Meal Added To Favorites');
      }
    });
  }

  void _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  void _setScreen(String identifier) async {
    Navigator.of(context).pop(); // close the side drawer before pushing
    if (identifier == 'filters') {
      final result = await Navigator.of(context).push<Map<Filter, bool>>(
        MaterialPageRoute(
          builder: (ctx) => FiltersScreen(
            glutenFreeFilter: _filterSelections[Filter.glutenFree]!,
            lactoseFreeFilter: _filterSelections[Filter.lactoseFree]!,
            veganFilter: _filterSelections[Filter.vegan]!,
            vegetarianFilter: _filterSelections[Filter.vegetarian]!,
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
    print(_filterSelections);
    final List<Meal> availableMeals = dummyMeals.where((meal) {
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
      isFavorite: _isFavorite,
      onToggleFavorite: _toggleFavoriteMeal,
    );
    String activePageTitle = 'Categories';
    if (_selectedPageIndex == 1) {
      selectedPage = MealsScreen(
        meals: _favoriteMeals,
        isFavorite: _isFavorite,
        onToggleFavorite: _toggleFavoriteMeal,
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
