import 'package:finddy/domain/entities/preference/preference_model.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenThree.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/preference_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
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
  // List<Map<String, String>> data = [
  //   {'id': '1', 'value': 'Mencari teman belajar untuk belajar bersama'},
  //   {'id': '2', 'value': 'Mencari teman belajar sebagai mentor'},
  //   {'id': '3', 'value': 'Mencari teman belajar untuk bertanya dan sharing'},
  //   {'id': '4', 'value': 'Mencari teman belajar sebagai teman seperjuangan'}
  // ];

  List<PreferenceModel> _dataPref = [];

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
                        onPressed: () {
                          final userData = FirebaseAuth.instance.currentUser;
                          final interest = [];
                          for (var i = 0;
                              i < widget.params!.userInterest.length;
                              i++) {
                            interest.add({
                              "id": widget.params!.userInterest[i].id,
                              "name": widget.params!.userInterest[i].name,
                              "skill": widget.params!.userInterest[i].skill,
                            });
                          }

                          final pref = [];
                          for (var i = 0; i < _dataPref.length; i++) {
                            pref.add({
                              "id": _dataPref[i].id,
                              "name": _dataPref[i].name
                            });
                          }
                          context.read<PreferenceCubit>().upadateUser(
                              userData!.uid,
                              widget.params!.phone!,
                              widget.params!.photo!,
                              widget.params!.university!,
                              widget.params!.username!,
                              interest,
                              pref,
                              widget.params!.location!);
                          print(_dataPref.length);
                          print(interest);
                          // context.goNamed(AppRoutes.nrHome);
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
