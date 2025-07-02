import 'dart:convert'; // For JSON decoding
import 'package:ecome/Bassurl.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class MyOrdersPage extends StatefulWidget {
  @override
  State<MyOrdersPage> createState() => _MyOrdersPageState();
}

class _MyOrdersPageState extends State<MyOrdersPage> {
  bool isLoading = true;
  String token = '';
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = (prefs.getString("token") ?? '').trim();

    if (savedToken.isNotEmpty) {
      setState(() {
        token = savedToken;
        isLoading = true;
      });
      await getOrders(token);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Token not available.');
    }
  }

  List<dynamic> orders = [];

  Future<void> getOrders(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var response = await http.get(
        Uri.parse('$BasseUrl/api/my-orders'),
        headers: headers,
      );

      if (response.statusCode == 200) {
        final Map<String, dynamic> data = jsonDecode(response.body);
        setState(() {
          orders =
              data['data'] ?? []; // Adjust 'orders' based on the actual key
        });
        print("Orders: $orders");
      } else {
        print('Failed to load orders: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error fetching orders: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7E8EB),
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () => Navigator.of(context).pop(),
          child: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(100),
              color: const Color(0xff004CFF),
            ),
            child: const Icon(
              Icons.arrow_back,
              color: Colors.white,
            ),
          ),
        ),
        title: const Text(
          "My Orders",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Roboto Flex',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : orders.isEmpty
              ? const Center(
                  child: Text(
                    'No Orders Found',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                )
              : ListView.builder(
                  itemCount: orders.length,
                  itemBuilder: (context, index) {
                    //final order = orders[index];
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0),
                      child: GestureDetector(
                        onTap: () {
                          int orderesid = orders[index]['id'];
Get.toNamed(MyPagesName.orderDetailsPage, arguments: {'orderid': orderesid});

                        },
                        child: Container(
                          height: 139,
                          color: Colors.white,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              children: [
                                Container(
                                  height: 90,
                                  width: 92,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(9),
                                    image: DecorationImage(
                                      image: NetworkImage(
                                          "$imageUrl/products/${orders[index]['order_detail']['image'][0]}"),
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 17),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Arrving on ${orders[index]['order_detail']['arriving_date'] ?? ''}",
                                        style: TextStyle(
                                          color: orders[index]['order_detail']
                                                      ['arriving_date'] ==
                                                  "today"
                                              ? Colors.green
                                              : Color(0xffECA61B),
                                          fontFamily: 'Roboto Flex',
                                          fontSize: 13,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        "${orders[index]['order_detail']['name'] ?? ''}",
                                        style: const TextStyle(
                                          fontFamily: 'Nunito Sans',
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        'Order #',
                                        style: const TextStyle(
                                          fontFamily: 'Roboto Flex',
                                          fontSize: 12,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Row(
                                        children: List.generate(5, (starIndex) {
                                          // Parse the rating and handle it
                                          double ratingValue = double.tryParse(
                                                  orders[index]['order_detail']
                                                          ['rating'] ??
                                                      '0') ??
                                              0;
                                          int rating = ratingValue
                                              .floor(); // Ensure integer value for stars

                                          bool isRated = starIndex < rating;

                                          return isRated
                                              ? Icon(
                                                  Icons.star,
                                                  size: 20,
                                                  color: Color(0xffECA61B),
                                                )
                                              : Icon(
                                                  Icons.star_border,
                                                  size: 20,
                                                  color: Colors.grey,
                                                );
                                        }),
                                      ),
                                      const SizedBox(height: 4),
                                      const Text(
                                        'Rate this product now',
                                        style: TextStyle(
                                          color: Colors.blue,
                                          fontSize: 12,
                                          fontFamily: 'Roboto Flex',
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const Icon(Icons.arrow_forward_ios, size: 12),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
