import 'package:finddy/presentation/navigation/app_router.dart';
import 'package:finddy/presentation/screen/login/cubit/login_cubit.dart';
import 'package:finddy/presentation/screen/register/cubit/register_cubit.dart';
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
        BlocProvider<LoginCubit>(create: (BuildContext context) {
          return LoginCubit();
        }),
        BlocProvider<RegisterCubit>(create: (BuildContext context) {
          return RegisterCubit();
        })
      ],
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
    );
  }
}
