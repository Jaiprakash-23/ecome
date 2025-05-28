


import 'package:ecome/Categories/CartPage.dart';
import 'package:ecome/Categories/Categories.dart';
import 'package:ecome/Categories/ManageAddressPage.dart';
import 'package:ecome/Categories/OrderSummaryPage.dart';
import 'package:ecome/Categories/PaymentOptionsPage.dart';
import 'package:ecome/Categories/PaymentOptionssPage.dart';
import 'package:ecome/Categories/ReviewsPage.dart';
import 'package:ecome/Dashboardd.dart';
import 'package:ecome/Dashbord.dart';
import 'package:ecome/HomeScreen/FilterPage.dart';
import 'package:ecome/HomeScreen/Homepage.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:ecome/HomeScreen/ProductPage.dart';
import 'package:ecome/InternetCheckMiddleware.dart';
import 'package:ecome/MobileRepairPage/RepairRequestSummaryPage.dart';
import 'package:ecome/MobileRepairPage/SelectIssuesPage.dart';
import 'package:ecome/MobileRepairPage/SelectTechnicianPage.dart';
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
    GetPage(name: MyPagesName.splash, page: () => SplashScreen(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.splashscreenn, page: ()=>Splashscreenn(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.landingPage, page: ()=>LandingPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.loginPage, page: ()=>LoginPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.singup, page: ()=>Singup(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.otpscreen, page: ()=>OtpScreen(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.otppage, page: ()=>Otppage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.cart, page: ()=>CartScreen(),middlewares: [InternetCheckMiddleware()]),
   // GetPage(name: MyPagesName.shopPage, page: ()=>ShopPage()),
    GetPage(name: MyPagesName.welcomescreen, page: ()=>Welcomescreen(),middlewares: [InternetCheckMiddleware()]),
   GetPage(name: MyPagesName.dashbordd, page: ()=>Dashboardd(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.dashbord, page: ()=>Dashboard(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.repairRequestSummaryPage, page: ()=>RepairRequestSummaryPage()),
    GetPage(name: MyPagesName.productPage, page: ()=>ProductPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.reviewsPage, page: ()=>ReviewsPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.orderSummaryPage, page: ()=>OrderSummaryPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.manageAddressPage, page: ()=>ManageAddressPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.filterPage, page: ()=>FilterPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.privacyCenterPage, page: ()=>PrivacyCenterPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.myOrdersPage, page: ()=>MyOrdersPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.orderDetailsPage, page: ()=>OrderDetailsPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.paymentOptionsPage, page: ()=>PaymentOptionsPage(),middlewares: [InternetCheckMiddleware()]),
    GetPage(name: MyPagesName.paymentOptionssPage, page: ()=>PaymentOptionssPage(),middlewares: [InternetCheckMiddleware()]),
   GetPage(name: MyPagesName.selectIssuesPage, page: ()=>SelectIssuesPage(),middlewares: [InternetCheckMiddleware()]),
     GetPage(name: MyPagesName.selectTechnicianPage, page: ()=>SelectTechnicianPage(),middlewares: [InternetCheckMiddleware()]),  
       
        ];}