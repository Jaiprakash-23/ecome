import 'package:flutter/material.dart';

class RepairRequestDetailsPage extends StatelessWidget {
  const RepairRequestDetailsPage({Key? key}) : super(key: key);

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
            // Handle back navigation
          },
        ),
        title: const Text(
          "Repair Request Summary",
          style: TextStyle(
              color: Colors.black, fontSize: 16, fontFamily: "Roboto Flex"),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            new Divider(
              color: Color(0xffE7E8EB),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    "Order Number: OD426748484989",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto Flex",
                        color: Color(0xff707070)),
                  ),
                  const SizedBox(height: 4),
                  const Text(
                    "Order Date: 24th April 2025",
                    style: TextStyle(
                        fontSize: 12,
                        fontFamily: "Roboto Flex",
                        color: Color(0xff707070)),
                  ),
                ],
              ),
            ),
            new Divider(
              color: Color(0xffE7E8EB),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: const TextSpan(
                      text: "Repair Status: ",
                      style: TextStyle(
                          color: Colors.black,
                          fontFamily: "Roboto Flex",
                          fontSize: 17),
                      children: [
                        TextSpan(
                          text: "Picked Up",
                          style: TextStyle(
                              color: Color(0xffFB09FF),
                              fontFamily: "Roboto Flex",
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  Card(
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            "Your Device: Iphone",
                            style: TextStyle(
                              fontSize: 15,
                              fontFamily: "Roboto Flex",
                            ),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            "Selected Issues: ",
                            style: TextStyle(
                                fontSize: 15,
                                fontFamily: "Roboto Flex",
                                color: Color(0xff000000)),
                          ),
                          const Text(
                            "Screen Damage, Display Issues, Touch Issues",
                            style: TextStyle(
                                fontSize: 12,
                                fontFamily: "Roboto Flex",
                                color: Color(0xff819AA9)),
                          ),
                          const Divider(
                              height: 24, thickness: 1, color: Colors.grey),
                          Row(
                            children: [
                              Icon(Icons.location_on,
                                  color: Colors.grey, size: 26),
                              SizedBox(width: 4),
                              const Text(
                                "Magadi Main Rd, next to Prasanna Theatre,\n New Delhi, Janakpuri 110056",
                                style: TextStyle(
                                    fontSize: 14,
                                    fontFamily: "Nunito Sans",
                                    color: Color(0xff95989A)),
                              ),
                            ],
                          ),
                          const Divider(
                              height: 24, thickness: 1, color: Colors.grey),
                          //const SizedBox(height: 8),
                          Padding(
                            padding: const EdgeInsets.only(left: 25),
                            child: const Text(
                              "Balram Agarwal\n+91 - 9313484654\nbalramagarwal07@gmail.com",
                              style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: "Roboto Flex",
                                  color: Color(0xff95989A)),
                            ),
                          ),
                          const Divider(
                              height: 24, thickness: 1, color: Colors.grey),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Selected Technician:",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontFamily: "Roboto Flex",
                                ),
                              ),
                              Container(
                                height: 20,
                                width: 53,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(3),
                                    border:
                                        Border.all(color: Color(0xff1580C3))),
                                child: Row(
                                  children: [
                                    Icon(Icons.call,
                                        size: 16, color: Color(0xff1580C3)),
                                    Text("Call",
                                        style: TextStyle(
                                            fontFamily: "Roboto Flex",
                                            color: Color(0xff1580C3)))
                                  ],
                                ),
                              )
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
  mainAxisAlignment: MainAxisAlignment.spaceBetween,
  children: [
    // Left Section: Technician Details
    Row(
      children: [
        CircleAvatar(
          radius: 20,
          backgroundImage: const NetworkImage(
              "https://via.placeholder.com/150"), // Replace with actual image URL
        ),
        const SizedBox(width: 10),
        const Text(
          "Guru Tech Ltd.",
          style: TextStyle(
            fontSize: 15,
            fontFamily: "Roboto Flex",
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    ),
    
    // Right Section: Rating and Action Buttons
    Row(
      children: [
        Row(
          children: const [
            Icon(Icons.star, color: Colors.amber, size: 16),
            SizedBox(width: 4),
            Text("3.9", style: TextStyle(fontSize: 12)),
          ],
        ),
      ],
    ),
  ],
),


                          const Divider(
                              height: 24, thickness: 1, color: Colors.grey),
                          Row(
                            children: const [
                              Icon(Icons.location_on_outlined,
                                  color: Color(0xff95989A), size: 16),
                              SizedBox(width: 8),
                              Text(
                                "Janakpuri Delhi, West New Delhi 110056",
                                style: TextStyle(color: Color(0xff95989A),fontFamily: "Nunito Sans",fontSize: 10),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  Row(
                            children: const [
                              Icon(Icons.access_time,
                                  color: Color(0xff3FFFB2), size: 16),
                              SizedBox(width: 8),
                              Text(
                                "Pickup is in process",
                                style: TextStyle(color: Colors.black),
                              ),
                            ],
                          ),
                           const SizedBox(height: 20),
                  Center(
                    child: ElevatedButton.icon(
                      onPressed: () {
                        // Handle Track Order action
                      },
                      icon: const Icon(Icons.navigation,
                          size: 16, color: Colors.white),
                      label: const Text("Track order",
                          style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 40, vertical: 12),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
