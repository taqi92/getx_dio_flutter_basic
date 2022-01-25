import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:mitro/models/responses/notification/notification_response.dart';
import 'package:mitro/network/repositories/notification_respository.dart';
import 'package:mitro/utils/constants.dart';

class NotificationController extends GetxController {
  late final NotificationRepository _notificationRepository;

  @override
  void onInit() {
    _notificationRepository = NotificationRepository();
    super.onInit();
  }

  int pageNo = 0;
  var isLastPage = false;
  var unreadCounter = 0.obs;
  //List<NotificationContent>? notifications = [];

  void getUnreadCounter() {
    _notificationRepository.getUnreadNotificationCounter((response, error) {
      var counter = response?.payload;

      if(counter != null && counter is int && counter > 0) {
        unreadCounter.value = counter;
      }
    });
  }

  void markAsRead() {
    _notificationRepository.markAsReadNotification((response, error) {
      if(response != null) {
        unreadCounter.value = 0;
        update();
      }
    });
  }

  void getAllNotifications({int pageSize = 20, bool isFromLoadNext = false}) {
    loading();

    if(!isFromLoadNext) {
      pageNo = 0;
      //notifications = [];
    }

    /*_notificationRepository.getAllNotifications(pageNo, pageSize, (response, error) {
      if (response?.payload != null) {
        var payload = response?.payload;
        payload?.content?.forEach((notification) => notifications?.add(notification));
        isLastPage = payload?.last == true;

        dismissLoading();
        update();
      } else {
        showMessage(error);
      }
    });*/
  }

  void loadNextPageNotifications() {
    if(!isLastPage) {
      pageNo++;
      getAllNotifications(isFromLoadNext: true);
    }
  }
}