import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:vandana/Constant/color_constant.dart';
import 'package:vandana/Constant/textstyle_constant.dart';

class CustomTextField extends StatelessWidget {
  TextEditingController controller;
  String? hintText;
  BorderRadius? borderRadius;
  Widget? suffixIcon;
  Widget? prefixIcon;
  double? focuseBorderWidth;
  bool? isObscureText;
  bool? isExpand = false;
  Color? focuseBorderColor;
  Color? textFieldBackgroundColor;
  int? maxLine;
  List<TextInputFormatter>? textInputFormatter;
  bool? enable;
  TextInputType? textInputType;
  bool? isReadOnly = false;
  String? labelText;
  Function()? onTap;
  FocusNode? focusNode;
  String? Function(String?)? validator;
  int? maxLength;
  Function(String)? onChange;
  Function(String)? onSubmitted;
  Color? fillColor;
  Color? hintColor;
  TextSelectionControls? textSelectionControls;

  CustomTextField(
      {super.key,
      required this.controller,
      this.hintText,
      this.onChange,
      this.borderRadius,
      this.enable,
      this.fillColor,
      this.focuseBorderColor,
      this.focuseBorderWidth,
      this.focusNode,
      this.hintColor,
      this.isExpand,
      this.isReadOnly,
      this.labelText,
      this.maxLength,
      this.maxLine,
      this.validator,
      this.isObscureText,
      this.onTap,
      this.onSubmitted,
      this.prefixIcon,
      this.suffixIcon,
      this.textFieldBackgroundColor,
      this.textInputFormatter,
      this.textInputType,
      this.textSelectionControls});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      obscureText: isObscureText ?? false,
      inputFormatters: textInputFormatter,
      maxLines: maxLine ?? 1,
      maxLength: maxLength ?? 1000,
      focusNode: focusNode,
      minLines: 1,
      onTap: onTap,
      readOnly: isReadOnly ?? false,
      onChanged: onChange,
      onFieldSubmitted: onSubmitted,
      validator: validator,
      keyboardType: textInputType ?? TextInputType.text,
      style: TextStyleConstant.regular16(),
      cursorColor: ColorConstant.orange,
      decoration: InputDecoration(
        prefixIcon: prefixIcon,
        fillColor: fillColor ?? ColorConstant.white,
        filled: true,
        enabled: enable ?? true,
        counterText: "",
        labelStyle: TextStyleConstant.medium14(color: ColorConstant.grey),
        border: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
              width: focuseBorderWidth ?? 2,
              color: focuseBorderColor ?? ColorConstant.orange),
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        disabledBorder: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: borderRadius ?? BorderRadius.circular(10),
        ),
        suffixIcon: suffixIcon,
        // helperText: helperText,
        focusColor: ColorConstant.orange,
        labelText: labelText,
        hintText: hintText,
        contentPadding: EdgeInsets.fromLTRB(
            Get.width * 0.037, Get.height * 0.012, 0, Get.height * 0.012),
        hintStyle: TextStyleConstant.semiBold14(
            color: hintColor ?? ColorConstant.darkGrey),
      ),
      selectionControls: textSelectionControls,
    );
  }
}
