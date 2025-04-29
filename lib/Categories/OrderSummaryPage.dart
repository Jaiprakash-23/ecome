import 'package:dotted_line/dotted_line.dart';
import 'package:ecome/Categories/ManageAddressPage.dart';
import 'package:ecome/Categories/VoucherPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class OrderSummaryPage extends StatefulWidget {
  @override
  State<OrderSummaryPage> createState() => _OrderSummaryPageState();
}

class _OrderSummaryPageState extends State<OrderSummaryPage> {
   late Razorpay razorpay;

  @override
  void initState() {
    super.initState();
    razorpay = Razorpay();

    // Setting up Razorpay event listeners
    razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentErrorResponse);
    razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccessResponse);
    razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWalletSelected);
  }

  @override
  void dispose() {
    razorpay.clear(); // Cleanup the Razorpay instance to avoid memory leaks
    super.dispose();
  }

  void openCheckout() {
    var options = {
      'key': 'rzp_test_Q2EaBgbw3u8R12',
      'amount': 1 * 1, // Amount in smallest currency unit (100 = ₹1.00)
      'name': 'Acme Corp.',
      'description': 'Fine T-Shirt',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {'contact': '8888888888', 'email': 'test@razorpay.com'},
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

  void handlePaymentSuccessResponse(PaymentSuccessResponse response) {
    debugPrint("Payment successful. Payment ID: ${response.paymentId}");
    // Navigate to the Welcome page directly without showing a dialog
    // Navigator.pushReplacement(
    //   context,
    //   MaterialPageRoute(builder: (context) => Welcome()),
    // );
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
                  GestureDetector(
                    onTap: (){
                       Get.toNamed(MyPagesName.manageAddressPage);
                    },
                    child: Container(
                      color: Colors.white,
                      child: Card(
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12)),
                        child: Padding(
                          padding: const EdgeInsets.all(29.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                      "Magadi Main Rd, next to Prasanna Theatre,\nCholourpalya, Bengaluru, Karnataka 560023\n+91987654321",
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
                                onTap: (){
                                  Get.toNamed(MyPagesName.manageAddressPage);
                                //   showModalBottomSheet(
                                //   context: context,
                                //   isScrollControlled: true,
                                //   shape: const RoundedRectangleBorder(
                                //     borderRadius:
                                //         BorderRadius.vertical(top: Radius.circular(16)),
                                //   ),
                                //   builder: (context) => ActiveCouponBottomSheet(),
                                // );
                    
                                },
                                child: Container(
                                    height: 30,
                                    width: 30,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(100),
                                        color: Color(0xff004BFE)),
                                    child: Icon(Icons.edit, color: Colors.white)),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    color: Colors.white,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: _buildOrderItem(
                            imageUrl: "assets/images/detailpage.png",
                            title: "Lorem ipsum dolor sit amet consectetur.",
                            price: "\$12.00",
                            originalPrice: "\$17.00",
                            details: "M - White\nQty: 1",
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(13.0),
                          child: _buildOrderItem(
                            imageUrl: "assets/images/detailpage.png",
                            title: "Lorem ipsum dolor sit amet consectetur.",
                            price: "\$17.00",
                            details: "S - Black\nQty: 1",
                          ),
                        ),
                        Text(
                          "    Delivered by Thursday, 23 April",
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: 'Nunito Sans',
                              fontSize: 12),
                        ),
                        SizedBox(
                          height: 10,
                        )
                      ],
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
                                style: TextStyle(fontFamily: 'Raleway', fontSize: 13),
                              ),
                              GestureDetector(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    builder: (context) => ActiveCouponBottomSheet(),
                                  );
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
                              Expanded(
                                child: SizedBox(
                                  height: 40, 
                                 
                                  child: TextField(
                                    decoration: InputDecoration(
                                      hintText: "Enter Coupon Code",
                                      hintStyle:
                                          TextStyle(color: Colors.blue, fontSize: 12),
                                      filled: true,
                                      fillColor: Colors.white,
                                      contentPadding: EdgeInsets.symmetric(
                                          vertical: 0, horizontal: 8),
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(8),
                                        borderSide: BorderSide.none,
                                      ),
                                    ),
                                    style: TextStyle(
                                        fontSize: 12), // Adjust text size to fit
                                    textAlignVertical: TextAlignVertical.center,
                                  ),
                                ),
                              ),
                              SizedBox(width: 8),
                              ElevatedButton(
                                onPressed: () {
                                  // Add your apply coupon logic here
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.black,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 0, vertical: 0),
                                ),
                                child: Text("Apply",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontFamily: 'Nunito Sans',
                                        fontSize: 16)),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                  // Divider(),
                  // TextField(
                  //   decoration: InputDecoration(
                  //     labelText: "Coupon Code",
                  //     hintText: "Enter Coupon Code",
                  //     suffixIcon: TextButton(
                  //       onPressed: () {},
                  //       child: Text("Apply"),
                  //     ),
                  //   ),
                  // ),
                  // Divider(),
                  // _buildPricingDetails(),
                  Container(
                    color: Colors.white,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Pricing Details",
                            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                          ),
                          SizedBox(height: 16),
                          _buildPricingRow("Price (2 item)", "₹ 29,000"),
                          _buildPricingRow("Discount", "- ₹ 17.00"),
                          _buildPricingRow("Platform Fee", "₹ 10"),
                          _buildPricingRow("Delivery Charges", "Free Delivery",
                              valueStyle: TextStyle(color: Colors.green)),
                          Divider(thickness: 1, color: Colors.grey[300]),
                          _buildPricingRow(
                            "Total Amount",
                            "₹ 30,710",
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
                            style: TextStyle(color: Colors.black54, fontSize: 12),
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
                            style: TextStyle(color: Colors.black54, fontSize: 12),
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
                            "₹34,00",
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: 'Raleway'),
                          ),
                        ],
                      ),
                      ElevatedButton(
                        onPressed: () {
                          openCheckout();
                          // Navigator.push(
                          //   context,
                          //   MaterialPageRoute(
                          //       builder: (context) => ManageAddressPage()),
                          // );
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
                      ),
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
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Container(
            width: 60, height: 60,
               decoration: BoxDecoration(border: Border.all(width: 5,color: Colors.white), borderRadius: BorderRadius.circular(100),image: DecorationImage(image: AssetImage(imageUrl),fit: BoxFit.cover)),
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
                    style: TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
                SizedBox(height: 4),
                Text(details,
                    style: TextStyle(
                        color: Colors.black54,
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
    );
  }
}

class ActiveCouponBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Active Coupon Code",
            style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                fontFamily: 'Raleway'),
          ),
          SizedBox(height: 36),

          // 🔽 Here's the added separator
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Voucher",
                        style: TextStyle(
                            color: Color(0xff004CFF),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 18),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffFFEBEB)),
                        child: Center(
                          child: Text(
                            '   Valid Until 5.16.20  ',
                            style: TextStyle(color: Colors.black, fontSize: 12,fontFamily: 'Raleway'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                   MySeparator(color: Colors.grey),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.shopping_bag_rounded,color: Color(0xff004CFF),),
                        Text(' First Purchase',style: TextStyle(fontFamily: 'Raleway',fontSize: 17),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  5% off for your next order',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12),),
                        Container(
                          height: 26, 
                          width: 79, 
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xff004CFF)),
                          child:Center(child: Text('Apply',style: TextStyle(fontFamily: 'Raleway',fontSize: 14,color:Color(0xffFFFFFF)),))
                        )
                      ],
                    )
                ],
              ),
            ),
          ),

         
         
          SizedBox(height: 16),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.blue),
              borderRadius: BorderRadius.circular(8),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "Voucher",
                        style: TextStyle(
                            color: Color(0xff004CFF),
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 18),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xffFFEBEB)),
                        child: Center(
                          child: Text(
                            '   Valid Until 5.16.20  ',
                            style: TextStyle(color: Colors.black, fontSize: 12,fontFamily: 'Raleway'),
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 10,),
                   MySeparator(color: Colors.grey),
                    SizedBox(height: 10,),
                    Row(
                      children: [
                        Icon(Icons.shopping_bag_rounded,color: Color(0xff004CFF),),
                        Text(' First Purchase',style: TextStyle(fontFamily: 'Raleway',fontSize: 17),)
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('  5% off for your next order',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12),),
                        Container(
                          height: 26, 
                          width: 79, 
                          decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xff004CFF)),
                          child:Center(child: Text('Apply',style: TextStyle(fontFamily: 'Raleway',fontSize: 14,color:Color(0xffFFFFFF)),))
                        )
                      ],
                    )
                ],
              ),
            ),
          ),

         
        ],
      ),
    );
  }
}

class CouponCard extends StatelessWidget {
  final String title;
  final String description;
  final String validity;

  CouponCard({
    required this.title,
    required this.description,
    required this.validity,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: Colors.blue),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Voucher",
                    style: TextStyle(
                        color: Color(0xff004CFF),
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Raleway',
                        fontSize: 18),
                  ),
                  SizedBox(height: 15),
                  MySeparator(color: Colors.grey),
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.card_giftcard, color: Colors.black),
                      SizedBox(width: 8),
                      Text(
                        title,
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 17),
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    description,
                    style: TextStyle(
                        color: Colors.black,
                        fontFamily: 'Nunito Sans',
                        fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  height: 30,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(5),
                      color: Color(0xffFFEBEB)),
                  child: Center(
                    child: Text(
                      validity,
                      style: TextStyle(color: Colors.black54, fontSize: 12),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 8),

              // ElevatedButton(
              //   onPressed: () {
              //     // Add action for "Apply"
              //   },
              //   style: ElevatedButton.styleFrom(backgroundColor: Colors.blue),
              //   child: Text("Apply"),
              // ),
            ],
          )
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
