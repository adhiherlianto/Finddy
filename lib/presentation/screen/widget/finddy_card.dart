import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

class FDCard extends StatelessWidget {
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  final Color? color;
  final double? height;
  final Widget child;
  final BorderRadiusGeometry borderRadius;
  final VoidCallback? onPressed;

  const FDCard(
      {Key? key,
      this.margin,
      this.color,
      required this.child,
      this.padding,
      this.height,
      required this.borderRadius,
      this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: double.infinity,
        padding: padding,
        margin: margin,
        height: height,
        decoration: BoxDecoration(
            color: color ?? AppColors.neutralwhite,
            borderRadius: borderRadius,
            boxShadow: [
              BoxShadow(
                  color: const Color(0xff0000000d).withOpacity(0.05),
                  blurRadius: 1,
                  offset: const Offset(2, 3)),
              BoxShadow(
                  color: const Color(0xff0000000d).withOpacity(0.05),
                  blurRadius: 1,
                  offset: const Offset(-2, -1))
            ]),
        child: child,
      ),
    );
  }
}
