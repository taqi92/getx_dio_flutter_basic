import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:mitro/utils/shared_pref.dart';

typedef ResponseCallback<R, E> = void Function(R response, E error);

const emailPattern = r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

const sendTransition = Transition.rightToLeft;
const backTransition = Transition.leftToRight;


/*sharedPrefKey start*/
const String keyUserId = "keyUserId";
const String keySortBy = "keySortBy";
const String keyUserName = "keyUserName";
const String keyUserType = "keyUserType";
const String keyJwtToken = "keyJwtToken";
const String keyRefreshToken = "keyRefreshToken";
/*sharedPrefKey end*/

void closeSoftKeyBoard() {
  FocusManager.instance.primaryFocus?.unfocus();
}

Future<void> logout() async {
  try {
    var userId = await SharedPref.read(keyUserId);
    if(userId != null) {
      //await subscribeUnSubscribeTopicToFirebase(userId, isUnSubscribe: true);
    }
  } catch(_) {}

  await SharedPref.removeAll();
  EasyLoading.dismiss();
  //Get.offAll(() => const LoginScreen(), transition: sendTransition);
}

/*Future<void> subscribeUnSubscribeTopicToFirebase(var userId, {bool isUnSubscribe = false}) async {
  try {
    if(isUnSubscribe) {
      await FirebaseMessaging.instance.unsubscribeFromTopic("$userId");
    } else {
      await FirebaseMessaging.instance.subscribeToTopic("$userId");
    }
  } catch(e) {
    //EasyLoading.showError(e.toString());
  }
}*/

Future<bool> isInternetConnected(BuildContext context, {bool isShowAlert = false}) async {
  bool isConnected = false;

  try {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile || connectivityResult == ConnectivityResult.wifi) {
      isConnected = true;
    }
  } catch(_) {}

  if(isShowAlert && !isConnected) {
    showMessage("Internet Connectivity Problem");
  }

  return isConnected;
}

void loading({var value = "Please wait...", bool isHideKeyboard = true}) {
  if(isHideKeyboard) closeSoftKeyBoard();
  EasyLoading.show(status: value);
}

void dismissLoading() {
  EasyLoading.dismiss();
}

void showMessage(String? value, {bool isToast= false, bool isInfo = false}) {
  if (isInfo) {
    EasyLoading.showInfo("$value");
  } else if(isToast) {
    EasyLoading.showSuccess("$value");
  } else {
    dismissLoading();
    EasyLoading.showError("$value", duration: const Duration(seconds: 5), dismissOnTap: true);
  }
}

void showAlertDialog(
    String title, String body, String confirmButtonText, String cancelButtonText,
    Function(bool onConfirm, bool onCancel) clickEvent, {barrierDismissible = true}
) {
  Get.defaultDialog(
    title: title,
    textConfirm: " $confirmButtonText ",
    textCancel: cancelButtonText,
    radius: 11,
    barrierDismissible: barrierDismissible,
    content: Text(
      body,
      textAlign: TextAlign.center,
    ),
    confirmTextColor: Colors.white,
    titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
    contentPadding: const EdgeInsets.all(16),
    onConfirm: () {
      Get.back();
      clickEvent(true, false);
    },
    onCancel: () {
      Get.back();
      clickEvent(false, true);
    },
  );
}

// void launchUrl(String? value, {bool sms = false, bool call = false,}) async {
//   if(value != null) {
//     if(call) {
//       value = "tel:$value";
//     } else if(sms) {
//       value = "sms:$value";
//     }
//
//     if (await canLaunch(value)) {
//       await launch(value,);
//     } else {
//       EasyLoading.showError('Could not launch: $value');
//     }
//   }
// }