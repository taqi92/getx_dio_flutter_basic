class CommonResponse {
  dynamic success;
  dynamic payload;
  String? message;
  String? status;

  CommonResponse({
    this.success,
    this.message,
    this.payload,
    this.status,
  });

  CommonResponse.fromJson(dynamic json) {
    success = json['success'];
    message = json['message'];
    payload = json['payload'];
    status = json['status'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['success'] = success;
    map['message'] = message;
    map['payload'] = payload;
    map['status'] = status;
    return map;
  }
}