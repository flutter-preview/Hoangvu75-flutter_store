import 'dart:collection';

import 'package:hitek_test/data/models/base_response.dart';

import '../../../utils/dialog_utils.dart';
import '../../common/base_service.dart';
import '../../models/account.dart';
import 'iauth_repository.dart';

class AuthRepository extends IAuthRepository {
  AuthRepository({
    required BaseService api,
  }) : _api = api;
  final BaseService _api;

  @override
  Future<HashMap<String, dynamic>> login(String username, String password) async {
    try {
      Map<String, dynamic> body = {
        "username": username,
        "password": password,
      };

      DialogUtils.showLoadingDialog();
      BaseResponse<dynamic> response = await _api.client.login(body);
      await DialogUtils.closeDialog();
      int? code = response.code;
      Account account = Account.fromJson(response.results["object"]["result"]);
      String accessToken = response.results["object"]["token"];

      HashMap<String, dynamic> result = HashMap();
      result.addAll({"code": code});
      result.addAll({"account": account});
      result.addAll({"accessToken": accessToken});

      return result;
    } catch (err) {
      await DialogUtils.closeDialog();
      throw handleError(err);
    }
  }
}
