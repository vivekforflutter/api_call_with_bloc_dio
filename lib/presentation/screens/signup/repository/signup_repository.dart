import '../../../../api/api_provider.dart';
import '../model/signup_request_model.dart';
import '../model/signup_response_model.dart';

class SignUpRepository {
  final signUpProvider = SignUpProvider();
  Future<SignUpResponseModel?> signupUser(SignupRequestModel requestSignup){
    return signUpProvider.signupApi(requestSignup);
  }
}

class NetworkError extends Error {}
