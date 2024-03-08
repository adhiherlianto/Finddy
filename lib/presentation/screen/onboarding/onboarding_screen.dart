// ignore_for_file: use_build_context_synchronously

import 'package:carousel_slider/carousel_slider.dart';
import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/widget/finddy_button.dart';

import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

// ignore: must_be_immutable
class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({Key? key}) : super(key: key);

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  CarouselController carouselController = CarouselController();

  List<DataSlider> data = [
    DataSlider(
        title: "Temukan teman belajar lebih mudah!",
        desc:
            "Finddy, tempat di mana Anda dapat mencari inspirasi belajar melalui koneksi dengan teman-teman sekelas yang berbeda minat akademisnya. Aplikasi ini memberikan pengalaman berharga dengan fitur tambah teman, chat, dan motivasi belajar yang luar biasa",
        icon: 'assets/images/reason_1.png'),
    DataSlider(
        title: "Motivasi Belajar Menjadi Pemacu Semangat",
        desc:
            "Dengan Finddy, tidak hanya teman belajar yang Anda temukan, tetapi juga teman seperjalanan yang dapat memberikan dukungan dan semangat. Nikmati layanan chatting yang nyaman, tambahkan teman dengan mudah, dan temukan motivasi belajar yang unik sesuai dengan kebutuhan Anda.",
        icon: 'assets/images/reason_2.png'),
    DataSlider(
        title: "Berkomunikasi dengan teman menjadi lebih mudah",
        desc:
            "Sambut kegembiraan belajar dengan Finddy! Tambah teman sejalan dengan minat akademis Anda, terhubung melalui fitur chat yang ramah, dan biarkan motivasi belajar kami menjadi pendorong kesuksesan Anda. Jelajahi peluang baru, belajarlah bersama, dan raih prestasi luar biasa dalam perjalanan pendidikan Anda!",
        icon: 'assets/images/reason_3.png'),
  ];

  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/images/onboarding_background.png"),
              fit: BoxFit.cover)),
      child: SingleChildScrollView(
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const SizedBox(height: 20),
          FinddyLogo(size: 40),
          const SizedBox(height: 80),
          _carouselPages(),
          const SizedBox(height: 20),
          _dotIndicator(),
          _buttonCarousel(),
        ]),
      ),
    ));
  }

  Widget _carouselPages() {
    return CarouselSlider.builder(
        itemCount: data.length,
        carouselController: carouselController,
        itemBuilder: ((context, index, realIndex) => SizedBox(
              width: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: FinddyLogo(
                      size: 200,
                      logo: data[index].icon,
                    ),
                  ),
                  const SizedBox(height: 25),
                  FDText.onBoarding(
                    text: data[index].title,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: 24),
                  Expanded(
                    child: FDText.bodyP2(
                      text: data[index].desc,
                      textAlign: TextAlign.center,
                      // text: 'test',
                    ),
                  )
                ],
              ),
            )),
        options: CarouselOptions(
            autoPlay: false,
            // enlargeCenterPage: true,
            viewportFraction: 1,
            height: 500,
            // aspectRatio: 1.0,
            initialPage: 0,
            autoPlayInterval: const Duration(seconds: 2),
            onPageChanged: ((index, reason) {
              setState(() {
                currentIndex = index;
              });
            })));
  }

  Widget _dotIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(
          data.length,
          (index) => GestureDetector(
                onTap: () {
                  carouselController.animateToPage(index);
                  setState(() => currentIndex = index);
                },
                child: Container(
                  height: 8,
                  width: 8,
                  margin: const EdgeInsets.only(top: 0, left: 16),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8),
                      color: currentIndex == index
                          ? AppColors.primaryGreen
                          : AppColors.neutralBlack20),
                ),
              )),
    );
  }

  Widget _buttonCarousel() {
    return Container(
      padding: const EdgeInsets.only(top: 50),
      child: Row(
        children: [
          FDButton.secondary(
            onPressed: () async {
              final SharedPreferences prefs =
                  await SharedPreferences.getInstance();
              await prefs.setBool('check', true);
              context.pushNamed(AppRoutes.nrLogin);
            },
            text: "Lewati",
            width: 98,
          ),
          const SizedBox(width: 16),
          Expanded(
              child: FDButton.primary(
                  onPressed: () async {
                    if (currentIndex == 2) {
                      final SharedPreferences prefs =
                          await SharedPreferences.getInstance();
                      await prefs.setBool('check', true);
                      context.pushNamed(AppRoutes.nrLogin);
                    } else {
                      debugPrint('currentIndex : $currentIndex');
                      setState(() => currentIndex = currentIndex + 1);
                      debugPrint('currentIndex2 : $currentIndex');
                      carouselController.animateToPage(currentIndex);
                    }
                  },
                  text: "Lanjut"))
        ],
      ),
    );
  }
}

class DataSlider {
  String title;
  String desc;
  String icon;

  DataSlider({required this.title, required this.desc, required this.icon});
}
