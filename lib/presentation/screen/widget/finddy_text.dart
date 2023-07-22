import 'package:finddy/presentation/theme/colors.dart';
import 'package:finddy/presentation/theme/typography.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class FDText extends StatelessWidget {
  final String text;
  final TextStyle? textStyle;
  final TextAlign? textAlign;
  final TextOverflow? overflow;
  final int? maxLines;
  final Color? color;

  const FDText.headersH3(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.headersH3,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.headersH4(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.headersH4,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.headersH5(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.headersH5,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.bodyP3(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.bodyP3,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.bodyP4(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.bodyP4,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.bodyP5(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.bodyP5,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.bodyP2(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.bodyP2,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.headersH6(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.headersH6,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.headersH7(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.headersH7,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  const FDText.onBoarding(
      {Key? key,
      required this.text,
      this.textStyle = AppTextStyles.onBoarding,
      this.textAlign,
      this.overflow,
      this.maxLines,
      this.color = AppColors.neutralBlack80})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      maxLines: maxLines,
      overflow: overflow ?? TextOverflow.visible,
      style: textStyle?.copyWith(color: color),
    );
  }
}
