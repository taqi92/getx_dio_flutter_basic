class ErrorResponse {

  dynamic status;
  String? error;
  String? message;

  ErrorResponse({
    this.error,
    this.message,
  });

  ErrorResponse.fromJson(dynamic json) {
    error = json['error'];
    status = json['status'];
    message = json['message'];
  }

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['status'] = status;
    map['error'] = error;
    map['message'] = message;
    return map;
  }
}