import 'package:finddy/domain/repositories/chat/notification_service.dart';
import 'package:finddy/presentation/navigation/app_router.dart';
import 'package:finddy/presentation/screen/auth/cubit/auth_cubit.dart';
import 'package:finddy/presentation/screen/chat/cubit/chat_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/complete_profile_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/interest_cubit.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/preference_cubit.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/cubit/add_friend_cubit.dart';
import 'package:finddy/presentation/screen/friend_request/cubit/friend_request_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/friend_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/user_cubit.dart';

import 'package:finddy/presentation/screen/register/cubit/register_cubit.dart';
import 'package:finddy/presentation/screen/search_friends/cubit/search_friend_cubit_cubit.dart';
import 'package:finddy/presentation/screen/splash/cubit/splash_cubit.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:device_preview/device_preview.dart';
import 'package:flutter/services.dart';

final navigatorKey = GlobalKey<NavigatorState>();
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp();
  await NotificationService().initNotification();

  runApp(DevicePreview(
    builder: (context) => const MyApp(),
    enabled: false,
  ));
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
        BlocProvider<CurrentUserCubit>(create: (BuildContext context) {
          return CurrentUserCubit();
        }),
        BlocProvider<AddFriendCubit>(create: (BuildContext context) {
          return AddFriendCubit();
        }),
        BlocProvider<FriendCubit>(create: (BuildContext context) {
          return FriendCubit();
        }),
        BlocProvider<FriendRequestCubit>(create: (BuildContext context) {
          return FriendRequestCubit();
        }),
        BlocProvider<ChatCubit>(create: (BuildContext context) {
          return ChatCubit();
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
              useMaterial3: false,
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
