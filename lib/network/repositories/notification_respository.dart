

import 'package:mitro/models/responses/common/common_response.dart';
import 'package:mitro/models/responses/notification/notification_response.dart';
import 'package:mitro/utils/constants.dart';

import '../api_client.dart';

class NotificationRepository {
  final ApiClient _apiClient = ApiClient.apiClient;
  static final NotificationRepository _notificationRepository = NotificationRepository._internal();

  NotificationRepository._internal();

  factory NotificationRepository() {
    return _notificationRepository;
  }

  void markAsReadNotification(ResponseCallback<CommonResponse?, String?> callback) async {
    _apiClient.postRequest("/api/notification/mark-as-read", null, (response, error) {
      if(response != null) {
        callback(CommonResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void getAllNotifications(int pageNo, int pageSize, ResponseCallback<NotificationResponse?, String?> callback) async {
    _apiClient.getRequest('/api/notification/all?pageNo=$pageNo&pageSize=$pageSize&sortBy=creationDate&ascOrDesc=desc', (response, error) {
      if(response != null) {
        //callback(NotificationResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }

  void getUnreadNotificationCounter(ResponseCallback<CommonResponse?, String?> callback) async {
    _apiClient.getRequest('/api/notification/unread-counter', (response, error) {
      if(response != null) {
        callback(CommonResponse.fromJson(response), null);
      } else {
        callback(null, error);
      }
    });
  }
}