

import 'package:mitro/models/responses/common/common_response.dart';
import 'package:mitro/models/responses/login/login_response.dart';
import 'package:mitro/utils/constants.dart';
import 'package:mitro/utils/endpoints.dart';

import '../api_client.dart';

class AuthRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final AuthRepository _authRepository = AuthRepository._internal();

  AuthRepository._internal();

  factory AuthRepository() {
    return _authRepository;
  }

  void signUp(Map<String, dynamic> request, ResponseCallback<LoginResponse?, String?> callback) {
    _apiClient.postRequest(signUpEndpoint, request, (response, error) {
      if(response != null) {
        callback(LoginResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void login(Map<String, dynamic> request, ResponseCallback<LoginResponse?, String?> callback) {
    _apiClient.postRequest(loginEndpoint, request, (response, error) {
      if(response != null) {
        callback(LoginResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void forgotPassword(Map<String, dynamic> request, ResponseCallback<CommonResponse?, String?> callback) {
    _apiClient.postRequest(forgetPasswordEndpoint, request, (response, error) {
      if(response != null) {
        callback(CommonResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void resetPassword(Map<String, dynamic> request, ResponseCallback<CommonResponse?, String?> callback) {
    _apiClient.postRequest(forgetPasswordEndpoint, request, (response, error) {
      if(response != null) {
        callback(CommonResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void resendVerificationEmail(Map<String, dynamic> request, ResponseCallback<CommonResponse?, String?> callback) {
    _apiClient.postRequest(sendVerificationEmailEndpoint, request, (response, error) {
      if(response != null) {
        callback(CommonResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void getLegalDocs(String url, ResponseCallback<CommonResponse?, String?> callback) {
    _apiClient.getRequest(url, (response, error) {
      if(response != null) {
        callback(CommonResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

}
