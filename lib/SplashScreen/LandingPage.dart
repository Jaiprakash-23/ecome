// import 'package:ecome/MyRoutes/myPagesName.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:get/get_navigation/get_navigation.dart';

// class LandingPage extends StatelessWidget {
//   const LandingPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: Column(
//         children: [
//           // Centered Content
//           Expanded(
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               crossAxisAlignment: CrossAxisAlignment.center,
//               children: [
//                 // Logo
//                 Image.asset(
//                   'assets/images/logo.png', // Replace with your logo path
//                   height: 134,
//                   width: 247,
//                 ),
//                 const SizedBox(height: 20),
//                 // Title
//                 const Text(
//                   'Own Gears',
//                   style: TextStyle(
//                     fontSize: 52,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: "Raleway"
//                   ),
//                 ),
//                 const SizedBox(height: 10),
//                 // Subtitle
//                 const Text(
//                   'Beautiful eCommerce App\nfor your online store',
//                   textAlign: TextAlign.center,
//                   style: TextStyle(
//                     fontSize: 19,
//                     color: Color(0xff202020),
//                     fontFamily: 'Nunito Sans'
//                   ),
//                 ),
//               ],
//             ),
//           ),
//           // Bottom Row

//           // Padding(
//           //   padding: const EdgeInsets.symmetric(horizontal: 0.0, vertical: 0),
//           //   child:

//           //   Row(
//           //     mainAxisAlignment: MainAxisAlignment.center,
//           //     children: [
//           //       const Text(
//           //         'I already have an account',
//           //         style: TextStyle(fontSize: 15,fontFamily: 'Nunito Sans'),
//           //       ),
//           //       const SizedBox(width: 10),
//           //       ElevatedButton(
//           //         onPressed: () {
//           //          // Get.toNamed(MyPagesName.otppage);
//           //           //Get.toNamed(MyPagesName.loginPage);
//           //           // Add navigation logic here
//           //         },
//           //         style: ElevatedButton.styleFrom(
//           //           shape: const CircleBorder(),
//           //           padding: const EdgeInsets.all(14),
//           //           backgroundColor: Color(0xff004CFF),
//           //         ),
//           //         child: const Icon(
//           //           Icons.arrow_forward,
//           //           color: Colors.white,
//           //         ),
//           //       ),
//           //     ],
//           //   ),

//           // ),

//         ],
//       ),
//     );
//   }
// }

import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class LandingPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Logo
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset(
                  'assets/images/logo.png', // Replace with your logo image path
                  height: 120,
                ),
              ),
              SizedBox(height: 20),

              // Title
              const Text(
                'Own Gears',
                style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Raleway"),
              ),
              SizedBox(height: 10),

              // Subtitle
              const Text(
                'Beautiful eCommerce App\nfor your online store',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 19,
                    color: Color(0xff202020),
                    fontFamily: 'Nunito Sans'),
              ),
              SizedBox(height: 40),

              // Login Button
              SizedBox(
                height: 50,
                width: 201,
                child: ElevatedButton(
                  onPressed: () {
                    Get.toNamed(MyPagesName.loginPage);
                    // Navigate to login page
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff004CFF),
                    padding: EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      SizedBox(width: 25),
                      Container(
                        height: 30, // Reduced height for better alignment
                        width: 30, // Same width for a circular appearance
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.white,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                          size:
                              16, // Slightly smaller icon for proportional design
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              SizedBox(height: 20),

              // Create Account Button
              TextButton(
                onPressed: () {
                 Get.toNamed(MyPagesName.singup);
                },
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      "Create Account",
                      style: TextStyle(fontSize: 16, color: Colors.black),
                    ),
                    SizedBox(width: 10),
                     Container(
                        height: 30, // Reduced height for better alignment
                        width: 30, // Same width for a circular appearance
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: Colors.black,
                        ),
                        child: Icon(
                          Icons.arrow_forward,
                          color: Colors.white,
                          size:
                              16, // Slightly smaller icon for proportional design
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
