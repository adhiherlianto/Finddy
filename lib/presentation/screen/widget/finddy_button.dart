import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FDButton extends StatelessWidget {
  final VoidCallback onPressed;
  final String text;
  bool? isLoading;
  Color? backgroundColor;
  Color? textColor;
  double? width;
  double? height;

  FDButton.primary(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isLoading,
      this.backgroundColor = AppColors.primaryGreen,
      this.textColor = AppColors.neutralwhite,
      this.width,
      this.height})
      : super(key: key);

  FDButton.secondary(
      {Key? key,
      required this.onPressed,
      required this.text,
      this.isLoading,
      this.backgroundColor = AppColors.primaryLightBlue,
      this.textColor = AppColors.primaryGreen,
      this.width})
      : super(key: key);
  FDButton.teritary(
      {Key? key,
      this.height,
      required this.onPressed,
      this.isLoading,
      required this.text,
      this.backgroundColor = AppColors.error,
      this.textColor = AppColors.neutralwhite,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 46,
      child: ElevatedButton(
          onPressed: onPressed,
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(backgroundColor)),
          child: height == null
              ? FDText.headersH6(
                  text: text,
                  color: textColor,
                )
              : FDText.headersH8(
                  text: text,
                  color: textColor,
                )),
    );
  }
}
