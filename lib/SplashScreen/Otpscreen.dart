import 'package:flutter/material.dart';

class Otppage extends StatefulWidget {
  const Otppage({super.key});

  @override
  State<Otppage> createState() => _OtppageState();
}

class _OtppageState extends State<Otppage> {
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
              height: 360, // Fixed height for the image
              fit: BoxFit
                  .cover, // Ensures the image covers its height proportionally
            ),
          ),
          Positioned(
            top: -40,
            left: -50,
            child: Image.asset(
              'assets/images/images1.png',
              height: 340, // Fixed height for the image
              fit: BoxFit
                  .cover, // Ensures the image covers its height proportionally
            ),
          ),
          Positioned(
            top: 270,
            right: 0,
            child: Image.asset(
              'assets/images/images2.png',
              height: 150, // Fixed height for the image
              fit: BoxFit
                  .cover, // Ensures the image covers its height proportionally
            ),
          ),
          Positioned(
            bottom: -100,
            right: -50,
            child: Image.asset(
              'assets/images/mass2.png',
              height: 400, // Fixed height for the image
              fit: BoxFit
                  .cover, // Ensures the image covers its height proportionally
            ),
          ),
          // Content
          //SizedBox(height: 140,),
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
                // Subtitle
                const Text(
                  "Good to see you back! ❤️",
                  style: TextStyle(
                    fontSize: 19,
                    fontFamily: 'Nunito Sans',
                    color: Colors.black54,
                  ),
                ),
                const SizedBox(height: 32),
                // Email TextField
                TextField(
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xffD2D2D2)),
                    filled: true,
                    fillColor: Color(0xffF8F8F8),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide.none,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                // Next Button
                ElevatedButton(
                  onPressed: () {
                    // Get.toNamed(MyPagesName.otpScreen);
                    // Add your logic here
                  },
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
                // Cancel Button
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
                SizedBox(
                  height: 35,
                )
              ],
            ),
          ),
          //
        ],
      ),
    );
  }


}