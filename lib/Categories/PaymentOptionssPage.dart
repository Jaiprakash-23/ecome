import 'package:flutter/material.dart';

class PaymentOptionssPage extends StatefulWidget {
  @override
  State<PaymentOptionssPage> createState() => _PaymentOptionssPageState();
}

class _PaymentOptionssPageState extends State<PaymentOptionssPage> {
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
                      fontFamily: "Raleway"
                    ),
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price (10 items)',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '₹48,927',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Pickup Charges',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '₹129',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Packaging Charges',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '₹167',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Protect Promise Fee',
                            style: TextStyle(fontSize: 16),
                          ),
                          Text(
                            '₹98',
                            style:
                                TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),),
            SizedBox(height: 16),
            GestureDetector(
              onTap: () {
                // Add offers functionality
              },
              child: Card(
                elevation: 3,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                child: ListTile(
                  leading: Icon(Icons.local_offer_outlined),
                  title: Text('Offers',style: TextStyle(
                    fontFamily: "Nunito Sans",
                    fontSize: 16
                  ),),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select Payment Option',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,fontFamily: "Roboto"),
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
                  SizedBox(height: 16,),
                  Container(
                    height: 46,
                    width: 295,
                    decoration: BoxDecoration(
                      color: Color(0xffF2F5FE),
                      borderRadius: BorderRadius.circular(9)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/wallet_3.png"),
                        Text('Wallet',style: TextStyle(fontFamily: "Nunito Sans",fontSize: 12,),),
                        Text('Available Balance - ₹2300',style: TextStyle(fontFamily: "Nunito Sans",fontSize: 12,color: Color(0xff4CD9B1)),),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                  SizedBox(height: 16,),
                   Container(
                    height: 46,
                    width: 295,
                    decoration: BoxDecoration(
                      color: Color(0xffF2F5FE),
                      borderRadius: BorderRadius.circular(9)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/imagesss.png"),
                        Text('Debit/Credit Card, UPI Net Banking',style: TextStyle(fontFamily: "Nunito Sans",fontSize: 12,color: Color(0xff606060)),),
                        //Text('Available Balance - ₹2300',style: TextStyle(fontFamily: "Nunito Sans",fontSize: 12,color: Color(0xff4CD9B1)),),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                 
                 SizedBox(height: 16,),
                   Container(
                    height: 46,
                    width: 295,
                    decoration: BoxDecoration(
                      color: Color(0xffF2F5FE),
                      borderRadius: BorderRadius.circular(9)
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Image.asset("assets/images/imagesss.png"),
                        Text('Cash on Delivery',style: TextStyle(fontFamily: "Nunito Sans",fontSize: 12,color: Color(0xff606060)),),
                        //Text('Available Balance - ₹2300',style: TextStyle(fontFamily: "Nunito Sans",fontSize: 12,color: Color(0xff4CD9B1)),),
                        Icon(Icons.arrow_forward_ios),
                      ],
                    ),
                  ),
                ],
              ), 
            ),
            SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '₹6,699',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                ElevatedButton(
                  onPressed: () {
                    // Make payment logic
                  },
                  child: Text('Make Payment'),
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
