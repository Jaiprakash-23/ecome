import 'package:flutter/material.dart';

class ProductPage extends StatefulWidget {
  @override
  _ProductPageState createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  String selectedColor = "Yellow";
  String selectedSize = "M";
  int quantity = 1;
    final List<String> images = [
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
    'assets/images/image1.png',
  ];

  // Index of the selected image
  int selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final colors = ["Grey", "Yellow", "White", "Green", "Black"];
    final sizes = [
      {"label": "S", "enabled": true},
      {"label": "M", "enabled": true},
      {"label": "L", "enabled": true},
      {"label": "XL", "enabled": true},
      {"label": "XXL", "enabled": false},
      {"label": "XXXL", "enabled": false},
    ];
    

    return Scaffold(
      // appBar: AppBar(
      //   title: Text("Product Page"),
      //   backgroundColor: Colors.white,
      //   elevation: 0,
      //   foregroundColor: Colors.black,
      // ),
      body: SingleChildScrollView(
       // padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Product Image
            Container(
              height: 380,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(0),
                image: DecorationImage(
                  image: AssetImage('assets/images/detailpage.png'), // Replace with your image asset
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Row(
             // mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  height: 75, 
                  width: 75,
                 // color: Colors.amber,
                  decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/images/detailpage.png'))),
                ),
                SizedBox(width: 9,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "\$17.00",
                      style: TextStyle(
                        fontSize: 26,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        Container(
                          height: 25, 
                          width: 50, 
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Color(0xffE5EBFC)),
                          child: Center(
                            child: Text(
                            "Pink",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color(0xff000000),
                              fontSize: 14,
                            ),
                                                    ),
                          ),
                        ),
                        SizedBox(width: 9,),
                         Container(
                          height: 25, 
                          width: 50, 
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Color(0xffE5EBFC)),
                          child: Center(
                            child: Text(
                            "M",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color(0xff000000),
                              fontSize: 14,
                            ),
                                                    ),
                          ),
                        ),
                        
                      ],
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 24),

            Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Color Options",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16),
            // Horizontal list of images
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(images.length, (index) {
                  final isSelected = index == selectedIndex;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(horizontal: 8),
                      width: 80,
                      height: 80,
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: isSelected ? Colors.blue : Colors.transparent,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                        image: DecorationImage(
                          image: AssetImage(images[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: isSelected
                          ? Align(
                              alignment: Alignment.topLeft,
                              child: Container(
                                margin: EdgeInsets.all(4),
                                width: 20,
                                height: 20,
                                decoration: BoxDecoration(
                                  color: Colors.black.withOpacity(0.7),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                            )
                          : null,
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
            // Text(
            //   "Color Options",
            //   style: TextStyle(fontSize: 17,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
            // ),
            //   SizedBox(height: 8),
            // Row(
            //   mainAxisAlignment: MainAxisAlignment.start,
            //   children: colors.map((color) {
            //     final isSelected = color == selectedColor;
            //     return GestureDetector(
            //       onTap: () {
            //         setState(() {
            //           selectedColor = color;
            //         });
            //       },
            //       child: Container(
            //         margin: EdgeInsets.symmetric(horizontal: 4),
            //         padding: EdgeInsets.all(4),
            //         decoration: BoxDecoration(
            //           border: Border.all(
            //             color: isSelected ? Colors.black : Colors.transparent,
            //             width: 2,
            //           ),
            //           shape: BoxShape.circle,
            //         ),
            //         child: CircleAvatar(
            //           backgroundColor: color == "Yellow"
            //               ? Colors.yellow
            //               : color == "Grey"
            //                   ? Colors.grey
            //                   : color == "White"
            //                       ? Colors.white
            //                       : color == "Green"
            //                           ? Colors.green
            //                           : Colors.black,
            //           radius: 24,
            //         ),
            //       ),
            //     );
            //   }).toList(),
            // ),
            SizedBox(height: 24),

            // Size Options
            Text(
              "Size",
              style: TextStyle(fontSize: 17,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: sizes.map((size) {
                final isEnabled = size["enabled"] == true;
                final isSelected = size["label"] == selectedSize;
                return GestureDetector(
                  onTap: isEnabled
                      ? () {
                          setState(() {
                            selectedSize = "${size["label"]!}";
                          });
                        }
                      : null,
                  child: Container(
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    padding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Colors.blue.shade50
                          : isEnabled
                              ? Colors.white
                              : Colors.grey.shade200,
                      border: isSelected
                          ? Border.all(color: Colors.black, width: 1.5)
                          : null,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      "${size["label"]!}",
                      style: TextStyle(
                        color: isEnabled ? Colors.black : Colors.grey,
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            SizedBox(height: 24),

           Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              "Quantity",
              style: TextStyle(fontSize: 17,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                     setState(() {
                            quantity--;
                          });
                      //  quantity > 1
                      // ? () {
                         
                      //   }
                      // : null;

                  },
                  child: Container(
                    height: 50, 
                    width: 50, 
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black)),
                    child: Center(child: Icon(Icons.remove)),
                  ),
                ),
                SizedBox(width: 8,),
                // IconButton(
                //   onPressed: quantity > 1
                //       ? () {
                //           setState(() {
                //             quantity--;
                //           });
                //         }
                //       : null,
                //   icon: Icon(Icons.remove),
                // ),
                Container(
                  height: 50, 
                  width: 75, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xffE5EBFC)),
                  child: Center(
                    child: Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 16),
                                    ),
                  ),
                ),
                 SizedBox(width: 8,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      quantity++;
                    });

                  },
                  child: Container(
                      height: 50, 
                      width: 50, 
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black)),
                      child: Center(child: Icon(Icons.add)),
                    ),
                ),
                 SizedBox(width: 8,),
                // IconButton(
                //   onPressed: () {
                //     setState(() {
                //       quantity++;
                //     });
                //   },
                //   icon: Icon(Icons.add),
                // ),
              ],
            ),
          

            ],
           ),
            
          
         
         
           SizedBox(height: 24),

            // Buttons
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: BorderSide(color: Colors.grey.shade300),
                    ),
                  ),
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.black,
                  ),
                ),
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: Text(
                        "Add to cart",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.amber.shade700,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: Text(
                      "Buy now",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
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
  }
}
