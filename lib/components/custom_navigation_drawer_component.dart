import 'package:flutter/painting.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mitro/components/text_component.dart';
import 'package:mitro/utils/asset_const.dart';
import 'package:mitro/utils/constants.dart';
import 'package:mitro/utils/shared_pref.dart';
import 'package:mitro/utils/style.dart';

import 'image_view_component.dart';

class CustomNavigationDrawerComponent extends StatefulWidget {
  const CustomNavigationDrawerComponent({Key? key,}) : super(key: key);

  @override
  _UserCustomNavigationDrawerComponentState createState() => _UserCustomNavigationDrawerComponentState();
}

class _UserCustomNavigationDrawerComponentState extends State<CustomNavigationDrawerComponent> {

  String? name;
  String? userType;

  @override
  void initState() {
    _loadUserInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        margin: const EdgeInsets.only(top: 42),
        decoration: BoxDecoration(
          shape: BoxShape.rectangle,
          color: Colors.white.withOpacity(0.8)
        ),
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            _accountHeader(context),
            const SizedBox(height: 16,),
            _createDrawerItem(
              Icons.home,
              text: "breaker",
              onTap: () {
                Get.back();
              },
            ),

            _createDrawerItem(
              Icons.notifications,
              text: "notifications",
              onTap: () {
                //Navigator.of(context).pop();
                //Get.to(() => const NotificationScreen(), transition: sendTransition);
              },
            ),
            _createDrawerItem(
              Icons.logout,
              text: "logout",
              onTap: () => _logoutAlertDialog(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _accountHeader(context) {
    return Container(
      margin: const EdgeInsets.only(top: 32.0),
      color: Colors.white,
      child: Column(
        children: [
          const ImageViewComponent(
            imageUrl: userPlaceholderAsset,
            placeHolderIcon: userPlaceholderAsset,
            borderWidth: 0.2,
            borderColor: kPrimaryColor,
            height: 95,
            width: 95,
          ),
          TextComponent(
            name ?? "Guest User",
            fontSize: textFontSize,
            maxLines: 3,
            isTranslatable: false,
            textOverflow: TextOverflow.ellipsis,
            fontWeight: mediumFontWeight,
            padding: const EdgeInsets.fromLTRB(8, 16, 8, 4),
          ),
          TextComponent(
            userType?.replaceAll("_", " ") ?? "",
            fontSize: smallFontSize,
            isTranslatable: false,
            textOverflow: TextOverflow.ellipsis,
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 16),
          ),
          const Divider(),
        ],
      ),
    );
  }

  void _logoutAlertDialog() {
    Get.defaultDialog(
      title: "Logout",
      textConfirm: "Logout",
      textCancel: "Cancel",
      radius: 14,
      content: const Text(
        "want_to_logout",
        textAlign: TextAlign.center,
      ).tr(),
      confirmTextColor: Colors.white,
      titlePadding: const EdgeInsets.fromLTRB(16, 16, 16, 0),
      contentPadding: const EdgeInsets.all(16),
      onConfirm: () async {
        loading(value: "Please wait...");
        await logout();
      },
    );
  }

  Widget _createDrawerItem(IconData icon, {String? text, GestureTapCallback? onTap, double size = 24}) {
    return ListTile(
      dense: true,
      title: Row(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(left: 8, right: 12.0),
            child: Icon(
              icon,
              color: kPrimaryColor,
              size: size,
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: TextComponent(
              text,
              fontSize: textSmallFontSize,
              fontWeight: mediumFontWeight,
              textAlign: TextAlign.start,
              padding: const EdgeInsets.fromLTRB(0, 0, 24, 0),
            ),
          )
        ],
      ),
      onTap: onTap,
    );
  }

  Future<void> _loadUserInfo() async {
    SharedPref.read(keyUserName).then((userName) {
      if(userName != null) {
        setState(() {
          name = userName;
        });
      }
    });

    SharedPref.read(keyUserType).then((type) {
      if(type != null) {
        setState(() {
          userType = type;
        });
      }
    });
  }
}
