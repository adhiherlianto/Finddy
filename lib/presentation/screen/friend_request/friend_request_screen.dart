import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/cubit/add_friend_cubit.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/detail_profile_params.dart';
import 'package:finddy/presentation/screen/friend_request/cubit/friend_request_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class FriendRequestScreen extends StatefulWidget {
  const FriendRequestScreen({super.key});

  @override
  State<FriendRequestScreen> createState() => _FriendRequestState();
}

class _FriendRequestState extends State<FriendRequestScreen> {
  @override
  void didChangeDependencies() {
    final email = FirebaseAuth.instance.currentUser!.email;
    context.read<CurrentUserCubit>().getCurrentUser(email!);
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<AddFriendCubit, AddFriendState>(
          listener: (context, state) {
            if (state is AddFriendSuccess || state is DeleteFriendSuccess) {
              final email = FirebaseAuth.instance.currentUser!.email;
              context.read<CurrentUserCubit>().getCurrentUser(email!);
            }
          },
        ),
        BlocListener<CurrentUserCubit, CurrentUserState>(
            listener: (context, state) {
          if (state is CurrentUserSuccess) {
            context
                .read<FriendRequestCubit>()
                .getALlFriendRequest(state.currentUser.friendRequests ?? []);
          }
        })
      ],
      child: Scaffold(
        body: SingleChildScrollView(
            child: Container(
                padding: const EdgeInsets.fromLTRB(24, 50, 24, 10),
                child: _friendContent())),
      ),
    );
  }

  Widget _friendContent() {
    return BlocBuilder<CurrentUserCubit, CurrentUserState>(
      builder: (context, userState) {
        if (userState is CurrentUserSuccess) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FDText.headersH6(
                  text: "Permintaan Pertemanan",
                  color: Colors.black,
                ),
                BlocBuilder<FriendRequestCubit, FriendRequestCubitState>(
                  builder: (context, state) {
                    if (state is FriendRequestCubitSuccess) {
                      return ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: state.allFriendRequest.length,
                          itemBuilder: (context, index) => _friendRequestItem(
                                state.allFriendRequest[index].name!,
                                state.allFriendRequest[index].username!,
                                index,
                                state.allFriendRequest,
                              ));
                    } else if (state is FriendRequestCubitLoading) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (state is FriendRequestCubitError) {
                      return Center(
                        child: Text(state.error),
                      );
                    }
                    return const SizedBox.shrink();
                  },
                )
              ],
            ),
          );
        } else if (userState is CurrentUserLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (userState is CurrentUserError) {
          return Center(
            child: Text(userState.error),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _friendRequestItem(
      String name, String username, int index, List<UserModel> alluser) {
    return Container(
      color: AppColors.neutralwhite,
      width: double.infinity,
      padding: const EdgeInsets.only(bottom: 12),
      child: FDCard(
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(12),
        onPressed: () {
          DetailProfilParams params = DetailProfilParams(
              email: alluser[index].email!, type: "detail teman");
          context.pushNamed(AppRoutes.nrDetailprofile, extra: params);
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            FDProfilePicture(size: 54, data: alluser[index].photo!),
            const SizedBox(width: 12),
            Expanded(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FDText.bodyP3(text: name, overflow: TextOverflow.ellipsis),
                    const SizedBox(height: 8),
                    FDText.bodyP4(text: "@$username"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    FDButton.primary(
                      onPressed: () {
                        context
                            .read<AddFriendCubit>()
                            .addFriend(alluser[index].uid!);
                        context
                            .read<AddFriendCubit>()
                            .deleteFriendRequest(alluser[index].uid!, true);
                      },
                      text: "Terima",
                      height: 28,
                      width: 73,
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    FDButton.teritary(
                      onPressed: () {
                        context
                            .read<AddFriendCubit>()
                            .deleteFriendRequest(alluser[index].uid!, true);
                      },
                      text: "Tolak",
                      height: 28,
                      width: 73,
                    ),
                  ],
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
