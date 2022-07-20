import '../../../../api/api_provider.dart';
import '../model/register_request_model.dart';
import '../model/register_response_model.dart';

class RegisterRepository{
  final apiProvider = ApiProvider();

  Future<RegisterResponseModal?> registerUser(RegisterRequestModel requestRegister){
    return apiProvider.registerApi(requestRegister);
  }
}
class NetworkError extends Error {}