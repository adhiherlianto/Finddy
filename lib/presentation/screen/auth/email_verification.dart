import 'dart:async';

import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/home/home_screen.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class EmailVerification extends StatefulWidget {
  const EmailVerification({super.key});

  @override
  State<EmailVerification> createState() => _EmailVerificationState();
}

class _EmailVerificationState extends State<EmailVerification> {
  bool isEmailVerified = false;
  Timer? timer;
  @override
  void initState() {
    isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    if (!isEmailVerified) {
      sendVerificationEmail();

      timer = Timer.periodic(
          const Duration(seconds: 3), (_) => checkEmailVerified());
    }
    super.initState();
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  Future sendVerificationEmail() async {
    final user = FirebaseAuth.instance.currentUser!;
    await user.sendEmailVerification();
  }

  Future checkEmailVerified() async {
    await FirebaseAuth.instance.currentUser!.reload();
    setState(() {
      isEmailVerified = FirebaseAuth.instance.currentUser!.emailVerified;
    });
  }

  @override
  Widget build(BuildContext context) => isEmailVerified
      ? const HomeScreen()
      : Scaffold(
          backgroundColor: AppColors.lightWhite,
          body: Center(
            child: BlocListener<CurrentUserCubit, CurrentUserState>(
              listener: (context, state) {
                if (state is LogoutSuccess) {
                  context.goNamed(AppRoutes.nrLogin);
                } else if (state is LogoutError) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.error),
                    ),
                  );
                }
              },
              child: FDCard(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    height: 444,
                    width: 308,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FinddyLogo(size: 40),
                        const SizedBox(height: 10),
                        const FDText.headersH3(
                          text: "Silahkan Cek Email Kamu!",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 10),
                        const FDText.bodyP2(
                          text:
                              "Silakan cek email untuk melakukan verifikasi, jika sudah kembali lagi ke aplikasi untuk melanjutkan proses registrasi",
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        FDButton.secondary(
                            onPressed: () {
                              sendVerificationEmail();
                            },
                            text: "Kirim Ulang Verifikasi"),
                        const SizedBox(height: 12),
                        FDButton.teritary(
                            onPressed: () {
                              context.read<CurrentUserCubit>().logoutUser();
                            },
                            text: "Logout"),
                      ],
                    ),
                  )),
            ),
          ),
        );
}
