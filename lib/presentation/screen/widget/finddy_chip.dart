import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

class FDChip extends StatelessWidget {
  final Color color;
  final double height;
  final String title;
  Color? textColor;
  EdgeInsetsGeometry? padding;
  EdgeInsetsGeometry? margin;
  VoidCallback? onPressed;
  bool? selectedIndex;
  final TypeChip typeChip;

  FDChip.normal(
      {Key? key,
      required this.color,
      required this.height,
      required this.title,
      this.textColor,
      this.padding,
      this.margin,
      this.typeChip = TypeChip.normal})
      : super(key: key);

  FDChip.action(
      {Key? key,
      required this.color,
      required this.height,
      required this.title,
      this.textColor,
      this.padding,
      this.margin,
      required this.onPressed,
      required this.selectedIndex,
      this.typeChip = TypeChip.action})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _typeFinddyChip();
  }

  Widget _typeFinddyChip() {
    if (typeChip == TypeChip.normal) {
      return Container(
          padding: padding ??
              const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(52),
            color: color,
          ),
          margin: margin ?? const EdgeInsets.only(right: 8),
          child: FDText.bodyP5(
            text: title,
            color: textColor ?? AppColors.neutralBlack80,
          ));
    } else {
      return InkWell(
        onTap: onPressed,
        child: Container(
            padding: padding ??
                const EdgeInsets.symmetric(vertical: 2, horizontal: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(52),
              color: selectedIndex! ? AppColors.purple : color,
            ),
            margin: margin ?? const EdgeInsets.only(right: 8),
            child: FDText.bodyP5(
              text: title,
              color: selectedIndex! ? AppColors.neutralwhite : textColor,
            )),
      );
    }
  }
}

enum TypeChip { normal, action }
