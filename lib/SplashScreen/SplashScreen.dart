
import 'dart:async';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  final PageController _pageController = PageController();
  late Timer _timer;
  int _currentPage = 0;

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 2; // Restart from the first page if needed
      }
      _pageController.animateToPage(
       _currentPage,
        duration: const Duration(milliseconds: 500),
       curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background Images
          Positioned(
            top: 0,
            child: Image.asset(
              'assets/images/images1.png',
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 320,
            child: Image.asset(
              'assets/images/bubble02.png',
              height: 300,
              fit: BoxFit.cover,
            ),
          ),
          // PageView for Auto Sliding and Swiping
          PageView.builder(
            controller: _pageController,
            onPageChanged: (index) {
              _currentPage = index; // Update current page on manual swipe
            },
            itemCount: 3,
            itemBuilder: (context, index) {
              return _buildPage(
                image: index==0?'assets/images/shop.jpg':index==1?'assets/images/service.jpg':'assets/images/delivery.jpg',
                title: index == 0
                    ? 'Shop'
                    : index == 1
                        ? 'Services'
                        : 'Pick and Drop',
                description: index == 0
                    ? 'Love shopping. Makes you\n feel like shopping. Making \nlife easier. More of what you\n want. More you see'
                    : index == 1
                        ? 'Want fix it fast, fix it right! \n· Our repair experts, at your\n service! · Quality repairs,\n guaranteed satisfaction!'
                        : 'Relax and get your gadgets\n repair with pickup and\n service facility',
                isLastPage: index == 2,
              );
            },
          ),
          // Dots indicator at the bottom
           Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3,
                (index) => AnimatedBuilder(
                  animation: _pageController,
                  builder: (context, child) {
                    return Container(
                      margin: const EdgeInsets.symmetric(horizontal: 4),
                      width: _currentPage == index ? 10 : 10,
                      height: _currentPage == index ? 10 : 10,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: _currentPage == index
                            ? Colors.blue
                            : const Color(0xffC7D6FB),
                      ),
                    );
                  },
                ),
              ),
            ),
          )
          // Positioned(
          //   bottom: 30,
          //   left: 0,
          //   right: 0,
          //   child: Row(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: List.generate(
          //       3,
          //       (index) => Container(
          //         margin: const EdgeInsets.symmetric(horizontal: 4),
          //         width: _currentPage == index ? 20 : 10,
          //         height: _currentPage == index ? 20 : 10,
          //         decoration: BoxDecoration(
          //           shape: BoxShape.circle,
          //           color: _currentPage == index
          //               ? Colors.blue
          //               : const Color(0xffC7D6FB),
          //         ),
          //       ),
          //     ),
          //   ),
          // ),
        ],
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
    bool isLastPage = false,
  }) {
    return Center(
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
                  image: DecorationImage(
                    image: AssetImage(image),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 40),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  fontFamily: "raleway",
                ),
              ),
              const SizedBox(height: 10),
              Text(
                description,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 19,
                  fontWeight: FontWeight.normal,
                  fontFamily: "Nunito Sans",
                ),
              ),
              SizedBox(height: 30,),
              if (isLastPage)
                 //SizedBox(height: 30,),
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
    );
  }
}
