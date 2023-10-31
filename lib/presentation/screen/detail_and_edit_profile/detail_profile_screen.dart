import 'package:finddy/presentation/screen/widget/finddy_button.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class DetailProfileScreen extends StatefulWidget {
  final String type;
  const DetailProfileScreen({Key? key, required this.type}) : super(key: key);

  @override
  State<DetailProfileScreen> createState() => _DetailProfileScreenState();
}

class _DetailProfileScreenState extends State<DetailProfileScreen> {
  @override
  Widget build(BuildContext context) {
    debugPrint('type ${widget.type}');
    return Scaffold(
      body: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(24),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _detailProfile(),
              _buttonDetail(),
              _bidangMinatContent(),
              _locationContent(),
              _lookingForContent()
            ],
          ),
        ),
      ),
    );
  }

  Widget _detailProfile() {
    return const Center(
      child: Column(
        children: [
          SizedBox(height: 30),
          FDProfilePicture(
            size: 100,
            data:
                'https://assets.goal.com/v3/assets/bltcc7a7ffd2fbf71f5/blt943c9f051f0087c0/639f1d7d03c7a66c44782060/GettyImages-1245184407.jpg?auto=webp&format=pjpg&width=3840&quality=60',
          ),
          FDText.headersH5(text: 'Indra Kurniawan'),
          FDText.bodyP4(text: '@ik260501'),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.school, size: 16),
              SizedBox(width: 4),
              FDText.bodyP4(text: 'Universitas Padjadjaran')
            ],
          ),
          SizedBox(height: 32)
        ],
      ),
    );
  }

  Widget _buttonDetail() {
    if (widget.type == 'detail') {
      return FDButton.primary(onPressed: () {}, text: 'Edit Profil');
    }
    return Row(
      children: [
        Expanded(
            child: FDButton.primary(onPressed: () {}, text: 'Simpan Teman')),
        const SizedBox(width: 24),
        InkWell(
          onTap: () {},
          child: Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
                color: AppColors.warning,
                borderRadius: BorderRadius.circular(7)),
            child: const Icon(
              FeatherIcons.messageCircle,
              color: AppColors.neutralwhite,
            ),
          ),
        )
      ],
    );
  }

  Widget _bidangMinatContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 40),
        const FDText.headersH6(text: 'Bidang/minat'),
        const SizedBox(height: 16),
        FDCard(
            padding: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const FDText.headersH6(
                  text: 'Digital Marketing',
                  color: AppColors.primaryGreen,
                ),
                const SizedBox(height: 12),
                FDChip.normal(
                    color: AppColors.accentGrass, height: 22, title: 'Pemula')
              ],
            ))
      ],
    );
  }

  Widget _locationContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const FDText.headersH6(text: 'Lokasi'),
        const SizedBox(height: 16),
        FDCard(
            padding: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Icon(FeatherIcons.mapPin,
                        size: 16, color: AppColors.primaryGreen),
                    SizedBox(width: 4),
                    FDText.headersH6(
                      text: 'Digital Marketing',
                      color: AppColors.primaryGreen,
                    ),
                  ],
                ),
                SizedBox(height: 8),
                FDText.bodyP4(text: 'Jawa Barat')
              ],
            ))
      ],
    );
  }

  Widget _lookingForContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 16),
        const FDText.headersH6(text: 'Saya sedang mencari'),
        const SizedBox(height: 16),
        FDCard(
            padding: const EdgeInsets.all(12),
            borderRadius: BorderRadius.circular(8),
            child: const Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                FDText.bodyP4(text: '1. Teman belajar untuk belajar bersama')
              ],
            ))
      ],
    );
  }
}
