import 'package:flutter/material.dart';

class RepairRequestSummaryPage extends StatelessWidget {
  const RepairRequestSummaryPage({Key? key}) : super(key: key);

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
          "Repair Request Summary",
          style: TextStyle(
              color: Colors.black, fontSize: 12, fontFamily: "Roboto Flex"),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Your repair request summary is below",
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w600,
                fontFamily: "Roboto Flex",
              ),
            ),
            const SizedBox(height: 20),
            Card(
              color: Colors.white,
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.only(top: 16.0, left: 16, right: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        RichText(
                          text: const TextSpan(
                            text: "Your Device: ",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 15,
                                fontFamily: "Roboto Flex"),
                            children: [
                              TextSpan(
                                text: "Iphone",
                                style: TextStyle(
                                  color: Colors.blue,
                                  fontFamily: "Roboto Flex",
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                        Text(
                          "Selected Issues:",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 15,
                              fontFamily: "Roboto Flex"),
                        ),
                        Text(
                          "Screen Damage, Display Issues, Touch Issues",
                          style: TextStyle(
                              color: Colors.grey,
                              fontFamily: "Roboto Flex",
                              fontSize: 12),
                        ),

                        const SizedBox(height: 10),
                        const Text(
                          "Selected Technician:",
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w600,
                              fontFamily: "Roboto Flex"),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            CircleAvatar(
                              radius: 20,
                              backgroundImage: const NetworkImage(
                                  "https://via.placeholder.com/150"), // Replace with actual image URL
                            ),
                            //const SizedBox(width: 10),
                            Text(
                              "Guru Tech Ltd.",
                              style: TextStyle(
                                  fontSize: 14, fontWeight: FontWeight.w600),
                            ),
                            Row(
                              children: const [
                                Icon(Icons.location_on,
                                    color: Colors.grey, size: 16),
                                SizedBox(width: 4),
                                Text(
                                  "Janakpuri Delhi",
                                  style: TextStyle(
                                      color: Colors.grey, fontSize: 12),
                                ),
                              ],
                            ),

                            
                          ],
                        ),
                        // ),
                      ],
                    ),
                  ),
                  new Divider(
                    color: Color(0xffECF0F3),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 16.0),
                    child: Row(
                      children: [
                        Image.asset("assets/images/icons5.png"),
                        SizedBox(
                          width: 6,
                        ),
                        const Text("1 KM", style: TextStyle(fontSize: 12)),
                        const SizedBox(width: 74),
                        Row(
                          children: const [
                            Icon(Icons.star, color: Colors.amber, size: 16),
                            SizedBox(width: 4),
                            Text("3.9", style: TextStyle(fontSize: 12)),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 10),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Pickup Address",
                  style: TextStyle(fontSize: 17,fontFamily: "Roboto Flex", fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle update address
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 12,fontFamily: "Roboto Flex", color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Card(
              color: Colors.white,
              elevation: 1,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Row(
                  children: const [
                    Icon(Icons.location_on, color: Colors.grey, size: 16),
                    SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        "Magadi Main Rd, next to Prasanna Theatre, New Delhi, Janakpuri 110056",
                        style: TextStyle(color: Colors.grey,fontFamily: "Nunito Sans"),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  "Contact Information",
                  style: TextStyle(fontSize: 17,fontFamily: "Roboto Flex", fontWeight: FontWeight.w600),
                ),
                GestureDetector(
                  onTap: () {
                    // Handle update contact info
                  },
                  child: const Text(
                    "Update",
                    style: TextStyle(fontSize: 12,fontFamily: "Roboto Flex", color: Colors.blue),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  Text(
                    "Balram Agarwal",
                    style: TextStyle(
                        color: Color(0xff95989A),
                        fontSize: 12, 
                        fontFamily: "Roboto Flex",
                        ),
                  ),
                  SizedBox(height: 4),
                  Text("+91 - 9313484654",
                      style: TextStyle(fontSize: 12, 
                        fontFamily: "Roboto Flex",)),
                  SizedBox(height: 4),
                  Text("balramagarwal07@gmail.com",
                      style: TextStyle(fontSize: 12, 
                        fontFamily: "Roboto Flex",)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            new Divider(
                    color: Color(0xffFFFFFF),
                  ),
            Row(
              children: const [
                Icon(Icons.access_time, color: Colors.green, size: 16),
                SizedBox(width: 8),
                Text(
                  "Pickup Expected on 03 June 2025",
                  style: TextStyle(color: Colors.black),
                ),
              ],
            ),
            const Spacer(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextButton.icon(
                  onPressed: () {
                     Navigator.of(context).pop();

                    // Handle "Back" action
                  },
                  icon: const Icon(Icons.arrow_back, color: Colors.black),
                  label:
                      const Text("Back", style: TextStyle(color: Colors.black)),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Handle "Complete Request" action
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: const EdgeInsets.symmetric(
                        vertical: 16, horizontal: 24),
                  ),
                  child: const Text(
                    "Complete Request",
                    style: TextStyle(fontSize: 16, color: Colors.white,fontFamily: "Nunito Sans"),
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
