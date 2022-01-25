import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:get/get.dart';
import 'package:mitro/utils/asset_const.dart';
import 'package:mitro/utils/constants.dart';
import 'package:mitro/utils/shared_pref.dart';
import 'package:mitro/welcome_page.dart';


import 'base/base_state.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends BaseState<SplashScreen> {

  startTime() async {

    try {
      var userId = await SharedPref.read(keyUserId);

      if (userId != null) {
        //await subscribeUnSubscribeTopicToFirebase(userId);
        //Get.offAll(() => const HomeScreen(), transition: sendTransition);
      } else {
        //await subscribeUnSubscribeTopicToFirebase(userId, isUnSubscribe: true);
        //Get.offAll(() => const LoginScreen(), transition: sendTransition);
        Get.off(() => const WelcomePage(), transition: sendTransition);
      }
    } catch (e) {
      EasyLoading.showError(e.toString());
      //Get.offAll(() => const LoginScreen(), transition: sendTransition);
      Get.off(() => const WelcomePage(), transition: sendTransition);
    }
  }

  @override
  void initState() {
    super.initState();

    startTime();

    isInternetConnected(context).then((internet) {
      if (internet) {
        // Internet Present Case
        startTime();
      } else {
        // No-Internet Case
        showWarningDialog(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
          decoration: const BoxDecoration(
            color: Colors.white,
          ),
          child: Center(
            child: Image.asset(
              welcomeScreenImageSvg,
            ),
          )),
    );
  }

  showWarningDialog(BuildContext context) {
    Widget continueButton = TextButton(
      child: const Text(
        "Retry",
      ),
      onPressed: () {
        Navigator.pop(context);
        EasyLoading.showToast("Please wait...");

        isInternetConnected(context).then((internet) {
          if (internet) {
            // Internet Present Case
            startTime();
          } else {
            // No-Internet Case
            showWarningDialog(context);
          }
        });
      },
    );

    Widget cancelButton = TextButton(
      child: const Text(
        "Exit",
      ),
      onPressed: () {
        if (Platform.isAndroid) {
          SystemNavigator.pop();
        } else if (Platform.isIOS) {
          exit(0);
        }
      },
    );

    if (Platform.isIOS) {
      CupertinoAlertDialog alert = CupertinoAlertDialog(
        title: const Text(
          "No Internet connection!",
        ),
        content: const Text(
          "Please Connect your device to internet first",
        ),
        actions: [cancelButton, continueButton],
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    } else {
      AlertDialog alert = AlertDialog(
        elevation: 2,
        title: const Text(
          "No Internet connection!",
        ),
        content: const Text(
          "Please Connect your device to internet first",
        ),
        actions: [cancelButton, continueButton],
      );
      showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext context) {
          return alert;
        },
      );
    }
  }
}
