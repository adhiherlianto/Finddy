import 'package:finddy/gen/assets.gen.dart';
import 'package:flutter/material.dart';

class FinddyLogo extends StatelessWidget {
  final double size;
  String? logo;

  FinddyLogo({Key? key, required this.size, this.logo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration:
          BoxDecoration(borderRadius: BorderRadius.circular(9), boxShadow: [
        BoxShadow(
            color: logo == null
                ? const Color(0xff0000000d).withOpacity(0.05)
                : Colors.transparent,
            blurRadius: 1,
            offset: const Offset(2, 3))
      ]),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(9),
        child: Image.asset(
          logo == null ? Assets.images.imgFindyLogo.path : logo!,
          width: size,
          height: size,
          fit: BoxFit.fill,
        ),
      ),
    );
  }
}
