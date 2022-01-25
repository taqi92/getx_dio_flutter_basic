import 'dart:io';
import 'package:flutter/widgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_navigation/src/snackbar/snackbar.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';


class PushNotificationService {

  static final PushNotificationService _pushNotificationService = PushNotificationService._internal();
  PushNotificationService._internal();

  factory PushNotificationService() {
    return _pushNotificationService;
  }

  /*final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
  final _notificationController = Get.put(NotificationController());

  Future initialise() async {
    if (Platform.isIOS) {
      try {
        var settings = await _firebaseMessaging.getNotificationSettings();

        if(settings.authorizationStatus != AuthorizationStatus.authorized) {
          await _firebaseMessaging.requestPermission(
            alert: true,
            announcement: false,
            badge: true,
            carPlay: false,
            criticalAlert: false,
            provisional: false,
            sound: true,
          );
        }
      } catch(e) {
        EasyLoading.showError(e.toString());
      }
    }

    //onLaunch(completely closed - not in background)
    _firebaseMessaging.getInitialMessage().then((RemoteMessage? message) {
      _sendFromNotificationClick(message);
    });

    //onMessage(app in open)
    FirebaseMessaging.onMessage.listen((RemoteMessage? message) {
      _sendFromNotificationClick(message, isNavigate: false);
    });

    //onResume(app in background)
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage? message) {
      _sendFromNotificationClick(message);
    });
  }

  void _sendFromNotificationClick(RemoteMessage? message, {bool isNavigate = true}) {
    var data = message?.data;

    if(data != null) {
      var body = data['body'];
      var title = data['title'];
      var tradeCode = data['tradeCode'];
      var companyName = data['companyName'];
      var unreadCounterData = data['unreadCount'];

      if(unreadCounterData != null && unreadCounterData != "") {
        var unreadCounter = int.parse(unreadCounterData);

        SharedPref.read(keyJwtToken).then((jwt) {
          if(jwt != null) {
            if(unreadCounter > 0) {
              _notificationController.unreadCounter.value = unreadCounter;
            }

            if(isNavigate) {
              Get.to(() => StockDetailsScreen(tradeCode: tradeCode, companyName: companyName,), transition: sendTransition);
            } else if(title != null && body != null) {
              Get.snackbar(
                title,
                body,
                isDismissible: true,
                backgroundColor: fadeAshColor,
                snackPosition: SnackPosition.BOTTOM,
                icon: const Icon(
                  Icons.notifications,
                  color: colorPrimary,
                ),
              );
            }
          } else {
            EasyLoading.showError("Something went wrong!");
          }
        }).catchError((onError) {
          EasyLoading.showError(onError.toString());
        });
      }
    }
  }*/
}
