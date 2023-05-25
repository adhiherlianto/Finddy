import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/complete_profile_step_one_screen.dart';
import 'package:finddy/presentation/screen/complete_profile/complete_profile_step_three_screen.dart';
import 'package:finddy/presentation/screen/complete_profile/complete_profile_step_two_screen.dart';
import 'package:finddy/presentation/screen/login/login_screen.dart';
import 'package:finddy/presentation/screen/register/register_screen.dart';
import 'package:go_router/go_router.dart';

final GoRouter fdGlobalRouter = GoRouter(initialLocation: '/login', routes: [
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
    path: '/complete-profile-step-1',
    name: AppRoutes.nrCompleteProfileStep1,
    builder: (context, state) => const CompleteProfileStepOneScreen(),
  ),
  GoRoute(
    path: '/complete-profile-step-2',
    name: AppRoutes.nrCompleteProfileStep2,
    builder: (context, state) => const CompleteProfileStepTwoScreen(),
  ),
  GoRoute(
    path: '/complete-profile-step-3',
    name: AppRoutes.nrCompleteProfileStep3,
    builder: (context, state) => const CompleteProfileStepThreeScreen(),
  ),
]);
