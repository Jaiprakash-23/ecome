import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:ecome/Bassurl.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';




final List<Map<String, String>> orders = [
  {
    'status': 'Arriving Today',
    'image': 'assets/image1.jpg',
    'orderId': '92287157',
    'description': 'Lorem ipsum dolor sit amet conse ...',
  },
  {
    'status': 'Arriving on Thursday',
    'image': 'assets/image2.jpg',
    'orderId': '92287157',
    'description': 'Lorem ipsum dolor sit amet conse ...',
  },
];

class OrderDetailsPage extends StatefulWidget {
  final  orderesid;

  const OrderDetailsPage({Key? key,  this.orderesid}) : super(key: key);

  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  String token = '';
  Map<String, dynamic> order = {};
  Map<String, dynamic> ordeesr = {};
  Map<String, dynamic> addressshipng = {};
 
 List<Map<String, String>> get steps {
    return [
      {
        'status': ordeesr['order_status'] ?? 'Pending',
        'date': ordeesr['confirmed'] ?? 'N/A',
      },
      {'status': 'Shipped', 'date': ordeesr['accepted'] ?? ''},
      {'status': 'Delivered', 'date': ordeesr['delivered'] ?? ''},
    ];
  }
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString("token") ?? '').trim();

    if (token.isNotEmpty) {
      await fetchOrderDetails(token);
    } else {
      print('Token not available.');
    }
  }

  Future<void> fetchOrderDetails(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET', Uri.parse('$BasseUrl/api/order/details/${widget.orderesid}'));
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = jsonDecode(responseBody);
      setState(() {
        order = data['data']['order_detail'] ?? {};
        ordeesr = data['data'] ?? {};
        addressshipng = data['address'] ?? {};
      });
      print("Order details fetched: $order");
    } else {
      print("Failed to fetch order details: ${response.reasonPhrase}");
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
    fetchOrderDetails(token);
  }

  int _selectedRating = 0;
  void _onStarTap(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: Color(0xff004CFF),
              ),
              child: Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: Text(
          "Orders Details",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Flex',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Divider(),
              _buildOrderInfo(),
              //SizedBox(height: 16),
              Divider(),
              // Delivery Status
              _buildDeliveryStatus(),
              buildStepList(),
              Divider(),
              // Order List
              _buildOrderList(),
              SizedBox(height: 16),
              Divider(),
              Center(
                child: Text(
                  'Cancel This Order',
                  style: TextStyle(
                      fontFamily: 'Roboto Flex',
                      fontSize: 10,
                      color: Color(0xff000000)),
                ),
              ),
              Divider(),
              //  Center(child: Text('Rate this product now',style: TextStyle(fontFamily: 'Roboto Flex',fontSize: 10,color: Color(0xff000000)))),
              Center(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _showReviewBottomSheet(context);
                    });
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Rate this product now',
                          style: TextStyle(
                              fontFamily: 'Roboto Flex',
                              fontSize: 11,
                              color: Color(0xff000000))),
                      SizedBox(width: 6),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return GestureDetector(
                            onTap: () => _onStarTap(index + 1),
                            child: Icon(
                              Icons.star,
                              size: 11,
                              color: _selectedRating > index
                                  ? Colors.orange
                                  : Color(0xffECA61B),
                            ),
                          );
                        }),
                      ),
                      
                    ],
                  ),
                ),
              ),
              Divider(),
              _buildSectionTitle('Shipping Address'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  '${addressshipng['contact_person_name']}\n ${addressshipng['address']}\n  ${addressshipng['road']} ${addressshipng['postal_code']}\n ${addressshipng['contact_person_number']}',
                  style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 11),
                ),
              ),
              SizedBox(height: 16),
              // Price Details
              _buildSectionTitle('Price Details'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildPriceRow('Price (${order['quantity']} items)', '₹ ${order['subtotal']}'),
                    _buildPriceRow('Discount', '- ₹ 17.00'),
                    _buildPriceRow('Platform Fee', '₹ 10'),
                    _buildPriceRow(
                        'Delivery Charges', 'Free Delivery', Colors.green),
                    Divider(),
                    _buildPriceRow(
                      'Total Amount',
                      '₹ 30,710',
                      Colors.black,
                      FontWeight.bold,
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Download Invoice Button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Download Invoice'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Number:${order['order_id'] ?? ''} ',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              'Order Date: ${ordeesr['confirmed'] ?? ''}',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Total Amount',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
            Text(
              '₹ ${order['subtotal'] ?? ''}',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

 Widget _buildDeliveryStatus() {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        '1 Item Delivered',
        style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
      ),
      SizedBox(height: 8),
      Row(
        children: [
          Text(
            'Package Delivered on ',
            style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 12,
                color: Color(0xff95989A)),
          ),
          Text(
            '28th April, 2025',
            style: TextStyle(
                fontFamily: 'Roboto Flex',
                fontSize: 12,
                color: Color(0xff000000)),
          ),
        ],
      ),
      SizedBox(height: 16),
      // ...steps.asMap().entries.map((entry) {
      //   final index = entry.key;
      //   final step = entry.value;
      //   final isLast = index == steps.length - 1;
      //   final hasDate = step['date'] != null && step['date']!.isNotEmpty;
      //   final color = hasDate ? Color(0xff4CD964) : Color(0xff707070);

      //   return Row(
      //     crossAxisAlignment: CrossAxisAlignment.start,
      //     children: [
      //       Column(
      //         children: [
      //           Icon(
      //             Icons.check_circle,
      //             color: color,
      //             size: 24,
      //           ),
      //           // Render the line only if this is NOT the last step
      //           if (!isLast)
      //             Container(
      //               height: 40,
      //               width: 2,
      //               color: color,
      //             ),
      //         ],
      //       ),
      //       SizedBox(width: 8),
      //       Expanded(
      //         child: Column(
      //           crossAxisAlignment: CrossAxisAlignment.start,
      //           children: [
      //             Text(
      //               step['status']!,
      //               style: TextStyle(
      //                 fontFamily: 'Roboto Flex',
      //                 fontSize: 12,
      //                 fontWeight: FontWeight.bold,
      //                 color: color,
      //               ),
      //             ),
      //             Text(
      //               step['date']!,
      //               style: TextStyle(
      //                   fontFamily: 'Roboto Flex',
      //                   fontSize: 12,
      //                   color: Color(0xff95989A)),
      //             ),
      //             SizedBox(height: 16),
      //           ],
      //         ),
      //       ),
      //     ],
      //   );
      // }).toList(),
    
    
    ],
  );
}
Widget buildStepList() {
  // Check if the status is 'Canceled'
  if (ordeesr['order_status']?.toLowerCase() == 'canceled') {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Column(
          children: [
            Icon(
              Icons.cancel,
              color: Color(0xffFF0000),
              size: 24,
            ),
          ],
        ),
        SizedBox(width: 8),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Order Canceled',
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffFF0000),
                ),
              ),
              Text(
                '${ordeesr['canceled']??''}', // You can replace this with any specific cancellation date or leave as 'N/A'
                style: TextStyle(
                  fontFamily: 'Roboto Flex',
                  fontSize: 12,
                  color: Color(0xff95989A),
                ),
              ),
              SizedBox(height: 16),
            ],
          ),
        ),
      ],
    );
  }

  // Default rendering for non-canceled status
  return Column(
    children: steps.asMap().entries.map((entry) {
      final index = entry.key;
      final step = entry.value;
      final isLast = index == steps.length - 1;
      final hasDate = step['date'] != null && step['date']!.isNotEmpty;
      final color = hasDate ? Color(0xff4CD964) : Color(0xff707070);

      return Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              Icon(
                Icons.check_circle,
                color: color,
                size: 24,
              ),
              if (!isLast)
                Container(
                  height: 40,
                  width: 2,
                  color: color,
                ),
            ],
          ),
          SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  step['status']!,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                    color: color,
                  ),
                ),
                Text(
                  step['date']!,
                  style: TextStyle(
                    fontFamily: 'Roboto Flex',
                    fontSize: 12,
                    color: Color(0xff95989A),
                  ),
                ),
                SizedBox(height: 16),
              ],
            ),
          ),
        ],
      );
    }).toList(),
  );
}
 
Widget _buildOrderList() {
  return ListView.builder(
    physics: NeverScrollableScrollPhysics(),
    shrinkWrap: true,
    itemCount: 1, 
    itemBuilder: (context, index) {
      //var item = order; 

      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 4.0),
        child: ListTile(
          leading: Container(
            height: 60,
            width: 56,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage("$imageUrl/products/${order['image'][0]}"),
                fit: BoxFit.cover,
              ),
              borderRadius: BorderRadius.circular(100),
              //color: Colors.amber,
              border: Border.all(color: Colors.white, width: 4),
            ),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${order['name']}",
                    style: TextStyle(fontFamily: 'Nunito Sans', fontSize: 12),
                  ),
                  Row(
                    children: [
                      if (order['discount'] != null)
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            "₹ ${order['discount']?? ''}",
                            style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF1AEAE),
                            ),
                          ),
                        ),
                      SizedBox(width: 5),
                      Text(
                        "₹ ${order['price']}",
                        style: TextStyle(
                          fontFamily: 'Raleway',
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              Text(
                "M - White",
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 12,
                  color: Color(0xff000000),
                ),
              ),
              Text(
                "Qty: ${order['quantity']}",
                style: TextStyle(
                  fontFamily: 'Nunito Sans',
                  fontSize: 12,
                  color: Color(0xff000000),
                ),
              ),
            ],
          ),
        ),
      );
    },
  );
}


  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle(fontSize: 11, fontFamily: 'Roboto Flex'),
    );
  }

  Widget _buildPriceRow(String label, String value,
      [Color? color, FontWeight? fontWeight]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(fontFamily: 'Raleway'),
          ),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontFamily: 'Raleway',
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }

  int selectedRating = 0;
  TextEditingController rate = TextEditingController();
  Future<void> Addreviews() async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('$BasseUrl/api/add/reviews'));
    request.body = json.encode({
      "product_id": "${widget.orderesid}",
      "review_text": rate.text,
      "rating": selectedRating
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

   if (response.statusCode == 201) {
  print(await response.stream.bytesToString());
  showSuccessDialog(context);
  setState(() {
    
  });
  // Future.delayed(Duration(seconds: 2), () {
  //   Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => OrderDetailsPage()), // Replace MyPage with your page
  //   );
  // });
  //  Navigator.pushReplacement(
  //     context,
  //     MaterialPageRoute(builder: (context) => OrderDetailsPage()), // Replace MyPage with your current page's widget
  //   );
} else {
  showErrorDialog(context);
}
  }
  void showSuccessDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.success,
    customHeader: Icon(
      Icons.done,
      size: 50,
      color: Color(0xff85A8FB),
    ),
    body: Center(
      child: Column(
        children: [
          Text(
            'Done!',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Thank you for your review',
            style: TextStyle(
              fontFamily: 'Nunito Sans',
              fontSize: 13,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: Colors.orange,
                size: 30,
              );
            }),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  )..show(); // Ensure this is chained
}

void showErrorDialog(BuildContext context) {
  AwesomeDialog(
    context: context,
    animType: AnimType.scale,
    dialogType: DialogType.error,
    customHeader: Icon(
      Icons.error,
      size: 50,
      color: Colors.red,
    ),
    body: Center(
      child: Column(
        children: [
          Text(
            'Error!',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontSize: 19,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'Thank you for your review',
            style: TextStyle(
              fontFamily: 'Nunito Sans',
              fontSize: 13,
            ),
          ),
          SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(5, (index) {
              return Icon(
                Icons.star,
                color: Colors.orange,
                size: 30,
              );
            }),
          ),
          SizedBox(height: 20),
        ],
      ),
    ),
  )..show(); // Ensure this is chained
}


  void _showReviewBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Text(
                        'Review',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Container(
                      width: double.infinity,
                      color: Colors.white,
                      child: Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                CircleAvatar(
                                  backgroundImage:
                                      AssetImage('assets/profile.jpg'),
                                  radius: 20,
                                ),
                                SizedBox(width: 10),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Lorem ipsum dolor sit \namet consectetur.',
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontFamily: 'Nunito Sans',
                                      ),
                                    ),
                                    Text(
                                      'Order #92287157',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xff202020),
                                        fontFamily: 'Raleway',
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: List.generate(5, (index) {
                                return GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedRating = index + 1;
                                    });
                                  },
                                  child: Icon(
                                    index < selectedRating
                                        ? Icons.star
                                        : Icons.star_border,
                                    color: Colors.orange,
                                    size: 30,
                                  ),
                                );
                              }),
                            ),
                            SizedBox(height: 16),
                            TextField(
                              controller: rate,
                              decoration: InputDecoration(
                                hintText: 'Your comment',
                                filled: true,
                                fillColor: Color(0xffF1F4FE),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide.none,
                                ),
                              ),
                              maxLines: 3,
                            ),
                            SizedBox(height: 16),
                            GestureDetector(
                              onTap: () {
                                Addreviews();
                                print('fghjuk');
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Color(0xff004CFF),
                                ),
                                child: Center(
                                  child: Text(
                                    'Say it!',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),

                          
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
  
}
