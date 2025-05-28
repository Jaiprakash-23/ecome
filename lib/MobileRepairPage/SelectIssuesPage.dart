import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SelectIssuesPage extends StatefulWidget {
  @override
  _SelectIssuesPageState createState() => _SelectIssuesPageState();
}

class _SelectIssuesPageState extends State<SelectIssuesPage> {
  final List<String> issues = [
    "Screen Damage",
    "Battery Replacement",
    "Folder Broken",
    "Mic Issue",
    "Sound Issue",
    "Display Issues",
    "Mother Board",
    "Touch Issue"
  ];

  final Set<int> selectedIssues = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black,size: 20,),
          onPressed: () {
            Navigator.of(context).pop();
            // Handle back navigation
          },
        ),
        title: const Text(
          "Select Issues",
          style: TextStyle(color: Colors.black, fontSize: 12,fontFamily: "Roboto Flex"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
  text: TextSpan(
    text: "Select issues of your ",
    style: const TextStyle(
      fontSize: 17,
      fontWeight: FontWeight.w600,
      color: Colors.black,
      fontFamily: "Roboto Flex"
    ),
    children: [
      TextSpan(
        text: "Iphone",
        style: const TextStyle(
          color: Colors.blue,
          fontWeight: FontWeight.w600,
          fontFamily: "Roboto Flex"
        ),
      ),
      const TextSpan(
        text: " device",
      ),
    ],
  ),
),

            const SizedBox(height: 20),
            Expanded(
              child: 
              GridView.builder(
                itemCount: issues.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3,
                ),
                itemBuilder: (context, index) {
  return GestureDetector(
    onTap: () {
      setState(() {
        if (selectedIssues.contains(index)) {
          selectedIssues.remove(index);
        } else {
          selectedIssues.add(index);
        }
      });
    },
    child: Container(
      decoration: BoxDecoration(
        color: selectedIssues.contains(index) ? Colors.blue[50] : Colors.white,
        border: Border.all(
          color: selectedIssues.contains(index) ? Colors.blue : Colors.grey,
        ),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (selectedIssues.contains(index))
            const Icon(
              Icons.check,
              color: Colors.blue,
              size: 20,
            ),
          if (selectedIssues.contains(index))
            const SizedBox(width: 8), // Add spacing between the icon and text
          Text(
            issues[index],
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w600,
              fontFamily: "Roboto Flex",
              color: selectedIssues.contains(index) ? Colors.blue : Colors.black,
            ),
          ),
        ],
      ),
    ),
  );
},

                // itemBuilder: (context, index) {
                //   return GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         if (selectedIssues.contains(index)) {
                //           selectedIssues.remove(index);
                //         } else {
                //           selectedIssues.add(index);
                //         }
                //       });
                //     },
                //     child: Container(
                //       decoration: BoxDecoration(
                //         color: selectedIssues.contains(index)
                //             ? Colors.blue[50]
                //             : Colors.white,
                //         border: Border.all(
                //           color: selectedIssues.contains(index)
                //               ? Colors.blue
                //               : Colors.grey,
                //         ),
                //         borderRadius: BorderRadius.circular(8),
                //       ),
                //       child: Center(
                //         child: Text(
                //           issues[index],
                //           style: TextStyle(
                //             fontSize: 14,
                //             fontWeight: FontWeight.w600,
                //             color: selectedIssues.contains(index)
                //                 ? Colors.blue
                //                 : Colors.black,
                //           ),
                //         ),
                //       ),
                //     ),
                //   );
                // },
              
              
              
              ),
           
           
            ),
            Center(
              child: SizedBox(
                height: 330,
                child: Image.asset(
                  "assets/images/reparing1.png",
                  fit: BoxFit.cover,
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  label: const Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {
                    Get.toNamed(MyPagesName.selectTechnicianPage);
                    // Handle "Continue" action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 6),
                  ),
                  child: const Text(
                    "     Continue →    ",
                    style: TextStyle(fontSize: 16,fontFamily: "Nunito Sans",color: Color(0xffFFFFFF)),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}