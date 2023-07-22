import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

class FDProfilePicture extends StatelessWidget {
  final double size;
  final String data;
  const FDProfilePicture({Key? key, required this.size, required this.data})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(52),
        border: Border.all(color: AppColors.primaryGreen, width: 2),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(52),
        child: Image.network(
          data,
          width: size - 2,
          height: size - 2,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
