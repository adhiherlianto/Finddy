import 'package:finddy/gen/assets.gen.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileStepOneScreen extends StatefulWidget {
  const CompleteProfileStepOneScreen({Key? key}) : super(key: key);

  @override
  State<CompleteProfileStepOneScreen> createState() =>
      _CompleteProfileStepOneScreenState();
}

class _CompleteProfileStepOneScreenState
    extends State<CompleteProfileStepOneScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _perguruanTinggiController =
      TextEditingController();
  final TextEditingController _noTlpController = TextEditingController();

  final List _lokasi = ["Bandung", "Jakarta"];
  String? _selectedLocatation;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const StepIndicator(currentStep: 1),
          Expanded(
            child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 44, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FDText.headersH3(
                        text: "Lengkapi data kamu",
                        color: AppColors.neutralBlack60),
                    const SizedBox(height: 12),
                    const FDText.bodyP3(
                        text: "Isi identitas lengkapmu dulu ya!",
                        color: AppColors.neutralBlack60),
                    const SizedBox(height: 40),
                    InkWell(
                        onTap: () {},
                        child: Center(
                          child: Image.asset(Assets.images.profile.path,
                              width: 100, height: 100),
                        )),
                    const SizedBox(height: 33),
                    const FDText.headersH6(
                      text: "Username",
                      color: AppColors.neutralBlack60,
                    ),
                    const SizedBox(height: 12),
                    FDTextField.normal(
                      hintText: "Masukan username kamu",
                      textEditingController: _usernameController,
                      onChanged: (data) {},
                    ),
                    const SizedBox(height: 12),
                    const FDText.headersH6(
                      text: "Lokasi",
                      color: AppColors.neutralBlack60,
                    ),
                    FDTextField.normal(
                      hintText: "Masukan username kamu",
                      textEditingController: _usernameController,
                      onChanged: (data) {},
                    ),
                    const SizedBox(height: 24),
                    const FDText.headersH6(
                      text: "Asal perguruan tinggi",
                      color: AppColors.neutralBlack60,
                    ),
                    const SizedBox(height: 12),
                    FDTextField.normal(
                      hintText: "Pilih perguruan tinggi",
                      textEditingController: _perguruanTinggiController,
                      onChanged: (data) {},
                    ),
                    const SizedBox(height: 24),
                    const FDText.headersH6(
                      text: "Lokasi",
                      color: AppColors.neutralBlack60,
                    ),
                    const SizedBox(height: 12),
                    _dropDownLocation(_lokasi, _selectedLocatation),
                    const SizedBox(height: 24),
                    const FDText.headersH6(
                      text: "Kontak (No. Whatsapp)",
                      color: AppColors.neutralBlack60,
                    ),
                    const SizedBox(height: 12),
                    FDTextField.normal(
                      hintText: "Masukan Kontakmu",
                      textEditingController: _noTlpController,
                      onChanged: (data) {},
                    ),
                    const SizedBox(height: 40),
                    FDButton.primary(
                        onPressed: () {
                          context.pushNamed(AppRoutes.nrCompleteProfileStep2);
                        },
                        text: "Lanjutkan"),
                  ],
                ),
              ),
            ),
          ),
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
            text: "Pilih kabupaten/kota kamu", color: AppColors.neutralBlack20),
        items: items
            .map((e) =>
                DropdownMenuItem(value: e, child: FDText.bodyP4(text: e)))
            .toList(),
        value: value,
        onChanged: (value) {
          setState(() {
            _selectedLocatation = value as String;
          });
        });
  }
}
