import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorio/widgets/meal_widgets/meal_item/meal_filter_icon.dart';
import 'package:calorio/core/constants/app_assets.dart';

import 'package:calorio/providers/filters_provider.dart';

class FiltersScreen extends ConsumerStatefulWidget {
  const FiltersScreen({
    super.key,
  });

  @override
  ConsumerState<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends ConsumerState<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _veganFilter = false;
  bool _vegetarianFilter = false;

  @override
  void initState() {
    super.initState();
    final activeFilters = ref.read(filtersProvider);
    _glutenFreeFilter = activeFilters[Filter.glutenFree]!;
    _lactoseFreeFilter = activeFilters[Filter.lactoseFree]!;
    _veganFilter = activeFilters[Filter.vegan]!;
    _vegetarianFilter = activeFilters[Filter.vegetarian]!;
  }

  SwitchListTile _getCustomTile(
    bool cValue,
    ValueChanged<bool> onChanged,
    String iconAsset,
    String cTitle,
    String cSubtitle,
  ) {
    return SwitchListTile(
      value: cValue,
      onChanged: onChanged,
      activeThumbColor: Theme.of(context).colorScheme.onPrimaryFixed,
      activeTrackColor: Theme.of(context).colorScheme.tertiary,
      contentPadding: EdgeInsets.symmetric(horizontal: 25),
      secondary: MealFilterIcon(
        asset: iconAsset,
        size: 30,
      ),
      title: Text(
        cTitle,
        style:
            Theme.of(
              context,
            ).textTheme.titleLarge!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
      subtitle: Text(
        cSubtitle,
        style:
            Theme.of(
              context,
            ).textTheme.labelMedium!.copyWith(
              color: Theme.of(context).colorScheme.onSurface,
            ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: PopScope(
        canPop: false,
        onPopInvokedWithResult: ((didPop, result) {
          if (didPop) {
            return;
          }
          ref.read(filtersProvider.notifier).setFilters({
            Filter.glutenFree: _glutenFreeFilter,
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegan: _veganFilter,
            Filter.vegetarian: _vegetarianFilter,
          });
          Navigator.of(context).pop();
        }),
        child: Column(
          children: [
            _getCustomTile(
              _glutenFreeFilter,
              (isChanged) {
                setState(() => _glutenFreeFilter = isChanged);
              },
              AppAssets.glutenFree,
              'Gluten-Free',
              'Only include gluten-free meals',
            ),
            _getCustomTile(
              _lactoseFreeFilter,
              (isChanged) {
                setState(() => _lactoseFreeFilter = isChanged);
              },
              AppAssets.lactoseFree,
              'Lactose-Free',
              'Only include lactose-free meals',
            ),
            _getCustomTile(
              _veganFilter,
              (isChanged) {
                setState(() => _veganFilter = isChanged);
              },
              AppAssets.vegan,
              'Vegan',
              'Only include vegan meals',
            ),
            _getCustomTile(
              _vegetarianFilter,
              (isChanged) {
                setState(() => _vegetarianFilter = isChanged);
              },
              AppAssets.vegetarian,
              'Vegetarian',
              'Only include vegetarian meals',
            ),
          ],
        ),
      ),
    );
  }
}
