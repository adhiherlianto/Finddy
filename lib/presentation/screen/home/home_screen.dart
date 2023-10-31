import 'package:finddy/presentation/screen/main_screen/main_screen.dart';
import 'package:finddy/presentation/screen/message/message_screen.dart';
import 'package:finddy/presentation/screen/search_friends/search_friend_screen.dart';
import 'package:finddy/presentation/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_feather_icons/flutter_feather_icons.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
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

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: _pages[_selectedPageIndex]['pages'] as Widget,
        bottomNavigationBar: BottomNavigationBar(
            selectedItemColor: AppColors.primaryGreen,
            unselectedItemColor: AppColors.neutralBlack60,
            onTap: _selectPage,
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
            ]),
      ),
    );
  }
}
