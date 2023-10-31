import 'package:finddy/domain/entities/user/user_model.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/user_cubit.dart';
import 'package:finddy/presentation/screen/search_friends/cubit/search_friend_cubit_cubit.dart';
import 'package:finddy/presentation/screen/widget/finddy_card.dart';
import 'package:finddy/presentation/screen/widget/finddy_chip.dart';
import 'package:finddy/presentation/screen/widget/finddy_logo.dart';
import 'package:finddy/presentation/screen/widget/finddy_profile_picture.dart';
import 'package:finddy/presentation/screen/widget/finddy_text.dart';
import 'package:finddy/presentation/screen/widget/finddy_textfield.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class SearchFriendScreen extends StatefulWidget {
  const SearchFriendScreen({Key? key}) : super(key: key);

  @override
  State<SearchFriendScreen> createState() => _SearchFriendScreenState();
}

class _SearchFriendScreenState extends State<SearchFriendScreen> {
  @override
  void dispose() {
    _searchController.clear();
    super.dispose();
  }

  @override
  void initState() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    context.read<UserCubit>().getUser(userEmail!);
    context.read<SearchFriendCubit>().getAllUser();
    super.initState();
  }

  List<UserModel> alluser = [];
  String? name;
  UserModel currentUser = const UserModel();

  final TextEditingController _searchController = TextEditingController();

  List<dynamic> bMinat = ['Semua'];
  int _selectedStatus = 0;

  final List _kemampuanData = ["Semua", "Pemula", "Menengah", "Master"];
  final List _lokasi = ["Semua Lokasi", "Lokasiku"];
  String idLokasi = "";

  String? _valkemampuanData;
  String? _valLokasi;

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<SearchFriendCubit, SearchFriendCubitState>(
            listener: (context, state) {
          if (state is SearchFriendCubitSuccess) {
            setState(() {
              alluser = state.allUser;
            });
          }
        }),
        BlocListener<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserSuccess) {
              bMinat.removeWhere((element) => element != "Semua");
              final listMinat =
                  List.from(state.user.interest!.map((e) => e.name));
              setState(() {
                bMinat.addAll(listMinat);
                idLokasi = state.user.location!.locationId;
                print(idLokasi);
              });
            }
          },
        )
      ],
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SingleChildScrollView(
          child: SizedBox(
              width: double.infinity,
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _topSide(),
                    ListView.builder(
                      shrinkWrap: true,
                      itemBuilder: (context, index) => _bottomSide(
                          alluser[index].name!, alluser[index].location!.city),
                      itemCount: alluser.length,
                    ),
                  ])),
        ),
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
            onChanged: (value) {
              setState(() {
                name = value;
                context.read<SearchFriendCubit>().getNameSearch(name);
              });
            },
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
              bMinat.length,
              (index) => FDChip.action(
                onPressed: () {
                  setState(() {
                    _selectedStatus = index;
                  });
                },
                selectedIndex: _selectedStatus == index,
                color: AppColors.thirdLightBlue,
                height: 29,
                title: bMinat[index],
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

  Widget _bottomSide(String name, String location) {
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
                Row(
                  children: [
                    FDText.bodyP3(text: name),
                    const Spacer(),
                    const Icon(
                      Icons.bookmark,
                      size: 16,
                      color: AppColors.primaryGreen,
                    )
                  ],
                ),
                Row(
                  children: [
                    const Icon(FeatherIcons.mapPin,
                        size: 12, color: AppColors.neutralBlack60),
                    const SizedBox(width: 4),
                    FDText.bodyP4(
                        text: location, color: AppColors.neutralBlack60),
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
              print(_valkemampuanData);
              if (_valkemampuanData == "Semua") {
                context.read<SearchFriendCubit>().getAllUser();
              } else {
                context
                    .read<SearchFriendCubit>()
                    .getSkillSearch(_valkemampuanData);
              }
            });
          } else {
            setState(() {
              _valLokasi = value as String;
              print(_valLokasi);
              if (_valLokasi == "Lokasiku") {
                context.read<SearchFriendCubit>().getLocationSearch(idLokasi);
              } else {
                context.read<SearchFriendCubit>().getAllUser();
              }
            });
          }
        });
  }
}
