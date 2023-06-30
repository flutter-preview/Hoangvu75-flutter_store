import 'dart:collection';

import 'package:hitek_test/data/models/account.dart';
import 'package:rxdart/rxdart.dart';

import '../common/base_service.dart';
import '../repositories/auth/iauth_repository.dart';

class AccountService extends BaseService {
  late IAuthRepository authRepository;

  AccountService({
    required this.authRepository,
  });

  static BehaviorSubject<Account?> account = BehaviorSubject<Account?>.seeded(null);

  Future<void> login(HashMap<String, dynamic> loginResponse) async {
    BaseService.accessToken = loginResponse["accessToken"];
  }
}
