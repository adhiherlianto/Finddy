import 'package:finddy/presentation/navigation/app_router.dart';
import 'package:finddy/presentation/screen/auth/cubit/auth_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/interest_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/preference_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/user_cubit.dart';

import 'package:finddy/presentation/screen/register/cubit/register_cubit.dart';
import 'package:finddy/presentation/screen/search_friends/cubit/search_friend_cubit_cubit.dart';
import 'package:finddy/presentation/screen/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (BuildContext context) {
          return AuthCubit();
        }),
        BlocProvider<RegisterCubit>(create: (BuildContext context) {
          return RegisterCubit();
        }),
        BlocProvider<SplashCubit>(create: (BuildContext context) {
          return SplashCubit();
        }),
        BlocProvider<CompleteProfileCubit>(create: (BuildContext context) {
          return CompleteProfileCubit();
        }),
        BlocProvider<InterestCubit>(create: (BuildContext context) {
          return InterestCubit();
        }),
        BlocProvider<PreferenceCubit>(create: (BuildContext context) {
          return PreferenceCubit();
        }),
        BlocProvider<UserCubit>(create: (BuildContext context) {
          return UserCubit();
        }),
        BlocProvider<SearchFriendCubit>(create: (BuildContext context) {
          return SearchFriendCubit();
        }),
      ],
      child: ScrollConfiguration(
        behavior: const MaterialScrollBehavior().copyWith(overscroll: false),
        child: MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routeInformationProvider: fdGlobalRouter.routeInformationProvider,
          routeInformationParser: fdGlobalRouter.routeInformationParser,
          routerDelegate: fdGlobalRouter.routerDelegate,
          theme: ThemeData(
              pageTransitionsTheme: const PageTransitionsTheme(builders: {
            TargetPlatform.android: FadeUpwardsPageTransitionsBuilder(),
            TargetPlatform.iOS: FadeUpwardsPageTransitionsBuilder()
          })),
          title: "Finddy",
        ),
      ),
    );
  }
}
