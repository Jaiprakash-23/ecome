import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Splashscreenn extends StatefulWidget {
  const Splashscreenn({super.key});

  @override
  State<Splashscreenn> createState() => _SplashscreennState();
}

class _SplashscreennState extends State<Splashscreenn> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Top-left aligned image with height 300
          Positioned(
            top: 0,
            left: 0,
            child: Image.asset(
              'assets/images/images1.png',
              height: 300, // Fixed height for the image
              fit: BoxFit.cover, // Ensures the image covers its height proportionally
            ),
          ),
          // Top-right aligned image
          Positioned(
            bottom: 20,
            right: 0, // Positioning it to the right
            child: Image.asset(
              'assets/images/bubble2.png',
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
                          image: AssetImage('assets/images/Placeholder_01.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(height: 40),
                    const Text(
                      'Ready?',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        fontFamily: "raleway",
                      ),
                    ),
                    const SizedBox(height: 10),
                    const Text(
                      'Lorem ipsum dolor sit amet,\n consectetur adipiscing elit.',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 19,
                        fontWeight: FontWeight.normal,
                        fontFamily: "Nunito Sans",
                      ),
                    ),
                    SizedBox(height: 30,),
                    InkWell(
                      onTap: (){
                        Get.offNamed(MyPagesName.landingPage);
                      },
                      child: Container(
                        height: 50, 
                        width: 201,
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xff004CFF)),
                        child: Center(child: Text('Let`s Start',style: TextStyle(color: Colors.white,fontFamily: "Nunito Sans",fontSize: 22),)),
                      ),
                    )
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
                    color: index == 2 ? Colors.blue : const Color(0xffC7D6FB),
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
