import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MobileRepairPage extends StatefulWidget {
  @override
  _MobileRepairPageState createState() => _MobileRepairPageState();
}

class _MobileRepairPageState extends State<MobileRepairPage> {
  int selectedBrandIndex = -1;
  final List<String> brands = ["Samsung", "iPhone", "Oppo", "OnePlus"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
       // toolbarHeight: 70,
        backgroundColor: Color(0xffF2F2F2),
        //elevation: 10,
        leading: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Container(
                            height: 45,
                            width: 45,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                border:
                                    Border.all(color: Colors.white, width: 3)),
                          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: const [
            Text(
              "Balram Agarwal",
              style: TextStyle(color: Color(0xff000000), fontSize: 12,fontFamily: "Roboto Flex"),
            ),
            Row(
              children: [
                Icon(Icons.location_on_outlined,color: Color(0xff95989A),size: 12,),
                Text(
                  "Magadi Main Rd, next to Prasanna Theatre",
                  style: TextStyle(color: Color(0xff95989A), fontSize: 10),
                ),
              ],
            ),
          ],
        ),
        actions: const [
          Icon(Icons.notifications_none, color: Colors.black),
          SizedBox(width: 10),
        ],
        
      ),
      body: Column(
        children: [
           new Divider(
            color: Color(0xff95989A),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Column(
            
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  

                  const SizedBox(height: 10),
                  Center(
                    child: const Text(
                      "MOBILE REPAIR",
                      style: TextStyle(
                        color: Color(0xff1580C3),
                        fontSize: 12,
                        fontFamily: "Roboto Flex",
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5),
                  Center(
                    child: const Text(
                      "Find your On-Demand\n       Service Worker",
                      style: TextStyle(
                        fontSize: 22,
                        fontFamily: "Roboto Flex",
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    "Select Brand",
                    style: TextStyle(
                      fontSize: 12,
                      fontFamily: "Roboto Flex",
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: GridView.builder(
                      itemCount: brands.length * 4, // Repeating brands
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 4,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemBuilder: (context, index) {
                        int brandIndex = index % brands.length;
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedBrandIndex = index;
                            });
                           
                          },
                          child: Container(
                            decoration: BoxDecoration(
                              color: selectedBrandIndex == index
                                  ? Colors.blue[50]
                                  : Colors.white,
                              border: Border.all(
                                color: selectedBrandIndex == index
                                    ? Colors.blue
                                    : Colors.grey,
                              ),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Center(
                              child: Text(
                                brands[brandIndex],
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: selectedBrandIndex == index
                                      ? Colors.blue
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                  const Center(
                    child: Text(
                      "See More...",
                      style: TextStyle(
                        fontSize: 12, 
                        fontFamily: "Roboto Flex",
                        color: Color(0xff1580C3),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                       Get.toNamed(MyPagesName.selectIssuesPage);
                      // Handle "Continue" action
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xff000000),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      minimumSize: const Size(double.infinity, 50),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text(
                          "Continue ",
                          style: TextStyle(fontSize: 16,
                          fontFamily: "Nunito Sans",
                          color: Color(0xffFFFFFF),
                          fontWeight: FontWeight.normal
                        
                          ),
                        ),
                        Icon(Icons.arrow_forward,color: Color(0xffFFFFFF),)
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ),
        ],
      ),
      
   
    );
  }
}