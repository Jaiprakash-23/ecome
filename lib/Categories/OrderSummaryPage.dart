import 'dart:async';
import 'dart:convert';

import 'package:dotted_line/dotted_line.dart';
import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/ManageAddressPage.dart';
import 'package:ecome/Categories/PaymentOptionssPage.dart';
import 'package:ecome/Categories/VoucherPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class OrderSummaryPage extends StatefulWidget {
  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
  late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    getToken();

    getOrderSummary(token);
   
  }

 

 

  TextEditingController couponController = TextEditingController();
  String token = '';
  bool isApplied = false;
  String? errorMessage;
  int? offdata;
  final FocusNode textFieldFocus = FocusNode();

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString("token") ?? '').trim();
      fetchCoupons(token);
      getOrderSummary(token);
    });
    print('Cleaned datatoken: $token');
  }

  List<dynamic> coupons = [];

  Future<void> fetchCoupons(String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var request = http.Request('GET', Uri.parse('$BasseUrl/api/coupon/list'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      setState(() {});
      // Read and decode the response
      String responseBody = await response.stream.bytesToString();
      try {
        // Decode JSON and assign to coupons
        coupons = jsonDecode(responseBody) as List<dynamic>;
        print('Coupons: $coupons');
      } catch (e) {
        print('Error decoding JSON: $e');
      }
    } else {
      print('Error: ${response.reasonPhrase}');
    }
  }

  Map<dynamic, String> OrderSummary = {};
   late List<dynamic> dataOrderSummary = [];

  late String coupen = "";
  Future<void> getOrderSummary(String token) async {
    print('rftyuiolkjhgfghjk $coupen');
    var headers = {
      'Authorization': 'Bearer $token',
    };
    var requestUri = Uri.parse('$BasseUrl/api/order/summary?code=$coupen');

    try {
      var response = await http.get(requestUri, headers: headers);

      if (response.statusCode == 200) {
        String responseData = response.body;
        var decodedData = jsonDecode(responseData);
        setState(() {});
        // Ensure the data matches the expected format
        if (decodedData is Map) {
          setState(() {});
          dataOrderSummary = decodedData['items'];
          OrderSummary =
              decodedData.map((key, value) => MapEntry(key, value.toString()));
          print("Order Summary: $dataOrderSummary");
        } else {
          print("Unexpected response format.");
        }
      } else {
        print(
            "Failed to fetch order summary. Status code: ${response.statusCode}");
        print("Reason: ${response.reasonPhrase}");
      }
    } catch (e) {
      print("Error occurred: $e");
    }
  }
List<Map<String, dynamic>> get productdata => dataOrderSummary.map((item) {
    return {
      'productId': item['product_id'],
      'quantity': item['quantity'],
    };
  }).toList();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffE7E8EB),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
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
        title: Text("Order Summary",
            style: TextStyle(
                color: Colors.black,
                fontFamily: 'Raleway',
                fontSize: 24,
                fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              //padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                      color: Colors.white,
                      child: OrderSummary['address'] == "No address found"
                          ? GestureDetector(
                              onTap: () {
                                Get.toNamed(MyPagesName.manageAddressPage);
                              },
                              child: Card(
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12)),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                      height: 40,
                                      //width: 90,
                                      child:
                                          Center(child: Text("Add Address"))),
                                ),
                              ),
                            )
                          : Card(
                              //color: Colors.white,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12)),
                              child: Padding(
                                padding: const EdgeInsets.all(29.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Deliver To",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontFamily: 'Raleway',
                                                fontSize: 14),
                                          ),
                                          SizedBox(height: 8),
                                          Text(
                                            "${OrderSummary['address'] ?? ''}",
                                            style: TextStyle(
                                              color: Colors.black,
                                              fontFamily: 'Nunito Sans',
                                              fontSize: 10,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        Get.toNamed(
                                            MyPagesName.manageAddressPage);
                                      },
                                      child: Container(
                                          height: 30,
                                          width: 30,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              color: Color(0xff004BFE)),
                                          child: Icon(Icons.edit,
                                              color: Colors.white)),
                                    ),
                                  ],
                                ),
                              ),
                            )),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height:
                                300, // Set a fixed height for ListView or wrap it in a ConstrainedBox
                            child: 
                            ListView.builder(
                              itemCount: dataOrderSummary.length,
                              itemBuilder: (context, index) {
                                //  productdata = dataOrderSummary.map((dataOrderSummary) {
                                //   return {
                                //     'product_id': dataOrderSummary['product_id'],
                                //     'quantity': dataOrderSummary['quantity'],
                                //   };
                                // }).toList();
                                return Padding(
                                  padding: const EdgeInsets.all(13.0),
                                  child: _buildOrderItem(
                                      imageUrl:
                                          "$imageUrl/products/${dataOrderSummary[index]['images'][0]}",
                                      title:
                                          "${dataOrderSummary[index]['title'] ?? ''}",
                                      price:
                                          "₹ ${dataOrderSummary[index]['sales_price'] ?? ''}",
                                      originalPrice:
                                          "₹ ${dataOrderSummary[index]['price'] ?? ''}",
                                      details:
                                          "${dataOrderSummary[index]['size'] ?? ''} - ${dataOrderSummary[index]['color'] ?? ''}\nQty: ${dataOrderSummary[index]['quantity'] ?? ''}",
                                      date:
                                          'Delivered by ${dataOrderSummary[index]['delivered_by']}',
                                      discount: dataOrderSummary[index]
                                          ['delivery_charge'],
                                      f: dataOrderSummary[index]
                                                  ['delivery_charge'] ==
                                              "Free Delivery"
                                          ? Colors.green
                                          : Colors.red),
                                );
                              },
                            ),
                          
                          
                          ),

                          SizedBox(
                            height: 10,
                          ),
                          // Text(
                          //   "    Delivered by ${OrderSummary['delivered_by']}",
                          //   style: TextStyle(
                          //     color: Colors.black,
                          //     fontFamily: 'Nunito Sans',
                          //     fontSize: 12,
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 10,
                          // ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    //height: 81,
                    width: double.infinity,
                    color: Color(0xffD9E4FF),
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Coupon Code',
                                style: TextStyle(
                                    fontFamily: 'Raleway', fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: () {
                                  fetchCoupons(token);
                                  showModalBottomSheet(
                                      context: context,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                            top: Radius.circular(16)),
                                      ),
                                      builder: (context) => Padding(
                                            padding: const EdgeInsets.all(16.0),
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  "Active Coupon Code",
                                                  style: TextStyle(
                                                      fontSize: 22,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Raleway'),
                                                ),
                                                SizedBox(height: 36),
                                                Expanded(
                                                  child: coupons.isEmpty
                                                      ? Container(
                                                          width:
                                                              double.infinity,
                                                          child: Center(
                                                            child: Text(
                                                                "Coupons Not Available"),
                                                          ),
                                                        )
                                                      : ListView.builder(
                                                          itemCount:
                                                              coupons.length,
                                                          scrollDirection:
                                                              Axis.vertical,
                                                          itemBuilder:
                                                              (context, index) {
                                                            return Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Container(
                                                                decoration:
                                                                    BoxDecoration(
                                                                  border: Border.all(
                                                                      color: Colors
                                                                          .blue),
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              8),
                                                                ),
                                                                child: Padding(
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .all(
                                                                          8.0),
                                                                  child: Column(
                                                                    children: [
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Text(
                                                                            "${coupons[index]['code'] ?? ''}",
                                                                            style: TextStyle(
                                                                                color: Color(0xff004CFF),
                                                                                fontWeight: FontWeight.bold,
                                                                                fontFamily: 'Raleway',
                                                                                fontSize: 18),
                                                                          ),
                                                                          Container(
                                                                            height:
                                                                                30,
                                                                            decoration:
                                                                                BoxDecoration(borderRadius: BorderRadius.circular(5), color: Color(0xffFFEBEB)),
                                                                            child:
                                                                                Center(
                                                                              child: Text(
                                                                                '   Valid Until ${coupons[index]['expire_date']}  ',
                                                                                style: TextStyle(color: Colors.black, fontSize: 12, fontFamily: 'Raleway'),
                                                                              ),
                                                                            ),
                                                                          ),
                                                                        ],
                                                                      ),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      MySeparator(
                                                                          color:
                                                                              Colors.grey),
                                                                      SizedBox(
                                                                        height:
                                                                            10,
                                                                      ),
                                                                      Row(
                                                                        children: [
                                                                          Icon(
                                                                            Icons.shopping_bag_rounded,
                                                                            color:
                                                                                Color(0xff004CFF),
                                                                          ),
                                                                          Text(
                                                                            ' ${coupons[index]['title'] ?? ''}',
                                                                            style:
                                                                                TextStyle(fontFamily: 'Raleway', fontSize: 17),
                                                                          )
                                                                        ],
                                                                      ),
                                                                      Row(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.spaceBetween,
                                                                        children: [
                                                                          Padding(
                                                                            padding:
                                                                                EdgeInsets.all(0),
                                                                            child: coupons[index]['discount_type'] == 'percentage'
                                                                                ? Text(
                                                                                    ' ${coupons[index]['discount'] ?? ''} % OFF for your next order',
                                                                                    style: TextStyle(fontFamily: 'Nunito Sans', fontSize: 12),
                                                                                  )
                                                                                : Text(
                                                                                    '₹ ${coupons[index]['discount'] ?? ''} OFF for your next order',
                                                                                    style: TextStyle(fontFamily: 'Nunito Sans', fontSize: 12),
                                                                                  ),
                                                                          ),
                                                                          GestureDetector(
                                                                            onTap:
                                                                                () async {
                                                                              setState(() {
                                                                                couponController.text = coupons[index]['code'];
                                                                                offdata = coupons[index]['discount'];
                                                                              });
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child: Container(
                                                                                height: 26,
                                                                                width: 79,
                                                                                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9), color: Color(0xff004CFF)),
                                                                                child: Center(
                                                                                    child: Text(
                                                                                  'Apply',
                                                                                  style: TextStyle(fontFamily: 'Raleway', fontSize: 14, color: Color(0xffFFFFFF)),
                                                                                ))),
                                                                          )
                                                                        ],
                                                                      )
                                                                    ],
                                                                  ),
                                                                ),
                                                              ),
                                                            );
                                                          },
                                                        ),
                                                )
                                              ],
                                            ),
                                          ));
                                },
                                child: Text(
                                  'View Available Coupon',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 10,
                                      color: Color(0xffFF5790)),
                                ),
                              )
                            ],
                          ),
                          Row(
                            children: [
                              if (!isApplied)
                                Expanded(
                                  child: SizedBox(
                                    height: 40,
                                    child: TextField(
                                      controller: couponController,
                                      decoration: InputDecoration(
                                        hintText: "Enter Coupon Code",
                                        hintStyle: TextStyle(
                                            color: Colors.blue, fontSize: 12),
                                        filled: true,
                                        fillColor: Colors.white,
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 0, horizontal: 8),
                                        border: OutlineInputBorder(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          borderSide: BorderSide.none,
                                        ),
                                        //errorText: errorMessage, // Show error if not null
                                      ),
                                      style: TextStyle(fontSize: 12),
                                      textAlignVertical:
                                          TextAlignVertical.center,
                                    ),
                                  ),
                                )
                              else
                                Expanded(
                                  child: Container(
                                    color: Colors.transparent,
                                    child: ListTile(
                                      leading: Icon(Icons.check_circle_outlined,
                                          color: Colors.green),
                                      title: Text(
                                          "${couponController.text} applied"),
                                      subtitle: coupons[0]['discount_type'] ==
                                              'percentage'
                                          ? Text(
                                              '$offdata % OFF for your next order',
                                              style: TextStyle(
                                                  fontFamily: 'Nunito Sans',
                                                  fontSize: 12),
                                            )
                                          : Text(
                                              '₹ $offdata OFF for your next order',
                                              style: TextStyle(
                                                  fontFamily: 'Nunito Sans',
                                                  fontSize: 12),
                                            ),
                                      trailing: GestureDetector(
                                        onTap: () {
                                          coupen = couponController.text = '';

                                          isApplied = false;
                                          errorMessage = null;

                                          getOrderSummary(token);
                                        },
                                        child: Text(
                                          'REMOVE',
                                          style: TextStyle(
                                            fontSize: 18,
                                            fontFamily: "Raleway",
                                            color: Colors.red,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              SizedBox(width: 8),
                              if (!isApplied)
                                ElevatedButton(
                                  onPressed: () {
                                    if (couponController.text.isEmpty) {
                                      setState(() {
                                        errorMessage =
                                            "Coupon code cannot be empty"; // Set error
                                      });
                                    } else {
                                      coupen = couponController.text;
                                      isApplied = true;
                                      errorMessage = null; // Clear error

                                      getOrderSummary(token);
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.black,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        horizontal: 0, vertical: 0),
                                  ),
                                  child: Text(
                                    "Apply",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 16),
                                  ),
                                ),
                            ],
                          ),
                          if (errorMessage != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 8),
                              child: Text(
                                errorMessage!,
                                style:
                                    TextStyle(color: Colors.red, fontSize: 12),
                              ),
                            ),
                        ],
                      ),
                    ),
                  ),

                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pricing Details",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          _buildPricingRow(
                              "Price (${OrderSummary['total_quantity']} item)",
                              "₹ ${OrderSummary['Total_price'] ?? ''}"),
                          _buildPricingRow("Discount",
                              "- ₹ ${OrderSummary['discount_amount'] ?? ''}"),
                          Padding(
                              padding: const EdgeInsets.all(0),
                              child: OrderSummary['coupon_code'] == 0
                                  ? null
                                  : _buildPricingRow("Coupons applied",
                                      "₹ ${OrderSummary['coupon_code'] ?? ''}")),
                          _buildPricingRow("Platform Fee",
                              "₹ ${OrderSummary['platform_fee'] ?? ''}"),
                          _buildPricingRow(
                              "Delivery Charges",
                              OrderSummary['delivery_charges'] == 0
                                  ? "${OrderSummary['delivery_charges']}"
                                  : "Free Delivery",
                              // "":"${OrderSummary['delivery_charges']}",
                              valueStyle: TextStyle(color: Colors.green)),
                          Divider(thickness: 1, color: Colors.grey[300]),
                          _buildPricingRow(
                            "Total Amount",
                            "₹ ${OrderSummary['total_amount'] ?? ''}",
                            isBold: true,
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider(),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xffE4FFE7),
                      padding: EdgeInsets.all(16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(0),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.lock,
                          color: Color(0xffECA61B),
                          size: 20,
                        ),
                        SizedBox(width: 8),
                        Text(
                          "Continue to the next page to make payment",
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              color: Color(0xff000000),
                              fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 26),
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text:
                            "By continuing with the order, you confirm that you are above 18 years of age, and you agree to the ",
                        style: TextStyle(color: Colors.black54, fontSize: 12),
                        children: [
                          TextSpan(
                            text: "Terms of Use",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Terms of Use page
                              },
                          ),
                          TextSpan(
                            text: " and ",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                          TextSpan(
                            text: "Privacy Policy",
                            style: TextStyle(color: Colors.blue, fontSize: 12),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                // Navigate to Privacy Policy page
                              },
                          ),
                          TextSpan(
                            text: ".",
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 16),

                  //SizedBox(height: 16),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Total",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          fontFamily: 'Raleway'),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "₹${OrderSummary['total_amount'] ?? ''}",
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          fontFamily: 'Raleway'),
                    ),
                  ],
                ),
                Padding(
                    padding: const EdgeInsets.all(0),
                    child: OrderSummary['address'] == "No address found"
                        ? ElevatedButton(
                            onPressed: () {
                              //Get.toNamed(MyPagesName.paymentOptionssPage);
                              // openCheckout();
                              // Navigator.push(
                              //   context,
                              //   MaterialPageRoute(
                              //       builder: (context) => ManageAddressPage()),
                              // );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.grey,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "    Proceed To Pay   ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 16),
                            ),
                          )
                        : ElevatedButton(
                            onPressed: () {
                              String CouponController;
                              String address_id ='${OrderSummary['address_id']}';
                              String Amonut="${OrderSummary['total_amount']}";
                              //Get.toNamed(MyPagesName.paymentOptionssPage,arguments: productdata);
                              //openCheckout();
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => PaymentOptionssPage(productdata:productdata, CouponController:  couponController.text,address_id: address_id,Amonut:Amonut)),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black,
                              padding: EdgeInsets.symmetric(vertical: 10),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            child: Text(
                              "    Proceed To Pay   ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 16),
                            ),
                          )),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildPricingRow(String label, String value,
      {TextStyle? valueStyle, bool isBold = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                fontFamily: 'Raleway'),
          ),
          Text(
            value,
            style: valueStyle ??
                TextStyle(
                    fontSize: 14,
                    fontWeight: isBold ? FontWeight.bold : FontWeight.normal,
                    fontFamily: 'Raleway'),
          ),
        ],
      ),
    );
  }

  Widget _buildOrderItem({
    required String imageUrl,
    required String title,
    required String price,
    String? originalPrice,
    required String details,
    required String date,
    required String discount,
    required Color f,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        children: [
          Row(
            children: [
              Container(
                width: 60,
                height: 60,
                decoration: BoxDecoration(
                    border: Border.all(width: 5, color: Colors.white),
                    borderRadius: BorderRadius.circular(100),
                    image: DecorationImage(
                        image: NetworkImage(imageUrl), fit: BoxFit.cover)),
              ),
              // ClipRRect(

              //   borderRadius: BorderRadius.circular(100),
              //   child:
              //       Image.asset(imageUrl, width: 60, height: 60, fit: BoxFit.cover),
              // ),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title,
                        style: TextStyle(
                            fontSize: 12,
                            fontFamily: 'Nunito Sans',
                            color: Color(0xff000000))),
                    SizedBox(height: 4),
                    Text(details,
                        style: TextStyle(
                            color: Color(0xff000000),
                            fontFamily: 'Nunito Sans',
                            fontSize: 12)),
                  ],
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  if (originalPrice != null)
                    Text(
                      originalPrice,
                      style: TextStyle(
                          decoration: TextDecoration.lineThrough,
                          color: Colors.red,
                          fontFamily: 'Raleway',
                          fontSize: 15),
                    ),
                  SizedBox(
                    width: 7,
                  ),
                  Text(price,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway',
                          fontSize: 16)),
                ],
              ),
            ],
          ),
          Row(
            children: [
              Text(date),
              SizedBox(
                width: 8,
              ),
              Text(
                discount,
                style: TextStyle(color: f),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class MySeparator extends StatelessWidget {
  final Color color;

  const MySeparator({Key? key, this.color = Colors.black}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final boxWidth = constraints.constrainWidth();
        final dashWidth = 4.0;
        final dashHeight = 2.0;
        final dashCount = (boxWidth / (2 * dashWidth)).floor();

        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: List.generate(dashCount, (_) {
            return Container(
              width: dashWidth,
              height: dashHeight,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
            );
          }),
        );
      },
    );
  }
}
