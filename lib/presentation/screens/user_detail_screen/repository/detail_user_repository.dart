import '../../../../api/api_provider.dart';
import '../model/user_modal_request_idwise.dart';
import '../model/user_modal_response.dart';

class DetailUserRepository{
  final apiProvider = ApiProvider();

  Future<UserModalResponse?> DetailUsers(UserModalRequest requestModalIdWise){
    return apiProvider.fetchUserDetailsIdWise(requestModalIdWise);
  }
}
class NetworkError extends Error {}