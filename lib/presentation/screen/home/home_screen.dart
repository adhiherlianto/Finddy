import 'package:finddy/presentation/navigation/app_routes.dart';
import 'package:finddy/presentation/screen/complete_profile/cubit/preference_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/cubit/current_user_cubit.dart';
import 'package:finddy/presentation/screen/main_screen/main_screen.dart';
import 'package:finddy/presentation/screen/message/message_screen.dart';
import 'package:finddy/presentation/screen/search_friends/search_friend_screen.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    final userEmail = FirebaseAuth.instance.currentUser!.email;
    context.read<CurrentUserCubit>().getCurrentUser(userEmail!);
    super.initState();
  }

  final List<Map<String, Object>> _pages = [
    {'pages': const MainScreen(), 'title': 'Beranda'},
    {'pages': const SearchFriendScreen(), 'title': 'Cari Teman'},
    {'pages': const MessageScreen(), 'title': 'Pesan'},
  ];

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() => _selectedPageIndex = index);
  }

  Future<void> _showAlert() {
    return showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(32.0))),
        title: const Text('Kamu belum melengkapi profil'),
        content: const Text('Lakukan pengisian data profil?'),
        actions: <Widget>[
          TextButton(
            onPressed: () => context.pop(),
            child: const Text('batal'),
          ),
          TextButton(
            onPressed: () {
              context.pop();
              context.pushNamed(AppRoutes.nrCompleteProfileStep1);
            },
            child: const Text('ya'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: BlocListener<PreferenceCubit, PreferenceState>(
        listener: (context, state) {
          print("state :$state");
          if (state is UpdateUserSuccess) {
            final userEmail = FirebaseAuth.instance.currentUser!.email;
            context.read<CurrentUserCubit>().getCurrentUser(userEmail!);
          }
        },
        child: Scaffold(
          body: _pages[_selectedPageIndex]['pages'] as Widget,
          bottomNavigationBar: BlocBuilder<CurrentUserCubit, CurrentUserState>(
            builder: (context, state) {
              if (state is CurrentUserSuccess) {
                return BottomNavigationBar(
                    selectedItemColor: AppColors.primaryGreen,
                    unselectedItemColor: AppColors.neutralBlack60,
                    onTap: (value) {
                      state.currentUser.isVerified == true
                          ? _selectPage(value)
                          : _showAlert();
                    },
                    currentIndex: _selectedPageIndex,
                    items: const [
                      BottomNavigationBarItem(
                        icon: Icon(Icons.home),
                        label: 'Home',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(Icons.search),
                        label: 'Cari teman',
                      ),
                      BottomNavigationBarItem(
                        icon: Icon(FeatherIcons.messageCircle),
                        label: 'Pesan',
                      ),
                    ]);
              }
              return BottomNavigationBar(
                  selectedItemColor: AppColors.primaryGreen,
                  unselectedItemColor: AppColors.neutralBlack60,
                  onTap: (value) {},
                  currentIndex: _selectedPageIndex,
                  items: const [
                    BottomNavigationBarItem(
                      icon: Icon(Icons.home),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(Icons.search),
                      label: 'Cari teman',
                    ),
                    BottomNavigationBarItem(
                      icon: Icon(FeatherIcons.messageCircle),
                      label: 'Pesan',
                    ),
                  ]);
            },
          ),
        ),
      ),
    );
  }
}
