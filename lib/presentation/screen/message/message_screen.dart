import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class MessageScreen extends StatefulWidget {
  const MessageScreen({Key? key}) : super(key: key);

  @override
  State<MessageScreen> createState() => _MessageScreenState();
}

class _MessageScreenState extends State<MessageScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FinddyLogo(size: 40),
          const SizedBox(height: 30),
          const FDText.headersH4(text: "Pesan"),
          const FDText.bodyP2(
              text: "Tempat berdiskusi dan berbagi dengan teman belajar",
              color: AppColors.neutralBlack40),
          const SizedBox(height: 20),
          FDCard(
              onPressed: () {
                context.pushNamed(AppRoutes.nrDetailprofile, extra: '');
              },
              borderRadius: BorderRadius.circular(12),
              padding: const EdgeInsets.all(12),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const FDProfilePicture(
                      size: 54,
                      data:
                          'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt943c9f051f0087c0/639f1d7d03c7a66c44782060/GettyImages-1245184407.jpg?auto=webp&format=pjpg&width=3840&quality=60'),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            FDText.bodyP3(text: "C. Ronaldo"),
                            Spacer(),
                            FDText.bodyP5(text: "13/02/2022"),
                          ],
                        ),
                        const SizedBox(height: 4),
                        FDChip.normal(
                            color: AppColors.accentGrass,
                            height: 16,
                            title: "Frontend Dev."),
                        const SizedBox(height: 12),
                        const FDText.bodyP5(
                            text:
                                "Lorem ipsum dolor amet sit esta mana sidu  dolor amet sit esta mana sidu")
                      ],
                    ),
                  )
                ],
              ))
        ],
      ),
    );
  }
}
