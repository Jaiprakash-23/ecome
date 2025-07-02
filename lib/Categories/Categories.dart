import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:ecome/HomeScreen/ShoppingHomePage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Categories extends StatefulWidget {
  int productId;
  final String categoryName;
  final bool showBackIcon; 
   
  //  Map<String, String> selectedValues = {};
Map<String, List<String>> selectedValues = {};
  Categories({required this.productId, this.showBackIcon = false, required this.categoryName, required this.selectedValues, });

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  Map<String, dynamic> data = {};
  final Set<int> _favoriteIndices = {};
  // String token = '';
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


String buildQueryParams(Map<String, List<String>> filters) {
  return filters.entries.map((entry) {
    final key = entry.key.toLowerCase(); // optional: lowercase keys
    final value = entry.value.join(',').toLowerCase(); // convert list to comma-separated string
    return "$key=$value";
  }).join('&');
}
  Future<void> getProduct(String token) async {
   final queryParams = buildQueryParams(widget.selectedValues);
   print('ertyuikjhgfvc $queryParams');
    final headers = {
      'Authorization': 'Bearer $token',
    };

    final url =
        Uri.parse('$BasseUrl/api/categories/subcategories/${widget.productId}?$queryParams');
        
       

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

  @override
  void initState() {
    super.initState();
    getToken();
  }

  int selectedIndex = 0;

  final List<String> options = [
    'Popular',
    'Newest',
    'Price High to Low',
    'Price Low to High',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: _buildAppBar(),
        body: 
        Padding(
  padding: const EdgeInsets.all(8.0),
  child: SingleChildScrollView(
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
          ],
        ),
        const SizedBox(height: 20),
        if (isLoading)
          const Center(
            child: CircularProgressIndicator(), // Show loader
          )
        else if (getksubcategories.isEmpty)
          const Center(
            child: Text(
              "No products available",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.grey,
              ),
            ),
          )
        else
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
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
      ],
    ),
  ),
),

       
        bottomNavigationBar: BottomAppBar(
          height: 50,
          color: Color(0xffFFFFFF),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.zero,
                    ),
                    builder: (context) {
                      int tempSelectedIndex =
                          selectedIndex; // local copy for inside bottom sheet

                      return StatefulBuilder(
                        builder: (context, setModalState) {
                          return Container(
                            width: double.infinity,
                            height: MediaQuery.of(context).size.height * 0.3,
                            //color: Colors.white,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding:
                                      const EdgeInsets.only(top: 26, left: 26),
                                  child: Text(
                                    "SORT BY",
                                    style: TextStyle(
                                        fontFamily: "Roboto Flex",
                                        fontSize: 16),
                                  ),
                                ),
                                Divider(),
                                Center(
                                  child: Wrap(
                                    spacing: 16,
                                    runSpacing: 16,
                                    children:
                                        List.generate(options.length, (index) {
                                      final isSelected =
                                          tempSelectedIndex == index;

                                      return GestureDetector(
                                        onTap: () {
                                          setModalState(() {
                                            tempSelectedIndex = index;
                                          });
                                          setState(() {
                                            selectedIndex = index;
                                          });
                                        },
                                        child: Container(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 24, vertical: 12),
                                          decoration: BoxDecoration(
                                            color: isSelected
                                                ? Colors.blue.shade50
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(24),
                                            border: Border.all(
                                              color: isSelected
                                                  ? Colors.blue
                                                  : Colors.grey.shade300,
                                            ),
                                          ),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              Text(
                                                options[index],
                                                style: TextStyle(
                                                  color: isSelected
                                                      ? Colors.black
                                                      : Colors.grey.shade700,
                                                  fontWeight: isSelected
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                ),
                                              ),
                                              if (isSelected)
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 8.0),
                                                  child: Icon(
                                                    Icons.check_circle,
                                                    color: Colors.black,
                                                    size: 20,
                                                  ),
                                                ),
                                            ],
                                          ),
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                      );
                    },
                  );
                },
                child: Container(
                    height: MediaQuery.of(context).size.height / 1,
                    width: MediaQuery.of(context).size.width / 3,
                    color: Color(0xffFFFFFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/sort.png",height: 20,width: 20,),
                        Text(
                          "  Sort",
                          style: TextStyle(
                              fontFamily: "Roboto Flex", fontSize: 15),
                        ),
                      ],
                    )),
              ),
              Container(
                height: 40,
                width: 1,
                color: Color(0xff898A8D),
              ),
              GestureDetector(
                onTap: () {
                  Get.toNamed(
                    MyPagesName.filterPage,
                    arguments: {'productId': widget.productId},
                  );
                },
                child: Container(
                    height: MediaQuery.of(context).size.height / 1,
                    width: MediaQuery.of(context).size.width / 3,
                    color: Color(0xffFFFFFF),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image.asset("assets/images/edit.png",height: 20,width: 20,),
                        Text("  Filter",
                            style: TextStyle(
                                fontFamily: "Roboto Flex", fontSize: 15)),
                      ],
                    )),
              )
            ],
          ),
        ));
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            if (widget.showBackIcon)
              GestureDetector(
                onTap: () {
                  Navigator.pop(context); 
                },
                child: Container(
              height: 40,
              width: 40,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(100),
                  color: Color(0xff004CFF)),
              child: Center(
                  child: Icon(
                Icons.arrow_back,
                color: Colors.white,
              )),
            ),
              )
            else
               Image.asset('assets/images/logo.png', height: 27, width: 50),
            const SizedBox(width: 16),
            Expanded(
              child: Container(
                height: 45,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(25),
                ),
                child: TextField(
                  autofocus: false,
                  readOnly: true,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ShoppingHomePage(),
                      ),
                    );
                  },
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: "Search",
                    suffixIcon: Icon(Icons.search, color: Colors.blueAccent),
                    border: InputBorder.none,
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 5, vertical: 10),
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    // AppBar(
    //   automaticallyImplyLeading: false,
    //   title: Row(
    //     children: [
    //       Image.asset('assets/images/logo.png', height: 27, width: 50),
    //       const SizedBox(width: 16),
    //       Expanded(
    //         child: Container(
    //           height: 45,
    //           decoration: BoxDecoration(
    //             color: Colors.grey[200],
    //             borderRadius: BorderRadius.circular(25),
    //           ),
    //           child:  TextField(
    //             autofocus: false,
    //                     readOnly: true, 
    //                     onTap: () {
    //                       Navigator.push(
    //                         context,
    //                         MaterialPageRoute(
    //                           builder: (context) => ShoppingHomePage(),
    //                         ),
    //                       );
    //                     },
    //             decoration: InputDecoration(
    //               isDense: true,
    //               hintText: "Search",
    //               suffixIcon:
    //                   Icon(Icons.search, color: Colors.blueAccent),
    //               border: InputBorder.none,
    //               contentPadding:
    //                   const EdgeInsets.symmetric(horizontal: 5, vertical: 10),
    //             ),
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // );
 
 
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
                      categoryName: subcategoryName, selectedValues: {},
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

  Future<void> addwitchdata(int productId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'POST', Uri.parse('$BasseUrl/api/add/wishlist?product_id=$productId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(" fghjuijhgfghj ${await response.stream.bytesToString()}");
    } else {
      print(response.reasonPhrase);
    }
  }

  Future<void> deletewitchdata(int productId) async {
    var headers = {'Authorization': 'Bearer $token'};
    var request = http.Request(
        'POST', Uri.parse('$BasseUrl/api/remove/wishlist/$productId'));

    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(" fghjuijhgfghj ${await response.stream.bytesToString()}");
    } else {
      print(response.reasonPhrase);
    }
  }

  late int productdataid;
  Widget _buildProductCard(int index) {
    final product = getksubcategories[index];
    final productImage = product['images']?.isNotEmpty == true
        ? '$imageUrl/products/${product['images'][0]}'
        : '';

    return InkWell(
      child: Container(
        margin: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(9),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: GestureDetector(
                onTap: () {
                  int? productId = product['id'];
                  if (productId != null) {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) =>
                            ProductDetailScreen(productId: productId),
                      ),
                    );
                  }
                },
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
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      //Text("${widget.selectedValues}"),
                      Text(
                        (product['title'] ?? '').length > 20
                            ? '${product['title']?.substring(0, 20)}...'
                            : product['title'] ?? '',
                        style: const TextStyle(
                         fontSize: 12,
                          fontFamily: "Nunito Sans",
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (_favoriteIndices.contains(index)) {
                              productdataid = product['id'];
                              _favoriteIndices.remove(index);
                              deletewitchdata(productdataid);
                            } else {
                              productdataid = product['id'];
                              _favoriteIndices.add(index);
                              addwitchdata(productdataid);
                            }
                          });
                        },
                        child: Icon(
                          _favoriteIndices.contains(index)
                              ? Icons.favorite
                              : Icons.favorite_outline_sharp,
                          color: _favoriteIndices.contains(index)
                              ? Colors.red
                              : const Color(0xffE7E8EB),
                          size: 18,
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Text(
                          '₹ ${double.tryParse(product['sale_price'])?.toInt() ?? 0}',
                          style: TextStyle(
                              color: Colors.black,
                              fontFamily: "Raleway",
                              fontSize: 15)),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        '₹ ${double.tryParse(product['price'])?.toInt() ?? 0}',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.red,
                          fontFamily: 'Raleway',
                          decoration: TextDecoration.lineThrough,
                        ),
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Padding(
                        padding: const EdgeInsets.all(0),
                        child: product['discount_offer'] == null
                            ? null
                            : Container(
                                height: 18,
                                width: 39,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(9),
                                        topRight: Radius.circular(9),
                                        bottomLeft: Radius.circular(9)),
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xffFF5790),
                                        Color(0xffF81140)
                                      ],
                                    )),
                                child: Center(
                                    child: Text(
                                  '-${product['discount_offer'] ?? ''}%',
                                  style: TextStyle(
                                      fontFamily: 'Raleway',
                                      fontSize: 13,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                )),
                              ),
                      )
                    ],
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
