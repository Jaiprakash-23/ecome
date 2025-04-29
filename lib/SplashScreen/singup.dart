import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class Singup extends StatefulWidget {
  const Singup({super.key});

  @override
  State<Singup> createState() => _SingupState();
}

class _SingupState extends State<Singup> {
  final _formKey = GlobalKey<FormState>(); // Add _formKey
  TextEditingController name = TextEditingController();
  TextEditingController number = TextEditingController();

  Future<void> signup() async {
    if (!_formKey.currentState!.validate()) {
      // If the form is not valid, return early
      return;
    }

    var request = http.MultipartRequest(
        'POST', Uri.parse('https://ensantehealth.com/owngears/public/api/signup'));
    request.fields.addAll({
      'name': name.text,
      'number': number.text,
    });

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
       Get.snackbar(
        "Registered successfully",
        response.reasonPhrase ?? "Registered successfully",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.toNamed(MyPagesName.loginPage);
    } else {
      print(response.reasonPhrase);
      Get.snackbar(
        "Signup Failed",
        response.reasonPhrase ?? "An unknown error occurred",
        snackPosition: SnackPosition.TOP,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          // Background blobs
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
          // Content
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Form(
              key: _formKey, // Wrap the form with Form widget and attach _formKey
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Signup",
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
                  TextFormField(
                    controller: name,
                    decoration: InputDecoration(
                      hintText: "Enter Your Name",
                      hintStyle: TextStyle(color: Color(0xffD2D2D2)),
                      filled: true,
                      fillColor: Color(0xffF8F8F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Name cannot be empty";
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 15),
                  TextFormField(
                    controller: number,
                    decoration: InputDecoration(
                      hintText: "Enter Mobile Number",
                      hintStyle: TextStyle(color: Color(0xffD2D2D2)),
                      filled: true,
                      fillColor: Color(0xffF8F8F8),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(19),
                        borderSide: BorderSide.none,
                      ),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Mobile Number cannot be empty";
                      }
                      if (!RegExp(r'^\d+$').hasMatch(value)) {
                        return "Enter a valid mobile number";
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: signup,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff004CFF),
                      minimumSize: const Size(double.infinity, 61),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: const Text(
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
                  SizedBox(height: 35),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
