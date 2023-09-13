import 'package:new_project_setup/constants/app.export.dart';

class BaseRaisedButton extends ElevatedButton {
  final VoidCallback onPressed;
  final String buttonText;
  final double? fontSize;
  final double? borderRadius;
  final FontWeight? fontWeight;
  final MaterialStateProperty<Color>? buttonColor;
  final Color? textColor;
  final double? buttonVerticalPadding;
  final double? buttonHorizontalPadding;
  final Color? borderSideColor;

  BaseRaisedButton({Key? key,
    required this.buttonText, required this.onPressed,
    this.borderSideColor,
    this.fontSize, this.fontWeight, this.buttonColor, this.buttonVerticalPadding, this.buttonHorizontalPadding, this.borderRadius,this.textColor})
      : super(
    key: key,
    child: Container(
      height: Utils.getSize(30),
      alignment : Alignment.center,
      child: BaseText(
        text: buttonText,
        color: textColor ?? ColorRes.whiteColor,
        fontSize: fontSize ?? 18,
        fontWeight: fontWeight ?? FontWeight.w600,
      ),
    ),
    onPressed: onPressed,
    style: ButtonStyle(
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(borderRadius ?? 20), side: BorderSide(color: borderSideColor ?? Colors.transparent)),
        ),
        backgroundColor: buttonColor ?? MaterialStateProperty.all(ColorRes.primaryColor),
        elevation: MaterialStateProperty.all(0),
        padding: MaterialStateProperty.all<EdgeInsetsGeometry>(EdgeInsets.symmetric(vertical: buttonVerticalPadding ?? 18, horizontal: buttonHorizontalPadding ?? 0))),
  );
}