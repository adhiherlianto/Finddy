import 'package:finddy/globals.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/auth/login_screen.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenThree.dart';
import 'package:finddy/presentation/screen/complete_profile/ParamScreenTwo.dart';
import 'package:finddy/presentation/screen/complete_profile/complete_profile_step_one_screen.dart';
import 'package:finddy/presentation/screen/complete_profile/complete_profile_step_three_screen.dart';
import 'package:finddy/presentation/screen/complete_profile/complete_profile_step_two_screen.dart';
import 'package:finddy/presentation/screen/detail_and_edit_profile/detail_profile_screen.dart';
import 'package:finddy/presentation/screen/home/home_screen.dart';
import 'package:finddy/presentation/screen/onboarding/onboarding_screen.dart';
import 'package:finddy/presentation/screen/register/register_screen.dart';
import 'package:finddy/presentation/screen/splash/splash_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter fdGlobalRouter = GoRouter(
    navigatorKey: AppGlobals.navigatorKey,
    initialLocation: '/splash',
    routes: [
      GoRoute(
        path: '/onboarding',
        name: AppRoutes.nrOnBoarding,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/splash',
        name: AppRoutes.nrSplash,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        name: AppRoutes.nrLogin,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        name: AppRoutes.nrRegister,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/home',
        name: AppRoutes.nrHome,
        builder: (context, state) => const HomeScreen(),
      ),
      GoRoute(
        path: '/complete-profile-step-1',
        name: AppRoutes.nrCompleteProfileStep1,
        builder: (context, state) => const CompleteProfileStepOneScreen(),
      ),
      GoRoute(
        path: '/complete-profile-step-2',
        name: AppRoutes.nrCompleteProfileStep2,
        builder: (context, state) {
          ParamScreenTwo params = state.extra as ParamScreenTwo;
          return CompleteProfileStepTwoScreen(params: params);
        },
      ),
      GoRoute(
        path: '/complete-profile-step-3',
        name: AppRoutes.nrCompleteProfileStep3,
        builder: (context, state) {
          ParamScreenThree params = state.extra as ParamScreenThree;
          return CompleteProfileStepThreeScreen(params: params);
        },
      ),
      GoRoute(
        path: '/detail-profile',
        name: AppRoutes.nrDetailprofile,
        builder: (context, state) {
          final type = state.extra as String;
          return DetailProfileScreen(type: type);
        },
      ),
    ]);
