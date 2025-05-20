import 'dart:async';
import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/OrderSummaryPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  List<dynamic> Cartdata = [];
  String token = '';

  @override
  void initState() {
    super.initState();

    getToken();
    Cartgetdata('');
    startAutoRefresh();
  }

  void incrementQuantity(int index) {
    setState(() {
      Increment();
      Cartdata[index]["quantity"]++;
    });
  }

  void decrementQuantity(int index) {
    setState(() {
      dncrement();
      if (Cartdata[index]["quantity"] > 1) {
        Cartdata[index]["quantity"]--;
      }
      Cartgetdata('token');
    });
  }

  bool isLoading = true;

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = (prefs.getString("token") ?? '').trim();

    if (savedToken.isNotEmpty) {
      setState(() {
        token = savedToken;
        isLoading = true;
      });
      await Cartgetdata(token);
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

  Future<void> Cartgetdata(String token) async {
    if (token.isEmpty) {
      print("Token is empty");
      return;
    }

    try {
      var headers = {'Authorization': 'Bearer $token'};
      var response =
          await http.get(Uri.parse('$BasseUrl/api/cart'), headers: headers);

      if (response.statusCode == 200) {
        setState(() {
          Cartdata = jsonDecode(response.body)['data'] ?? [];
        });
        print('Cartdata $Cartdata');
      } else {
        print("Error: ${response.statusCode} - ${response.reasonPhrase}");
      }
    } catch (e) {
      print("API Call Failed: $e");
    }
  }


//   }

  @override
  void dispose() {
    timer?.cancel(); // Cancel the timer when the widget is disposed
    super.dispose();
  }

  Timer? timer;
  void startAutoRefresh() {
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (mounted) {
        Cartgetdata(token);
      }
    });
  }

  late int Product_Id;
  Future<void> Increment() async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InE5Z1BKRUhTZ2xKcWcwZ3hVckhoNHc9PSIsInZhbHVlIjoidXArc1dLODNNcWorYWtuL2hzQ1Q0b3pDQlgxQ2F4U3hVNGJ3Um1URW5ZdUwyc0RjNVdOY1M2WEFSdlJGQkdiSURrSGF4SHFidmFqazQ2RFZOdmx5bE1JY0lVS0s4RmU4bDAxVzBKU2FudUJhZFVING5yRkpBWHYvOHpQdEZLWnciLCJtYWMiOiIzMzVhNTQ4MmRhOGFhZmViMmY5MmVkMTIzOWUwNjdhNTkxNjYwZDI1ZGI5ZmMzODY0NGFlYzNmYWFmYjE4MzQyIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImI0cHExd1pELzgvZTcvTjRwVWlOUmc9PSIsInZhbHVlIjoiOXhyZFU0MmxIaHpHSmo5TkpzTzdtbHJEaWZTb245d3pjWUl5TkRSNFRnU0JYTVFtSWh4ZnBsbnNIcUNtbUpWQ3ZnelNJekZGNFl3VC85bWMwUXRDUlJuelh6dkl0enlNSDRNTXJaUy9NTTRaeU1QeUpSRmtBM3lCQ2p1UFV1ZWwiLCJtYWMiOiJhNWMyNzk0Nzc0ZWYyODA0NDkyNDlhYzkzMTEzYTBlM2VhMGExYjQ5OGI3YjE5Y2EyOTIyNGU4ZWZjZWUwMWVkIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$BasseUrl/api/add/quantity?product_id=$Product_Id&quantity=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> dncrement() async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InE5Z1BKRUhTZ2xKcWcwZ3hVckhoNHc9PSIsInZhbHVlIjoidXArc1dLODNNcWorYWtuL2hzQ1Q0b3pDQlgxQ2F4U3hVNGJ3Um1URW5ZdUwyc0RjNVdOY1M2WEFSdlJGQkdiSURrSGF4SHFidmFqazQ2RFZOdmx5bE1JY0lVS0s4RmU4bDAxVzBKU2FudUJhZFVING5yRkpBWHYvOHpQdEZLWnciLCJtYWMiOiIzMzVhNTQ4MmRhOGFhZmViMmY5MmVkMTIzOWUwNjdhNTkxNjYwZDI1ZGI5ZmMzODY0NGFlYzNmYWFmYjE4MzQyIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImI0cHExd1pELzgvZTcvTjRwVWlOUmc9PSIsInZhbHVlIjoiOXhyZFU0MmxIaHpHSmo5TkpzTzdtbHJEaWZTb245d3pjWUl5TkRSNFRnU0JYTVFtSWh4ZnBsbnNIcUNtbUpWQ3ZnelNJekZGNFl3VC85bWMwUXRDUlJuelh6dkl0enlNSDRNTXJaUy9NTTRaeU1QeUpSRmtBM3lCQ2p1UFV1ZWwiLCJtYWMiOiJhNWMyNzk0Nzc0ZWYyODA0NDkyNDlhYzkzMTEzYTBlM2VhMGExYjQ5OGI3YjE5Y2EyOTIyNGU4ZWZjZWUwMWVkIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'POST',
        Uri.parse(
            '$BasseUrl/api/cart/decrement?product_id=$Product_Id&quantity=1'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> Delete() async {
    var headers = {
      'Authorization': 'Bearer $token',
      'Cookie':
          'XSRF-TOKEN=eyJpdiI6InpRRmloSFR3UWIySWk1UWtKVEh0L0E9PSIsInZhbHVlIjoiWWRzWmVaWDArNFJ2Rlgxb0x2OUFidHJOUnlqckh5QXZna1ZZRUZHUjJIdnpHNzkvOE1UVnNqNzhjalRWTGpyajV1Ui9WQkJnRFNTeEZZUG9mY2IveDcxN3dMeWNGaEpERm02QVdjbm5PU2wxa2tZS2FLWGtiejZoYWo4Si8xNGsiLCJtYWMiOiI5ZmI5NmZlZjBiNDI1YzQ5MjEyMmM3YzVmNDYyNjFiYTk4MzkyZWVjMDUyOGRlZDg5ZmVkMGUyN2ZiNzQxYjBiIiwidGFnIjoiIn0%3D; laravel_session=eyJpdiI6ImxQTVRqQjF4TUlwVHF4a1UwMkhKMnc9PSIsInZhbHVlIjoiTXlFNmQ3d0EweisrbUNiNnMrRXptczhjbFdRbGE2OUtHeHRCNllVaFlMeGJQQURBTGFwa1gwZzYyVnJzbjY5eXoyOGxwSTh0ZWxGajlNakhRUHVxUTU3TnlDOFhvb2hvVG5KRTZjcy8wbUU4ekJWK3Fkck4yMDlIcmNla0c3T0kiLCJtYWMiOiI0MzlkYmJmYmUxNzg5YjgzYWU3Mzk0OGJmYTgxNjIyYTc5OTM3Y2ZiZDllYTQ2MTBhMDkyODFlNzhjNzE0NzUyIiwidGFnIjoiIn0%3D'
    };
    var request = http.Request(
        'DELETE', Uri.parse('$BasseUrl/api/cart/delete/$Product_Id'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  @override
  Widget build(BuildContext context) {
    setState(() {});
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: Row(
          children: [
            const Text(
              'Cart',
              style: TextStyle(
                color: Colors.black,
                fontSize: 28,
                fontFamily: 'Raleway',
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(width: 5),
            CircleAvatar(
              radius: 14,
              backgroundColor: Colors.blue,
              child: Text(
                '2',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Cartdata == null || Cartdata.isEmpty
                      ? Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/EmptyCart.png'),
                              SizedBox(height: 10),
                              Text(
                                'Your cart is empty!',
                                style:
                                    TextStyle(fontSize: 18, color: Colors.grey),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          physics: NeverScrollableScrollPhysics(),
                          shrinkWrap: true, // Allow the list to be scrollable
                          itemCount: Cartdata.length,
                          itemBuilder: (context, index) {
                            return _buildCartItem(
                              imageUrl:
                                  '$imageUrl/products/${Cartdata[index]['product']['images'][0] ?? 'ertyui'}',
                              title:
                                  '${Cartdata[index]['product']['title'] ?? 'ertyui'}',
                              price:
                                  "${Cartdata[index]['product']['sale_price'] ?? 'drtyui'}",
                              size:
                                  '${Cartdata[index]['product']['size'] ?? 'rtyuio'}',
                              color:
                                  '${Cartdata[index]['product']['color'] ?? 'rtyui'}',
                              quantity:
                                  "${Cartdata[index]['quantity'].toString()}",
                              onIncrease: () {
                                setState(() {
                                  Product_Id = Cartdata[index]['product_id'];
                                  incrementQuantity(index);
                                });
                              },
                              onDecrease: () {
                                setState(() {
                                  Product_Id = Cartdata[index]['product_id'];
                                  decrementQuantity(index);
                                });
                              },
                              onRemove: () async {
                                setState(() {
                                  Product_Id = Cartdata[index]['product_id'];
                                });
                                await Delete(); // Call the delete method
                                await Cartgetdata(token); // Refresh cart data
                                setState(
                                    () {}); // Update the UI with the latest data
                              },
                            );
                          },
                        ),
                  Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Text(
                      'From Your Wishlist',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  ListView.builder(
                    itemCount: 3,
                    shrinkWrap: true, // Allow the list to be scrollable
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return _buildCartItemm(
                        imageUrl:
                            'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                        title: 'Lorem ipsum dolor sit amet consectetur.',
                        price: 17.00,
                        size: 'M',
                        color: 'Pink',
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          _buildFooter(
            total: 188, // Calculate total
            onCheckout: () {},
          ),
        ],
      ),
    );
  }

  Widget _buildCartItem({
    required String imageUrl,
    required String title,
    required String price,
    required String size,
    required String color,
    required String quantity,
    required VoidCallback onIncrease,
    required VoidCallback onDecrease,
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
                  height: 80,
                  width: 80,
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
                Text('$color, Size $size',
                    style: const TextStyle(
                        color: Color(0xff000000), fontFamily: 'Raleway')),
                Text('₹ $price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Raleway')),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 50),
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.remove_circle_outline,
                      color: Color(0xff004BFE)),
                  onPressed: onDecrease,
                ),
                Container(
                  height: 30,
                  width: 37,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(9),
                      color: const Color(0xffE5EBFC)),
                  child: Center(
                      child: Text(quantity.toString(),
                          style: const TextStyle(fontSize: 16))),
                ),
                IconButton(
                  icon: const Icon(Icons.add_circle_outline_sharp,
                      color: Color(0xff004BFE)),
                  onPressed: onIncrease,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildCartItemm({
    required String imageUrl,
    required String title,
    required double price,
    required String size,
    required String color,
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
                  height: 80,
                  width: 80,
                  fit: BoxFit.cover,
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
                Text('$color, Size $size',
                    style: const TextStyle(
                        color: Color(0xff000000), fontFamily: 'Raleway')),
                Text('₹ $price',
                    style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        fontFamily: 'Raleway')),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(
      {required double total, required VoidCallback onCheckout}) {
    return Cartdata.isEmpty
        ? Container()
        : Container(
            color: const Color(0xffF5F5F5),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Total: ₹ $total',
                    style: const TextStyle(
                        fontSize: 20,
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.bold),
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => OrderSummaryPage()),
                      // );
                      Get.toNamed(MyPagesName.orderSummaryPage);
                    },
                    child: Container(
                      height: 40,
                      width: 128,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: const Color(0xff004CFF)),
                      child: const Center(
                          child: Text('Checkout',
                              style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 16,
                                  color: Color(0xffF3F3F3)))),
                    ),
                  )
                ],
              ),
            ),
          );
  }
}
