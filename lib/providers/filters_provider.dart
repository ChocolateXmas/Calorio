import 'package:flutter_riverpod/flutter_riverpod.dart';

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
