import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileStepTwoScreen extends StatefulWidget {
  const CompleteProfileStepTwoScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileStepTwoScreen> createState() =>
      _CompleteProfileStepTwoScreenState();
}

class _CompleteProfileStepTwoScreenState
    extends State<CompleteProfileStepTwoScreen> {
  final TextEditingController _searchController = TextEditingController();

  final List _kemampuanData = ["Pemula", "Master"];
  String? _selectedKemampuan;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const StepIndicator(currentStep: 2),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 44, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FDText.headersH3(
                        text: "Pilih bidang minatmu",
                        color: AppColors.neutralBlack60),
                    const SizedBox(height: 12),
                    const FDText.bodyP3(
                        text:
                            "Pilih yang sesuai agar teman belajarmu mudah ketika menemukanmu",
                        color: AppColors.neutralBlack60),
                    const SizedBox(height: 28),
                    FDTextField.normal(
                      hintText: "Cari teman",
                      textEditingController: _searchController,
                      onPressed: () {},
                      icon: const Icon(Icons.search,
                          color: AppColors.neutralBlack20),
                    ),
                    const SizedBox(height: 54),
                    _contentCard("Digital Marketing"),
                    const SizedBox(height: 100),
                    FDButton.primary(
                        onPressed: () {
                          context.pushNamed(AppRoutes.nrCompleteProfileStep3);
                        },
                        text: "Lanjutkan"),
                    const SizedBox(height: 12),
                    FDButton.secondary(
                        onPressed: () {
                          context.pop();
                        },
                        text: "Kembali"),
                    const SizedBox(height: 12),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _contentCard(String title) {
    return FDCard(
      borderRadius: BorderRadius.circular(8),
      padding: const EdgeInsets.all(12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              FDText.headersH5(text: title, color: AppColors.primaryGreen),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(FeatherIcons.x,
                      size: 20, color: AppColors.purple))
            ],
          ),
          const SizedBox(height: 16),
          const FDText.bodyP4(
              text: "Tingkat kemampuan", color: AppColors.neutralBlack60),
          const SizedBox(height: 8),
          _dropDownLocation(_kemampuanData, _selectedKemampuan),
        ],
      ),
    );
  }

  Widget _dropDownLocation(List items, String? value) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(4),
          ),
          contentPadding:
              const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
          filled: true,
          fillColor: AppColors.neutralwhite,
          focusedBorder: OutlineInputBorder(
            borderSide:
                const BorderSide(color: AppColors.neutralBlack20, width: 2),
            borderRadius: BorderRadius.circular(4.0),
          ),
        ),
        focusColor: Colors.transparent,
        hint: const FDText.bodyP4(
            text: "Pilih tingkat kemampuan", color: AppColors.neutralBlack20),
        items: items
            .map((e) =>
                DropdownMenuItem(value: e, child: FDText.bodyP4(text: e)))
            .toList(),
        value: value,
        onChanged: (value) {
          setState(() {
            _selectedKemampuan = value as String;
          });
        });
  }
}
