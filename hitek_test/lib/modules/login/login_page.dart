import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hitek_test/utils/image_path.dart';

class LoginPage extends StatelessWidget {
  LoginPage({super.key});

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarIconBrightness: Brightness.dark,
          statusBarColor: Colors.transparent,
        ),
        backgroundColor: Colors.transparent,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(
              height: 124.0,
            ),
            _appLogo(),
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
                transform: Matrix4.translationValues(0, -200.0 * (1 - value), 0),
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
                transform: Matrix4.translationValues(0, 200.0 * (1 - value), 0),
                child: Opacity(
                  opacity: value,
                  child: _loginButton(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Container _loginButton() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36.0),
      padding: const EdgeInsets.symmetric(
        vertical: 12.0,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(8.0),
        color: const Color.fromRGBO(84, 125, 191, 1),
      ),
      child: const Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Tiếp tục',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
            ),
          ),
        ],
      ),
    );
  }

  Container _passwordTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: _passwordController,
        obscureText: true,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Mật khẩu của bạn',
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  Container _emailTextField() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 36.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: TextFormField(
        controller: _emailController,
        keyboardType: TextInputType.emailAddress,
        decoration: const InputDecoration(
          border: InputBorder.none,
          hintText: 'Email của bạn',
          contentPadding: EdgeInsets.symmetric(horizontal: 15.0, vertical: 12.0),
        ),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 16,
        ),
      ),
    );
  }

  Image _appLogo() {
    return Image.asset(
      ImagePaths.app_logo,
      width: 156.0,
      height: 64.0,
    );
  }
}
