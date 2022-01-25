
class LoginResponse {
  dynamic success;
  String? status;
  String? message;
  LoginPayload? payload;

  LoginResponse({
    this.status,
    this.success,
    this.message,
    this.payload,
  });

  LoginResponse.fromJson(dynamic json) {
    status = json['status'];
    success = json['success'];
    message = json['message'];
    payload = json['payload'] != null ? LoginPayload.fromJson(json['payload']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['success'] = success;
    map['message'] = message;
    if (payload != null) {
      map['payload'] = payload?.toJson();
    }
    return map;
  }
}

class LoginPayload {
  String? accessToken;
  String? tokenType;
  String? refreshToken;
  //User? user;

  LoginPayload({
    this.accessToken,
    this.tokenType,
    this.refreshToken,
  });

  LoginPayload.fromJson(dynamic json) {
    accessToken = json['accessToken'];
    tokenType = json['tokenType'];
    refreshToken = json['refreshToken'];
    //user = json['user'] != null ? User.fromJson(json['user']) : null;
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = accessToken;
    map['tokenType'] = tokenType;
    map['refreshToken'] = refreshToken;
    /*if (user != null) {
      map['user'] = user?.toJson();
    }*/
    return map;
  }
}