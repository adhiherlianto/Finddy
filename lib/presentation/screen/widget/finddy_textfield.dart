import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class FDTextField extends StatelessWidget {
  final String hintText;
  final TextEditingController textEditingController;
  final void Function(String)? onChanged;
  final TypeTextField typeTextField;
  Widget? icon;
  bool isVisible;
  VoidCallback? onPressed;

  FDTextField.normal(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.onChanged,
      this.isVisible = false,
      this.typeTextField = TypeTextField.normal})
      : super(key: key);

  FDTextField.password(
      {Key? key,
      required this.hintText,
      required this.textEditingController,
      this.onChanged,
      required this.icon,
      required this.isVisible,
      this.typeTextField = TypeTextField.password,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textEditingController,
      onChanged: onChanged,
      //showhide input
      obscureText: isVisible,
      decoration: InputDecoration(
          border: InputBorder.none,
          hintText: hintText,
          hintStyle: const TextStyle(color: AppColors.neutralBlack20),
          filled: true,
          fillColor: AppColors.lightWhite,
          contentPadding: const EdgeInsets.all(16),
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(color: AppColors.primaryBlue),
            borderRadius: BorderRadius.circular(4.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.neutralBlack20, width: 2),
            borderRadius: BorderRadius.circular(4.0),
          ),
          // suffixIcon: IconButton(onPressed: (){}, icon: icon!) ?? SizedBox.shrink()
          suffixIcon: typeTextField == TypeTextField.normal
              ? const SizedBox.shrink()
              : IconButton(onPressed: onPressed, icon: icon!)),
    );
  }
}

enum TypeTextField { normal, password }
