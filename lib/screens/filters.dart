import 'package:flutter/material.dart';
import 'package:calorio/widgets/meal_widgets/meal_item/meal_filter_icon.dart';
import 'package:calorio/core/constants/app_assets.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({
    super.key,
    required this.glutenFreeFilter,
    required this.lactoseFreeFilter,
    required this.veganFilter,
    required this.vegetarianFilter,
  });

  final bool glutenFreeFilter;
  final bool lactoseFreeFilter;
  final bool veganFilter;
  final bool vegetarianFilter;

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _glutenFreeFilter;
  late bool _lactoseFreeFilter;
  late bool _veganFilter;
  late bool _vegetarianFilter;

  @override
  void initState() {
    super.initState();
    _glutenFreeFilter = widget.glutenFreeFilter;
    _lactoseFreeFilter = widget.lactoseFreeFilter;
    _veganFilter = widget.veganFilter;
    _vegetarianFilter = widget.vegetarianFilter;
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
          Navigator.of(context).pop({
            Filter.glutenFree: _glutenFreeFilter,
            Filter.lactoseFree: _lactoseFreeFilter,
            Filter.vegan: _veganFilter,
            Filter.vegetarian: _vegetarianFilter,
          });
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
