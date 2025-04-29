import 'dart:convert';

import 'package:ecome/Dashbord.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class OtpScreen extends StatefulWidget {
  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  final List<TextEditingController> _controllers = List.generate(
    4,
    (index) => TextEditingController(),
  );

  bool _isLoading = false;

  Future<void> _verifyOtp(String otp) async {
    setState(() {
      _isLoading = true;
    });

    try {
      final request = http.MultipartRequest(
        'POST',
        Uri.parse('https://ensantehealth.com/owngears/public/api/verify-otp'),
      );
      request.fields['otp'] = otp;

      final response = await request.send();

      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        final jsonResponse = json.decode(responseData);

        if (jsonResponse['status'] == true) {
          print("OTP Verified: $responseData");
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Dashboard()),
          );
        } else {
          print("OTP Verification Failed: $responseData");
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(jsonResponse['message'] ?? "Invalid OTP! Please try again."),
            ),
          );
        }
      } else {
        final errorMessage = await response.stream.bytesToString();
        print("Server Error: $errorMessage");
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Something went wrong. Please try again.")),
        );
      }
    } catch (e) {
      print("Error during OTP verification: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Something went wrong. Please try again.")),
      );
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _handleOtpChange(String value, int index) {
    if (value.isNotEmpty) {
      if (index < _controllers.length - 1) {
        FocusScope.of(context).nextFocus(); // Move to the next field
      } else {
        // When the last field is filled, combine OTP and send to the server
        String enteredOtp = _controllers.map((c) => c.text).join();
        _verifyOtp(enteredOtp);
      }
    } else if (value.isEmpty && index > 0) {
      // Move focus to the previous field if the current field is empty
      FocusScope.of(context).previousFocus();
    }
  }

  @override
  void dispose() {
    for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // Safely retrieve the name argument or default to 'Guest'
    final String name = Get.arguments?['name']?.toString() ?? 'Guest';

    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: -30,
            child: Image.asset(
              'assets/images/mass.png',
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 106,
                  width: 106,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: Colors.white,
                    border: Border.all(
                      color: Colors.white,
                      width: 8.0,
                    ),
                  ),
                  child: Container(
                    height: 106,
                    width: 106,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.black,
                      image: DecorationImage(
                        image: AssetImage('assets/images/artist.png'),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  "Hello, ${name[0].toUpperCase()}${name.substring(1).toLowerCase()}!!",
                  style: TextStyle(
                    fontSize: 28,
                    fontFamily: 'Roboto Flex',
                    color: Color(0xff202020),
                  ),
                ),
                const SizedBox(height: 15),
                const Text(
                  "Enter Your OTP",
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Nunito Sans',
                    color: Color(0xff000000),
                  ),
                ),
                const SizedBox(height: 32),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextField(
                        controller: _controllers[index],
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        maxLength: 1,
                        onChanged: (value) => _handleOtpChange(value, index),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.only(left: 190),
                  child: GestureDetector(
                    onTap: () {
                      // Resend OTP logic
                    },
                    child: Text(
                      "Resend OTP",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Submit OTP',
                        style: TextStyle(fontSize: 15, fontFamily: 'Nunito Sans'),
                      ),
                      const SizedBox(width: 10),
                      _isLoading
                          ? CircularProgressIndicator()
                          : ElevatedButton(
                              onPressed: () {
                                String enteredOtp =
                                    _controllers.map((c) => c.text).join();
                                _verifyOtp(enteredOtp);
                              },
                              style: ElevatedButton.styleFrom(
                                shape: CircleBorder(),
                                padding: EdgeInsets.all(14),
                                backgroundColor: Color(0xff004CFF),
                              ),
                              child: const Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
