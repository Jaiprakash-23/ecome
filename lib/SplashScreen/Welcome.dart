import 'dart:async';

import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class Welcomescreen extends StatefulWidget {
  const Welcomescreen({super.key});

  @override
  State<Welcomescreen> createState() => _WelcomescreenState();
}

class _WelcomescreenState extends State<Welcomescreen> {
   void initState() {
            super.initState();
            Timer(const Duration(seconds: 4),() {
             Get.offNamed(MyPagesName.splashscreenn);
            });
          }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left aligned image with height 300
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/images1.png',
              height: 300, // Fixed height for the image
              fit: BoxFit.cover, // Ensures the image covers its height proportionally
            ),
          ),
          Positioned(
            top: 320,
            child: Image.asset(
              'assets/images/bubble02.png',
              height: 300, // Fixed height for the image
              fit: BoxFit.cover, // Ensures the image covers its height proportionally
            ),
          ),
          // Centered card
          Center(
            child: Card(
              elevation: 8,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
              child: Container(
                width: 330,
                height: 650,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 330,
                      height: 350,
                      decoration: BoxDecoration(
                        borderRadius: const BorderRadius.only(
                          topLeft: Radius.circular(16),
                          topRight: Radius.circular(16),
                        ),
                        color: Colors.amber,
                        image: const DecorationImage(
                          image: AssetImage('assets/images/image1.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Welcome',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "raleway",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.\n Sed non consectetur turpis.\n Morbi eu eleifend lacus.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Nunito Sans",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          // Dots indicator at the bottom
          Positioned(
            bottom: 30, // Adjust this value for spacing from the bottom
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => Container(
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  width: 20,
                  height: 20,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: index == 1 ? Colors.blue : Color(0xffC7D6FB),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
