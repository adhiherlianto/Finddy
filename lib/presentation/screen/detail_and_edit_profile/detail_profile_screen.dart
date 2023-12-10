import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/chat/chat_params.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/cubit/add_friend_cubit.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/detail_profile_params.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/user/user_model.dart';
import '../main_screen/cubit/user_cubit.dart';

class DetailProfileScreen extends StatefulWidget {
  final DetailProfilParams? params;
  const DetailProfileScreen({Key? key, required this.params}) : super(key: key);

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  final email = FirebaseAuth.instance.currentUser!.email;
  @override
  void initState() {
    context.read<CurrentUserCubit>().getCurrentUser(email!);
    context.read<UserCubit>().getUser(widget.params!.email);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddFriendCubit, AddFriendState>(
          listener: (context, state) {
            context.read<UserCubit>().getUser(widget.params!.email);
          },
        )
      ],
      child: BlocBuilder<UserCubit, UserState>(builder: (context, state) {
        if (state is UserSuccess) {
          return Scaffold(
            body: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24),
              child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
                builder: (context, userState) {
                  if (userState is CurrentUserSuccess) {
                    return SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _detailProfile(state.user),
                          _buttonDetail(state.user, userState.currentUser),
                          _bidangMinatContent(state.user),
                          _locationContent(state.user),
                          _lookingForContent(state.user)
                        ],
                      ),
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            ),
          );
        } else if (state is UserLoading) {
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is UserError) {
          return Scaffold(
            body: Center(
              child: Text(state.error),
            ),
          );
        }
        return const SizedBox.shrink();
      }),
    );
  }

  Widget _detailProfile(UserModel currentUser) {
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

  Widget _buttonDetail(UserModel currentUser, UserModel user) {
    if (widget.params!.type == 'detail') {
      return FDButton.primary(
          onPressed: () {
            context.pushNamed(AppRoutes.nrCompleteProfileStep1);
          },
          text: 'Edit Profil');
    }
    return currentUser.friends?.contains(user.uid) ?? false
        ? Row(
            children: [
              Expanded(
                  child: FDButton.teritary(
                      onPressed: () {
                        context
                            .read<AddFriendCubit>()
                            .deleteFriend(currentUser.uid!);
                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text("Teman dihapus"),
                          backgroundColor: AppColors.error,
                        ));
                      },
                      text: 'Hapus Teman')),
              const SizedBox(width: 24),
              InkWell(
                onTap: () {
                  final params =
                      ChatParams(sender: user, receiver: currentUser);
                  context.pushNamed(AppRoutes.nrChatRoom, extra: params);
                },
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
          )
        : currentUser.friendRequests?.contains(user.uid) ?? false
            ? FDButton.primary(
                onPressed: () {
                  context
                      .read<AddFriendCubit>()
                      .deleteFriendRequest(currentUser.uid!, false);
                  ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                    content: Text("Permintaan teman dibatalkan"),
                    backgroundColor: AppColors.error,
                  ));
                },
                text: 'Permintaan Teman diajukan')
            : user.friendRequests?.contains(currentUser.uid) ?? false
                ? FDButton.primary(
                    onPressed: () {
                      context
                          .read<AddFriendCubit>()
                          .addFriend(currentUser.uid!);
                      context
                          .read<AddFriendCubit>()
                          .deleteFriendRequest(currentUser.uid!, true);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Teman ditambahkan"),
                        backgroundColor: AppColors.primaryGreen,
                      ));
                    },
                    text: 'Terima Pertemanan')
                : FDButton.primary(
                    onPressed: () {
                      context
                          .read<AddFriendCubit>()
                          .addFriendRequest(currentUser.uid!);
                      context
                          .read<AddFriendCubit>()
                          .deleteFriendRequest(user.uid!, false);
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                          backgroundColor: AppColors.primaryGreen,
                          content: Text("Permintaan teman diajukan")));
                    },
                    text: 'Simpan Teman');
  }

  Widget _bidangMinatContent(UserModel currentUser) {
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

  Widget _locationContent(UserModel currentUser) {
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

  Widget _lookingForContent(UserModel currentUser) {
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
