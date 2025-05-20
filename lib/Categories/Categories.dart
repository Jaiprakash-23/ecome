import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  int productId;
  final String categoryName;

  Categories({required this.productId, required this.categoryName});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map<String, dynamic> data = {};
  String token = '';
   bool isLoading = true;
  List<dynamic> ksubcategories = [];
  List<dynamic> getksubcategories = [];

  /// Fetches the token from shared preferences and retrieves product data.
  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString("token") ?? '').trim();

    if (token.isNotEmpty) {
      await getProduct(token);
    } else {
      print('Token not available.');
    }
  }
/// Fetches product data using the provided token.
Future<void> getProduct(String token) async {
  final headers = {
    'Authorization': 'Bearer $token',
  };

  final url =
      Uri.parse('$BasseUrl/api/categories/subcategories/${widget.productId}');

  try {
    final response = await http.get(url, headers: headers);
    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      setState(() {
        data = responseData;
        ksubcategories = responseData['subcategories'] ?? [];
        getksubcategories = responseData['products'] ?? [];
        isLoading = false; // Set loading to false after data is loaded
      });
      print('Product data loaded successfully.');
    } else {
      setState(() {
        isLoading = false; // Set loading to false even if there's an error
      });
      print('Failed to load product data: ${response.reasonPhrase}');
    }
  } catch (e) {
    setState(() {
      isLoading = false; // Ensure loading is false in case of an exception
    });
    print('Error fetching product data: $e');
  }
}

  /// Fetches product data using the provided token.
  // Future<void> getProduct(String token) async {
  //   final headers = {
  //     'Authorization': 'Bearer $token',
  //   };

  //   final url =
  //       Uri.parse('$BasseUrl/api/categories/subcategories/${widget.productId}');

  //   try {
  //     final response = await http.get(url, headers: headers);
  //     if (response.statusCode == 200) {
  //       final responseData = jsonDecode(response.body);
  //       setState(() {
  //         data = responseData;
  //         ksubcategories = responseData['subcategories'] ?? [];
  //         getksubcategories = responseData['products'] ?? [];
  //       });
  //       print('Product data loaded successfully.');
  //     } else {
  //       print('Failed to load product data: ${response.reasonPhrase}');
  //     }
  //   } catch (e) {
  //     print('Error fetching product data: $e');
  //   }
  // }

 
 
 
  @override
  void initState() {
    super.initState();
    getToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _buildAppBar(),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildProductSection(),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                
                Text(
                  widget.categoryName,
                  style: const TextStyle(
                    fontSize: 21,
                    fontWeight: FontWeight.bold,
                    fontFamily: "Raleway",
                  ),
                ),
                 GestureDetector(
                  onTap: (){
                    Get.toNamed(MyPagesName.filterPage);
                  },
                   child: Row(
                     children: [
                       Text(
                        'Filters',
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.normal,
                          fontFamily: "Nunito Sans",
                        ),
                                       ),
                                       SizedBox(width: 9,),
                        Image.asset('assets/images/Icon65.png'),SizedBox(width: 9,),
                     ],
                   ),
                 ),
              ],
            ),
            const SizedBox(height: 20),
           Expanded(
  child: isLoading // Variable to manage the loading state
      ? const Center(
          child: CircularProgressIndicator(), // Show loader
        )
      : getksubcategories.isEmpty
          ? const Center(
              child: Text(
                "No products available",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.grey,
                ),
              ),
            )
          : GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: getksubcategories.length,
              itemBuilder: (context, index) {
                return _buildProductCard(index);
              },
            ),
),

          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          Image.asset('assets/images/logo.png', height: 27, width: 50),
          const SizedBox(width: 16),
          Expanded(
            child: Container(
              height: 45,
              decoration: BoxDecoration(
                color: Colors.grey[200],
                borderRadius: BorderRadius.circular(25),
              ),
              child: const TextField(
                decoration: InputDecoration(
                  hintText: "Search",
                  suffixIcon: Icon(Icons.camera_alt_outlined,
                      color: Colors.blueAccent),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProductSection() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(ksubcategories.length, (index) {
          return GestureDetector(
            onTap: () async {
              if (index < ksubcategories.length) {
                int subcategoryId = ksubcategories[index]['id'];
                String subcategoryName = ksubcategories[index]['name'];
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => Categories(
                      productId: subcategoryId,
                      categoryName: subcategoryName,
                    ),
                  ),
                );
              } else {
                print('Subcategory index out of bounds.');
              }
            },
            child: _buildSubcategoryItem(index),
          );
        }),
      ),
    );
  }

  Widget _buildSubcategoryItem(int index) {
    final subcategory = ksubcategories[index];
    final productImage = subcategory['image']?.isNotEmpty == true
        ? '$imageUrl${subcategory['image']}'
        : '';

    return Column(
      children: [
        Container(
          width: 70,
          height: 70,
          margin: const EdgeInsets.only(right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            image: imageUrl.isNotEmpty
                ? DecorationImage(
                    image: NetworkImage(productImage),
                    fit: BoxFit.cover,
                  )
                : null,
            color: Colors.grey[200],
          ),
        ),
        Text(
          subcategory['name'] ?? '',
          style: const TextStyle(fontSize: 13, fontFamily: 'Raleway'),
        ),
      ],
    );
  }

  Widget _buildProductCard(int index) {
    final product = getksubcategories[index];
    final productImage = product['images']?.isNotEmpty == true
        ? '$imageUrl/products/${product['images'][0]}'
        : '';

    return InkWell(
      onTap: () {
        int? productId = product['id'];
        if (productId != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => ProductDetailScreen(productId: productId),
            ),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  image: DecorationImage(
                    image: NetworkImage(productImage),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product['title'] ?? '',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontFamily: "Raleway",
                    ),
                  ),
                  Text(
                    '₹ ${product['price'] ?? '0'}',
                    style: const TextStyle(fontFamily: "Raleway"),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
