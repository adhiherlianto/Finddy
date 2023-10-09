import 'package:carousel_slider/carousel_slider.dart';
import 'package:finddy/gen/assets.gen.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/user_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

const data = [
  'Lorem ipsum dolor amet sit vanarana lost valley1',
  'Lorem ipsum dolor amet sit vanarana lost valley2',
  'Lorem ipsum dolor amet sit vanarana lost valley3'
];
int currentIndex = 0;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    context.read<UserCubit>().getUser(userEmail!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<UserCubit, UserState>(
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
      child: Container(
        width: double.infinity,
        height: double.infinity,
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("assets/images/background_home.png"),
                fit: BoxFit.cover)),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  FinddyLogo(size: 40),
                  const Spacer(),
                  // Badge(
                  //     onTap: () {},
                  //     position: BadgePosition.topEnd(top: -10, end: -12),
                  //     badgeContent: const FDText.bodyP3(
                  //       text: "1",
                  //       color: AppColors.neutralwhite,
                  //       textAlign: TextAlign.center,
                  //     ),
                  //     child: const Icon(
                  //       FeatherIcons.heart,
                  //       size: 25,
                  //       color: AppColors.neutralwhite,
                  //     )),
                  IconButton(
                    onPressed: () {
                      _popUpProfile();
                      // context.read<AuthCubit>().LogoutUser();
                    },
                    icon: const Icon(FeatherIcons.menu),
                    iconSize: 32,
                    color: AppColors.neutralwhite,
                  )
                ],
              ),
              const SizedBox(height: 20),
              const FDText.headersH4(
                text: "Solusi saat mencari teman belajar",
                color: AppColors.neutralwhite,
              ),
              const SizedBox(height: 8),
              FDText.bodyP2(
                text: "Temukan teman belajarmu secara lebih mudah di sini",
                color: AppColors.neutralwhite.withOpacity(0.7),
              ),
              FDCard(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  margin: const EdgeInsets.only(bottom: 30, top: 24),
                  borderRadius: BorderRadius.circular(20),
                  color: AppColors.calmWhite,
                  child: Column(
                    children: [
                      const FDText.headersH6(
                        text: "Motivasi Harian",
                        textStyle: TextStyle(letterSpacing: 2),
                      ),
                      const SizedBox(height: 20),
                      _carouselPages(),
                      const SizedBox(height: 33),
                      _dotIndicator(),
                    ],
                  )),
              _firstContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _firstContent() {
    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const FDText.headersH6(
            text: "Isi Profil Anda",
            color: Colors.black,
          ),
          const SizedBox(height: 12),
          FDCard(
              onPressed: () {
                context.pushNamed(AppRoutes.nrCompleteProfileStep1);
              },
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.all(12),
              color: AppColors.neutralwhite,
              child: Row(
                children: [
                  Image.asset('assets/images/empty_profile.png',
                      width: 52, height: 52),
                  const SizedBox(width: 12),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FDText.headersH7(text: "Lengkapi profil anda"),
                      FDText.bodyP4(
                        text:
                            "Profil anda dibutuhkan untuk\nmenemukan teman belajar",
                        color: AppColors.neutralBlack60,
                      )
                    ],
                  )
                ],
              ))
        ],
      ),
    );
  }

  Widget _carouselPages() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 38),
      height: 50,
      width: double.infinity,
      child: CarouselSlider.builder(
          itemCount: data.length,
          itemBuilder: (((context, index, realIndex) {
            return FDText.bodyP2(
              text: data[index],
              color: Colors.black,
              textAlign: TextAlign.center,
            );
          })),
          options: CarouselOptions(
              autoPlay: true,
              initialPage: 0,
              viewportFraction: 1,
              autoPlayInterval: const Duration(seconds: 5),
              onPageChanged: ((index, reason) {
                setState(() {
                  currentIndex = index;
                });
              }))),
    );
  }

  Widget _dotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          data.length,
          (index) => Container(
                height: 8,
                width: 8,
                margin: const EdgeInsets.only(top: 0, left: 16),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    color: currentIndex == index
                        ? AppColors.primaryGreen
                        : AppColors.neutralBlack20),
              )),
    );
  }

  Future _popUpProfile() {
    return showDialog(
        barrierDismissible: false,
        context: context,
        builder: (context) => AlertDialog(
              insetPadding: EdgeInsets.zero,
              alignment: Alignment.topCenter,
              content: SizedBox(
                height: 140,
                width: 375,
                child: Stack(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Column(
                        children: [
                          Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Image.asset(
                                Assets.images.emptyProfile.path,
                                width: 52,
                                height: 52,
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const FDText.headersH7(
                                      text: "Indra Kurniawan"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      context.pushNamed(
                                          AppRoutes.nrDetailprofile,
                                          extra: "detail");
                                    },
                                    child: const FDText.bodyP4(
                                      text: "Halaman profile",
                                      color: AppColors.purple,
                                    ),
                                  )
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          FDButton.secondary(
                            onPressed: () {
                              context.read<UserCubit>().LogoutUser();
                              context.goNamed(AppRoutes.nrLogin);
                            },
                            text: "Keluar",
                            width: 327,
                          )
                        ],
                      ),
                    ),
                    Positioned(
                      top: -10,
                      right: 0,
                      child: IconButton(
                          onPressed: () {
                            context.pop();
                          },
                          icon: const Icon(
                            FeatherIcons.x,
                            size: 32,
                          )),
                    ),
                  ],
                ),
              ),
            ));
  }
}
