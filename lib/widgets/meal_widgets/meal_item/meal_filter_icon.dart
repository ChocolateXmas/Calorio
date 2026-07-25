import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MealFilterIcon extends StatelessWidget {
  const MealFilterIcon({super.key, required this.asset});

  final String asset;

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(
      asset,
      width: 20,
      height: 20,
      colorFilter: ColorFilter.mode(
        Theme.of(context).iconTheme.color ?? Colors.black,
        BlendMode.srcIn,
      ),
    );
  }
}
