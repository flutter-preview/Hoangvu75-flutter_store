import 'dart:collection';

import 'package:hitek_test/data/models/account.dart';

import '../common/base_service.dart';
import '../repositories/auth/iauth_repository.dart';

class AccountService extends BaseService {
  late IAuthRepository authRepository;

  AccountService({
    required this.authRepository,
  });


  Future<void> login(HashMap<String, dynamic> loginResponse) async {
    Account account = loginResponse["account"];
  }
}
