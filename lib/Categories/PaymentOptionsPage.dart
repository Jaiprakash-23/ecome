import 'package:flutter/material.dart';

class PaymentOptionsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text("Payment Options"),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16.0),
              ),
              elevation: 4,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Order Summary",
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Image.network(
                          'https://via.placeholder.com/80', // Replace with actual image URL
                          width: 80,
                          height: 80,
                          fit: BoxFit.cover,
                        ),
                        SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("Nike Air Jordan Retro 1 High OG"),
                              SizedBox(height: 4),
                              Text("Qty: 1  Size: 7 UK"),
                            ],
                          ),
                        ),
                      ],
                    ),
                    Divider(height: 32, color: Colors.grey),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Total Amount", style: TextStyle(fontSize: 16)),
                        Text(
                          "₹6,699.0",
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(height: 16),
            ListTile(
              leading: Icon(Icons.local_offer),
              title: Text("Offers"),
              trailing: Icon(Icons.chevron_right),
              onTap: () {},
            ),
            SizedBox(height: 16),
            Text(
              "Select Payment Option",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Card(
              child: ListTile(
                leading: Icon(Icons.account_balance_wallet),
                title: Text("Wallet"),
                subtitle: Text("Available Balance - ₹2300"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.credit_card),
                title: Text("Debit/Credit Card, UPI Net Banking"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Card(
              child: ListTile(
                leading: Icon(Icons.delivery_dining),
                title: Text("Cash on Delivery"),
                trailing: Icon(Icons.chevron_right),
                onTap: () {},
              ),
            ),
            Spacer(),
            Column(
              children: [
                Text("₹6,699", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    minimumSize: Size(double.infinity, 50),
                  ),
                  child: Text("Make Payment"),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
