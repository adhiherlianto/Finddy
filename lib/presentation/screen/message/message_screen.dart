import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/chat/chat_params.dart';
import 'package:finddy/presentation/screen/chat/cubit/chat_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_empty.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../theme/colors.dart';
import '../widget/finddy_card.dart';
import '../widget/finddy_chip.dart';
import '../widget/finddy_logo.dart';
import '../widget/finddy_profile_picture.dart';
import '../widget/finddy_text.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  void initState() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    context.read<CurrentUserCubit>().getCurrentUser(userEmail!);
    context.read<ChatCubit>().getLastMessage();
    super.initState();
  }

  UserModel currentUser = const UserModel();
  @override
  Widget build(BuildContext context) {
    return BlocListener<CurrentUserCubit, CurrentUserState>(
      listener: (context, state) {
        if (state is CurrentUserSuccess) {
          currentUser = state.currentUser;
        }
      },
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          if (state is LastChatLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (state is LastChatError) {
            return Center(
              child: Text(state.error),
            );
          } else if (state is LastChatSuccess) {
            return Container(
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FinddyLogo(size: 40),
                  const SizedBox(height: 30),
                  const FDText.headersH4(text: "Pesan"),
                  const FDText.bodyP2(
                      text:
                          "Tempat berdiskusi dan berbagi dengan teman belajar",
                      color: AppColors.neutralBlack40),
                  const SizedBox(height: 20),
                  state.data.isEmpty
                      ? const FinddyEmpty(
                          text: " Maaf anda tidak memiliki pesan")
                      : ListView.builder(
                          itemCount: state.data.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            DateTime date =
                                DateTime.parse(state.data[index].timestamp);
                            String formattedDate =
                                DateFormat('dd/mm/yyyy').format(date);
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 10),
                              child: FDCard(
                                  onPressed: () {
                                    final params = ChatParams(
                                        sender: currentUser,
                                        receiver: state.data[index].userInfo);
                                    context.pushNamed(AppRoutes.nrChatRoom,
                                        extra: params);
                                  },
                                  borderRadius: BorderRadius.circular(12),
                                  padding: const EdgeInsets.all(12),
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      FDProfilePicture(
                                          size: 54,
                                          data: state
                                              .data[index].userInfo.photo!),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Row(
                                              children: [
                                                FDText.bodyP3(
                                                    text: state.data[index]
                                                        .userInfo.name!),
                                                const Spacer(),
                                                FDText.bodyP5(
                                                    text: formattedDate),
                                              ],
                                            ),
                                            const SizedBox(height: 4),
                                            SizedBox(
                                              height: 19,
                                              child: ListView.builder(
                                                shrinkWrap: true,
                                                itemCount: state.data[index]
                                                    .userInfo.interest!.length,
                                                physics:
                                                    const NeverScrollableScrollPhysics(),
                                                scrollDirection:
                                                    Axis.horizontal,
                                                itemBuilder: (context, idx) =>
                                                    FDChip.normal(
                                                  color: idx == 0
                                                      ? AppColors.accentSky
                                                      : idx == 1
                                                          ? AppColors
                                                              .accentGrass
                                                          : AppColors
                                                              .accentSunShine,
                                                  height: 19,
                                                  title: state
                                                              .data[index]
                                                              .userInfo
                                                              .interest!
                                                              .length ==
                                                          1
                                                      ? state
                                                          .data[index]
                                                          .userInfo
                                                          .interest![0]
                                                          .name
                                                      : state
                                                          .data[index]
                                                          .userInfo
                                                          .interest![idx]
                                                          .name,
                                                ),
                                              ),
                                            ),
                                            const SizedBox(height: 12),
                                            FDText.bodyP4(
                                                text: state.data[index].message)
                                          ],
                                        ),
                                      )
                                    ],
                                  )),
                            );
                          },
                        )
                ],
              ),
            );
          }
          return const SizedBox.shrink();
        },
      ),
    );
  }
}
