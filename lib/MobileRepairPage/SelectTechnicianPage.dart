import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class SelectTechnicianPage extends StatefulWidget {
  @override
  _SelectTechnicianPageState createState() => _SelectTechnicianPageState();
}

class _SelectTechnicianPageState extends State<SelectTechnicianPage> {
  int? selectedTechnicianIndex;

  final List<Map<String, dynamic>> technicians = [
    {"name": "Guru Tech", "location": "Janakpuri Delhi", "distance": "1 KM", "rating": 3.9},
    {"name": "Guru Tech", "location": "Janakpuri Delhi", "distance": "3 KM", "rating": 4.9},
    {"name": "Guru Tech", "location": "Janakpuri Delhi", "distance": "5 KM", "rating": 4.0},
    {"name": "Guru Tech", "location": "Janakpuri Delhi", "distance": "10 KM", "rating": 4.9},
    {"name": "Guru Tech", "location": "Janakpuri Delhi", "distance": "10 KM", "rating": 4.9},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffF2F2F2),
      appBar: AppBar(
        backgroundColor: Color(0xffF2F2F2),
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () {
             Navigator.of(context).pop();
            // Handle back navigation
          },
        ),
        title: const Text(
          "Select Technician",
          style: TextStyle(color: Colors.black,fontFamily: "Roboto Flex", fontSize: 12),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RichText(
              text: const TextSpan(
                text: "Best available technicians for ",
                style: TextStyle(color: Colors.black, fontSize: 17,fontFamily: "Roboto Flex", fontWeight: FontWeight.w600),
                children: [
                  TextSpan(
                    text: "Iphone",
                    style: TextStyle(color: Colors.blue,fontFamily: "Roboto Flex", fontWeight: FontWeight.w600),
                  ),
                  TextSpan(
                    text: " device for selected issues",
                  ),
                ],
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              "Screen Damage, Display Issues, Touch Issues",
              style: TextStyle(color: Color(0xff819AA9),fontFamily: "Roboto Flex", fontSize: 12),
            ),
            const SizedBox(height: 20),
            Expanded(
              child: GridView.builder(
                itemCount: technicians.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.9,
                ),
                itemBuilder: (context, index) {
                  final technician = technicians[index];
                  final isSelected = selectedTechnicianIndex == index;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedTechnicianIndex = index;
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey.shade300,
                          width: isSelected ? 2 : 1,
                        ),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 30,
                            backgroundImage: const NetworkImage(
                                "https://via.placeholder.com/150"), // Replace with real image URL
                          ),
                          const SizedBox(height: 8),
                          Text(
                            technician["name"],
                            style: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Icon(Icons.location_on_outlined, color: Colors.grey, size: 20),
                              const SizedBox(width: 4),
                              Text(
                                technician["location"],
                                style: const TextStyle(color: Colors.grey, fontSize: 12),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                           new Divider(
            color: Color(0xff95989A),
          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                               mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              //mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Row(
                                  children: [
                                    Image.asset("assets/images/icons5.png"),
                                    SizedBox(width: 8,),
                                    Text(
                                      technician["distance"],
                                      style: const TextStyle(color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                                const SizedBox(width: 10),
                                Row(
                                 
                                  children: [
                                    const Icon(Icons.star, color: Colors.amber, size: 16),
                                    const SizedBox(width: 4),
                                    Text(
                                      technician["rating"].toString(),
                                      style: const TextStyle(color: Colors.black, fontSize: 12),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                     Navigator.of(context).pop();
                    // Handle "Back" action
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  label: const Text(
                    "Back",
                    style: TextStyle(color: Colors.black),
                  ),
                ),
                ElevatedButton(
                  onPressed: selectedTechnicianIndex == null
                      ? null
                      : () {
                        Get.toNamed(MyPagesName.repairRequestSummaryPage);
                          // Handle "Continue" action
                        },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                  ),
                  child: const Text(
                    "Continue →",
                    style: TextStyle(fontSize: 16,color: Colors.white),
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