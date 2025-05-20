


import 'package:ecome/Categories/CartPage.dart';
import 'package:ecome/Categories/Categories.dart';
import 'package:ecome/Categories/ManageAddressPage.dart';
import 'package:ecome/Categories/OrderSummaryPage.dart';
import 'package:ecome/Categories/PaymentOptionsPage.dart';
import 'package:ecome/Categories/PaymentOptionssPage.dart';
import 'package:ecome/Categories/ReviewsPage.dart';
import 'package:ecome/Dashbord.dart';
import 'package:ecome/HomeScreen/FilterPage.dart';
import 'package:ecome/HomeScreen/Homepage.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:ecome/HomeScreen/ProductPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:ecome/OrdersPage/MyOrdersPage.dart';
import 'package:ecome/OrdersPage/OrdersDetails.dart';
import 'package:ecome/Profile/PrivacyCenterPage.dart';
import 'package:ecome/SplashScreen/LandingPage.dart';
import 'package:ecome/SplashScreen/LoginPage.dart';
import 'package:ecome/SplashScreen/Otppage.dart';
import 'package:ecome/SplashScreen/Otpscreen.dart';
import 'package:ecome/SplashScreen/SplashScreen.dart';
import 'package:ecome/SplashScreen/SplashScreenn.dart';
import 'package:ecome/SplashScreen/Welcome.dart';
import 'package:ecome/SplashScreen/singup.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class MyRoute {
  static List<GetPage> get list => [
    GetPage(name: MyPagesName.splash, page: () => SplashScreen()),
    GetPage(name: MyPagesName.splashscreenn, page: ()=>Splashscreenn()),
    GetPage(name: MyPagesName.landingPage, page: ()=>LandingPage()),
    GetPage(name: MyPagesName.loginPage, page: ()=>LoginPage()),
    GetPage(name: MyPagesName.singup, page: ()=>Singup()),
    GetPage(name: MyPagesName.otpscreen, page: ()=>OtpScreen()),
    GetPage(name: MyPagesName.otppage, page: ()=>Otppage()),
    GetPage(name: MyPagesName.cart, page: ()=>CartScreen()),
   // GetPage(name: MyPagesName.shopPage, page: ()=>ShopPage()),
    GetPage(name: MyPagesName.welcomescreen, page: ()=>Welcomescreen()),
   
    GetPage(name: MyPagesName.dashbord, page: ()=>Dashboard()),
    //GetPage(name: MyPagesName.productDetailScreen, page: ()=>ProductDetailScreen()),
    GetPage(name: MyPagesName.productPage, page: ()=>ProductPage()),
    GetPage(name: MyPagesName.reviewsPage, page: ()=>ReviewsPage()),
    GetPage(name: MyPagesName.orderSummaryPage, page: ()=>OrderSummaryPage()),
    GetPage(name: MyPagesName.manageAddressPage, page: ()=>ManageAddressPage()),
    GetPage(name: MyPagesName.filterPage, page: ()=>FilterPage()),
    GetPage(name: MyPagesName.privacyCenterPage, page: ()=>PrivacyCenterPage()),
    GetPage(name: MyPagesName.myOrdersPage, page: ()=>MyOrdersPage()),
    GetPage(name: MyPagesName.orderDetailsPage, page: ()=>OrderDetailsPage()),
    GetPage(name: MyPagesName.paymentOptionsPage, page: ()=>PaymentOptionsPage()),
    GetPage(name: MyPagesName.paymentOptionssPage, page: ()=>PaymentOptionssPage()),
   
        ];}