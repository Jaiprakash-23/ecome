import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController mobilenumber = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  bool _isLoading = false;
  Map<String, dynamic> data = {};

Future<void> login() async {
  if (!_formKey.currentState!.validate()) {
    // If validation fails, return early.
    return;
  }

  setState(() {
    _isLoading = true; // Show loading state.
  });

  try {
    var request =
        http.MultipartRequest('POST', Uri.parse('$BasseUrl/api/send-otp'));
    request.fields.addAll({
      'number': mobilenumber.text,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      String responseData = await response.stream.bytesToString();
      data = jsonDecode(responseData);

      if (data['status'] == false) {
        // Show error message if status is false
        Get.snackbar(
          "",
          data['message'],
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        // Save mobile number in SharedPreferences
        SharedPreferences prefs = await SharedPreferences.getInstance();
        await prefs.setString('mobile_number', mobilenumber.text);

        String name = data['name'] ?? 'Unknown';

        Get.snackbar(
          "Success",
          data['otp'].toString(),
          duration: const Duration(seconds: 5),
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.green,
          colorText: Colors.white,
        );

        // Navigate to OTP screen and pass the name
        Get.toNamed(
          MyPagesName.otpscreen,
          arguments: {'name': name},
        );
      }
    } else {
      String error = response.reasonPhrase ?? "Unknown error";
      Get.snackbar("Error", error, snackPosition: SnackPosition.BOTTOM);
    }
  } catch (e) {
    Get.snackbar("Error", "Something went wrong. Please try again.",
        snackPosition: SnackPosition.BOTTOM);
  } finally {
    setState(() {
      _isLoading = false; // Hide loading state.
    });
  }
}

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background images (same as before)
          Positioned(
            top: 0,
            left: -30,
            child: Image.asset(
              'assets/images/bubble002.png',
              height: 360,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: -40,
            left: -50,
            child: Image.asset(
              'assets/images/images1.png',
              height: 340,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 270,
            right: 0,
            child: Image.asset(
              'assets/images/images2.png',
              height: 150,
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: Image.asset(
              'assets/images/mass2.png',
              height: 400,
              fit: BoxFit.cover,
            ),
          ),

          // Form content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                const Text(
                  "Login",
                  style: TextStyle(
                    fontSize: 52,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Roboto Flex',
                    color: Colors.black,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  "Good to see you back! ❤️",
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Nunito Sans',
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                // Form
                Form(
                  key: _formKey,
                  child: TextFormField(
                    controller: mobilenumber,
                    keyboardType: TextInputType.phone,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
                      hintStyle: TextStyle(color: Color(0xffD2D2D2)),
                      filled: true,
                      fillColor: Color(0xffF8F8F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile number cannot be empty.";
                      } else if (value.length != 10 ||
                          !RegExp(r'^[0-9]+$').hasMatch(value)) {
                        return "Enter a valid 10-digit mobile number.";
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: _isLoading ? null : login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xff004CFF),
                    minimumSize: const Size(double.infinity, 61),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  child: _isLoading
                      ? CircularProgressIndicator(color: Colors.white)
                      : const Text(
                          "Next",
                          style: TextStyle(
                              fontSize: 22,
                              color: Colors.white,
                              fontFamily: 'Nunito Sans'),
                        ),
                ),
                const SizedBox(height: 16),
                Center(
                  child: TextButton(
                    onPressed: () {
                      // Get.toNamed(MyPagesName.loginPage);
                      // Add cancel logic here
                    },
                    child: const Text(
                      "Cancel",
                      style: TextStyle(
                          color: Colors.black54,
                          fontSize: 15,
                          fontFamily: 'Nunito Sans'),
                    ),
                  ),
                ),
                const SizedBox(height: 35),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
