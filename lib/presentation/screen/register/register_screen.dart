import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/register/cubit/register_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

final TextEditingController _nameController = TextEditingController();
final TextEditingController _emailController = TextEditingController();
final TextEditingController _passwordController = TextEditingController();
final TextEditingController _confirmPasswordController =
    TextEditingController();

bool textfieldPw = false;
bool textfielConfirmPw = false;

class _RegisterScreenState extends State<RegisterScreen> {
  @override
  void dispose() {
    _nameController.clear();
    _emailController.clear();
    _passwordController.clear();
    _confirmPasswordController.clear();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterCubit, RegisterState>(
      listener: (context, state) {
        if (state is RegisterSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: AppColors.primaryGreen,
              content: Text('Register Success'),
            ),
          );
          context.pushNamed(AppRoutes.nrLogin);
        } else if (state is RegisterError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              backgroundColor: AppColors.error,
              content: Text(state.error),
            ),
          );
        }
      },
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(24, 52, 24, 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FDText.headersH3(
                  text: "Bergabung dengan kami!",
                  color: AppColors.neutralBlack80,
                ),
                const SizedBox(height: 12),
                const FDText.bodyP3(
                  text:
                      "Bergabung dan temukan teman belajar yang sesuai dengan preferensimu",
                  color: AppColors.neutralBlack60,
                ),
                const SizedBox(height: 78),
                const FDText.headersH6(
                  text: "Nama lengkap",
                  color: AppColors.neutralBlack60,
                ),
                const SizedBox(height: 12),
                FDTextField.normal(
                  hintText: "Masukan nama kamu",
                  textEditingController: _nameController,
                  onChanged: (data) {},
                ),
                const SizedBox(height: 24),
                const FDText.headersH6(
                  text: "Email",
                  color: AppColors.neutralBlack60,
                ),
                const SizedBox(height: 12),
                FDTextField.normal(
                  hintText: "Masukan email kamu",
                  textEditingController: _emailController,
                  onChanged: (data) {},
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
                  onChanged: (data) {
                    print("dataPassword : $data");
                  },
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
                const SizedBox(height: 24),
                const FDText.headersH6(
                  text: "Konfirmasi Password",
                  color: AppColors.neutralBlack60,
                ),
                const SizedBox(height: 12),
                FDTextField.password(
                  hintText: "Masukkan kata sandi kamu",
                  textEditingController: _confirmPasswordController,
                  onChanged: (data) {
                    print("dataPassword : $data");
                  },
                  icon: textfielConfirmPw
                      ? const Icon(Icons.visibility_off)
                      : const Icon(Icons.visibility),
                  isVisible: textfieldPw,
                  onPressed: () {
                    setState(() {
                      textfielConfirmPw = !textfielConfirmPw;
                    });
                  },
                ),
                const SizedBox(height: 40),
                FDButton.primary(
                    onPressed: () {
                      context.read<RegisterCubit>().registerUser(
                          _emailController.text,
                          _passwordController.text,
                          _nameController.text);
                      // context.pushNamed(AppRoutes.nrHome);
                    },
                    text: "Registrasi"),
                const SizedBox(height: 60),
                const Center(
                  child: FDText.bodyP3(
                    text: "Sudah punya akun?",
                    color: AppColors.neutralBlack60,
                  ),
                ),
                const SizedBox(height: 12),
                FDButton.secondary(
                    onPressed: () {
                      context.pushNamed(AppRoutes.nrLogin);
                    },
                    text: "Login Sekarang")
              ],
            ),
          ),
        ),
      ),
    );
  }
}
