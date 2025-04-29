import 'package:flutter/material.dart';


class CategoriesPage extends StatefulWidget {
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
  // List of main categories
 final List<Map<String, dynamic>> _categories = [
  {
    "title": "Clothing",
    "icon": Icons.checkroom,
    "image": "assets/images/detailpage.png",
  },
  {
    "title": "Shoes",
    "icon": Icons.sports_kabaddi,
    "image": "assets/images/detailpage.png",
  },
  {
    "title": "Bags",
    "icon": Icons.shopping_bag,
    "image": "assets/images/detailpage.png",
  },
  {
    "title": "Lingerie",
    "icon": Icons.favorite,
    "image": "assets/images/detailpage.png",
  },
  {
    "title": "Accessories",
    "icon": Icons.style,
    "image": "assets/images/detailpage.png",
  },
];

  // Common subcategories for all main categories
  final List<String> _subcategories = [
    "Dresses",
    "Pants",
    "Skirts",
    "Shorts",
    "Jackets",
    "Hoodies",
    "Shirts",
    "Polo",
    "T-Shirts",
    "Tunics",
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "All Categories",
          style: TextStyle(
            fontSize: 28, 
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            color: Colors.black),
        ),
        //centerTitle: true,
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView.builder(
  itemCount: _categories.length + 1, // Add 1 for the "Just for You" card
  itemBuilder: (context, index) {
    if (index < _categories.length) {
      // Existing category cards
      return Card(
        margin: EdgeInsets.only(bottom: 16.0),
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Theme(
          data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
          child: ExpansionTile(
            leading: CircleAvatar(
              radius: 24,
              backgroundImage: AssetImage(
                'assets/images/detailpage.png',
              ),
            ),
            title: Text(
              _categories[index]["title"],
              style: TextStyle(fontWeight: FontWeight.bold,
              fontFamily: 'Raleway' ,
              fontSize: 17
              ),
            ),
            trailing: Icon(
              Icons.expand_more,
              color: Colors.black,
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  alignment: WrapAlignment.start,
                  children: _subcategories.map((sub) {
                    return SizedBox(
                      width: (MediaQuery.of(context).size.width - 64) / 2,
                      child: ElevatedButton(
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.white,
                          foregroundColor: Colors.black,
                          shape: RoundedRectangleBorder(
                            side: BorderSide(color: Color(0xffFFEBEB)),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          elevation: 0,
                          padding: EdgeInsets.symmetric(vertical: 12.0),
                        ),
                        child: Text(
                          sub,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',

                            fontSize: 15.0),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ),
            ],
          ),
        ),
      );
    } else {
      // "Just for You" card after all categories
      return Card(
        elevation: 4,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(1.0),
          child: Theme(
              data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              leading: CircleAvatar(
                radius: 24,
                backgroundImage: AssetImage(
                  'assets/images/detailpage.png',
                ),
              ),
              title: Text(
                'Just for You',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              trailing: Container(
                height: 30, 
                width: 30, 
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color:Colors.black),
                child: Icon(Icons.arrow_forward,color: Colors.white,),
              ),
            
            ),
          )
        ),
      );
    }
  },



)

        // Column(
        //   children: [
        //     Expanded(
        //       child: ListView.builder(
        //         itemCount: _categories.length,
        //         itemBuilder: (context, index) {
        //           return Card(
        //             margin: EdgeInsets.only(bottom: 16.0),
        //             elevation: 4,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //             child: Theme(
        //               data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        //               child: ExpansionTile(
        //                 leading: CircleAvatar(
        //                   radius: 24,
        //                   backgroundImage: AssetImage(
        //                     _categories[index]["image"], // Load category-specific image
        //                   ),
        //                 ),
        //                 title: Text(
        //                   _categories[index]["title"],
        //                   style: TextStyle(fontWeight: FontWeight.bold),
        //                 ),
        //                 trailing: Icon(
        //                   Icons.expand_more,
        //                   color: Colors.black,
        //                 ),
        //                 children: [
        //                   Padding(
        //                     padding: const EdgeInsets.all(12.0),
        //                     child: Wrap(
        //                       spacing: 8.0, // Horizontal spacing
        //                       runSpacing: 8.0, // Vertical spacing
        //                       alignment: WrapAlignment.start,
        //                       children: _subcategories.map((sub) {
        //                         return SizedBox(
        //                           width: (MediaQuery.of(context).size.width - 64) /
        //                               2, // 2 buttons per row
        //                           child: ElevatedButton(
        //                             onPressed: () {
        //                               // Handle subcategory button click
        //                             },
        //                             style: ElevatedButton.styleFrom(
        //                               backgroundColor: Colors.white,
        //                               foregroundColor: Colors.black,
        //                               shape: RoundedRectangleBorder(
        //                                 side: BorderSide(color: Colors.grey.shade300),
        //                                 borderRadius: BorderRadius.circular(8.0),
        //                               ),
        //                               elevation: 0,
        //                               padding: EdgeInsets.symmetric(vertical: 12.0),
        //                             ),
        //                             child: Text(
        //                               sub,
        //                               textAlign: TextAlign.center,
        //                               style: TextStyle(fontSize: 14.0),
        //                             ),
        //                           ),
        //                         );
        //                       }).toList(),
        //                     ),
        //                   ),
        //                 ],
        //               ),
        //             ),
        //           );
        //         },
        //       ),
        //     ),
         
        //  Card(
        //    elevation: 4,
        //             shape: RoundedRectangleBorder(
        //               borderRadius: BorderRadius.circular(12.0),
        //             ),
        //             child: Text('Just for You'),

        //  )
        //   ],
        // ),
     
     
      ),
    );
  }
}
