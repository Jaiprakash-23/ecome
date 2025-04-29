import 'package:ecome/Categories/CartPage.dart';
import 'package:ecome/Categories/CategoriesPage.dart';
import 'package:ecome/Categories/OrderSummaryPage.dart';
import 'package:ecome/Categories/Wishlist.dart';
import 'package:ecome/HomeScreen/Homepage.dart';
import 'package:ecome/Profile/UserProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = List.generate(
    5,
    (_) => GlobalKey<NavigatorState>(),
  );

  void _onTabTapped(int index) {
    if (_currentIndex != index) {
      setState(() {
        _currentIndex = index;
      });
    } else {
      // Reset navigation stack if tapped again
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
    return false; // Don't exit the app
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
        body: IndexedStack(
          index: _currentIndex,
          children: [
            _buildNavigator(0, ShopPage()),
            _buildNavigator(1, WishlistPage()),
            _buildNavigator(2, CategoriesPage()),
            _buildNavigator(3, CartScreen()),
            _buildNavigator(4, UserProfilePage()),
          ],
        ),
        bottomNavigationBar: BottomNavigationBar(
  type: BottomNavigationBarType.fixed, // <-- add this line
  selectedItemColor: Color(0xff004CFF),
  unselectedItemColor: Colors.black,
  currentIndex: _currentIndex,
  onTap: _onTabTapped,
  items: const [
    BottomNavigationBarItem(
      icon: Icon(Icons.home_outlined),
      label: 'Home',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.favorite_border),
      label: 'Wishlist',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.list_alt_rounded),
      label: 'Categories',
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.shopping_bag_outlined),
      label: 'Cart',
    ),
    BottomNavigationBarItem(
      icon: Icon(LucideIcons.user),
      label: 'Account',
    ),
  ],
),

        // bottomNavigationBar: BottomNavigationBar(
        //   selectedItemColor: Colors.black,
        //   unselectedItemColor: Colors.blue,
        //   currentIndex: _currentIndex,
        //   onTap: _onTabTapped,
        //   items: const [
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.home_outlined),
        //       label: 'Home',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.favorite_border),
        //       label: 'Wishlist',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.filter),
        //       label: 'Categories',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(Icons.shopping_bag_outlined),
        //       label: 'Cart',
        //     ),
        //     BottomNavigationBarItem(
        //       icon: Icon(LucideIcons.user),
        //       label: 'Account',
        //     ),
        //   ],
        // ),
      
      
      ),
    );
  }

  Widget _buildNavigator(int index, Widget child) {
    return Navigator(
      key: _navigatorKeys[index],
      onGenerateRoute: (routeSettings) {
        return MaterialPageRoute(builder: (_) => child);
      },
    );
  }
}


