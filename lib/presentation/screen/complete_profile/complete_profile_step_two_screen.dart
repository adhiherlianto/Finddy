import 'package:finddy/domain/entities/interest/interest_model.dart';
import 'package:finddy/domain/entities/user_interest/user_interest_model.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenThree.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenTwo.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/interest_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/widget/step_indicator.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

class CompleteProfileStepTwoScreen extends StatefulWidget {
  final ParamScreenTwo? params;

  const CompleteProfileStepTwoScreen({
    Key? key,
    this.params,
  }) : super(key: key);

  @override
  State<CompleteProfileStepTwoScreen> createState() =>
      _CompleteProfileStepTwoScreenState();
}

class _CompleteProfileStepTwoScreenState
    extends State<CompleteProfileStepTwoScreen> {
  final List _kemampuanData = ["Pemula", "Menengah", "Master"];
  List<InterestModel> _listInterest = [];
  final List<UserInterestModel> _userInterest = [];
  final List<String> _interestSkill = [];
  String? a;

  @override
  void initState() {
    context.read<InterestCubit>().getAllInterest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<InterestCubit, InterestState>(
        listener: (context, state) {
          if (state is InterestSuccess) {
            setState(() {
              _listInterest = state.interest;
            });
          }
        },
        child: Scaffold(
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
                        DropdownSearch<InterestModel>(
                          popupProps: PopupProps.bottomSheet(
                              showSearchBox: true,
                              disabledItemFn: (item) {
                                return _userInterest
                                    .map((e) => e.name)
                                    .contains(item.name);
                              },
                              constraints: const BoxConstraints.expand()),
                          items: _listInterest,
                          itemAsString: (item) => item.name.toString(),
                          dropdownDecoratorProps: DropDownDecoratorProps(
                            dropdownSearchDecoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(4),
                              ),
                              labelText: "Bidang Minat",
                              hintText: "Pilih Bidang Minat",
                            ),
                          ),
                          onChanged: (value) {
                            if (_userInterest.length < 3) {
                              final UserInterestModel interestValue =
                                  UserInterestModel(value!.id, value.name);
                              setState(() {
                                _userInterest.add(interestValue);
                                print(_userInterest.length);
                              });
                            }
                          },
                        ),
                        const SizedBox(height: 20),
                        _userInterest.isNotEmpty
                            ? ListView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: _userInterest.length,
                                itemBuilder: (context, index) {
                                  return _contentCard(_userInterest[index].name,
                                      _userInterest[index].id);
                                })
                            : const SizedBox.shrink(),
                        const SizedBox(height: 100),
                        FDButton.primary(
                            onPressed: () {
                              ParamScreenThree params = ParamScreenThree(
                                location: widget.params!.location,
                                phone: widget.params!.phone,
                                photo: widget.params!.photo,
                                university: widget.params!.university,
                                userInterest: _userInterest,
                                username: widget.params!.username,
                                interestSkill: _interestSkill,
                              );
                              context.pushNamed(
                                  AppRoutes.nrCompleteProfileStep3,
                                  extra: params);
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
        ),
      ),
    );
  }

  Widget _contentCard(String title, String id) {
    return FDCard(
      margin: const EdgeInsets.only(bottom: 12),
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
                  onPressed: () {
                    // final index = _userInterest.
                    setState(() {
                      _userInterest
                          .removeWhere((element) => element.name == title);
                    });
                  },
                  icon: const Icon(FeatherIcons.x,
                      size: 20, color: AppColors.purple))
            ],
          ),
          const SizedBox(height: 16),
          const FDText.bodyP4(
              text: "Tingkat kemampuan", color: AppColors.neutralBlack60),
          const SizedBox(height: 8),
          _dropDownLocation(_kemampuanData, a, id),
        ],
      ),
    );
  }

  Widget _dropDownLocation(List items, String? value, String id) {
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
          _interestSkill.add(value.toString());
        });
  }
}
