import 'package:flutter/material.dart';

class RepairHistoryPage extends StatelessWidget {
  final List<Map<String, dynamic>> repairHistory = [
    {
      "deviceLogo":
          "assets/images/iphone.png", // Replace with actual image URL
      "status": "Picked Up Done",
      "statusColor": Colors.green,
      "issues": "Screen Damage, Display Issues...",
      "orderNumber": "#92287157",
      "rating": 0, // No rating given yet
      "deviceName": "iPhone"
    },
    {
      "deviceLogo":
          "assets/images/oneplus.png", 
      "status": "Repair Done",
      "statusColor": Colors.green,
      "issues": "Screen Damage, Display Issues...",
      "orderNumber": "#92287157",
      "rating": 0, // No rating given yet
      "deviceName": "OnePlus"
    }
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        title: Row(
          children: [
            CircleAvatar(
                      radius: 24,
                      backgroundImage: NetworkImage(
                          "https://via.placeholder.com/150"), // Replace with actual user profile image URL
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Balram Agarwal",
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                        "Magadi Main Rd, next to Prasanna Theatre...",
                        style: TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                        ],
                      ),
                    ), 
          ],
        ),
       backgroundColor: Color(0xffFFFFFF),
        elevation: 0,
       actions: [
        IconButton(
                  icon: const Icon(Icons.notifications_outlined),
                  onPressed: () {
                    // Handle notification click
                  },
                ),

       ],
        
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          new Divider(
          color: Color(0xffE7E8EB),
        ),
          // Profile Section
          // Row(
          //   children: [
          //     const CircleAvatar(
          //       radius: 24,
          //       backgroundImage: NetworkImage(
          //           "https://via.placeholder.com/150"), // Replace with actual user profile image URL
          //     ),
          //     const SizedBox(width: 12),
          //     Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: const [
          //         Text(
          //           "Balram Agarwal",
          //           style: TextStyle(
          //             fontSize: 16,
          //             fontWeight: FontWeight.bold,
          //           ),
          //         ),
          //         Text(
          //           "Magadi Main Rd, next to Prasanna Theatre...",
          //           style: TextStyle(color: Colors.grey, fontSize: 12),
          //         ),
          //       ],
          //     ),
          //     const Spacer(),
          //     IconButton(
          //       icon: const Icon(Icons.notifications_outlined),
          //       onPressed: () {
          //         // Handle notification click
          //       },
          //     ),
          //   ],
          // ),
         
         
          const SizedBox(height: 16),
          Center(
            child: const Text(
              "My Repair History",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 16),
      Divider(color: Colors.grey, thickness: 0.5),
          // Repair History List
          Expanded(
            child: ListView.separated(
              itemCount: repairHistory.length,
              separatorBuilder: (context, index) =>
                  const Divider(color: Colors.grey, thickness: 0.5),
              itemBuilder: (context, index) {
                final repairItem = repairHistory[index];
                return ListTile(
                  leading: Image.asset(
                    repairItem["deviceLogo"],
                    width: 50,
                    height: 50,
                    fit: BoxFit.contain,
                  ),
                  title: Text(
                    repairItem["status"],
                    style: TextStyle(
                      color: repairItem["statusColor"],
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        repairItem["issues"],
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        "Order ${repairItem["orderNumber"]}",
                        style: const TextStyle(fontSize: 12),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          ...List.generate(
                            5,
                            (starIndex) => Icon(
                              starIndex < repairItem["rating"]
                                  ? Icons.star
                                  : Icons.star_border,
                              color: Colors.amber,
                              size: 16,
                            ),
                          ),
                          const SizedBox(width: 8),
                         
                        ],
                      ),
                       const Text(
                            "Rate the technician",
                            style: TextStyle(
                              color: Colors.grey,
                              fontSize: 12,
                            ),
                          ),
                    ],
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Navigate to detailed repair history page
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

