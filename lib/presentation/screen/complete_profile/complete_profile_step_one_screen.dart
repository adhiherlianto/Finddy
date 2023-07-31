import 'package:finddy/gen/assets.gen.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'cubit/complete_profile_cubit.dart';

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

  List _lokasi = [];

  String? _valLokasi;

  @override
  void initState() {
    context.read<CompleteProfileCubit>().getLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<CompleteProfileCubit, CompleteProfileState>(
      listener: (context, state) {
        if (state is CompleteProfileSuccess) {
          _lokasi = state.location;
        }
      },
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            body: state is CompleteProfileLoading
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
                      child: Column(
                        children: [
                          const StepIndicator(currentStep: 1),
                          Container(
                            padding: const EdgeInsets.fromLTRB(24, 44, 24, 0),
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
                                      child: Image.asset(
                                          Assets.images.profile.path,
                                          width: 100,
                                          height: 100),
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
                                const SizedBox(height: 24),
                                const FDText.headersH6(
                                  text: "Asal perguruan tinggi",
                                  color: AppColors.neutralBlack60,
                                ),
                                const SizedBox(height: 12),
                                FDTextField.normal(
                                  hintText: "Pilih perguruan tinggi",
                                  textEditingController:
                                      _perguruanTinggiController,
                                  onChanged: (data) {},
                                ),
                                const SizedBox(height: 24),
                                const FDText.headersH6(
                                  text: "Lokasi",
                                  color: AppColors.neutralBlack60,
                                ),
                                const SizedBox(height: 12),
                                _dropDown(_lokasi, _valLokasi, "location"),
                                const SizedBox(height: 24),
                                const FDText.headersH6(
                                  text: "Kontak (No. Whatsapp)",
                                  color: AppColors.neutralBlack60,
                                ),
                                const SizedBox(height: 12),
                                FDTextField.normal(
                                  isNumber: true,
                                  hintText: "Masukan Kontakmu",
                                  textEditingController: _noTlpController,
                                  onChanged: (data) {},
                                ),
                                const SizedBox(height: 40),
                                FDButton.primary(
                                    onPressed: () {
                                      context.pushNamed(
                                          "complete-profile-step-2",
                                          queryParameters: {
                                            "location": _valLokasi,
                                            "phone": _noTlpController.text,
                                            "university":
                                                _perguruanTinggiController.text,
                                            "username": _usernameController.text
                                          });
                                    },
                                    text: "Lanjutkan"),
                              ],
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        );
      },
    );
  }

  Widget _dropDown(List items, String? value, String type) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            filled: true,
            fillColor: AppColors.neutralwhite),
        focusColor: Colors.transparent,
        hint: FDText.bodyP4(
            text: type == 'kemampuan' ? "Pilih Kemampuan" : "Pilih Lokasi",
            color: AppColors.neutralBlack20),
        items: items
            .map((e) =>
                DropdownMenuItem(value: e, child: FDText.bodyP4(text: e)))
            .toList(),
        value: value,
        onChanged: (value) {
          setState(() {
            _valLokasi = value as String;
          });
        });
  }
}
