import 'package:flutter/material.dart';
import 'package:calorio/models/meal.dart';

class FavoriteToggleButton extends StatefulWidget {
  const FavoriteToggleButton({
    super.key,
    required this.meal,
    required this.isFavorite,
    required this.onToggleFavorite,
  });

  final Meal meal;
  final bool isFavorite;
  final void Function(Meal meal) onToggleFavorite;

  @override
  State<FavoriteToggleButton> createState() {
    return _FavoriteToggleButtonState();
  }
}

class _FavoriteToggleButtonState extends State<FavoriteToggleButton> {
  late bool _isFavorite;

  @override
  void initState() {
    super.initState();
    _isFavorite = widget.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: () {
        setState(() {
          _isFavorite = !_isFavorite;
        });
        widget.onToggleFavorite(widget.meal);
      },
      icon: Icon(
        _isFavorite ? Icons.star : Icons.star_outline,
        color: _isFavorite
            ? Colors.amber
            : Theme.of(context).colorScheme.onSurface,
      ),
    );
  }
}
