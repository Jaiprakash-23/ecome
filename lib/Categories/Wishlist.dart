import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WishlistPage extends StatefulWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  State<WishlistPage> createState() => _WishlistPageState();
}

class _WishlistPageState extends State<WishlistPage> {
  List<dynamic> witchdata = [];
  List<dynamic> dataproduct = [];
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
      await getwitchlist(token);
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

  Future<void> getwitchlist(String token) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'GET',
        Uri.parse(
            'https://ensantehealth.com/owngears/public/api/show/wishlist'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      var responseBody = await response.stream.bytesToString();
      var data = json.decode(responseBody);

      if (data != null && data['category'] is List) {
        setState(() {
          witchdata = data['category'] as List<dynamic>;
          dataproduct = data['data'] as List<dynamic>;
        });
        print('swertyuiohgf $dataproduct');
      } else {
        print('Error: "category" is not found or is not a list');
      }
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  Future<void> deletewitchdata(String productId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
      'POST',
      Uri.parse('$BasseUrl/api/remove/wishlist/$productId'),
    );

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      // Remove the deleted product locally from the list
      setState(() {
        dataproduct.removeWhere((item) => item['product_id'] == productId);
      });

      print(
          "Product removed successfully: ${await response.stream.bytesToString()}");
    } else {
      print('Failed to delete product: ${response.reasonPhrase}');
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Wishlist',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently viewed',
                  style: TextStyle(
                      fontSize: 21,
                      fontFamily: 'Raleway',
                      fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(100),
                      color: Color(0xff004CFF)),
                  child: Icon(
                    Icons.arrow_forward,
                    color: Colors.white,
                  ),
                )
              ],
            ),
          ),
          _buildRecentlyViewedList(),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: dataproduct.length,
            itemBuilder: (context, index) {
              return _buildWishlistItem(
                imageUrl:
                    "$imageUrl/products/${dataproduct[index]['product']['images'][0] ?? ''}",
                title: "${dataproduct[index]['product']['title'] ?? ''}",
                price:
                    "${double.tryParse(dataproduct[index]['product']['sale_price'])?.toInt() ?? 0}",
                size: "${dataproduct[index]['product']['color'] ?? ''}",
                color: "${dataproduct[index]['product']['size'] ?? ''}",
                onRemove: () {
                  deletewitchdata(dataproduct[index]['product_id']);
                  print(
                      'Removed item with ID: ${dataproduct[index]['product_id']}');
                },
                sale_price:
                    '${double.tryParse(dataproduct[index]['product']['price'])?.toInt() ?? 0}',
                discount_offer:
                    '${dataproduct[index]['product']['discount_offer'] ?? ''}',
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildWishlistItem({
    required String imageUrl,
    required String title,
    required String price,
    required String size,
    required String color,
    required String sale_price,
    required String discount_offer,
    required VoidCallback onRemove,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
      child: Row(
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  imageUrl,
                  height: 101.64,
                  width: 121.18,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                bottom: 4,
                left: 4,
                child: GestureDetector(
                  onTap: onRemove,
                  child: Container(
                    height: 24,
                    width: 24,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.delete,
                      color: Color(0xffD97474),
                      size: 16,
                    ),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title,
                    style: const TextStyle(
                        fontSize: 12, fontFamily: 'Nunito Sans')),
                Row(
                  children: [
                    Text('₹ $price',
                        style: TextStyle(
                            color: Colors.black,
                            fontFamily: "Raleway",
                            fontSize: 15)),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      '₹ $sale_price',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                        color: Colors.red,
                        fontFamily: 'Raleway',
                        decoration: TextDecoration.lineThrough,
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(0),
                      child: Container(
                        height: 18,
                        width: 39,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(9),
                                topRight: Radius.circular(9),
                                bottomLeft: Radius.circular(9)),
                            gradient: LinearGradient(
                              colors: [Color(0xffFF5790), Color(0xffF81140)],
                            )),
                        child: Center(
                            child: Text(
                          '-$discount_offer%',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              color: Colors.white),
                        )),
                      ),
                    )
                  ],
                ),

                // Text('₹ $price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Raleway')),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xffE5EBFC),
                      ),
                      child: Center(
                          child: Text('$size',
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Raleway',
                                  fontSize: 14))),
                    ),
                    const SizedBox(width: 9),
                    Container(
                      height: 30,
                      width: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xffE5EBFC),
                      ),
                      child: Center(
                          child: Text('$color',
                              style: const TextStyle(
                                  color: Color(0xff000000),
                                  fontFamily: 'Raleway',
                                  fontSize: 14))),
                    ),
                  ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 37,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Image.asset('assets/images/Add.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedList() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: witchdata.length,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return CircleAvatar(
            radius: 36,
            backgroundImage:
                NetworkImage('$imageUrl${witchdata[index]['image']}'),
          );
        },
      ),
    );
  }
}
