import 'dart:convert';

import 'package:ecome/Dashbord.dart';
import 'package:flutter/material.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:http/http.dart' as http;

class PaymentOptionssPage extends StatefulWidget {
  final List<Map<String, dynamic>> productdata;
  final CouponController;
  final address_id;
  final Amonut;

  const PaymentOptionssPage(
      {Key? key,
      required this.productdata,
      this.CouponController,
      this.address_id, this.Amonut})
      : super(key: key);
  @override
  State<PaymentOptionssPage> createState() => _PaymentOptionssPageState();
}

class _PaymentOptionssPageState extends State<PaymentOptionssPage> {
  String selectedOption = 'Wallet';
  late Razorpay razorpay;
  Future<void> OrderCreate() async {
    try {
      var headers = {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
        'Authorization':
            'Bearer 82|hPQjjaUVdQxxblbzzzQxnay0TovFqjaNvXtmdtgF76539cf7'
      };

      var request = http.Request(
          'POST',
          Uri.parse(
              'https://ensantehealth.com/owngears/public/api/order/create'));

      request.body = json.encode({
        // "products": [
        //   {"productId": 2, "quantity": 2},
        //   {"productId": 14, "quantity": 1}
        // ],
         "products": widget.productdata, // Pass directly if it's a List<Map>
        "address_id": widget.address_id,
        "payment_method": selectedOption,
        "coupon_code": widget.CouponController,
        "order_note": "Please deliver in the evening"
      });

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();
      final responseBody = await response.stream.bytesToString();

      if (response.statusCode == 201) {
        debugPrint('Order created successfully: $responseBody');
        // ScaffoldMessenger.of(context).showSnackBar(
        //   SnackBar(content: Text('Order created successfully!')),
        // );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => Dashboard()),
        );
      } else {
        debugPrint('Order creation failed. Status: ${response.statusCode}');
        debugPrint('Response: $responseBody');
        throw Exception(
            'Failed to create order. Status: ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in OrderCreate: $e');
      rethrow;
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    razorpay = Razorpay();

    // Setting up Razorpay event listeners
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  
  void openCheckout() {
  // Ensure 'widget.Amount' is a valid number
  var amount = double.tryParse(widget.Amonut) ?? 0; // Parse as a double and default to 0 if invalid

  var options = {
    'key': 'rzp_test_wITwIPQ4MCK9V5',
    'amount': (amount * 100).toInt(), // Multiply by 100 to convert to smallest currency unit (paise for INR)
    'name': 'Owngears',
    'description': 'Owngears Retail India',
    'retry': {'enabled': true, 'max_count': 1},
    'send_sms_hash': true,
    'prefill': {'contact': '8888888888', 'email': 'owngearsretail@gmail.com'},
    'external': {
      'wallets': ['paytm'],
    },
  };

  try {
    razorpay.open(options);
  } catch (e) {
    debugPrint("Error: $e");
  }
}


  void handlePaymentErrorResponse(PaymentFailureResponse response) {
    showAlertDialog(
      context,
      "Payment Failed",
      "Code: ${response.code}\nDescription: ${response.message}\nMetadata: ${response.error.toString()}",
    );
  }

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) async {
    debugPrint("Payment successful. Payment ID: ${response.paymentId}");

 
  }

  void handleExternalWalletSelected(ExternalWalletResponse response) {
    showAlertDialog(
      context,
      "External Wallet Selected",
      "Wallet: ${response.walletName}",
    );
  }

  void showAlertDialog(BuildContext context, String title, String message) {
    Widget continueButton = ElevatedButton(
      child: const Text("Continue"),
      onPressed: () {},
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
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
          title: Text("Payment Options",
              style: TextStyle(
                  color: Colors.black,
                  fontFamily: 'Raleway',
                  fontSize: 24,
                  fontWeight: FontWeight.bold)),
          backgroundColor: Colors.white,
          elevation: 0,
        ),
        body: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(0),
                child: Card(
                  color: Color(0xffFFFFFF),

                  ///margin: EdgeInsets.only(bottom: 16.0),
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.0),
                  ),
                  child: Theme(
                    data: Theme.of(context)
                        .copyWith(dividerColor: Colors.transparent),
                    child: ExpansionTile(
                      title: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Total Amount',
                            style: TextStyle(
                              fontSize: 18,
                              fontFamily: "Raleway",
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            '₹49,321',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                                color: Color(0xff000000),
                                fontFamily: "Raleway"),
                          ),
                        ],
                      ),
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Price (10 items)',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '₹48,927',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Delivery Charges',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    'FREE',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.green,
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Pickup Charges',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '₹129',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Packaging Charges',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '₹167',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              SizedBox(height: 8),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Protect Promise Fee',
                                    style: TextStyle(fontSize: 16),
                                  ),
                                  Text(
                                    '₹98',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),
              GestureDetector(
                onTap: () {
                  // Add offers functionality
                },
                child: Card(
                  color: Color(0xffFFFFFF),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ListTile(
                    leading: Icon(Icons.local_offer_outlined),
                    title: Text(
                      'Offers',
                      style: TextStyle(fontFamily: "Nunito Sans", fontSize: 16),
                    ),
                    trailing: Icon(Icons.arrow_forward_ios),
                  ),
                ),
              ),
              SizedBox(height: 16),
              //Text("${widget.productdata}"),
              Text(
                'Select Payment Option',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    fontFamily: "Roboto"),
              ),
              SizedBox(height: 8),
              Card(
                elevation: 3,
                color: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  children: [
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = 'Wallet';
                        });
                      },
                      child: Container(
                        height: 46,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: selectedOption == 'Wallet'
                                ? Color(0xffF2F5FE)
                                : Colors.white,
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Color(0xffF2F5FE))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/images/wallet_3.png"),
                            Text(
                              'Wallet',
                              style: TextStyle(
                                fontFamily: "Nunito Sans",
                                fontSize: 12,
                              ),
                            ),
                            Text(
                              'Available Balance - ₹2300',
                              style: TextStyle(
                                fontFamily: "Nunito Sans",
                                fontSize: 12,
                                color: selectedOption == 'Wallet'
                                    ? Colors.black
                                    : Colors.black,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () async {
                        setState(() {
                          selectedOption = 'Card';
                        });
                      },
                      child: Container(
                        height: 46,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: selectedOption == 'Card'
                                ? Color(0xffF2F5FE)
                                : Color(0xffFFFFFFF),
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Color(0xffF2F5FE))),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Image.asset("assets/images/imagesss.png"),
                            Text(
                              'Debit/Credit Card, UPI Net Banking',
                              style: TextStyle(
                                fontFamily: "Nunito Sans",
                                fontSize: 12,
                                color: selectedOption == 'Card'
                                    ? Colors.black
                                    : Colors.black,
                              ),
                            ),
                            Icon(Icons.arrow_forward_ios),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedOption = 'Cash';
                        });
                      },
                      child: Container(
                        height: 46,
                        margin: EdgeInsets.symmetric(horizontal: 16),
                        decoration: BoxDecoration(
                            color: selectedOption == 'Cash'
                                ? Color(0xffF2F5FE)
                                : Color(0xffFFFFFFF),
                            borderRadius: BorderRadius.circular(9),
                            border: Border.all(color: Color(0xffF2F5FE))),
                        child: Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Image.asset("assets/images/moneys.png"),
                              Text(
                                'Cash on Delivery',
                                style: TextStyle(
                                  fontFamily: "Nunito Sans",
                                  fontSize: 12,
                                  color: selectedOption == 'Cash'
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                              Icon(Icons.arrow_forward_ios),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomAppBar(
          height: 90,
          color: Color(0xffFFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  Text(
                    '₹${widget.Amonut}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        fontFamily: "Roboto"),
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'View detailed bill',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Color(0xff027FEE),
                        fontSize: 14,
                        fontFamily: "Roboto"),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () async {
                  if (selectedOption == 'Card') {
                    // For card payments, open Razorpay checkout first
                    openCheckout();
                  } else if (selectedOption == 'Wallet' ||
                      selectedOption == 'Cash') {
                    // For Wallet or Cash, directly call OrderCreate
                    try {
                      await OrderCreate();
                      // Handle successful order creation
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Order created successfully!')),
                      );
                      // You might want to navigate to a success page here
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text('Failed to create order: $e')),
                      );
                    }
                  }
                },
                child:selectedOption == 'Cash'? Text('Place Order',style: TextStyle(fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffFFFFFF)),):Text('Make Payment ',style: TextStyle(fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffFFFFFF)),),
                style: ElevatedButton.styleFrom(
                              backgroundColor: Color(0xff027FEE),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                            ),
                          ),
             // )
              //             ElevatedButton(
              //               onPressed: () {
              //                 if (selectedOption == 'Card') {
              //                   OrderCreate();
              //   //openCheckout(); // Trigger Razorpay checkout if 'Card' is selected
              // } else {
              //   ScaffoldMessenger.of(context).showSnackBar(
              //     SnackBar(
              //       content: Text('Please select Card as the payment option to proceed.'),
              //     ),
              //   );
              // }
              //                // openCheckout();
              //                 // Make payment logic
              //               },
              //               child: Text('Make Payment',style: TextStyle(fontFamily: "Roboto",fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffFFFFFF)),),
              //               style: ElevatedButton.styleFrom(
              //                 backgroundColor: Color(0xff027FEE),
              //                 shape: RoundedRectangleBorder(
              //                   borderRadius: BorderRadius.circular(8),
              //                 ),
              //                 padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
              //               ),
              //             ),
            ],
          ),
        ));
  }
}
