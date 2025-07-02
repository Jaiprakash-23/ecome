import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WalletPage extends StatefulWidget {
  @override
  State<WalletPage> createState() => _WalletPageState();
}

class _WalletPageState extends State<WalletPage> {
  bool isLoading = true;
  String token = '';
  @override
  void initState() {
    // TODO: implement initState
    getToken();
    super.initState();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = (prefs.getString("token") ?? '').trim();

    if (savedToken.isNotEmpty) {
      setState(() {
        token = savedToken;
        isLoading = true;
      });
      await fetchAmountData(token);
      await HIstory(token);
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

  Map<String, dynamic> Amount = {};

  Future<void> fetchAmountData(String token) async {
    var headers = {
      'Authorization': 'Bearer $token',
    };

    var request = http.Request('GET', Uri.parse('$BasseUrl/api/wallet'));

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        Amount = json.decode(responseBody); // Decode JSON into a map
       // print("Amount $Amount"); // Debug: Print the fetched data
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
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
                      '₹ ${Amount['balance'] ?? 0}',
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 32,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                ElevatedButton(
                  onPressed: () {
                     _showReviewBottomSheet(context);
                  },
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
                  height: MediaQuery.of(context).size.height / 1.7,
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
        ],
      ),
    );
  }

 List<dynamic> transactionss = []; // Store transactions as a list

  Future<void> HIstory(String token) async {
  var headers = {
    'Authorization': 'Bearer $token'
  };
  var request = http.Request(
    'GET',
    Uri.parse('$BasseUrl/api/wallet/history'),
  );

  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    var responseBody = await response.stream.bytesToString();
    var data = json.decode(responseBody);
    transactionss= data['transactions'];
    
      print("Transactions: $transactionss");
    } else {
      print("Error: 'data' is null or not a List.");
    }
  } 



Widget buildTransactionList() {
  

  return ListView.builder(
    itemCount: transactionss.length,
    itemBuilder: (context, index) {
     
      bool isCredit = index % 2 == 0;

      return ListTile(
        leading:transactionss[index]['type']=="debit"? Icon(
           Icons.arrow_upward ,
           
          color:  Colors.red,
        ):Icon(
           
            Icons.arrow_downward,
          color:  Colors.green,
        ),
        title: Text(
          'Trans ID: ${transactionss[index]['transaction_id'] ?? 'No Transaction Id'}',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Text("${transactionss[index]['description'] ?? 'No Transaction Id'}"
         
        ),
        trailing:transactionss[index]['type']=="debit"? Text(
         "${transactionss[index]['amount']}" ,
          style: TextStyle(
            color:  Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ):Text(
         "${transactionss[index]['amount']}" ,
          style: TextStyle(
            color:  Colors.green,
            fontWeight: FontWeight.bold,
          ),
        )
      );
    },
  );
}

TextEditingController Amountdata = TextEditingController();

Future<void> addamount(BuildContext context) async {
  if (Amountdata.text.isEmpty) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Please enter a valid amount'),
        backgroundColor: Colors.red,
      ),
    );
    return;
  }

  var headers = {
    'Authorization': 'Bearer $token',
  };
  var request = http.MultipartRequest(
    'POST',
    Uri.parse('$BasseUrl/api/wallet/add-funds'),
  );
  request.fields.addAll({
    'amount': Amountdata.text,
  });
  request.headers.addAll(headers);

  http.StreamedResponse response = await request.send();

  if (response.statusCode == 200) {
    String responseBody = await response.stream.bytesToString();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Amount added successfully!'),
        backgroundColor: Colors.green,
      ),
    );
    Navigator.of(context).pop(); // Close the bottom sheet
  } else {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Failed to add amount: ${response.reasonPhrase}'),
        backgroundColor: Colors.red,
      ),
    );
  }
}

void _showReviewBottomSheet(BuildContext context) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
    ),
    builder: (context) {
      return Padding(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom, // Adds padding for the keyboard
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Enter Amount to Add',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.normal,
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
                      SizedBox(height: 16),
                      TextField(
                        controller: Amountdata,
                        keyboardType: TextInputType.numberWithOptions(),
                        decoration: InputDecoration(
                          hintText: 'Enter Amount',
                          filled: true,
                          fillColor: Color(0xffF1F4FE),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 1,
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                Navigator.of(context).pop();
                              },
                              child: Container(
                                height: 40,
                                width: double.infinity,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Color(0xff000000),
                                ),
                                child: Center(
                                  child: Text(
                                    'Cancel',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: 8),
                          Expanded(
                            child: GestureDetector(
                              onTap: () {
                                addamount(context);
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
                                    'Make Payment',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Nunito Sans',
                                      fontSize: 16,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
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
}




}
