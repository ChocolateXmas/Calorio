import 'package:flutter/material.dart';

import 'package:flutter_svg/flutter_svg.dart';

class MealFilterIcon extends StatelessWidget {
  const MealFilterIcon({
    super.key,
    required this.asset,
    this.isActive,
    this.size,
  });

  final String asset;
  final bool? isActive;
  final double? size;

  @override
  Widget build(BuildContext context) {
    final Color mainSvgColor = switch (isActive) {
      true => Colors.green,
      false => Colors.grey,
      null => Colors.white,
    };
    return SvgPicture.asset(
      asset,
      width: size ?? 20,
      height: size ?? 20,
      colorFilter: ColorFilter.mode(
        mainSvgColor,
        BlendMode.srcIn,
      ),
    );
  }
}
