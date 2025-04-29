import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';

class MyOrdersPage extends StatelessWidget {
  final List<Map<String, String>> orders = [
    {
      'status': 'Arriving Today',
      'date': '',
      'image': 'assets/image1.jpg',
      'orderId': '92287157',
      'description': 'Lorem ipsum dolor sit amet conse ...',
    },
    {
      'status': 'Arriving on Thursday',
      'date': '',
      'image': 'assets/image2.jpg',
      'orderId': '92287157',
      'description': 'Lorem ipsum dolor sit amet conse ...',
    },
    {
      'status': 'Delivered on 6th April 2025',
      'date': '',
      'image': 'assets/image3.jpg',
      'orderId': '92287157',
      'description': 'Lorem ipsum dolor sit amet conse ...',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Color(0xffE7E8EB),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
              Navigator.of(context).pop();
            },
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff004CFF)),
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
            ),
          ),
        ),
        // IconButton(
        //   icon: Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: Text("My Orders",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Roboto Flex',
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
     
      body: 
      ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Padding(
            padding: const EdgeInsets.only(top: 2),
            child: GestureDetector(
              onTap: (){
                Get.toNamed(MyPagesName.orderDetailsPage);
              },
              child: Container(
                height: 139, 
                width: double.infinity, 
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Container(
                        height: 90, 
                        width: 92, 
                        decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Colors.amber),
                      ),
                      SizedBox(width: 17,),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                        order['status']!,
                        style: TextStyle(
                          color: Colors.green,
                          fontFamily: 'Roboto Flex',
                          fontSize: 13
                        ),),
                         SizedBox(height: 4),
                      Text(order['description']!,style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12),),
                      SizedBox(height: 4),
                      Text(
                        'Order #${order['orderId']}',
                        style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 12
                        ),
                      ),
                      SizedBox(height: 4),
                      Row(
                        children: List.generate(
                          5,
                          (starIndex) => Icon(
                            Icons.star_border,
                            size: 20,
                            color: Colors.grey,
                          ),
                        ),
                      ),
                      SizedBox(height: 4),
                      Text(
                        'Rate this product now',
                        style: TextStyle(
                          color: Colors.blue,
                          fontSize: 12,
                          fontFamily: 'Roboto Flex'
                        ),
                      ),
                    ],
                  ),
                  SizedBox(width: 29,),
                     Icon(Icons.arrow_forward_ios,size: 12,),
                    ],
                  ),
                ),
              ),
            ),
          );
          // Card(
          //   margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          //   child: ListTile(
          //     leading: Container(
          //       height: 240, 
          //       width: 92, 
          //       decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Colors.amber),
          //     ),
          //     title: Column(
          //       crossAxisAlignment: CrossAxisAlignment.start,
          //       children: [
          //         Text(
          //           order['status']!,
          //           style: TextStyle(
          //             color: Colors.green,
          //             fontFamily: 'Roboto Flex',
          //             fontSize: 13
          //           ),
          //         ),
          //         SizedBox(height: 4),
          //         Text(order['description']!,style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12),),
          //         SizedBox(height: 4),
          //         Text(
          //           'Order #${order['orderId']}',
          //           style: TextStyle(
          //             fontFamily: 'Roboto Flex',
          //             fontSize: 12
          //           ),
          //         ),
          //         SizedBox(height: 4),
          //         Row(
          //           children: List.generate(
          //             5,
          //             (starIndex) => Icon(
          //               Icons.star_border,
          //               size: 20,
          //               color: Colors.grey,
          //             ),
          //           ),
          //         ),
          //         SizedBox(height: 4),
          //         Text(
          //           'Rate this product now',
          //           style: TextStyle(
          //             color: Colors.blue,
          //             fontSize: 12,
          //             fontFamily: 'Roboto Flex'
          //           ),
          //         ),
          //       ],
          //     ),
          //     trailing: Icon(Icons.arrow_forward_ios,size: 12,),
          //   ),
          // );
       
       
        },
      ),
   
   
    );
  }
}
