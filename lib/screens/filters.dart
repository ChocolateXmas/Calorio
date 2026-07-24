import 'package:flutter/material.dart';

enum Filter {
  glutenFree,
  lactoseFree,
  vegan,
  vegetarian,
}

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key});

  @override
  State<FiltersScreen> createState() {
    return _FiltersScreenState();
  }
}

class _FiltersScreenState extends State<FiltersScreen> {
  bool _glutenFreeFilter = false;
  bool _lactoseFreeFilter = false;
  bool _veganFilter = false;
  bool _vegetarianFilter = false;

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
            SwitchListTile(
              value: _glutenFreeFilter,
              onChanged: (isChanged) {
                setState(() => _glutenFreeFilter = isChanged);
              },
              activeThumbColor: Theme.of(context).colorScheme.onPrimaryFixed,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 28),
              title: Text(
                'Gluten-Free',
                style:
                    Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include gluten-free meals',
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            SwitchListTile(
              value: _lactoseFreeFilter,
              onChanged: (isChanged) {
                setState(() => _lactoseFreeFilter = isChanged);
              },
              activeThumbColor: Theme.of(context).colorScheme.onPrimaryFixed,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 28),
              title: Text(
                'Lactose-Free',
                style:
                    Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include lactose-free meals',
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            SwitchListTile(
              value: _veganFilter,
              onChanged: (isChanged) {
                setState(() => _veganFilter = isChanged);
              },
              activeThumbColor: Theme.of(context).colorScheme.onPrimaryFixed,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 28),
              title: Text(
                'Vegan',
                style:
                    Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include vegan meals',
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
            SwitchListTile(
              value: _vegetarianFilter,
              onChanged: (isChanged) {
                setState(() => _vegetarianFilter = isChanged);
              },
              activeThumbColor: Theme.of(context).colorScheme.onPrimaryFixed,
              activeTrackColor: Theme.of(context).colorScheme.tertiary,
              contentPadding: EdgeInsets.only(left: 34, right: 28),
              title: Text(
                'Vegetarian',
                style:
                    Theme.of(
                      context,
                    ).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
              subtitle: Text(
                'Only include vegetarian meals',
                style:
                    Theme.of(
                      context,
                    ).textTheme.labelMedium!.copyWith(
                      color: Theme.of(context).colorScheme.onSurface,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
