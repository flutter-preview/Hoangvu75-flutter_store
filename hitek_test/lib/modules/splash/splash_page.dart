import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/splash/splash_controller.dart';
import 'package:hitek_test/widgets/app_logo.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late SplashController _splashController;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _splashController = SplashController(provider: this, context: context);
  }

  @override
  void dispose() {
    super.dispose();
    _splashController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<dynamic>(
      stream: _splashController.splashControllerStream,
      builder: (context, snapshot) {
        return Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            backgroundColor: AppColor.TRANSPARENT,
            systemOverlayStyle: SystemUiOverlayStyle(
              statusBarIconBrightness: (MediaQuery.of(context).platformBrightness == Brightness.dark)
                  ? Brightness.light
                  : Brightness.dark,
              statusBarColor: AppColor.TRANSPARENT,
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                height: _splashController.animationValue,
                width: MediaQuery.of(context).size.width,
              ),
              const AppLogo(),
            ],
          ),
        );
      }
    );
  }
}
