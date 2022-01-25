import 'dart:developer';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:mitro/models/responses/common/common_response.dart';
import 'package:mitro/models/responses/error/error_response.dart';
import 'package:mitro/models/responses/login/login_response.dart';
import 'package:mitro/utils/constants.dart';
import 'package:mitro/utils/endpoints.dart';
import 'package:mitro/utils/environment.dart';
import 'package:mitro/utils/shared_pref.dart';


class ApiClient {
  ApiClient._();

  static final ApiClient apiClient = ApiClient._internal();
  late Dio _dio;

  ApiClient._internal() {
    var options = BaseOptions(baseUrl: getBaseUrl(),);
    _dio = Dio(options);
  }

  void postRequest(String url, Map<String, dynamic>? request, ResponseCallback<dynamic, String?> callback, {bool checkStatusCodeOnly = false}) async {
    try {
      final apiResponse = await client.post(url, data: request);
      final responseData = apiResponse.data;

      if(responseData is Map<String, dynamic> || responseData is List) {
        if(checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(responseData, (response, error) => callback(response, error));
        }
      } else {
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void putRequest(String url, Map<String, dynamic> request, ResponseCallback<dynamic, String?> callback, {bool checkStatusCodeOnly = false}) async {
    try {
      final apiResponse = await client.put(url, data: request);
      final responseData = apiResponse.data;

      if(responseData is Map<String, dynamic> || responseData is List) {
        if(checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(responseData, (response, error) => callback(response, error));
        }
      } else {
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void deleteRequest(String url, ResponseCallback<dynamic, String?> callback, {bool checkStatusCodeOnly = false}) async {
    try {
      final apiResponse = await client.delete(url);
      final responseData = apiResponse.data;

      if(responseData is Map<String, dynamic> || responseData is List) {
        if(checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(responseData, (response, error) => callback(response, error));
        }
      } else {
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void getRequest(String url, ResponseCallback<dynamic, String?> callback, {bool checkStatusCodeOnly = false}) async {
    try {
      final apiResponse = await client.get(url,);
      var responseData = apiResponse.data;

      if(responseData is Map<String, dynamic> || responseData is List) {
        if(checkStatusCodeOnly) {
          callback(responseData, null);
        } else {
          _getActualResponse(responseData, (response, error) => callback(response, error));
        }
      } else {
        callback(null, _getErrorMessage(apiResponse));
      }
    } on DioError catch (e) {
      callback(null, _getDioErrorResponse(e));
    } on FormatException catch (e) {
      callback(null, e.toString());
    } catch (e) {
      callback(null, e.toString());
    }
  }

  void _getActualResponse(dynamic response, Function(dynamic, String?) callback) {
    if(response['success'] == true) {
      callback(response, null);
    } else {
      callback(null, response['message']);
    }
  }

  String _getErrorMessage(Response<dynamic> apiResponse) {
    var responseData = apiResponse.data;

    if(responseData != null && responseData != "") {
      String errorText = "";
      var errors = "${apiResponse.data}".split("\n");

      for(int i = 0; i < errors.length; i++) {
        if(i < 12) errorText += errors[i];
      }

      return errorText;
    } else {
      return "${apiResponse.statusMessage}";
    }
  }

  String? _getDioErrorResponse(DioError e) {
    var response = e.response;
    var statusCode = response?.statusCode;

    if(response?.data != null) {
      try {
        if(statusCode != null && statusCode == 401 || statusCode == 403 || statusCode! >= 500) {

          if(statusCode! >= 500) {
            return "Internal Server Error: $statusCode";
          } else {
            ErrorResponse errorResponse = ErrorResponse.fromJson(response?.data);
            var message = errorResponse.message;
            return message != null && message.isNotEmpty ? message : errorResponse.error;
          }
        } else {
          CommonResponse commonResponse = CommonResponse.fromJson(response?.data);
          return commonResponse.message;
        }
      } catch (e) {
        return e.toString();
      }
    } else {
      return e.message;
    }
  }

  Dio get client {
    _dio.interceptors.clear();
    _dio.interceptors.add(InterceptorsWrapper(
      onRequest: (options, handler) async {
        try {
          var connectivityResult = await (Connectivity().checkConnectivity());
          if (connectivityResult == ConnectivityResult.none) {
            return handler.reject(DioError(requestOptions: options, error: "internet_connectivity_problem".tr()), true);
          }

          if(isJwtTokenNeeded(options.path)) {
            var token = await SharedPref.read(keyJwtToken);
            options.headers.addAll({"Authorization": "Bearer $token",});
          }
        } catch(e) {
          return handler.reject(DioError(requestOptions: options, error: "Error: ${e.toString()}"), true);
        }

        options.headers.addAll({"Content-type": "application/json"});
        return handler.next(options);
      },
      onError: (error, handler) async {
        var errorResponse = error.response;
        RequestOptions? requestOptions = errorResponse?.requestOptions;

        if (errorResponse?.statusCode == 403) {
          _dio.interceptors.requestLock.lock();
          _dio.interceptors.responseLock.lock();

          try {
            var newDio = Dio();

            if(kDebugMode) {
              newDio.interceptors.clear();
              newDio.interceptors.add(LogInterceptor(
                error: true,
                request: true,
                requestBody: true,
                responseBody: true,
                requestHeader: true,
                logPrint: (object) {
                  log(object.toString());
                },
              ));
            }

            var refreshToken = await SharedPref.read(keyRefreshToken,);
            var refreshRequest = {"refreshTokenId": "$refreshToken"};
            var refreshResponse = await newDio.post(getBaseUrl() + refreshEndpoint, data: refreshRequest);

            if(refreshResponse.statusCode == 200 && requestOptions?.path != null) {
              LoginResponse response = LoginResponse.fromJson(refreshResponse.data);

              if(response.success == true && response.payload != null) {
                await SharedPref.write(keyJwtToken, response.payload?.accessToken);
                await SharedPref.write(keyRefreshToken, response.payload?.refreshToken);

                _dio.interceptors.requestLock.unlock();
                _dio.interceptors.responseLock.unlock();

                var request = await _dio.request(
                  requestOptions!.path,
                  options: requestOptions.asOptions(),
                  data: requestOptions.data,
                  queryParameters: requestOptions.queryParameters,
                );

                return handler.resolve(request);
              } else {
                var jwt = await SharedPref.read(keyJwtToken);
                if(jwt != null) {
                  await logout();
                }

                return handler.next(error);
              }
            }
          } catch (e) {
            await logout();
            return handler.next(error);
          }
        }

        return handler.next(error);
      },
    ));

    if(kDebugMode) {
      _dio.interceptors.add(LogInterceptor(
        error: true,
        request: true,
        requestBody: true,
        responseBody: true,
        requestHeader: true,
        responseHeader: true,
        logPrint: (object) {
          log(object.toString());
        },
      ));
    }

    return _dio;
  }

  bool isJwtTokenNeeded(String path) {
    if(
        path.contains(loginEndpoint) ||
        path.contains(signUpEndpoint) ||
        path.contains(refreshEndpoint) ||
        path.contains(privacyPolicyEndpoint) ||
        path.contains(termsConditionsEndpoint) ||
        path.contains(forgetPasswordEndpoint) ||
        path.contains(forgetPasswordChangeEndpoint) ||
        path.contains(forgetPasswordVerifyEndpoint)
    ) {
      return false;
    }

    return true;
  }
}

extension _AsOptions on RequestOptions {
  Options asOptions() {
    return Options(
      method: method,
      sendTimeout: sendTimeout,
      receiveTimeout: receiveTimeout,
      extra: extra,
      headers: headers,
      responseType: responseType,
      contentType: contentType,
      validateStatus: validateStatus,
      receiveDataWhenStatusError: receiveDataWhenStatusError,
      followRedirects: followRedirects,
      maxRedirects: maxRedirects,
      requestEncoder: requestEncoder,
      responseDecoder: responseDecoder,
      listFormat: listFormat,
    );
  }
}