import 'package:ecome/MobileRepairPage/MobileRepairPage.dart';
import 'package:flutter/material.dart';

class Dashboardd extends StatefulWidget {
  const Dashboardd({super.key});

  @override
  State<Dashboardd> createState() => _DashboarddState();
}

class _DashboarddState extends State<Dashboardd> {
 int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];

  final List<Widget> _pages = [
    MobileRepairPage(),
    
  ];

  void _onTap(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    } else {
      // Reset stack of the current navigator
      _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
    }
  }

  Future<bool> _onWillPop() async {
    final isFirstRouteInCurrentTab =
        !await _navigatorKeys[_currentIndex].currentState!.maybePop();

    if (isFirstRouteInCurrentTab) {
      if (_currentIndex != 0) {
        setState(() {
          _currentIndex = 0;
        });
        return false; // Don't exit the app
      }
      return true; // Exit the app
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: Stack(
          children: _pages.asMap().entries.map((entry) {
            int index = entry.key;
            Widget page = entry.value;

            return Offstage(
              offstage: _currentIndex != index,
              child: Navigator(
                key: _navigatorKeys[index],
                onGenerateRoute: (routeSettings) {
                  return MaterialPageRoute(
                    builder: (_) => page,
                  );
                },
              ),
            );
          }).toList(),
        ),
        bottomNavigationBar: BottomNavigationBar(
          currentIndex: _currentIndex,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Color(0xff004CFF),
          unselectedItemColor: Colors.black,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Repair Home',
            ),
            
            BottomNavigationBarItem(
              icon: Icon(Icons.list_alt_rounded),
              label: 'My Devices',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.shopping_bag_outlined),
              label: 'Back To Main',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person_outline),
              label: 'Account',
            ),
          ],
        ),
      ),
    );
  }
}