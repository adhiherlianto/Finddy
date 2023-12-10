import 'package:badges/badges.dart' as badge;
import 'package:carousel_slider/carousel_slider.dart';
import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/preference_cubit.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/detail_profile_params.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/friend_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_empty.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
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
  'Belajar adalah kunci untuk membuka pintu kesuksesan. Jadikan setiap pelajaran sebagai kesempatan untuk tumbuh dan berkembang.',
  'Hidup adalah tentang belajar. Jika berhenti maka engkau akan mati.',
  'Jangan pernah berhenti belajar, karena hidup tak pernah berhenti memberikan pelajaran.'
];
int currentIndex = 0;

class _MainScreenState extends State<MainScreen> {
  @override
  void initState() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    context.read<CurrentUserCubit>().getCurrentUser(userEmail!);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<CurrentUserCubit, CurrentUserState>(
          listener: (context, state) {
            if (state is LogoutSuccess) {
              context.goNamed(AppRoutes.nrLogin);
            } else if (state is LogoutError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.error),
                ),
              );
            } else if (state is CurrentUserSuccess) {
              context
                  .read<FriendCubit>()
                  .getAllFriend(state.currentUser.friends ?? []);
            }
          },
        ),
        BlocListener<PreferenceCubit, PreferenceState>(
          listener: (context, state) {
            if (state is PreferenceSuccess) {
              final userEmail = FirebaseAuth.instance.currentUser!.email;
              context.read<CurrentUserCubit>().getCurrentUser(userEmail!);
            }
          },
        )
      ],
      child: BlocBuilder<CurrentUserCubit, CurrentUserState>(
        builder: (context, state) {
          return Container(
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
                      state is CurrentUserSuccess
                          ? badge.Badge(
                              showBadge:
                                  state.currentUser.friendRequests?.length ==
                                          null
                                      ? true
                                      : false,
                              position:
                                  badge.BadgePosition.topEnd(top: -15, end: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .pushNamed(AppRoutes.nrFriendRequest);
                                  },
                                  child: const Icon(
                                    FeatherIcons.bell,
                                    size: 25,
                                    color: AppColors.neutralwhite,
                                  ),
                                ),
                              ))
                          : badge.Badge(
                              position:
                                  badge.BadgePosition.topEnd(top: -15, end: 10),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 20),
                                child: GestureDetector(
                                  onTap: () {
                                    context
                                        .pushNamed(AppRoutes.nrFriendRequest);
                                  },
                                  child: const Icon(
                                    FeatherIcons.bell,
                                    size: 25,
                                    color: AppColors.neutralwhite,
                                  ),
                                ),
                              )),
                      state is CurrentUserSuccess
                          ? IconButton(
                              onPressed: () {
                                state.currentUser.isVerified == true
                                    ? _popUpProfile(state.currentUser)
                                    : _showAlert();
                              },
                              icon: const Icon(FeatherIcons.menu),
                              iconSize: 32,
                              color: AppColors.neutralwhite,
                            )
                          : IconButton(
                              onPressed: () {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(
                                        content: Text("No Internet")));
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
                  state is CurrentUserSuccess
                      ? state.currentUser.isVerified == true &&
                              (state.currentUser.friends?.isNotEmpty ?? false)
                          ? _friendContent(state.currentUser)
                          : state.currentUser.isVerified == false
                              ? _firstContent()
                              : const FinddyEmpty(
                                  text:
                                      "Maaf anda belum memiliki teman belajar",
                                )
                      : state is CurrentUserLoading
                          ? const Center(
                              child: CircularProgressIndicator(),
                            )
                          : const SizedBox.shrink()
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _noData() {
    return const Text("nodata");
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

  Widget _friendContent(UserModel currentUser) {
    return BlocBuilder<FriendCubit, FriendCubitState>(
      builder: (context, state) {
        if (state is FriendCubitSuccess) {
          return SizedBox(
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FDText.headersH6(
                  text: "Teman Belajar",
                  color: Colors.black,
                ),
                const SizedBox(height: 12),
                ListView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: currentUser.friends!.length,
                    itemBuilder: (context, index) => _friendItem(
                        state.allfriend[index].name ??
                            state.allfriend.first.name!,
                        state.allfriend[index].location!.city,
                        index,
                        state.allfriend))
              ],
            ),
          );
        } else if (state is FriendCubitLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is FriendCubitError) {
          return Center(
            child: Text(state.error),
          );
        }
        return const SizedBox.shrink();
      },
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

  Future<void> _showAlert() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: const Text('Kamu belum melengkapi profil'),
        content: const Text('Lakukan pengisian data profil?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('batal'),
          ),
          TextButton(
            onPressed: () =>
                context.pushNamed(AppRoutes.nrCompleteProfileStep1),
            child: const Text('ya'),
          ),
        ],
      ),
    );
  }

  Future _popUpProfile(UserModel currentUser) {
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(50),
                                child: Image.network(
                                  currentUser.photo!,
                                  width: 52,
                                  height: 52,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  FDText.headersH7(
                                      text: currentUser.name ?? "Indra"),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      DetailProfilParams params =
                                          DetailProfilParams(
                                              email: currentUser.email!,
                                              type: "detail");
                                      context.pushNamed(
                                          AppRoutes.nrDetailprofile,
                                          extra: params);
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
                              context.read<CurrentUserCubit>().logoutUser();
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

  Widget _friendItem(
      String name, String location, int index, List<UserModel> alluser) {
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
                child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText.bodyP3(text: name),
                Row(
                  children: [
                    const Icon(FeatherIcons.mapPin,
                        size: 12, color: AppColors.neutralBlack60),
                    const SizedBox(width: 4),
                    FDText.bodyP4(
                        text: location, color: AppColors.neutralBlack60),
                  ],
                ),
                const SizedBox(height: 8),
                SizedBox(
                  height: 19,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: alluser[index].interest!.length,
                    physics: const NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.horizontal,
                    itemBuilder: (context, idx) => FDChip.normal(
                      color: idx == 0
                          ? AppColors.accentSky
                          : idx == 1
                              ? AppColors.accentGrass
                              : AppColors.accentSunShine,
                      height: 19,
                      title: alluser[index].interest!.length == 1
                          ? alluser[index].interest![0].name
                          : alluser[index].interest![idx].name,
                    ),
                  ),
                )
              ],
            ))
          ],
        ),
      ),
    );
  }
}
