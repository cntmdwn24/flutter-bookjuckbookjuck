import 'package:bookjuckboojuck/screens/searchbook_screen.dart';
import 'package:bookjuckboojuck/screens/community_screen.dart';
import 'package:bookjuckboojuck/screens/home_screen.dart';
import 'package:bookjuckboojuck/screens/profile_screen.dart';
import 'package:bookjuckboojuck/screens/scan_screen.dart';
import 'package:flutter/material.dart';
import '../presentation/providers/main_provider.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  void updateScreen() => setState(() {});

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      mainProvider.addListener(updateScreen);
    });
  }

  @override
  void dispose() {
    super.dispose();
    mainProvider.removeListener(updateScreen);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: mainProvider.pageController,
        physics: NeverScrollableScrollPhysics(),
        children: [
          HomeScreen(),
          CommunityScreen(),
          ScanScreen(),
          ProfileScreen(),
        ],
      ),
      bottomNavigationBar: Theme(
        data: Theme.of(context).copyWith(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.white,
          onTap: mainProvider.changeTabIndex,
          currentIndex: mainProvider.currentTabIndex,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          selectedIconTheme: IconThemeData(size: 35, color: Colors.blue),
          unselectedIconTheme:
              IconThemeData(size: 30, color: Colors.grey.shade600),
          items: [
            _buildBottomNavBarItem(icon: Icons.home_outlined),
            _buildBottomNavBarItem(icon: Icons.forum_outlined),
            _buildBottomNavBarItem(icon: Icons.document_scanner_outlined),
            _buildBottomNavBarItem(icon: Icons.person_outline),
          ],
        ),
      ),
    );
  }

  BottomNavigationBarItem _buildBottomNavBarItem({required IconData icon}) =>
      BottomNavigationBarItem(
        icon: Center(
          child: Icon(icon),
        ),
        label: '',
      );
}
