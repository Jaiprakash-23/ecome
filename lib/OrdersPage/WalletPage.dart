import 'package:flutter/material.dart';

class WalletPage extends StatelessWidget {
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
          "My Wallet",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Flex',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
     
     
      body: Column(
        children: [
          // Wallet Header
          Container(
            margin: EdgeInsets.all(16),
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue, Colors.purple],
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Available Balance',
                      style: TextStyle(color: Colors.white, fontSize: 16),
                    ),
                    SizedBox(height: 8),
                    Text(
                      '\$2300',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: Colors.blue,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  child: Text('Add Amount'),
                ),
              ],
            ),
          ),
          // Transaction Tabs
          DefaultTabController(
            length: 3,
            child: Column(
              children: [
                TabBar(
                  labelColor: Colors.blue,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: Colors.blue,
                  tabs: [
                    Tab(text: 'All'),
                    Tab(text: 'Credit History'),
                    Tab(text: 'Debit History'),
                  ],
                ),
                Container(
                  height: 400,
                  child: TabBarView(
                    children: [
                      buildTransactionList(),
                      buildTransactionList(),
                      buildTransactionList(),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Load More Button
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: TextButton(
              onPressed: () {},
              child: Text(
                'Load more...',
                style: TextStyle(color: Colors.blue),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTransactionList() {
    return ListView.builder(
      itemCount: 10,
      itemBuilder: (context, index) {
        bool isCredit = index % 2 == 0;
        return ListTile(
          leading: Icon(
            isCredit ? Icons.arrow_upward : Icons.arrow_downward,
            color: isCredit ? Colors.green : Colors.red,
          ),
          title: Text(
            'Trans ID: #${9228 + index}',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          subtitle: Text(
            isCredit
                ? 'Balance added'
                : 'Used against order #${8832 + index}',
          ),
          trailing: Text(
            isCredit ? '\$14.00' : '-\$37.00',
            style: TextStyle(
              color: isCredit ? Colors.green : Colors.red,
              fontWeight: FontWeight.bold,
            ),
          ),
        );
      },
    );
  }
}


