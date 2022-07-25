import '../../../../api/api_provider.dart';
import '../model/user_detail_request_model_pagewise.dart';
import '../model/user_detail_response_model.dart';


class UserDetailRepository{
  final apiProvider = ApiProvider();

  Future<UserDetailsResponseModel?> userDetails(UserRequestModelPagewise requestModelPagewise){
    return apiProvider.fetchUserDetails(requestModelPagewise);
  }
}
class NetworkError extends Error {}