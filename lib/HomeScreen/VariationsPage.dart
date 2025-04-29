import 'package:flutter/material.dart';

class VariationsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Dummy data for variations
    final variations = [
      {"color": "Grey", "image": "assets/grey_shoe.png"},
      {"color": "Yellow", "image": "assets/yellow_mic.png"},
      {"color": "White", "image": "assets/white_sneaker.png"},
      {"color": "Green", "image": "assets/green_skirt.png"},
      {"color": "Black", "image": "assets/black_sweater.png"},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text("Variations"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Variations",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            Expanded(
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: variations.length,
                separatorBuilder: (context, index) => SizedBox(width: 16),
                itemBuilder: (context, index) {
                  final item = variations[index];
                  return Column(
                    children: [
                      Stack(
                        alignment: Alignment.topRight,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage: AssetImage(item['image']!),
                          ),
                          if (index == 1) // Add checkmark for selected item
                            Positioned(
                              top: 4,
                              right: 4,
                              child: CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        item['color']!,
                        style: TextStyle(fontSize: 16),
                      ),
                    ],
                  );
                },
              ),
            ),
          
          
          ],
        ),
      ),
    );
  }
}
