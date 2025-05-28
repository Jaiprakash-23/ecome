import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class InternetCheckMiddleware extends GetMiddleware {
  @override
  RouteSettings? redirect(String? route)  {
    var connectivityResult =  Connectivity().checkConnectivity();

    if (connectivityResult == ConnectivityResult.none) {
      // If no internet, redirect to no-internet screen
      return const RouteSettings(name: '/no-internet');
    }
    return null; // Allow navigation
  }
}
