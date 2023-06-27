import 'package:flutter/widgets.dart';

import '../utils/image_path.dart';

class AppLogo extends StatelessWidget {
  const AppLogo({
    super.key,
    this.width = 156.0,
    this.height = 64.0,
  });

  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      ImagePaths.app_logo,
      fit: BoxFit.fill,
      width: width,
      height: height,
    );
  }
}
