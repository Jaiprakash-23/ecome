import 'dart:async';
import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/CartPage.dart';
import 'package:ecome/Categories/CategoriesPage.dart';
import 'package:ecome/Categories/Wishlist.dart';
import 'package:ecome/HomeScreen/Homepage.dart';
import 'package:ecome/Profile/UserProfilePage.dart';
import 'package:flutter/material.dart';
import 'package:lucide_icons/lucide_icons.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
class Dashboard extends StatefulWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;

  final List<GlobalKey<NavigatorState>> _navigatorKeys = [
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
    GlobalKey<NavigatorState>(),
  ];
   List<dynamic> Cartdata = [];
Map<String, dynamic> count = {}; 
String token = '';

  @override
  void initState() {
    super.initState();

    getToken();
    Cartgetdata('');
    startAutoRefresh();
  }
  bool isLoading = true;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = (prefs.getString("token") ?? '').trim();

    if (savedToken.isNotEmpty) {
      setState(() {
        token = savedToken;
        isLoading = true;
      });
      await Cartgetdata(token);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Token not available.');
    }
  }
 
 
Future<void> Cartgetdata(String token) async {
  if (token.isEmpty) {
    print("Token is empty");
    return;
  }

  try {
    var headers = {'Authorization': 'Bearer $token'};
    var response = await http.get(Uri.parse('$BasseUrl/api/cart'), headers: headers);

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      
      if (jsonResponse is Map<String, dynamic>) {
        setState(() {
          Cartdata = jsonResponse['data'] ?? [];
          count = jsonResponse;
        });
        //print('Cartdata: $Cartdata');
      } else {
        print("Unexpected JSON format.");
      }
    } else {
      print("Error: ${response.statusCode} - ${response.reasonPhrase}");
    }
  } catch (e) {
    print("API Call Failed: $e");
  }
}



  final List<Widget> _pages = [
    ShopPage(),
    WishlistPage(),
    CategoriesPage(onNavigateBack: () {  },),
    CartScreen(),
    UserProfilePage(),
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
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Timer? timer;
  void startAutoRefresh() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        Cartgetdata(token);
      }
    });
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
          items:  [
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
              icon: Stack(
                children: [
                  Icon(Icons.shopping_bag_outlined),
                  Positioned(
                  right: 0,
                  left: 13,
                  child: CircleAvatar(
                    radius: 9,
                    backgroundColor: Colors.black,
                    child: Text(
                      '${count['count']?? 0}',
                      style: TextStyle(fontSize: 10, color: Colors.white),
                    ),
                  ),
                ),
                ],
              ),
              //Icon(Icons.shopping_bag_outlined),
              label: 'Cart',
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