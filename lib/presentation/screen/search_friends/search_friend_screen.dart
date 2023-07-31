import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  State<SearchFriendScreen> createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  final TextEditingController _searchController = TextEditingController();

  List<String> data = ['Semua', 'UI/UX', 'Frontend Dev.'];
  int _selectedStatus = 0;

  final List _kemampuanData = ["Pemula", "Expert"];
  final List _lokasi = ["Bandung", "Jakarta"];

  String? _valkemampuanData;
  String? _valLokasi;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: SizedBox(
            width: double.infinity,
            child:
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              _topSide(),
              _bottomSide(),
            ])),
      ),
    );
  }

  Widget _topSide() {
    return Container(
      color: AppColors.primaryGreen,
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FinddyLogo(size: 40),
          const SizedBox(height: 44),
          const FDText.headersH4(
              text: "Cari teman belajar", color: AppColors.neutralwhite),
          const SizedBox(height: 4),
          const FDText.bodyP2(
              text: "Cari berdasarkan bidang/minat, kemampuan, dan lokasi",
              color: AppColors.neutralwhite),
          const SizedBox(height: 24),
          FDTextField.normal(
            hintText: "Cari teman",
            textEditingController: _searchController,
            onPressed: () {},
            icon: const Icon(Icons.search),
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(FeatherIcons.book, size: 12, color: AppColors.neutralwhite),
              SizedBox(width: 6),
              FDText.bodyP4(
                text: 'Bidang/minat',
                color: AppColors.neutralwhite,
              )
            ],
          ),
          const SizedBox(height: 4),
          Row(
            children: List.generate(
              data.length,
              (index) => FDChip.action(
                onPressed: () {
                  setState(() {
                    _selectedStatus = index;
                  });
                },
                selectedIndex: _selectedStatus == index,
                color: AppColors.thirdLightBlue,
                height: 29,
                title: data[index],
                textColor: Colors.black,
                padding:
                    const EdgeInsets.symmetric(vertical: 8, horizontal: 10),
              ),
            ),
          ),
          const SizedBox(height: 12),
          const SizedBox(
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(FeatherIcons.sliders,
                            size: 12, color: AppColors.neutralwhite),
                        SizedBox(width: 5),
                        FDText.bodyP4(
                            text: "Kemampuan", color: AppColors.neutralwhite),
                      ],
                    ),
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: SizedBox(
                    height: 20,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Icon(FeatherIcons.mapPin,
                            size: 12, color: AppColors.neutralwhite),
                        SizedBox(width: 5),
                        FDText.bodyP4(
                            text: "Lokasi", color: AppColors.neutralwhite)
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          const SizedBox(height: 4),
          Row(
            children: [
              Expanded(
                  child: _dropDown(
                      _kemampuanData, _valkemampuanData, "kemampuan")),
              const SizedBox(width: 8),
              Expanded(child: _dropDown(_lokasi, _valLokasi, "lokasi")),
            ],
          )
        ],
      ),
    );
  }

  Widget _bottomSide() {
    return Container(
      color: AppColors.neutralwhite,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      child: FDCard(
        borderRadius: BorderRadius.circular(12),
        padding: const EdgeInsets.all(12),
        onPressed: () {},
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
                const Row(
                  children: [
                    FDText.bodyP3(text: "C. Ronaldo"),
                    Spacer(),
                    Icon(
                      Icons.bookmark,
                      size: 16,
                      color: AppColors.primaryGreen,
                    )
                  ],
                ),
                const Row(
                  children: [
                    Icon(FeatherIcons.mapPin,
                        size: 12, color: AppColors.neutralBlack60),
                    SizedBox(width: 4),
                    FDText.bodyP4(
                        text: "Kuningan", color: AppColors.neutralBlack60),
                  ],
                ),
                const SizedBox(height: 8),
                FDChip.normal(
                  color: AppColors.accentSky,
                  height: 19,
                  title: "UI/UX",
                )
              ],
            ))
          ],
        ),
      ),
    );
  }

  Widget _dropDown(List items, String? value, String type) {
    return DropdownButtonFormField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
            filled: true,
            fillColor: AppColors.neutralwhite),
        focusColor: Colors.transparent,
        hint: FDText.bodyP4(
            text: type == 'kemampuan' ? "Pilih Kemampuan" : "Pilih Lokasi",
            color: AppColors.neutralBlack20),
        items: items
            .map((e) =>
                DropdownMenuItem(value: e, child: FDText.bodyP4(text: e)))
            .toList(),
        value: value,
        onChanged: (value) {
          if (type == 'kemampuan') {
            setState(() {
              _valkemampuanData = value as String;
            });
          } else {
            setState(() {
              _valLokasi = value as String;
            });
          }
        });
  }
}
