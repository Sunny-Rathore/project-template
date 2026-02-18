import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../core/app_export.dart';
import '../data/models/selection_popup_model.dart';

class CustomDropDown extends StatelessWidget {
  const CustomDropDown({
    super.key,
    this.alignment,
    this.width,
    this.height,
    this.focusNode,
    this.icon,
    this.autofocus = true,
    this.textStyle,
    this.items,
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
    required this.onChanged,
    this.value,
    this.isSearchable,
    this.borderColor,
  });

  final Alignment? alignment;

  final double? width;

  final double? height;

  final FocusNode? focusNode;

  final Widget? icon;

  final bool? autofocus;

  final TextStyle? textStyle;

  final List<SelectionPopupModel>? items;

  final String? hintText;

  final TextStyle? hintStyle;

  final Widget? prefix;

  final BoxConstraints? prefixConstraints;

  final Widget? suffix;

  final BoxConstraints? suffixConstraints;

  final EdgeInsets? contentPadding;

  final InputBorder? borderDecoration;

  final Color? fillColor;

  final Color? borderColor;

  final bool? filled;

  final FormFieldValidator<SelectionPopupModel>? validator;

  final Function(SelectionPopupModel) onChanged;

  final SelectionPopupModel? value;

  final bool? isSearchable;

  @override
  Widget build(BuildContext context) {
    return alignment != null
        ? Align(
            alignment: alignment ?? Alignment.center,
            child: dropDownWidget(context),
          )
        : dropDownWidget(context);
  }

  Widget dropDownWidget(BuildContext context) => SizedBox(
    height: height ?? 50.v,
    width: width ?? double.maxFinite,
    child: DropdownButtonFormField<SelectionPopupModel>(
      // dropdownColor: ,
      isDense: true,
      iconSize: 0.fSize,
      value: value,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      focusNode: focusNode ?? FocusNode(),
      icon: icon,
      autofocus: autofocus!,
      // style: textStyle ?? CustomTextStyles.titleSmallBold,
      items: items?.map((SelectionPopupModel item) {
        return DropdownMenuItem<SelectionPopupModel>(
          value: item,
          child: Text(
            item.title,
            overflow: TextOverflow.ellipsis,
            style: context.textTheme.bodySmall,
          ),
        );
      }).toList(),
      decoration: decoration(context),
      validator: validator,
      onChanged: (value) {
        onChanged!(value!);
      },
    ),
  );

  InputDecoration decoration(BuildContext context) => InputDecoration(
    hint: Text(
      hintText ?? 'Select item',
      style: context.textTheme.bodySmall?.copyWith(
        color: context.colorScheme.outline,
      ),
    ),
    prefixIcon: prefix,
    prefixIconConstraints: prefixConstraints,
    suffixIcon: Icon(
      Icons.arrow_drop_down,
      color: context.colorScheme.onSurface,
      size: 20.h,
    ),
    suffixIconConstraints: suffixConstraints,
    contentPadding: contentPadding ?? EdgeInsets.all(13.h),
    fillColor: fillColor ?? context.colorScheme.surface,
    filled: true,
    focusedErrorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? context.colorScheme.error,
        width: 1.h,
      ),
    ),
    border:
        borderDecoration ??
        OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? context.colorScheme.outline,
            width: 1.h,
          ),
        ),
    enabledBorder:
        borderDecoration ??
        OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? context.colorScheme.outline,
            width: 1.h,
          ),
        ),
    focusedBorder:
        borderDecoration ??
        OutlineInputBorder(
          borderSide: BorderSide(
            color: borderColor ?? context.colorScheme.primary,
            width: 1.h,
          ),
        ),

    errorBorder: OutlineInputBorder(
      borderSide: BorderSide(
        color: borderColor ?? context.colorScheme.onError,
        width: 1.h,
      ),
    ),
  );
}
