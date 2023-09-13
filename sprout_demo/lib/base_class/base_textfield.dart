import 'package:new_project_setup/constants/app.export.dart';

class BaseTextField extends TextFormField {
  final String? labelText;
  final String? hintText;
  final TextEditingController? controller;
  final TextInputType? textInputType;
  final bool? isSecure;
  final bool enabled;
  final String? Function(String?)? validator;
  final Widget? suffixIcon;
  final Color? fillColor;
  final Color? borderColor;
  final Color? textColor;
  final Color? cursorColor;
  final Widget? prefixIcon;
  final TextAlign? textAlign;
  final bool readOnly;
  final Function()? onEditingComplete;
  final Function(String?)? onSaved;
  final Function()? onTap;
  final Function(String)? onChanged;
  final TextCapitalization? textCapitalization;
  final double? borderRadius;
  final EdgeInsets? contentPadding;
  final TextInputAction? textInputAction;
  final List<TextInputFormatter>? inputFormatters;
  final int? maxLines;
  final int? errorMaxLines;
  final int? hintMaxLines;
  final Function(String?)? onFieldSubmitted;
  final int? minLines;
  final TextStyle? hintStyle;
  final TextStyle? labelStyle;
  final InputBorder? customBorder;

  BaseTextField({
    this.hintText,
    this.onTap,
    this.labelText,
    this.maxLines,
    this.errorMaxLines,
    this.suffixIcon,
     this.controller,
    this.onEditingComplete,
    this.borderRadius,
    this.cursorColor,
    this.onChanged,
    this.textCapitalization,
    this.prefixIcon,
    this.textAlign,
    this.readOnly = false,
    this.fillColor,
    this.borderColor,
    this.textColor,
    this.textInputType,
    this.isSecure = false,
    this.enabled = true,
    this.validator,
    this.textInputAction,
    this.contentPadding,
    this.inputFormatters,
    this.hintMaxLines,
    this.onSaved,
    this.onFieldSubmitted,
    this.minLines,
    this.hintStyle,
    this.labelStyle,
    this.customBorder,
  }) : super(
          onTap: onTap,
          controller: controller,
          keyboardType: textInputType ?? TextInputType.text,
          obscureText: isSecure ?? false,
          style: TextStyle(fontSize: Utils.getFontSize(16), fontWeight: FontWeight.w600, color: textColor ?? ColorRes.primaryColor,fontFamily: "Montserrat"),
          textCapitalization: textCapitalization ?? TextCapitalization.none,
          onEditingComplete: onEditingComplete,
          onChanged: onChanged,
          textInputAction: textInputAction ?? TextInputAction.next,
          enabled: enabled,
          cursorColor: cursorColor ?? ColorRes.blackColor,
          textAlign: textAlign ?? TextAlign.start,
          readOnly: readOnly,
          maxLines: maxLines ?? 1,
          onSaved: onSaved,
          onFieldSubmitted: onFieldSubmitted,
          minLines: minLines,
          inputFormatters: inputFormatters ?? [],
          decoration: InputDecoration(
              prefixIcon: prefixIcon,
              suffixIcon: suffixIcon,
              fillColor: fillColor ?? ColorRes.whiteColor,
              filled: true,
              border: customBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10), borderSide: BorderSide(color: borderColor ?? ColorRes.primaryColor, width: 1)),
              focusedBorder: customBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10), borderSide: BorderSide(color: borderColor ?? ColorRes.primaryColor, width: 1)),
              enabledBorder: customBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10), borderSide: BorderSide(color: borderColor ?? ColorRes.primaryColor, width: 1)),
              errorBorder: customBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10), borderSide: BorderSide(color: borderColor ?? ColorRes.primaryColor, width: 1)),
              focusedErrorBorder: customBorder ?? OutlineInputBorder(borderRadius: BorderRadius.circular(borderRadius ?? 10), borderSide: BorderSide(color: borderColor ?? ColorRes.primaryColor, width: 1)),
              contentPadding: contentPadding ?? EdgeInsets.symmetric(vertical: Utils.getSize(22), horizontal: Utils.getSize(20)),
              errorMaxLines: errorMaxLines ?? 1,
              hintText: hintText,
              hintMaxLines: hintMaxLines ?? 1,
              labelText: labelText,
              labelStyle: labelStyle ?? TextStyle(fontSize: Utils.getFontSize(15), fontWeight: FontWeight.w600, letterSpacing: Utils.getSize(0.5), color: textColor ?? ColorRes.primaryColorLight),
              hintStyle: hintStyle ?? TextStyle(fontFamily: "Montserrat", fontSize: Utils.getFontSize(14), fontWeight: FontWeight.w600, letterSpacing: 0.5, color: textColor ?? ColorRes.primaryColorLight)),
          validator: (name) {
            validator;
          },
        );
}