import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

import '../core/app_export.dart';
import 'base_button.dart';

class CustomElevatedButton extends BaseButton {
  const CustomElevatedButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.isLoading,
    required super.text,
    this.backgroundColor,
    this.radius,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;
  final Color? backgroundColor;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget(context),
          )
        : buildElevatedButtonWidget(context);
  }

  Widget buildElevatedButtonWidget(BuildContext context) => Container(
    height: height ?? 52.v,
    width: width ?? double.maxFinite,
    margin: margin,
    decoration: decoration,
    child: ElevatedButton(
      style:
          buttonStyle ??
          ElevatedButton.styleFrom(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(radius ?? 2.h),
            ),
            overlayColor: context.colorScheme.onPrimary,
            backgroundColor: backgroundColor ?? context.colorScheme.primary,
          ),
      onPressed: (isLoading ?? false) ? null : onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          (isLoading ?? false)
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: context.colorScheme.surface,
                    size: 30.fSize,
                  ),
                )
              : Padding(
                  padding: EdgeInsets.only(left: leftIcon == null ? 0 : 10.h),
                  child: Text(
                    text,
                    style:
                        buttonTextStyle ??
                        context.textTheme.bodyMedium?.copyWith(
                          fontSize: 16.0.fSize,
                          color: context.colorScheme.surface,
                          // fontWeight: FontWeight.w600,
                        ),
                  ),
                ),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}

class CustomOutlineButton extends BaseButton {
  const CustomOutlineButton({
    super.key,
    this.decoration,
    this.leftIcon,
    this.rightIcon,
    super.margin,
    super.onPressed,
    super.buttonStyle,
    super.alignment,
    super.buttonTextStyle,
    super.isDisabled,
    super.height,
    super.width,
    super.isLoading,
    required super.text,
    this.radius,
  });

  final BoxDecoration? decoration;

  final Widget? leftIcon;

  final Widget? rightIcon;
  final double? radius;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: buildElevatedButtonWidget(context),
          )
        : buildElevatedButtonWidget(context);
  }

  Widget buildElevatedButtonWidget(BuildContext context) => Container(
    height: height ?? 50.v,
    width: width ?? double.maxFinite,
    margin: margin,
    decoration: decoration,
    child: ElevatedButton(
      style:
          buttonStyle ??
          ElevatedButton.styleFrom(
            elevation: 0,
            backgroundColor: context.colorScheme.primary,
            shape: RoundedRectangleBorder(
              side: BorderSide(color: context.colorScheme.primary),
              borderRadius: BorderRadius.circular(radius ?? 2.h),
            ),
          ),
      onPressed: isLoading ?? false ? null : onPressed ?? () {},
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          leftIcon ?? const SizedBox.shrink(),
          (isLoading ?? false)
              ? Center(
                  child: LoadingAnimationWidget.staggeredDotsWave(
                    color: Colors.white,
                    size: 30,
                  ),
                )
              : Text(
                  text,
                  style:
                      buttonTextStyle ??
                      GoogleFonts.inter(
                        fontSize: 16.0.fSize,
                        color: context.colorScheme.onPrimary,
                        fontWeight: FontWeight.w600,
                      ),
                ),
          rightIcon ?? const SizedBox.shrink(),
        ],
      ),
    ),
  );
}
