import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/CartPage.dart';
import 'package:ecome/Categories/ReviewsPage.dart';
import 'package:ecome/Dashbord.dart';
import 'package:ecome/HomeScreen/ShoppingHomePage.dart';
import 'package:ecome/HomeScreen/VariationsPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ProductDetailScreen extends StatefulWidget {
  final int productId;
  // final Function(int) onNavigateToTab;

  ProductDetailScreen({
    required this.productId,
  });
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
  String token = '';
  Map<String, dynamic> data = {};

  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString("token") ?? '').trim();
    });
    if (token.isNotEmpty) {
      //await fetchProductDetail(token);
      await fetchProductData(token);
      await fetchImages(token).then((_) {
        preloadImages(_imageList);
      });
    } else {
      print('Token not available.');
    }
  }

  Future<void> preloadImages(List<String> urls) async {
    for (String url in urls) {
      await precacheImage(NetworkImage(url), context);
    }
  }

  List<Map<String, dynamic>> variations = [];
  bool isLoading = true;
  Map<String, Set<String>> attributeGroups = {};
  Map<String, String> selectedAttributes = {};

  String buildQueryParams(Map<String, String> filters) {
    return filters.entries.map((entry) {
      final key = entry.key.toLowerCase(); // optional: lowercase keys
      final value = entry.value.toLowerCase(); // handle as string
      return "$key=$value";
    }).join('&');
  }

  var queryParams;
  Future<void> fetchProductData(String token) async {
    queryParams = buildQueryParams(selectedAttributes);
    print(queryParams);
    final attributesQuery = selectedAttributes.entries
        .map((e) =>
            '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final url =
        Uri.parse('$BasseUrl/api/product/${widget.productId}?$queryParams');
    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      data = jsonResponse['data'];
      data = jsonDecode(response.body)['data'] as Map<String, dynamic>;
      final fetchedVariations =
          List<Map<String, dynamic>>.from(data['variation']);
      print('drtyuijhgf $fetchedVariations');
      // Grouping attributes
      Map<String, Set<String>> tempGroups = {};
      for (var variation in fetchedVariations) {
        final attrs = variation['attributes'] as Map<String, dynamic>;
        attrs.forEach((key, value) {
          if (!tempGroups.containsKey(key)) {
            tempGroups[key] = {};
          }
          tempGroups[key]!.add(value.toString());
        });
      }

      Map<String, String> defaultSelections = {
        for (var entry in tempGroups.entries) entry.key: entry.value.first
      };

      setState(() {
        variations = fetchedVariations;
        attributeGroups = tempGroups;
        selectedAttributes =
            selectedAttributes.isEmpty ? defaultSelections : selectedAttributes;
        isLoading = false;
      });
      //selectedAttributes = defaultSelections;
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  int quantity = 1;
  int _currentIndex = 0;
  final List<int> _bannerItems = [1, 2, 3, 4];
  List<String> _imageList = [];

  Future<void> fetchImages(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      var request = http.Request(
        'GET',
        Uri.parse('$BasseUrl/api/product/image/${widget.productId}'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse streamedResponse = await request.send();

      if (streamedResponse.statusCode == 200) {
        final http.Response response =
            await http.Response.fromStream(streamedResponse);
        final Map<String, dynamic> data = json.decode(response.body);

        if (data['success'] == true) {
          setState(() {
            _imageList = List<String>.from(data['images']);
          });
        }
      } else {
        print('Error: ${streamedResponse.reasonPhrase}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  Future<void> cartadd(String productId) async {
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token'
    };
    var request = http.Request('POST', Uri.parse('$BasseUrl/api/addtoCart'));
    request.body = json.encode({
      "product_id": productId,
      "variation": selectedAttributes,
      "quantity": quantity
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }

  final List<String> justList = [
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/r/c/j/m-db-t001-dreambe-original-imahyhe9vtkgwzpe.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/kvcpn680/night-dress-nighty/f/i/o/m-pcw00001409-piyali-s-creation-women-s-original-imag8ay73zazazja.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/k/0/0/m-nd-winestrip-bachuu-original-imahfpq9dmahbprb.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/w/g/r/free-11051-11054-trundz-original-imahyyr4zmxgkwyb.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/r/c/j/m-db-t001-dreambe-original-imahyhe9vtkgwzpe.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/kvcpn680/night-dress-nighty/f/i/o/m-pcw00001409-piyali-s-creation-women-s-original-imag8ay73zazazja.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/k/0/0/m-nd-winestrip-bachuu-original-imahfpq9dmahbprb.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/w/g/r/free-11051-11054-trundz-original-imahyyr4zmxgkwyb.jpeg?q=70",
  ];
  String selectedSize = "M";
  final List<dynamic> mostList = [
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/f/o/6/free-fk-mix-kf-r-05-capasino-original-imah2dfn8mnsffv6.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/track-suit/9/k/2/xl-5dz-jogging-dress-ladies-jogging-suit-for-women-summer-night-original-imah5qj8umjutrbp.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/k/p/p/s-nd-yellowzig-bachuu-original-imagtbhvjce8grqc.jpeg?q=70"
  ];

  PageController _dotController = PageController();

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  int selectedIndex = 0;
  void _openFullScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenGallery(
          imageList: _imageList, // Pass the entire list here
          initialIndex: index,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80), // Custom height
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SafeArea(
            child: Row(
              children: [
                Image.asset(
                  'assets/images/logo.png',
                  height: 27,
                  width: 50,
                ),
                SizedBox(width: 16),
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
                      decoration: InputDecoration(
                        isDense: true, // tighter layout
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 5, vertical: 10), // cursor padding
                        hintText: "Search",
                        prefixIcon: const SizedBox(
                            width: 5), // extra left padding for cursor
                        suffixIcon:
                            const Icon(Icons.search, color: Colors.blueAccent),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildBannerSlider(),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                          child: Text(
                            '${data['title'] ?? ''}',
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontSize: 26,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Raleway'),
                          ),
                        ),
                        Icon(
                          Icons.favorite_outline_sharp,
                          color: Color(0xff004CFF),
                        )
                      ],
                    ),

                    Row(
                      children: [
                        Text(
                          '₹ ${data['sale_price'] ?? ''}',
                          style: TextStyle(
                              fontSize: 26,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Raleway'),
                        ),
                        SizedBox(
                          width: 7,
                        ),
                        Text(
                          '₹ ${data['price'] ?? ''}',
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
                          padding: EdgeInsets.all(0),
                          child: data['discount_offer'] == null
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
                                    '-${data['discount_offer'] ?? ''}%',
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

                    SizedBox(height: 8),
                    Text(
                      '${data['description'] ?? ''}',
                      style: TextStyle(
                          color: Color(0xff000000),
                          fontFamily: 'Nunito Sans',
                          fontSize: 15),
                    ),
                    SizedBox(height: 24),
                    Text(
                      'Variations',
                      style: TextStyle(
                          fontSize: 17,
                          fontFamily: 'Raleway',
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 8),
                    buildGroupedAttributes(),
                    
                    SizedBox(height: 26),
                    Divider(height: 0),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "Quantity",
                          style: TextStyle(
                              fontSize: 17,
                              fontFamily: 'Raleway',
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 8),
                        Row(
                          children: [
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity--;
                                });
                              },
                              child: Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.black)),
                                child: Center(child: Icon(Icons.remove)),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            Container(
                              height: 31,
                              width: 33,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(9),
                                  color: Color(0xffE5EBFC)),
                              child: Center(
                                child: Text(
                                  quantity.toString(),
                                  style: TextStyle(fontSize: 16),
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  quantity++;
                                });
                              },
                              child: Container(
                                height: 37,
                                width: 37,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    border: Border.all(color: Colors.black)),
                                child: Center(child: Icon(Icons.add)),
                              ),
                            ),
                            SizedBox(
                              width: 8,
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 8),
                    GestureDetector(
                      onTap: () async {
                        try {
                          final productId = data[
                              'id']; // Replace 'id' with the correct key if needed.

                          if (productId == null) {
                            print("Product ID is null. Unable to add to cart.");
                            return;
                          }

                          await cartadd(productId.toString());

                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text(
                                    'Item added to cart',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Colors.white,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (_) => CartScreen()),
                                      );
                                    },
                                    child: Text(
                                      'GO TO CART',
                                      style: TextStyle(
                                        fontFamily: 'Roboto Flex',
                                        fontSize: 18,
                                        color: const Color(0xffECA61B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              backgroundColor: Colors.black,
                              behavior: SnackBarBehavior.floating,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              margin: const EdgeInsets.all(16),
                            ),
                          );
                        } catch (e) {
                          print("Error adding to cart: $e");
                        }
                      },
                      child: Container(
                        height: 40,
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(9),
                          color: const Color(0xffECA61B),
                        ),
                        child: const Center(
                          child: Text(
                            'Add To Cart',
                            style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 16,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text('Sold By',
                            style: TextStyle(
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito Sans',
                                fontSize: 16)),
                        SizedBox(
                          width: 70,
                        ),
                        Text('Seller Name',
                            style: TextStyle(
                                color: Color(0xff5982DA),
                                //fontWeight: FontWeight.bold,
                                fontFamily: 'Nunito Sans',
                                fontSize: 16)),
                      ],
                    ),
                    SizedBox(height: 8),
                    Divider(height: 0),
                    SizedBox(height: 8),
                    SizedBox(height: 26),
                    Text('Specifications',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 20)),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Material',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Raleway',
                                fontSize: 15)),
                        SizedBox(width: 10),
                        Container(
                            height: 25,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffFFEBEB)),
                            child: Center(
                                child: Text(
                              'Cotton 95%',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Raleway'),
                            ))),
                        SizedBox(
                          width: 9,
                        ),
                        Container(
                            height: 25,
                            width: 95,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffFFEBEB)),
                            child: Center(
                                child: Text(
                              'Nylon 5%',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Raleway'),
                            )))
                      ],
                    ),
                    SizedBox(height: 10),
                    Row(
                      children: [
                        Text('Type',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Raleway',
                                fontSize: 15)),
                        SizedBox(width: 50),
                        Text('Sports',
                            style: TextStyle(
                                fontWeight: FontWeight.normal,
                                fontFamily: 'Raleway',
                                fontSize: 15)),
                      ],
                    ),
                    SizedBox(height: 10),
                    Text('Details',
                        style: TextStyle(
                            fontWeight: FontWeight.normal,
                            fontFamily: 'Raleway',
                            fontSize: 16)),
                    SizedBox(height: 10),
                    Text('${data['description']}',
                        style: TextStyle(
                            // fontWeight: FontWeight.normal,
                            fontFamily: 'Nunito Sans',
                            fontSize: 16)),
                    SizedBox(height: 26),
                    Text('Rating & Reviews',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 20)),
                    Row(
                      children: [
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star, color: Colors.amber, size: 20),
                        Icon(Icons.star_half, color: Colors.amber, size: 20),
                        SizedBox(width: 4),
                        Container(
                            height: 25,
                            width: 49,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                color: Color(0xffE5EBFC)),
                            child: Center(
                                child: Text(
                              '4/5',
                              style: TextStyle(
                                  fontSize: 14, fontFamily: 'Raleway'),
                            ))),
                      ],
                    ),
                    SizedBox(height: 8),
                    ListTile(
                      contentPadding: EdgeInsets.zero,
                      leading: CircleAvatar(
                          backgroundImage: AssetImage(''),
                          radius: 30,
                          backgroundColor: Colors.grey[200]),
                      title: Text(
                        'Vercellula',
                        style: TextStyle(fontFamily: 'Raleway', fontSize: 16),
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: List.generate(
                                4,
                                (index) => Icon(Icons.star,
                                    color: Colors.amber, size: 16)),
                          ),
                          Text(
                              'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sedienique eu mamis id, pretium pulvinar sapien.',
                              style: TextStyle(
                                  fontFamily: 'Nunito Sans',
                                  fontSize: 12,
                                  color: Color(0xff000000))),
                        ],
                      ),
                    ),
                    SizedBox(height: 15),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => ReviewsPage(widget.productId)),
                        );
                        //Get.toNamed(MyPagesName.reviewsPage);
                      },
                      child: Container(
                        height: 40,
                        width: 335,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                            color: Color(0xff004CFF)),
                        child: Center(
                            child: Text(
                          'View All Reviews',
                          style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 16,
                              color: Colors.white),
                        )),
                      ),
                    ),
                    SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Most Popular',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 21,
                                fontFamily: "raleway")),
                        Row(
                          children: [
                            Text(
                              'See All   ',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 15,
                                  fontFamily: "raleway"),
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.toNamed(MyPagesName.filterPage);
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: Colors.blueAccent),
                                child: Icon(
                                  Icons.arrow_forward_rounded,
                                  color: Colors.white,
                                ),
                              ),
                            )
                          ],
                        )
                      ],
                    ),
                    Container(
                      height: 200,
                      //width: 200,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                      ),
                      child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: mostList.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: Container(
                              width: 150,
                              decoration: BoxDecoration(
                                //color: Colors.grey[100],
                                borderRadius: BorderRadius.circular(12),
                                // boxShadow: [
                                //   BoxShadow(
                                //     color: Colors.black12,
                                //     blurRadius: 4,
                                //     spreadRadius: 2,
                                //   ),
                                // ],
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: Image.network(
                                          mostList[index],
                                          height: 120,
                                          width: double.infinity,
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              '1780',
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: "raleway"),
                                            ),
                                            Icon(
                                              Icons.favorite_outlined,
                                              color: Colors.blue,
                                              size: 15,
                                            )
                                          ],
                                        ),
                                        Text('Sale',
                                            style: TextStyle(
                                                fontSize: 15,
                                                fontFamily: "raleway"))
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    SizedBox(height: 15),
                    Text('You Might Like',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 20)),
                    Container(
                      height: 980,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(5),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                        ),
                        itemCount: justList.length,
                        itemBuilder: (context, index) {
                          return InkWell(
                            onTap: () {
                              // Get.toNamed(MyPagesName.productDetailScreen);
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
                                          image: NetworkImage(justList[index]),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const Text(
                                          'Lorem ipsum dolor \nsit amet consectetur',
                                          style: TextStyle(
                                              // fontWeight: FontWeight.bold,
                                              color: Color(0xff000000),
                                              fontSize: 12,
                                              fontFamily: "Nunito Sans"),
                                        ),
                                        Text(
                                          '\$${(index + 1) * 15}',
                                          style: const TextStyle(
                                              color: Colors.black,
                                              fontFamily: "raleway"),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGroupedAttributes() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attributeGroups.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${entry.key}'.toUpperCase(),
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: entry.value.map((val) {
                  final isSelected = selectedAttributes[entry.key] == val;

                  if (entry.key.toLowerCase() == 'color') {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAttributes[entry.key] = val;
                        });
                        fetchProductData(token);
                      },
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Stack(
                            alignment: Alignment.center,
                            clipBehavior: Clip.none,
                            children: [
                              Container(
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: getColorFromName(val),
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    color: isSelected
                                        ? Colors.red
                                        : Colors.black12,
                                    width: isSelected ? 2 : 1,
                                  ),
                                ),
                              ),
                              if (isSelected)
                                Positioned(
                                  top: 2,
                                  right: 4,
                                  child: CircleAvatar(
                                    radius: 12,
                                    backgroundColor: Colors.black,
                                    child: Icon(
                                      Icons.check,
                                      color: Colors.white,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              // Positioned(
                              //   top: -1,
                              //   right: -5,
                              //   child: Icon(Icons.check_circle, size: 16, color: Colors.black),
                              // ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Text(
                            val,
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: isSelected
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                              color: isSelected ? Colors.red : Colors.black,
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedAttributes[entry.key] = val;
                        });
                        fetchProductData(token);
                      },
                      child: Chip(
                        label: Text(
                          val,
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black,
                          ),
                        ),
                        backgroundColor:
                            isSelected ? Colors.red : Colors.grey[200],
                      ),
                    );
                  }
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  Widget _buildBannerSlider() {
    return SizedBox(
      height: 450,
      child: Stack(
        children: [
          if (_imageList.isNotEmpty)
            CarouselSlider(
              options: CarouselOptions(
                height: 450,
                autoPlay: true,
                viewportFraction: 1.0,
                enlargeCenterPage: false,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentIndex = index;
                  });
                },
              ),
              items: _imageList.map((imageUrl) {
                return GestureDetector(
                  onTap: () => _openFullScreen(_imageList.indexOf(imageUrl)),
                  child: Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: CachedNetworkImageProvider(imageUrl),
                        //"https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/f/o/6/free-fk-mix-kf-r-05-capasino-original-imah2dfn8mnsffv6.jpeg?q=70"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              }).toList(),
            )
          else
            Center(child: CircularProgressIndicator()),

          // DOTS
          if (_imageList.isNotEmpty)
            Positioned(
              bottom: 30,
              left: 0,
              right: 0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _imageList.asMap().entries.map((entry) {
                  int index = entry.key;
                  return AnimatedContainer(
                    duration: Duration(milliseconds: 300),
                    width: _currentIndex == index ? 25.0 : 8.0,
                    height: 8.0,
                    margin: EdgeInsets.symmetric(horizontal: 4.0),
                    decoration: BoxDecoration(
                      color:
                          _currentIndex == index ? Colors.blue : Colors.white,
                      borderRadius: BorderRadius.circular(5.0),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}

class FullScreenGallery extends StatefulWidget {
  final List<String> imageList;
  final int initialIndex;

  const FullScreenGallery({
    required this.imageList,
    required this.initialIndex,
  });

  @override
  State<FullScreenGallery> createState() => _FullScreenGalleryState();
}

class _FullScreenGalleryState extends State<FullScreenGallery> {
  late PageController _pageController;
  int _currentIndex = 0;

  @override
  void initState() {
    _currentIndex = widget.initialIndex;
    _pageController = PageController(initialPage: _currentIndex);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          PhotoViewGallery.builder(
            itemCount: widget.imageList.length,
            pageController: _pageController,
            onPageChanged: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            builder: (context, index) {
              return PhotoViewGalleryPageOptions(
                imageProvider:
                    CachedNetworkImageProvider(widget.imageList[index]),
                minScale: PhotoViewComputedScale.contained,
                maxScale: PhotoViewComputedScale.covered * 2,
                heroAttributes: PhotoViewHeroAttributes(
                  tag: widget.imageList[index],
                ),
              );
            },
            scrollPhysics: const BouncingScrollPhysics(),
            backgroundDecoration: const BoxDecoration(color: Colors.white),
          ),

          // Cancel icon
          Positioned(
            top: 40,
            right: 20,
            child: GestureDetector(
              onTap: () => Navigator.pop(context),
              child: Container(
                padding: EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.close, color: Colors.white, size: 28),
              ),
            ),
          ),

          // Dots
          Positioned(
            bottom: 30,
            left: 0,
            right: 0,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: widget.imageList.asMap().entries.map((entry) {
                return AnimatedContainer(
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeInOut,
                  width: _currentIndex == entry.key ? 20.0 : 10.0,
                  height: 10.0,
                  margin: EdgeInsets.symmetric(horizontal: 5.0),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    borderRadius: BorderRadius.circular(10),
                    color: _currentIndex == entry.key
                        ? Color(0xff004CFF)
                        : Colors.grey[600],
                  ),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'pink':
      return Colors.pink;
    case 'purple':
      return Colors.purple;
    case 'grey':
      return Colors.grey;
    default:
      return Colors.grey[400]!;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}
