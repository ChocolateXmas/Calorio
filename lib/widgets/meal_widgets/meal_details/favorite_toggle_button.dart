import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:calorio/models/meal.dart';
import 'package:calorio/providers/favorites_provider.dart';

class FavoriteToggleButton extends ConsumerWidget {
  const FavoriteToggleButton({
    super.key,
    required this.meal,
  });

  final Meal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favoriteMealsList = ref.watch(favoriteMealProvider);
    final isFavorite = favoriteMealsList.contains(meal);
    return IconButton(
      onPressed: () {
        final bool wasAdded = ref
            .read(favoriteMealProvider.notifier)
            .toggleFavoriteMeal(meal);
        ScaffoldMessenger.of(context).clearSnackBars();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            behavior: SnackBarBehavior.floating,
            content: Text(
              wasAdded
                  ? 'Meal Added To Favorites'
                  : 'Meal Removed From Favorites',
            ),
          ),
        );
      },
      icon: AnimatedSwitcher(
        duration: const Duration(milliseconds: 200),
        transitionBuilder: (child, animation) => ScaleTransition(
          scale: Tween(begin: 0.5, end: 1.0).animate(animation),
          child: child,
        ),
        child: Icon(
          isFavorite ? Icons.star : Icons.star_outline,
          key: ValueKey(isFavorite),
          color: isFavorite
              ? Colors.amber
              : Theme.of(context).colorScheme.onSurface,
        ),
      ),
    );
  }
}
