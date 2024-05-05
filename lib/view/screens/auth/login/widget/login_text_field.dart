import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:web_view_app/core/utils/my_images.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:web_view_app/core/utils/dimensions.dart';
import 'package:web_view_app/core/utils/my_color.dart';
import 'package:web_view_app/core/utils/style.dart';
import 'package:web_view_app/view/components/text/label_text.dart';

import '../../../../../core/utils/my_strings.dart';

class LoginTextField extends StatefulWidget {

  final String? labelText;
  final String? hintText;
  final Function? onChanged;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final FocusNode? nextFocus;
  final FormFieldValidator? validator;
  final TextInputType? textInputType;
  final bool isEnable;
  final bool isPassword;
  final bool isShowSuffixIcon;
  final bool isIcon;
  final VoidCallback? onSuffixTap;
  final TextInputAction inputAction;
  final bool needOutlineBorder;
  final bool readOnly;
  final int maxLines;
  final Color fillColor;
  final bool isRequired;
  final String? prefixIconSvg;
  final Color? svgIconColor;

  const LoginTextField({
    Key? key,
    this.labelText,
    this.readOnly = false,
    this.fillColor = MyColor.transparentColor,
    required this.onChanged,
    this.hintText,
    this.controller,
    this.focusNode,
    this.nextFocus,
    this.validator,
    this.textInputType,
    this.isEnable = true,
    this.isPassword = false,
    this.isShowSuffixIcon = false,
    this.isIcon = false,
    this.onSuffixTap,
    this.inputAction = TextInputAction.next,
    this.needOutlineBorder = false,
    this.maxLines = 1,
    this.isRequired = false,
    this.prefixIconSvg,
    this.svgIconColor
  }) : super(key: key);

  @override
  State<LoginTextField> createState() => _LoginTextFieldState();
}

class _LoginTextFieldState extends State<LoginTextField> {

  bool obscureText = true;

  @override
  Widget build(BuildContext context) {

    return TextFormField(
        controller: widget.controller,
        focusNode: widget.focusNode,
        onFieldSubmitted: (text) => widget.nextFocus != null ? FocusScope.of(context).requestFocus(widget.nextFocus) : null,
        decoration: InputDecoration(
          contentPadding: Dimensions.textFieldContentPadding,
          fillColor: widget.fillColor,
          filled: true,
          labelText: widget.labelText,
          labelStyle: regularDefault.copyWith(color: MyColor.getTextFieldTextColor(),fontWeight: FontWeight.w500),
          enabledBorder: OutlineInputBorder(borderSide: const BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.circular(Dimensions.textFieldRadius)),
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: MyColor.transparentColor),borderRadius: BorderRadius.circular(Dimensions.textFieldRadius)),
        ),
        validator: widget.validator
    );
  }

  void _toggle() {
    setState(() {
      obscureText = !obscureText;
    });
  }
}