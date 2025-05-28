import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:ecome/MyRoutes/myroutename.dart';
import 'package:ecome/NoInternetScreen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:connectivity_plus/connectivity_plus.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Check Internet connectivity
  final connectivityResult = await Connectivity().checkConnectivity();
  final bool hasInternet = connectivityResult != ConnectivityResult.none;

  // Check if a mobile number exists in SharedPreferences
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String? mobileNumber = prefs.getString('mobile_number');

  // Set the initial route based on internet and mobile number
  String initialRoute = hasInternet
      ? (mobileNumber != null && mobileNumber.isNotEmpty
          ? MyPagesName.dashbord
          : MyPagesName.splash)
      : '/no-internet'; // Custom route for no internet

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
      initialRoute: widget.initialRoute,
      getPages: [
        ...MyRoute.list,
        GetPage(
          name: '/no-internet',
          page: () => const NoInternetScreen(),
        ),
      ],
    );
  }
}
