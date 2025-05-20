import 'package:flutter/material.dart';

class PaymentOptionssPage extends StatefulWidget {
  @override
  State<PaymentOptionssPage> createState() => _PaymentOptionssPageState();
}

class _PaymentOptionssPageState extends State<PaymentOptionssPage> {
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
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '₹49,321',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
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
                  title: Text('Offers'),
                  trailing: Icon(Icons.arrow_forward_ios),
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Select Payment Option',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            SizedBox(height: 8),
            Card(
              elevation: 3,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: Icon(Icons.account_balance_wallet_outlined),
                    title: Text('Wallet'),
                    subtitle: Text('Available Balance - ₹2300'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Wallet payment logic
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.credit_card),
                    title: Text('Debit/Credit Card, UPI Net Banking'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Card/UPI payment logic
                    },
                  ),
                  Divider(height: 1),
                  ListTile(
                    leading: Icon(Icons.money_outlined),
                    title: Text('Cash on Delivery'),
                    trailing: Icon(Icons.arrow_forward_ios),
                    onTap: () {
                      // Cash on Delivery logic
                    },
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
