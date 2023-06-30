import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/base/base_page.dart';
import 'package:hitek_test/modules/login/login_controller.dart';
import 'package:hitek_test/widgets/app_logo.dart';
import 'package:hitek_test/widgets/animated_text_field.dart';
import 'package:hitek_test/widgets/scale_tap.dart';

class LoginPage extends BasePage {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends BaseStatePage<LoginPage> {
  late final LoginController _controller;

  @override
  void initState() {
    super.initState();
    _controller = LoginController();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GestureDetector(
      onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
      child: Scaffold(
        appBar: baseAppBar(),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 124.0,
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 1,
                  end: 1.5,
                ),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1500),
                builder: (BuildContext context, double value, Widget? child) => AppLogo(
                  width: 156.0 * value,
                  height: 64.0 * value,
                ),
              ),
              const SizedBox(
                height: 129.0,
              ),
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0,
                  end: 1,
                ),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1500),
                builder: (BuildContext context, double value, Widget? child) => Transform(
                  transform: Matrix4.translationValues(0, -100.0 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _emailTextField(),
                  ),
                ),
              ),
              const SizedBox(height: 17.0),
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0,
                  end: 1,
                ),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1500),
                builder: (BuildContext context, double value, Widget? child) => Transform.scale(
                  scale: value,
                  child: Opacity(
                    opacity: value,
                    child: _passwordTextField(),
                  ),
                ),
              ),
              const SizedBox(height: 17.0),
              TweenAnimationBuilder(
                tween: Tween<double>(
                  begin: 0,
                  end: 1,
                ),
                curve: Curves.easeInOut,
                duration: const Duration(milliseconds: 1500),
                builder: (BuildContext context, double value, Widget? child) => Transform(
                  transform: Matrix4.translationValues(0, 100.0 * (1 - value), 0),
                  child: Opacity(
                    opacity: value,
                    child: _loginButton(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Container _emailTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36.0),
      child: AnimatedTextField(
        controller: _controller.emailController,
        isFocusedBorderWidth: 3.0,
        isUnfocusedBorderWidth: 1.0,
        isFocusedBorderColor: AppColor.DEFAULT_BLUE,
        isUnfocusedBorderColor: AppColor.DEFAULT_GREY,
        borderRadius: BorderRadius.circular(8.0),
        keyboardType: TextInputType.emailAddress,
        cursorColor: AppColor.DEFAULT_BLUE,
        hintText: "Email của bạn",
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        textStyle: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  Container _passwordTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36.0),
      child: AnimatedTextField(
        controller: _controller.passwordController,
        isFocusedBorderWidth: 3.0,
        isUnfocusedBorderWidth: 1.0,
        isFocusedBorderColor: AppColor.DEFAULT_BLUE,
        isUnfocusedBorderColor: AppColor.DEFAULT_GREY,
        borderRadius: BorderRadius.circular(8.0),
        keyboardType: TextInputType.emailAddress,
        cursorColor: AppColor.DEFAULT_BLUE,
        obscureText: true,
        hintText: "Mật khẩu của bạn",
        contentPadding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        textStyle: const TextStyle(fontSize: 16.0),
      ),
    );
  }

  ScaleTap _loginButton() {
    return ScaleTap(
      onTap: () {
        _controller.onLogin();
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 36.0),
        padding: const EdgeInsets.symmetric(
          vertical: 12.0,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          color: AppColor.BUTTON_BLUE,
        ),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Tiếp tục',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: AppColor.DEFAULT_WHITE,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
