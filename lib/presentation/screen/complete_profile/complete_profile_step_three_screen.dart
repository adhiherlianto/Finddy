// ignore_for_file: use_build_context_synchronously

import 'package:finddy/domain/entities/preference/preference_model.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenThree.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/preference_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileStepThreeScreen extends StatefulWidget {
  final ParamScreenThree? params;
  const CompleteProfileStepThreeScreen({Key? key, this.params})
      : super(key: key);

  @override
  State<CompleteProfileStepThreeScreen> createState() =>
      _CompleteProfileStepThreeScreenState();
}

class _CompleteProfileStepThreeScreenState
    extends State<CompleteProfileStepThreeScreen> {
  List<PreferenceModel> _dataPref = [];
  final List<PreferenceModel> _selectedPref = [];

  String? url;

  List<PreferenceModel> preferensiTeman = [];
  @override
  void initState() {
    context.read<PreferenceCubit>().getAllPref();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PreferenceCubit, PreferenceState>(
      listener: (context, state) {
        if (state is PreferenceSuccess) {
          setState(() {
            _dataPref = state.pref;
          });
        }
      },
      child: Scaffold(
        body: Column(
          children: [
            const StepIndicator(currentStep: 3),
            Expanded(
                child: SingleChildScrollView(
              child: Container(
                padding: const EdgeInsets.fromLTRB(24, 44, 24, 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const FDText.headersH3(
                        text: "Tentukan preferensi teman belajar",
                        color: AppColors.neutralBlack60),
                    const SizedBox(height: 12),
                    const FDText.bodyP3(
                        text:
                            "Pilih beberapa kriteria berikut yang akan membantu proses pencarian teman belajarmu",
                        color: AppColors.neutralBlack60),
                    const SizedBox(height: 35),
                    _customCheckBox(),
                    const SizedBox(height: 100),
                    FDButton.primary(
                        onPressed: () async {
                          final userData = FirebaseAuth.instance.currentUser;
                          final interest = [];
                          for (var i = 0;
                              i < widget.params!.userInterest.length;
                              i++) {
                            interest.add({
                              "id": widget.params!.userInterest[i].id,
                              "name": widget.params!.userInterest[i].name,
                            });
                          }
                          final pref = [];
                          for (var i = 0; i < _selectedPref.length; i++) {
                            pref.add({
                              "id": _selectedPref[i].id,
                              "name": _selectedPref[i].name
                            });
                          }
                          if (widget.params?.photo != null) {
                            final nameFile = "files/${userData!.email}.jpg";
                            final ref =
                                FirebaseStorage.instance.ref().child(nameFile);
                            await ref.putFile(widget.params!.photo!,
                                SettableMetadata(contentType: "jpg"));
                            url = (await ref.getDownloadURL()).toString();
                          } else {
                            url =
                                "https://firebasestorage.googleapis.com/v0/b/finddy-98fee.appspot.com/o/files%2Fuser.png?alt=media&token=678bde3b-8adf-4520-ac53-de649b85bdfb";
                          }
                          context.read<PreferenceCubit>().upadateUser(
                              userData!.uid,
                              widget.params!.phone!,
                              url!,
                              widget.params!.university!,
                              widget.params!.username!,
                              interest,
                              pref,
                              widget.params!.location!,
                              widget.params!.interestSkill!);
                          context.goNamed(AppRoutes.nrHome);
                        },
                        text: "Lanjutkan"),
                    const SizedBox(height: 12),
                    FDButton.secondary(
                        onPressed: () {
                          context.pop();
                        },
                        text: "Kembali"),
                  ],
                ),
              ),
            ))
          ],
        ),
      ),
    );
  }

  Widget _customCheckBox() {
    return Column(
      children: List.generate(_dataPref.length, (index) {
        return FDCard(
          margin: const EdgeInsets.only(bottom: 12),
          onPressed: () {
            addOrReplace(_dataPref[index].name, _dataPref[index].id);
          },
          borderRadius: BorderRadius.circular(8),
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          child: Row(
            children: [
              Checkbox(
                  value: isSelected(_dataPref[index].name),
                  onChanged: ((value) {
                    _selectedPref.add(_dataPref[index]);
                    addOrReplace(_dataPref[index].name, _dataPref[index].name);
                  })),
              const SizedBox(width: 15),
              Expanded(child: FDText.bodyP2(text: _dataPref[index].name))
            ],
          ),
        );
      }),
    );
  }

  bool isSelected(String title) {
    var contain = preferensiTeman.where((element) => element.name == title);
    if (contain.isEmpty) {
      return false;
    } else {
      return true;
    }
  }

  void addOrReplace(String title, String id) {
    if (isSelected(title)) {
      setState(() {
        preferensiTeman.removeWhere((element) => element.name == title);
      });
    } else {
      setState(() {
        preferensiTeman.add(PreferenceModel(id, title));
      });
    }
  }
}
