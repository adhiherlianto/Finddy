import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/auth/cubit/auth_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const LoginLayout();
  }
}

class LoginLayout extends StatefulWidget {
  const LoginLayout({Key? key}) : super(key: key);

  @override
  State<LoginLayout> createState() => _LoginLayoutState();
}

class _LoginLayoutState extends State<LoginLayout> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void initState() {
    //hide statusbar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.bottom]);
    super.initState();
  }

  @override
  void dispose() {
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: [SystemUiOverlay.top, SystemUiOverlay.bottom]);
    _emailController.clear();
    _passwordController.clear();
    super.dispose();
  }

  bool textfieldPw = false;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return BlocListener<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is LoginSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.primaryGreen,
              content: Text('Login Success'),
            ),
          );
          context.goNamed(AppRoutes.nrEmailVerif);
        } else if (state is LoginError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(state.error),
            ),
          );
        }
      },
      child: Scaffold(
        backgroundColor: AppColors.lightWhite,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(24),
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FinddyLogo(size: 40.0),
                  const SizedBox(height: 40),
                  const FDText.headersH3(
                    text: "Selamat datang kembali!",
                    color: AppColors.neutralBlack80,
                  ),
                  const SizedBox(height: 12),
                  const FDText.bodyP3(
                    text: "Mulai temukan teman belajarmu di sini!",
                    color: AppColors.neutralBlack60,
                  ),
                  const SizedBox(height: 78),
                  const FDText.headersH6(
                    text: "Email",
                    color: AppColors.neutralBlack60,
                  ),
                  const SizedBox(height: 12),
                  FDTextField.normal(
                    isEmail: true,
                    hintText: "Masukan email kamu",
                    textEditingController: _emailController,
                    onChanged: (data) {
                      print("dataEmail : $data");
                    },
                  ),
                  const SizedBox(height: 24),
                  const FDText.headersH6(
                    text: "Password",
                    color: AppColors.neutralBlack60,
                  ),
                  const SizedBox(height: 12),
                  FDTextField.password(
                    hintText: "Masukkan kata sandi kamu",
                    textEditingController: _passwordController,
                    onChanged: (data) {},
                    icon: textfieldPw
                        ? const Icon(Icons.visibility_off)
                        : const Icon(Icons.visibility),
                    isVisible: textfieldPw,
                    onPressed: () {
                      setState(() {
                        textfieldPw = !textfieldPw;
                      });
                    },
                  ),
                  const SizedBox(height: 40),
                  FDButton.primary(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {
                          context.read<AuthCubit>().loginUser(
                              _emailController.text, _passwordController.text);
                        }
                      },
                      text: "Login"),
                  const SizedBox(height: 60),
                  const Center(
                    child: FDText.bodyP3(
                      text: "Belum punya akun?",
                      color: AppColors.neutralBlack60,
                    ),
                  ),
                  const SizedBox(height: 12),
                  FDButton.secondary(
                      onPressed: () {
                        context.pushNamed(AppRoutes.nrRegister);
                      },
                      text: "Registrasi Sekarang")
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
