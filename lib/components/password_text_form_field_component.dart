import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:mitro/utils/style.dart';

class PasswordTextFormFieldComponent extends StatefulWidget {

  final String? hint;
  final TextInputAction? textInputAction;
  final Function(String? value) onChanged;

  final double? fontSize;
  final Color textFontColor;
  final String font;
  final FontWeight fontWeight;
  final EdgeInsets padding;
  final bool isFullValidate;
  final IconData? suffixIcon;
  final IconData? prefixIcon;
  final Color? prefixIconColor;

  const PasswordTextFormFieldComponent({
    Key? key,
    this.hint,
    this.suffixIcon,
    this.prefixIcon,
    required this.onChanged,
    this.isFullValidate = true,
    this.fontSize = textFontSize,
    this.font = latoFont,
    this.fontWeight = regularFontWeight,
    this.textFontColor = kTextColor,
    this.prefixIconColor = kTextColor,
    this.textInputAction = TextInputAction.done,
    this.padding = const EdgeInsets.fromLTRB(20, 8, 20, 8),
  }) : super(key: key);

  @override
  _PasswordTextFormFieldComponentState createState() => _PasswordTextFormFieldComponentState();
}

class _PasswordTextFormFieldComponentState extends State<PasswordTextFormFieldComponent> {
  bool _fieldVisibility = true;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _formKey.currentState?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding,
      child: Form(
        key: _formKey,
        child: TextFormField(
          autovalidateMode: AutovalidateMode.onUserInteraction,
          onChanged: (value) {
            if(_formKey.currentState != null && _formKey.currentState!.validate()) {
              widget.onChanged(value);
            } else {
              widget.onChanged(null);
            }
          },
          validator: (value) {
            var hintText = widget.hint?.tr() ?? "";

            if (value == null || value.trim().isEmpty) {
              return hintText + "empty_field_warning".tr();
            } else if (widget.isFullValidate) {
              if (value.length <= 7) {
                return hintText + "max_length_warning".tr();
              } else if (value.contains(" ")) {
                return hintText + "can_not_contain_white_space".tr();
              } else if (!passwordValidation(value)) {
                return hintText + "special_char_warning".tr();
              }
            }

            return null;
          },
          style: GoogleFonts.getFont(
            widget.font,
            fontWeight: widget.fontWeight,
            color: widget.textFontColor,
            fontSize: widget.fontSize,
          ),
          obscureText: _fieldVisibility,
          keyboardType: TextInputType.visiblePassword,
          textInputAction: widget.textInputAction,
          decoration: InputDecoration(
            hintText: widget.hint?.tr() ?? "",
            labelText: widget.hint?.tr() ?? "",
            errorMaxLines: 2,
            contentPadding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
            suffixIcon: IconButton(
              padding: const EdgeInsets.fromLTRB(0, 12, 0, 0),
              icon: Icon(
                _fieldVisibility ? Icons.visibility_off : Icons.visibility,
                color: _fieldVisibility ? Colors.grey : widget.prefixIconColor,
              ),
              onPressed: () {
                setState(() {
                  _fieldVisibility = !_fieldVisibility;
                });
              },
            ),
          ),
        ),
      ),
    );
  }

  bool passwordValidation(String password) {
    final digitReg = RegExp("[0-9]");
    final specialReg = RegExp("[!@#\$%&*()_+=|<>?{}\\[\\]~-]");

    final digitMatch = digitReg.hasMatch(password);
    final specialMatch = specialReg.hasMatch(password);
    return digitMatch && specialMatch;
  }
}
