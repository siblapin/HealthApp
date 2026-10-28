import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class SafeSvg extends StatelessWidget {
  const SafeSvg({
    super.key,
    required this.asset,
    this.height = 24,
    this.width = 24,
  });

  final String asset;
  final double height;
  final double width;

  @override
  Widget build(BuildContext context) {
    if (asset.isEmpty) {
      return SizedBox(height: height, width: width);
    }
    return SvgPicture.asset(asset, height: height, width: width);
  }
}
