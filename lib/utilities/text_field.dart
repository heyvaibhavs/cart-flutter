import 'package:cart/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomPhoneTextField extends StatelessWidget {
  final TextEditingController controller;
  final String? labelText;
  final bool autofocus;
  final bool showPrefix;
  final String? prefixText;
  final String? hintText;
  final Color? enabledBorderColor;
  final Color? focusedBorderColor;
  final Color? errorBorderColor;
  final Color? focusedErrorBorderColor;
  final BorderRadius? borderRadius;
  final TextInputType textInputType;
  final int? inputLength;


  const CustomPhoneTextField({
    Key? key,
    required this.controller,
    this.labelText,
    this.autofocus = true,
    this.showPrefix = true,
    this.prefixText,
    this.hintText,
    this.enabledBorderColor,
    this.focusedBorderColor,
    this.errorBorderColor,
    this.focusedErrorBorderColor,
    this.borderRadius,
    required this.textInputType,
    this.inputLength,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      autofocus: autofocus,
      cursorColor: AppColors.themeOrange,
      keyboardType: textInputType,
      inputFormatters: [LengthLimitingTextInputFormatter(inputLength)],
      decoration: InputDecoration(
        prefixText: showPrefix ? prefixText : null,
        labelText: labelText,
        hintText: hintText,
        hintStyle: TextStyle(
          color: Colors.black45
        ),
        floatingLabelStyle: const TextStyle(color: Colors.black54),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
          borderSide: BorderSide(
            color: enabledBorderColor ?? AppColors.themeOrange,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
          borderSide: BorderSide(
            color: focusedBorderColor ?? AppColors.themeOrange,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
          borderSide: BorderSide(
            color: errorBorderColor ?? AppColors.themeOrange,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: borderRadius ?? BorderRadius.zero,
          borderSide: BorderSide(
            color: focusedErrorBorderColor ?? AppColors.themeOrange,
            width: 2.0,
            style: BorderStyle.solid,
          ),
        ),
      ),
      // autofillHints: const [AutofillHints.telephoneNumber], // Added autofill hint
    );
  }
}
