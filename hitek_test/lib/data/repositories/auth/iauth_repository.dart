import 'dart:collection';

import '../ibase_repository.dart';

abstract class IAuthRepository extends IBaseRepository {
  Future<HashMap<String, dynamic>> login(String username, String password);
}