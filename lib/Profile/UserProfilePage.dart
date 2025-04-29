import 'package:ecome/HomeScreen/ProductPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:ecome/OrdersPage/WalletPage.dart';
import 'package:ecome/Profile/PrivacyCenterPage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserProfilePage extends StatefulWidget {
  @override
  State<UserProfilePage> createState() => _UserProfilePageState();
}

class _UserProfilePageState extends State<UserProfilePage> {
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('mobile_number'); // Remove the saved mobile number.

    // Optionally navigate to the login page or another screen.
    Get.offAllNamed(MyPagesName
        .loginPage); // Replace `MyPagesName.loginPage` with your login page route.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF9F9F9),
      // appBar: AppBar(
      //   backgroundColor: Colors.transparent,
      //   elevation: 0,
      //   title: Text(
      //     'Profile',
      //     style: TextStyle(color: Colors.black),
      //   ),
      //   centerTitle: true,
      // ),
      body: ListView(
        // padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(16.0),
                    decoration: BoxDecoration(
                      color: Color(0xffE5EBFC),
                      borderRadius: BorderRadius.circular(16.0),
                    ),
                    child: Row(
                      children: [
                        Container(
                          height: 45,
                          width: 45,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              border:
                                  Border.all(color: Colors.white, width: 3)),
                        ),
                        SizedBox(width: 16.0),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Hello! Balram Agarwal',
                              style: TextStyle(
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.normal,
                                  fontFamily: 'Raleway'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  SizedBox(height: 16.0),

                  // Quick Access Buttons
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.toNamed(MyPagesName.myOrdersPage);
                        },
                        child: Container(
                          height: 30,
                          width: 162,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Color(0xffF9F9F9)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/Icon.png'),
                              Text(
                                'Orders',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        width: 162,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color(0xffF9F9F9)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Icon(
                              Icons.favorite_outline_sharp,
                              color: Color(0xff004CFF),
                            ),
                            Text(
                              'Wishlist',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  Row(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => WalletPage()),
                          );
                        },
                        child: Container(
                          height: 30,
                          width: 162,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(18),
                              color: Color(0xffF9F9F9)),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Image.asset('assets/images/Package.png'),
                              Text(
                                'My Wallet',
                                style: TextStyle(
                                    fontFamily: 'Raleway',
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Container(
                        height: 30,
                        width: 162,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(18),
                            color: Color(0xffF9F9F9)),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset('assets/images/Gift.png'),
                            Text(
                              'Coupons',
                              style: TextStyle(
                                  fontFamily: 'Raleway',
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),

                  SizedBox(height: 24.0),
                ],
              ),
            ),
          ),
          // Header Section

          SizedBox(height: 6.0),

          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Account Settings'),
                  _buildListTile('Profile', Icons.person, context),
                  Divider(),
                  _buildListTile(
                      'Shipping Address', Icons.location_on, context),
                  Divider(),
                  _buildListTile(
                      'Notifications Center', Icons.notifications, context),
                  Divider(),
                  _buildListTile('Payment Methods', Icons.payment, context),
                  Divider(),
                  InkWell(
                      onTap: () {
                        Get.toNamed(MyPagesName.privacyCenterPage);
                      },
                      child: _buildListTile(
                          'Privacy Center', Icons.lock, context)),
                ],
              ),
            ),
          ),

          SizedBox(height: 6.0),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('My Activity'),
                  _buildListTile('Reviews', Icons.star_border, context),
                  _buildListTile(
                      'Questions & Answer', Icons.question_answer, context),
                ],
              ),
            ),
          ),
          // My Activity

          SizedBox(height: 6.0),
          Container(
            color: Colors.white,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildSectionHeader('Feedback & Information'),
                  _buildListTile('Terms, Policies and Licenses',
                      Icons.description, context),
                  _buildListTile('Browse FAQs', Icons.help_outline, context),
                ],
              ),
            ),
          ),
          // Feedback & Information

          SizedBox(height: 26.0),

          // Logout Button
          Center(
            child: ElevatedButton.icon(
              onPressed: () {
                logout();
              },
              icon: Icon(Icons.power_settings_new),
              label: Text('Logout'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Color(0xffC7D6FB),
                foregroundColor: Colors.black,
                padding: EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
              ),
            ),
          ),
          SizedBox(height: 26.0),
        ],
      ),
    );
  }

  Widget _buildQuickAction(String label, IconData icon) {
    return ElevatedButton(
      onPressed: () {},
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue.shade50,
        foregroundColor: Colors.black,
        padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 16.0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0),
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 28.0),
          SizedBox(height: 4.0),
          Text(
            label,
            style: TextStyle(fontSize: 12.0),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader(String title) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
            fontSize: 18.0, fontWeight: FontWeight.bold, fontFamily: 'Raleway'),
      ),
    );
  }

  Widget _buildListTile(String title, IconData icon, BuildContext context) {
    return ListTile(
      //onTap: () {},
      leading: Icon(icon, color: Color(0xff004CFF)),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'Nunito Sans', fontSize: 16, color: Color(0xff000000)),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
    );
  }
}
