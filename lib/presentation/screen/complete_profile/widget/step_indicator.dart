import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class StepIndicator extends StatelessWidget {
  final int currentStep;
  const StepIndicator({Key? key, required this.currentStep}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StepProgressIndicator(
      totalSteps: 3,
      currentStep: currentStep,
      padding: 2.0,
      size: 12,
      progressDirection: TextDirection.ltr,
      selectedColor: AppColors.primaryGreen,
      unselectedColor: AppColors.neutralBlack20,
    );
  }
}
