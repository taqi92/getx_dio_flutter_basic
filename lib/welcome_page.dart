import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:get/get.dart';
import 'package:mitro/utils/asset_const.dart';
import 'package:mitro/utils/size_config.dart';
import 'package:mitro/utils/style.dart';
import 'components/button_component.dart';
import 'components/default_image_view.dart';
import 'components/text_component.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children:  const [
              Center(
                  child: DefaultImageView(
                imageUrl: welcomeScreenImageSvg,
                isLocalAssetSvg: false,
                imageRadius: 0.0,
                backgroundRadius: 0.0,
                height: 220,
                width: 302,
              )),
              SizedBox(
                height: 36,
              ),
              TextComponent(
                'welcome_screen_text',
                fontSize: titleFontSize,
                fontWeight: titleFontWeight,
                color: kPrimaryColor,
                lineHeight: 1.4,
                textAlign: TextAlign.center,
                font: latoFont,
              ),
              TextComponent(
                'welcome_screen_sub_text',
                fontSize: textSmallFontSize,
                fontWeight: FontWeight.normal,
                color: kTextColor,
                lineHeight: 1.5,
              )
            ],
          ),
        ),
      ),
    );
  }
}
