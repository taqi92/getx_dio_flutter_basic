import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';
import 'package:mitro/components/text_component.dart';
import 'package:mitro/utils/size_config.dart';
import 'package:mitro/utils/style.dart';


abstract class BaseStateless {
  AppBar myAppBar({
    String? title, bool isNavigate = true, bool isCenterTitle = true,
    bool isTranslatable = true, bool backToProviderHome = false,
    bool backToCustomerHome = false, bool backToOrderDetails = false, List<Widget>? actions,
  }) {
    return AppBar(
      elevation: isNavigate ? 1.4 : 0,
      iconTheme: const IconThemeData(color: kPrimaryColor),
      centerTitle: isCenterTitle,
      title: _getTitle(title, isTranslatable),
      backgroundColor: Colors.white,
      leading: isNavigate ? GestureDetector(
        onTap: () {
          Get.back();

          // if(backToCustomerHome) {
          //   Get.offAll(() => const HomeCustomerScreen(), transition: backTransition);
          // } else if(backToProviderHome) {
          //   Get.offAll(() => const HomeServiceProviderScreen(), transition: backTransition);
          // }  else if(backToOrderDetails) {
          //   Get.close(3);
          // } else {
          //   Get.back();
          // }
        },
        child: const Padding(
          padding: EdgeInsets.all(8.0),
          child: Icon(
            Icons.arrow_back_outlined,
            color: kPrimaryColor,
          ),
        ),
      ) : null,
      actions: actions,
    );
  }

  Text? _getTitle(String? title, bool isTranslatable) {
    if(title != null && title != "") {
      var textStyle = GoogleFonts.getFont(
        latoFont,
        fontWeight: mediumFontWeight,
        color: kPrimaryColor,
        fontSize: appBarFontSize,
      );

      if(isTranslatable) {
        return Text(
          title,
          style: textStyle,
        ).tr();
      } else {
        return Text(
          title,
          style: textStyle,
        );
      }
    }

    return null;
  }

  void resetGetXValues(List<Rxn<dynamic>?>? args) {
    if(args != null) {
      for (var arg in args) {
        arg?.value = null;
      }
    }
  }

  bool isBlank(List<dynamic>? args) {
    if(args != null) {
      for(var arg in args) {
        if(arg == null) {
          return true;
        } else if(arg is String && arg.trim().isEmpty) {
          return true;
        }
      }
    }

    return false;
  }

  Widget noDataFoundWidget(BuildContext context) {
    return SizedBox(
      height: SizeConfig.getScreenHeight(context),
      width: SizeConfig.getScreenWidth(context),
      child: const Center(
        child: TextComponent(
          "no_data_found",
          padding: EdgeInsets.zero,
        ),
      ),
    );
  }
}
