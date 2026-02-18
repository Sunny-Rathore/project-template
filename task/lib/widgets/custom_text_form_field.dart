// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_export.dart';

class CustomTextFormField extends StatelessWidget {
  CustomTextFormField({
    super.key,
    this.alignment,
    this.width,
    this.scrollPadding,
    this.controller,
    this.focusNode,
    this.autofocus = false,
    this.textStyle,
    this.obscureText = false,
    this.textInputAction = TextInputAction.next,
    this.textInputType = TextInputType.text,
    this.maxLines,
    this.hintText,
    this.hintStyle,
    this.prefix,
    this.prefixConstraints,
    this.suffix,
    this.suffixConstraints,
    this.contentPadding,
    this.borderDecoration,
    this.fillColor,
    this.filled = false,
    this.validator,
    this.onTap,
    this.readOnly,
    this.maxLength,
    this.counter,
    this.onChanged,
  });

  final Alignment? alignment;

  final double? width;

  final TextEditingController? scrollPadding;

  final TextEditingController? controller;

  final FocusNode? focusNode;

  final bool? autofocus;

  final TextStyle? textStyle;

  final bool? obscureText;

  final TextInputAction? textInputAction;

  final TextInputType? textInputType;

  final int? maxLines;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final bool? filled;

  final FormFieldValidator<String>? validator;

  void Function(String)? onChanged;

  final bool? readOnly;

  final int? maxLength;

  VoidCallback? onTap;
  Widget? counter;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: textFormFieldWidget(context),
          )
        : textFormFieldWidget(context);
  }

  Widget textFormFieldWidget(BuildContext context) => SizedBox(
    width: width ?? double.maxFinite,
    child: TextFormField(
      focusNode: focusNode,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      maxLength: maxLength,
      onTap: onTap,
      readOnly: readOnly ?? false,
      onChanged: onChanged,
      controller: controller,
      style:
          textStyle ??
          context.textTheme.bodySmall?.copyWith(
            fontSize: 16.0.fSize,
            // color: context.colorScheme.onSurface,
            // fontWeight: FontWeight.w400,
          ),
      obscureText: obscureText!,
      textInputAction: textInputAction,
      keyboardType: textInputType,
      maxLines: maxLines ?? 1,
      decoration: decoration(context),
      validator: validator,
    ),
  );

  InputDecoration decoration(BuildContext context) => InputDecoration(
    counter: counter,
    // hintText: textAreaHint,
    hintText: hintText,
    hintStyle: context.textTheme.bodySmall?.copyWith(
      fontSize: 14.0.fSize,
      color: context.colorScheme.outline,
      fontWeight: FontWeight.w400,
    ),
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints,
    suffixIcon: suffix,
    suffixIconConstraints: suffixConstraints,
    isDense: true,
    contentPadding: contentPadding ?? EdgeInsets.all(12.h),
    fillColor: fillColor ?? context.colorScheme.surface,
    filled: true,
    border:
        borderDecoration ??
        OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide(
            color: context.colorScheme.outline,
            width: 1.h,
          ),
        ),
    enabledBorder:
        borderDecoration ??
        OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide(
            color: context.colorScheme.outline,
            width: 1.h,
          ),
        ),
    focusedBorder:
        borderDecoration ??
        OutlineInputBorder(
          // borderRadius: BorderRadius.circular(10.h),
          borderSide: BorderSide(
            color: context.colorScheme.primary,
            width: 1.h,
          ),
        ),
    errorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(10.h),
      borderSide: BorderSide(color: context.colorScheme.error, width: 1.h),
    ),
    focusedErrorBorder: OutlineInputBorder(
      // borderRadius: BorderRadius.circular(10.h),
      borderSide: BorderSide(color: context.colorScheme.error, width: 1.h),
    ),
    errorMaxLines: 3,
    errorStyle: TextStyle(fontSize: 12.fSize),
  );
}

/// Extension on [CustomTextFormField] to facilitate inclusion of all types of border style etc
extension TextFormFieldStyleHelper on CustomTextFormField {
  static OutlineInputBorder get outlineOnPrimary => OutlineInputBorder(
    borderRadius: BorderRadius.circular(24.h),
    borderSide: BorderSide.none,
  );

  static OutlineInputBorder get outlineRedATL4 => OutlineInputBorder(
    borderRadius: BorderRadius.circular(4.h),
    borderSide: const BorderSide(
      // color: appTheme.redA200,
      width: 1,
    ),
  );

  static OutlineInputBorder get fillRed => OutlineInputBorder(
    borderRadius: BorderRadius.only(
      topLeft: Radius.circular(12.h),
      topRight: Radius.circular(12.h),
      bottomRight: Radius.circular(12.h),
    ),
    borderSide: BorderSide.none,
  );
}
