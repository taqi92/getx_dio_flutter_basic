import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mitro/utils/style.dart';

class TextComponent extends StatelessWidget {
  final String? text;
  final double? fontSize;
  final Color color;
  final double opacity;
  final String font;
  final int? maxLines;
  final bool isTranslatable;
  final bool isHideKeyboard;
  final double? lineHeight;
  final TextAlign textAlign;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final TextOverflow? textOverflow;
  final VoidCallback? onPressed;
  final TextDecoration? textDecoration;

  const TextComponent(
      this.text,
      {
        Key? key,
        this.onPressed,
        this.maxLines,
        this.opacity = 1,
        this.textOverflow,
        this.font = latoFont,
        this.isTranslatable = true,
        this.isHideKeyboard = true,
        this.color = kTextColor,
        this.fontSize = textFontSize,
        this.textAlign = TextAlign.center,
        this.lineHeight = k24LineHeight,
        this.fontWeight = regularFontWeight,
        this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 8),
        this.textDecoration,
      }
  ) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return onPressed != null ?
    GestureDetector(
      onTapUp: (details) {
        if(isHideKeyboard) {
          FocusManager.instance.primaryFocus?.unfocus();
        }
      },
      child: _getTextWidget(),
      onTap: onPressed,
    ) :
    _getTextWidget();
  }

  Widget _getTextWidget() {
    return Padding(
      padding: padding,
      child: Text(
        isTranslatable ? (text?.tr() ?? "") : text ?? "",
        textAlign: textAlign,
        maxLines: maxLines,
        overflow: textOverflow,
        style: GoogleFonts.getFont(
          font,
          fontWeight: fontWeight,
          fontSize: fontSize,
            height: k24LineHeight,
          color: color.withOpacity(opacity),
          decoration: textDecoration
        ),
      ),
    );
  }
}
