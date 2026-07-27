import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorio/widgets/meal_widgets/meal_item/meal_filter_icon.dart';
import 'package:calorio/core/constants/app_assets.dart';

import 'package:calorio/providers/filters_provider.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({
    super.key,
  });

  SwitchListTile _getCustomTile(
    bool cValue,
    ValueChanged<bool> onChangedFn,
    String iconAsset,
    String cTitle,
    String cSubtitle,
    BuildContext context,
  ) {
    return SwitchListTile(
      value: cValue,
      onChanged: onChangedFn,
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
  Widget build(BuildContext context, WidgetRef ref) {
    final activeFilters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text('Filters'),
      ),
      body: Column(
        children: [
          _getCustomTile(
            activeFilters[Filter.glutenFree]!,
            (isChanged) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, isChanged);
            },
            AppAssets.glutenFree,
            'Gluten-Free',
            'Only include gluten-free meals',
            context,
          ),
          _getCustomTile(
            activeFilters[Filter.lactoseFree]!,
            (isChanged) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, isChanged);
            },
            AppAssets.lactoseFree,
            'Lactose-Free',
            'Only include lactose-free meals',
            context,
          ),
          _getCustomTile(
            activeFilters[Filter.vegan]!,
            (isChanged) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, isChanged);
            },
            AppAssets.vegan,
            'Vegan',
            'Only include vegan meals',
            context,
          ),
          _getCustomTile(
            activeFilters[Filter.vegetarian]!,
            (isChanged) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, isChanged);
            },
            AppAssets.vegetarian,
            'Vegetarian',
            'Only include vegetarian meals',
            context,
          ),
        ],
      ),
    );
  }
}
