import 'package:login_api_bloc/api/api_provider.dart';
import 'package:login_api_bloc/presentation/screens/login/model/login_request_model.dart';
import 'package:login_api_bloc/presentation/screens/login/model/login_response_model.dart';

class LoginRepository{
  final apiProvider = ApiProvider();

  Future<LoginResponseModel?> loginUser(LoginRequestModel requestLogin){
    return apiProvider.loginApi(requestLogin);
  }
}
class NetworkError extends Error {}