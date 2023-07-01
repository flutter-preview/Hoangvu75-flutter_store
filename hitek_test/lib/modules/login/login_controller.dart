import 'dart:collection';

import 'package:flutter/cupertino.dart';
import 'package:hitek_test/common/config/app_constants.dart';
import 'package:hitek_test/data/common/base_service.dart';
import 'package:hitek_test/data/repositories/auth/auth_repository.dart';
import 'package:hitek_test/data/repositories/auth/iauth_repository.dart';
import 'package:hitek_test/data/service/account_service.dart';
import 'package:hitek_test/utils/validator.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/dialog_utils.dart';

class LoginController {
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  late final IAuthRepository authRepository;
  late final AccountService accountService;

  String get _email => emailController.text;
  String get _password => passwordController.text;

  BehaviorSubject<bool?> isSubmittedEmailEmpty = BehaviorSubject<bool?>.seeded(false);
  BehaviorSubject<bool?> isSubmittedPasswordEmpty = BehaviorSubject<bool?>.seeded(false);

  LoginController() {
    emailController = TextEditingController();
    passwordController = TextEditingController();
    authRepository = AuthRepository(api: BaseService());
    accountService = AccountService(authRepository: authRepository);

    emailController.text = "hitektest+01@gmail.com";
    passwordController.text = "123456aA@";
  }

  void dispose() {
    emailController.dispose();
    passwordController.dispose();
  }

  void onLogin() async {
    if (validate()) {
      HashMap<String, dynamic> loginResponse = await login();
      accountService.login(loginResponse);
      if (loginResponse["code"] == 200) {
        Navigator.pushReplacementNamed(navigatorKey.currentContext!, '/main');
      }
    }
  }

  Future<HashMap<String, dynamic>> login() async {
    DialogUtils.showLoadingDialog();
    final response = await authRepository.login(_email, _password);
    DialogUtils.closeDialog();
    return response;
  }

  bool validate() {
    if (_email.isEmpty || _password.isEmpty) {
      DialogUtils.showNotificationDialog(title: "Login error!", content: "Please fill up all required fields.");
      if (_email.isEmpty) {
        isSubmittedEmailEmpty.add(true);
      }
      if (_password.isEmpty) {
        isSubmittedPasswordEmpty.add(true);
      }
      return false;
    } else if (!_email.isValidEmail) {
      DialogUtils.showNotificationDialog(title: "Login error!", content: "Your email is not valid.");
      return false;
    }
    return true;
  }
}