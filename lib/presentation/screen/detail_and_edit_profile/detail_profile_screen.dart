import 'package:finddy/presentation/screen/detail_and_edit_profile/detail_profile_params.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

import '../../../domain/entities/user/user_model.dart';
import '../main_screen/cubit/user_cubit.dart';

class DetailProfileScreen extends StatefulWidget {
  final DetailProfilParams? params;
  const DetailProfileScreen({Key? key, required this.params}) : super(key: key);

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  @override
  void initState() {
    context.read<UserCubit>().getUser(widget.params!.email);
    super.initState();
  }

  UserModel currentUser = const UserModel();

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
      listener: (context, state) {
        if (state is UserSuccess) {
          currentUser = state.user;
        }
      },
      child: BlocBuilder<UserCubit, UserState>(
        builder: (context, state) => Scaffold(
          body: (state is UserLoading)
              ? const Center(
                  child: CircularProgressIndicator(),
                )
              : Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(24),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _detailProfile(),
                        _buttonDetail(),
                        _bidangMinatContent(),
                        _locationContent(),
                        _lookingForContent()
                      ],
                    ),
                  ),
                ),
        ),
      ),
    );
  }

  Widget _detailProfile() {
    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          FDProfilePicture(
            size: 100,
            data: currentUser.photo!,
          ),
          FDText.headersH5(text: currentUser.name!),
          FDText.bodyP4(text: currentUser.username!),
          const SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.school, size: 16),
              const SizedBox(width: 4),
              FDText.bodyP4(text: currentUser.university!)
            ],
          ),
          const SizedBox(height: 32)
        ],
      ),
    );
  }

  Widget _buttonDetail() {
    if (widget.params!.type == 'detail') {
      return FDButton.primary(onPressed: () {}, text: 'Edit Profil');
    }
    return Row(
      children: [
        Expanded(
            child: FDButton.primary(onPressed: () {}, text: 'Simpan Teman')),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {},
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(7)),
            child: const Icon(
              FeatherIcons.messageCircle,
              color: AppColors.neutralwhite,
            ),
          ),
        )
      ],
    );
  }

  Widget _bidangMinatContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const FDText.headersH6(text: 'Bidang/minat'),
        const SizedBox(height: 16),
        ListView.builder(
          padding: EdgeInsets.zero,
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: currentUser.interest!.length,
          itemBuilder: (context, index) => FDCard(
              margin: const EdgeInsets.only(bottom: 12),
              padding: const EdgeInsets.all(12),
              borderRadius: BorderRadius.circular(8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FDText.headersH6(
                    text: currentUser.interest![index].name,
                    color: AppColors.primaryGreen,
                  ),
                  const SizedBox(height: 12),
                  FDChip.normal(
                      color: AppColors.accentGrass,
                      height: 22,
                      title: currentUser.interestSkill!.length > 1
                          ? currentUser.interestSkill![index]
                          : currentUser.interestSkill![0])
                ],
              )),
        )
      ],
    );
  }

  Widget _locationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 4),
        const FDText.headersH6(text: 'Lokasi'),
        const SizedBox(height: 16),
        FDCard(
            padding: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const Icon(FeatherIcons.mapPin,
                        size: 16, color: AppColors.primaryGreen),
                    const SizedBox(width: 4),
                    FDText.headersH6(
                      text: currentUser.location!.city,
                      color: AppColors.primaryGreen,
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                FDText.bodyP4(text: currentUser.location!.province)
              ],
            ))
      ],
    );
  }

  Widget _lookingForContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const FDText.headersH6(text: 'Saya sedang mencari'),
        const SizedBox(height: 16),
        FDCard(
            padding: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: currentUser.pref!.length,
                    itemBuilder: (context, index) => FDText.bodyP4(
                        text: '${index + 1}. ${currentUser.pref![index].name}'))
              ],
            ))
      ],
    );
  }
}
