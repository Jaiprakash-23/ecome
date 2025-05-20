import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:ecome/MyRoutes/myroutename.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check if a mobile number exists in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? mobileNumber = prefs.getString('mobile_number');

  // Set the initial route based on whether the mobile number exists
  String initialRoute = mobileNumber != null && mobileNumber.isNotEmpty
      ? MyPagesName.dashbord // Navigate to dashboard if mobile number exists
      : MyPagesName.splash; // Otherwise, go to the splash/login page

  runApp(MyApp(initialRoute: initialRoute));
}

class MyApp extends StatefulWidget {
  final String initialRoute;
  

  const MyApp({required this.initialRoute, super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.dark,
      ),
    );

    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "",
      //theme: AppTheme.appTheme,
      initialRoute: widget.initialRoute,
      getPages: MyRoute.list,
    );
  }
}


// import 'package:ecome/HomeScreen/Homepage.dart';
// import 'package:flutter/material.dart';
// import 'package:lucide_icons/lucide_icons.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: MainScreen(),
//     );
//   }
// }

// class MainScreen extends StatefulWidget {
//   @override
//   _MainScreenState createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int _currentIndex = 0;

//   final List<GlobalKey<NavigatorState>> _navigatorKeys = [
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//      GlobalKey<NavigatorState>(),
//     GlobalKey<NavigatorState>(),
//   ];

//   void _onTabTapped(int index) {
//     if (_currentIndex != index) {
//       setState(() {
//         _currentIndex = index;
//       });
//     } else {
//       // Reset navigation stack if tapped again
//       _navigatorKeys[index].currentState?.popUntil((route) => route.isFirst);
//     }
//   }

//   Future<bool> _onWillPop() async {
//     final isFirstRouteInCurrentTab =
//         !await _navigatorKeys[_currentIndex].currentState!.maybePop();

//     if (isFirstRouteInCurrentTab) {
//       if (_currentIndex != 0) {
//         // Switch to the Home tab
//         setState(() {
//           _currentIndex = 0;
//         });
//         return false; // Don't exit the app
//       }
//       return true; // Exit the app
//     }
//     return false; // Don't exit the app
//   }

//   @override
//   Widget build(BuildContext context) {
//     return WillPopScope(
//       onWillPop: _onWillPop,
//       child: Scaffold(
//         body: IndexedStack(
//           index: _currentIndex,
//           children: [
//             _buildNavigator(0, ShopPage()),
//             _buildNavigator(1, CategoriesScreen()),
//             _buildNavigator(2, ProfileScreen()),
//             _buildNavigator(3, ProfileScreen()),
//             _buildNavigator(4, ProfileScreen()),
//           ],
//         ),
//         bottomNavigationBar: BottomNavigationBar(
//           currentIndex: _currentIndex,
//           onTap: _onTabTapped,
//           backgroundColor: Colors.black,
//           items: const [
//             BottomNavigationBarItem(
//               backgroundColor: Colors.red,
//               icon: Icon(Icons.home_outlined), label: 'Home'),
//             BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: 'Favorites'),
//            BottomNavigationBarItem(icon: Icon(Icons.filter), label: 'Filters'),
//             BottomNavigationBarItem(icon: Icon(Icons.shopping_bag_outlined), label: 'Cart'),
//            BottomNavigationBarItem(icon: Icon(LucideIcons.user), label: 'Profile'),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildNavigator(int index, Widget child) {
//     return Navigator(
//       key: _navigatorKeys[index],
//       onGenerateRoute: (routeSettings) {
//         return MaterialPageRoute(builder: (_) => child);
//       },
//     );
//   }
// }



// class CategoriesScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Categories')),
//       body: Center(child: Text('Categories Page')),
//     );
//   }
// }

// class ProfileScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Profile')),
//       body: Center(child: Text('Profile Page')),
//     );
//   }
// }

// class DetailsScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Details')),
//       body: Center(child: Text('Details Page')),
//     );
//   }
// }

// import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         fontFamily: 'Inter',
//         primarySwatch: Colors.pink,
//       ),
//       home: ProductDetailScreen(),
//     );
//   }
// }

// class ProductDetailScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         leading: IconButton(
//           icon: Icon(Icons.arrow_back, color: Colors.black),
//           onPressed: () => Navigator.pop(context),
//         ),
//         backgroundColor: Colors.white,
//         elevation: 0,
//         actions: [
//           IconButton(
//             icon: Icon(Icons.favorite_border, color: Colors.black),
//             onPressed: () {},
//           ),
//           IconButton(
//             icon: Icon(Icons.share, color: Colors.black),
//             onPressed: () {},
//           ),
//         ],
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 16.0),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               // Product Image
//               Container(
//                 height: MediaQuery.of(context).size.height * 0.4,
//                 decoration: BoxDecoration(
//                   color: Colors.grey[200],
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 child: Center(
//                   child: Icon(Icons.image, size: 50, color: Colors.grey[400]),
//                 ),
//               ),
//               SizedBox(height: 20),
              
//               // Product Title and Price
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Stylish girls hot Dress',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Text(
//                     '\$17.00',
//                     style: TextStyle(
//                       fontSize: 22,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.pink,
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 12),
              
//               // Product Description
//               Text(
//                 'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mamis, sedienique eu mamis id, pretium pulvinar sapien.',
//                 style: TextStyle(
//                   fontSize: 14,
//                   color: Colors.grey[600],
//                   height: 1.5,
//                 ),
//               ),
//               SizedBox(height: 24),
              
//               // Variations Section
//               Text(
//                 'Variations',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 12),
              
//               // Color Variations
//               SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: ['Cody', 'Yellow', 'White', 'Green', 'Black']
//                       .map((color) => Container(
//                             margin: EdgeInsets.only(right: 10),
//                             padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//                             decoration: BoxDecoration(
//                               border: Border.all(color: Colors.grey[300]!),
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Text(color),
//                           ))
//                       .toList(),
//                 ),
//               ),
//               SizedBox(height: 20),
              
//               // Size Variations
//               Text(
//                 'Size',
//                 style: TextStyle(
//                   fontSize: 16,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 12),
//               Wrap(
//                 spacing: 10,
//                 children: ['S', 'M', 'L', 'XL', 'XXL']
//                     .map((size) => Container(
//                           padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
//                           decoration: BoxDecoration(
//                             border: Border.all(color: size == 'M' ? Colors.pink : Colors.grey[300]!),
//                             borderRadius: BorderRadius.circular(8),
//                             color: size == 'M' ? Colors.pink[50] : Colors.transparent,
//                           ),
//                           child: Text(size),
//                         ))
//                     .toList(),
//               ),
//               SizedBox(height: 30),
              
//               // Divider with custom style
//               Divider(height: 1, thickness: 1, color: Colors.grey[200]),
//               SizedBox(height: 20),
              
//               // Product Details
//               _buildDetailItem('Origin', 'EU'),
//               _buildDetailItem('Size guide', '', hasIcon: true),
//               _buildDetailItem('Specifications', '', hasIcon: true),
//               _buildDetailItem('Material', 'Cotton 95%, Mean 5%'),
//               SizedBox(height: 20),
              
//               // Divider
//               Divider(height: 1, thickness: 1, color: Colors.grey[200]),
//               SizedBox(height: 20),
              
//               // Rating & Reviews
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text(
//                     'Rating & Reviews',
//                     style: TextStyle(
//                       fontSize: 18,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   Row(
//                     children: [
//                       Icon(Icons.star, color: Colors.amber, size: 20),
//                       Icon(Icons.star, color: Colors.amber, size: 20),
//                       Icon(Icons.star, color: Colors.amber, size: 20),
//                       Icon(Icons.star, color: Colors.amber, size: 20),
//                       Icon(Icons.star_half, color: Colors.amber, size: 20),
//                       SizedBox(width: 8),
//                       Text('4/8'),
//                     ],
//                   ),
//                 ],
//               ),
//               SizedBox(height: 16),
              
//               // Review
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   CircleAvatar(
//                     radius: 20,
//                     backgroundColor: Colors.grey[200],
//                     child: Icon(Icons.person, color: Colors.grey),
//                   ),
//                   SizedBox(width: 12),
//                   Expanded(
//                     child: Column(
//                       crossAxisAlignment: CrossAxisAlignment.start,
//                       children: [
//                         Text(
//                           'Vercellula',
//                           style: TextStyle(
//                             fontWeight: FontWeight.bold,
//                           ),
//                         ),
//                         SizedBox(height: 4),
//                         Row(
//                           children: [
//                             Icon(Icons.star, color: Colors.amber, size: 16),
//                             Icon(Icons.star, color: Colors.amber, size: 16),
//                             Icon(Icons.star, color: Colors.amber, size: 16),
//                             Icon(Icons.star, color: Colors.amber, size: 16),
//                             SizedBox(width: 8),
//                           ],
//                         ),
//                         SizedBox(height: 8),
//                         Text(
//                           'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sedienique eu mamis id, pretium pulvinar sapien.',
//                           style: TextStyle(
//                             color: Colors.grey[600],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               SizedBox(height: 30),
              
//               // Most Popular Section
//               Text(
//                 'Most Popular',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
              
//               // Most Popular Grid
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.75,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemCount: 4,
//                 itemBuilder: (context, index) => _buildPopularItem(),
//               ),
//               SizedBox(height: 30),
              
//               // You Might Like Section
//               Text(
//                 'You Might Like',
//                 style: TextStyle(
//                   fontSize: 18,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               SizedBox(height: 16),
//               Text(
//                 'Lorem ipsum dolor sit amet consectetur adipiscing elit, sedienique eu mamis id, pretium pulvinar sapien.',
//                 style: TextStyle(
//                   color: Colors.grey[600],
//                 ),
//               ),
//               SizedBox(height: 16),
              
//               // You Might Like Grid
//               GridView.builder(
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 2,
//                   childAspectRatio: 0.75,
//                   crossAxisSpacing: 12,
//                   mainAxisSpacing: 12,
//                 ),
//                 itemCount: 4,
//                 itemBuilder: (context, index) => _buildPopularItem(),
//               ),
//               SizedBox(height: 20),
//             ],
//           ),
//         ),
//       ),
      
//       // Bottom Add to Cart Button
//       bottomNavigationBar: Container(
//         padding: EdgeInsets.all(16),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           boxShadow: [
//             BoxShadow(
//               color: Colors.grey.withOpacity(0.2),
//               spreadRadius: 1,
//               blurRadius: 5,
//               offset: Offset(0, -2),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             Expanded(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.pink,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: Text(
//                   'Add to cart',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//             SizedBox(width: 16),
//             Expanded(
//               child: ElevatedButton(
//                 style: ElevatedButton.styleFrom(
//                   backgroundColor: Colors.white,
//                   padding: EdgeInsets.symmetric(vertical: 16),
//                   side: BorderSide(color: Colors.pink),
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(8)),
//                 ),
//                 child: Text(
//                   'Buy Now',
//                   style: TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     color: Colors.pink,
//                   ),
//                 ),
//                 onPressed: () {},
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildDetailItem(String title, String value, {bool hasIcon = false}) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(vertical: 10),
//       child: Row(
//         children: [
//           Text(
//             title,
//             style: TextStyle(
//               fontSize: 16,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           Spacer(),
//           if (hasIcon)
//             Icon(Icons.chevron_right, color: Colors.grey)
//           else
//             Text(
//               value,
//               style: TextStyle(
//                 fontSize: 16,
//                 color: Colors.grey[600],
//               ),
//             ),
//         ],
//       ),
//     );
//   }

//   Widget _buildPopularItem() {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Container(
//           height: 150,
//           decoration: BoxDecoration(
//             color: Colors.grey[200],
//             borderRadius: BorderRadius.circular(8),
//           ),
//           child: Center(
//             child: Icon(Icons.image, size: 40, color: Colors.grey[400]),
//           ),
//         ),
//         SizedBox(height: 8),
//         Text(
//           'Product Name',
//           style: TextStyle(
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//         SizedBox(height: 4),
//         Text(
//           '\$12.99',
//           style: TextStyle(
//             color: Colors.pink,
//             fontWeight: FontWeight.bold,
//           ),
//         ),
//       ],
//     );
//   }
// }