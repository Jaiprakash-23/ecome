import 'dart:async';
import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/Categories.dart';
import 'package:ecome/Categories/CategoriesPage.dart';
import 'package:ecome/Dashboardd.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:ecome/HomeScreen/ShoppingHomePage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
// import 'package:video_player/video_player.dart';

class ShopPage extends StatefulWidget {
  // final Function(int) onNavigateToTab;
  // const ShopPage({Key? key, required this.onNavigateToTab}) : super(key: key);
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
  List products = [];
  bool isLoading = true;
  String token = '';

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString("token") ?? '').trim();
      fetchCategories(token);
      fetchProducts(token);
      fetchpopularproducts(token);
      fetchjustforyou(token);
    });
    print('Cleaned datatoken: $token');
  }

  Future<void> fetchProducts(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      print("producteds $token");

      var request = http.Request('GET', Uri.parse('$BasseUrl/api/products'));
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        products = jsonDecode(responseData)['data'];
        print("products $products");
      } else {
        print("Error fetching products: ${response.reasonPhrase}");
      }
    } catch (e) {
      print('An error occurred while fetching products: $e');
    }
  }

  List categories = [];
  Future<void> fetchCategories(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      print("gettokendate $token");
      var request = http.Request('GET', Uri.parse('$BasseUrl/api/categories'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        categories = jsonDecode(responseData)['data'];
        print("categories $categories");
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  List popularproducts = [];
  Future<void> fetchpopularproducts(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      print("gettokendate $token");
      var request =
          http.Request('GET', Uri.parse('$BasseUrl/api/popular-products'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        popularproducts = jsonDecode(responseData)['data'];
        print("categories $popularproducts");
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  List justforyou = [];
  Future<void> fetchjustforyou(String token) async {
    try {
      var headers = {'Authorization': 'Bearer $token'};
      print("gettokendate $token");
      var request =
          http.Request('GET', Uri.parse('$BasseUrl/api/just-for-you'));

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        justforyou = jsonDecode(responseData)['data'];
        print("justforyou $justforyou");
      } else {
        print('Error: ${response.reasonPhrase}');
      }
    } catch (e) {
      print('An error occurred: $e');
    }
  }

  int _currentIndex = 0;
  final List<int> _bannerItems = [1, 2, 3, 4];

  final List<dynamic> topitems = [
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/y/g/l/xl-ltpj-urbe-original-imagxm79jjfvssxd.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/s/k/e/xs-dn-01-night-suits-for-ladies-night-suits-for-ladies-sexy-original-imaghecjhsgdj6hm.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/c/v/t/s-550-lotik-original-imagwzqum86ekhhf.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/z/i/p/xl-ns-104-plush-original-imagg36fzsbgefgx.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/l/6/y/s-ns-109-plush-original-imagq42yagcxgtmr.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/a/c/l/free-veer3913-mahaarani-original-imah5ggcn2j6njgz.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/t/e/q/l-ns-109-plush-original-imagq42ygvg3zzxz.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/f/c/x/free-10147-49-trundz-original-imagpcg55pfxhdbg.jpeg?q=70"
  ];
  final List<dynamic> Flashitems = [
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/a/m/m/xl-1012-janmantar-original-imah3np3npsxwcpz.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/p/8/b/free-veer3785-mahaarani-original-imah2qc93veme7nj.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/y/9/m/xxl-pra-wo-collar-pradhruhe-original-imah9u5ddghz8gye.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/d/t/r/free-001-kripto-katrox-original-imah9uacy6rmpcxz.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/z/n/w/3xl-1075-ameerah-original-imah6g4zz5a7er36.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/c/6/o/3xl-1073-ameerah-original-imah2pg4zsyfwzgv.jpeg?q=70"
  ];

  int hours = 0, minutes = 36, seconds = 58;
  late Timer _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _startTimer();
  // }
  //late VideoPlayerController _controller;

  @override
  void initState() {
    getToken();

    super.initState();

    _startTimer();

    // Initialize video controller with a network video URL
    // _controller = VideoPlayerController.network(
    //   'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    // )
    // ..initialize().then((_) {
    //   setState(() {});
    //   _controller.pause();
    // })
    // ..setLooping(true);

    //_initializeControllers();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  // void _togglePlayPause() {
  //   setState(() {
  //     if (_controller.value.isPlaying) {
  //       _controller.pause();
  //     } else {
  //       _controller.play();
  //     }
  //   });
  // }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (hours == 0 && minutes == 0 && seconds == 0) {
        timer.cancel();
      } else {
        setState(() {
          if (seconds > 0) {
            seconds--;
          } else {
            if (minutes > 0) {
              minutes--;
              seconds = 59;
            } else if (hours > 0) {
              hours--;
              minutes = 59;
              seconds = 59;
            }
          }
        });
      }
    });
  }

  // @override
  // void dispose() {
  //   _timer.cancel();
  //   _controller.dispose();
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categories.length,
      child: Scaffold(
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
                  // Text(
                  //   "Shop",
                  //   style: TextStyle(
                  //       fontSize: 28,
                  //       fontWeight: FontWeight.bold,
                  //       color: Colors.black,
                  //       fontFamily: "raleway"),
                  // ),
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
                          prefixIcon: Padding(
                            padding: const EdgeInsets.only(
                                left: 5), // Extra left padding for cursor
                            // child: Icon(Icons.search,
                            //     color:
                            //         Colors.grey), // Replace with a search icon
                          ),
                          suffixIcon: const Icon(Icons.search,
                              color: Colors.blueAccent),
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            //mainAxisAlignment: MainAxisAlignment.start,
            children: [
              TabBar(
                automaticIndicatorColorAdjustment: true,
                labelPadding: EdgeInsets.only(left: 35),
                isScrollable: true,
                dividerColor: Colors.transparent,
                tabAlignment: TabAlignment.center,
                overlayColor:
                    MaterialStateProperty.resolveWith<Color?>((states) {
                  if (states.contains(MaterialState.pressed) ||
                      states.contains(MaterialState.hovered)) {
                    return Colors
                        .transparent; // Set overlay color to red when pressed or hovered
                  }
                  return null; // Default behavior
                }),
                tabs: [
                  // Add a static "Home" tab
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => CategoriesPage(
                            onNavigateBack: () {
                              Navigator.pop(context, 2); // Index to return to
                            },
                          ),
                        ),
                      );
                    },
                    child: Tab(
                      icon: Icon(
                        Icons.list_alt_rounded,
                        size: 30,
                        color: Colors.black,
                      ),
                      text: 'All',
                    ),
                  ),
                  // Add dynamic tabs for categories
                  ...categories.map((category) {
                    return GestureDetector(
                      onTap: () {
                        int productid = category['id'];
                        String categoryName = category['name'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => Categories(
                              productId: productid,
                              categoryName: categoryName, selectedValues: {},
                            ),
                          ),
                        );
                      },
                      child: Tab(
                        icon: CachedNetworkImage(
                          imageUrl: '$imageUrl${category['icon']}',
                          width: 30,
                          height: 30,
                        ),
                        text: category['name'],
                      ),
                    );
                  }).toList(),
                ],
              ),

              // SizedBox(
              //   height: 3,
              //   child: TabBarView(
              //     children: [],
              //   ),
              // ),
              _buildBannerSlider(),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  GestureDetector(
                    onTap: () {
                      Get.toNamed(MyPagesName.dashbordd);
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(builder: (context) => Dashboardd()),
                      // );
                      // Dashboardd
                    },
                    child: Container(
                        height: 80,
                        width: 80,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            color: Color(0xff6F95F3)),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset('assets/images/mobile.png'),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Mobile Repair',
                              style: TextStyle(
                                  fontFamily: 'Roboto Flex', fontSize: 8),
                            )
                          ],
                        )),
                  ),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffFF6B9D)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/technician.png'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Laptop Repair',
                            style: TextStyle(
                                fontFamily: 'Roboto Flex', fontSize: 8),
                          )
                        ],
                      )),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xff69F9CB)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/socialmedia.png'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Exchange Products',
                            style: TextStyle(
                                fontFamily: 'Roboto Flex', fontSize: 8),
                          )
                        ],
                      )),
                  Container(
                      height: 80,
                      width: 80,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(5),
                          color: Color(0xffF1AEAE)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset('assets/images/success.png'),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            'Contests',
                            style: TextStyle(
                                fontFamily: 'Roboto Flex', fontSize: 8),
                          )
                        ],
                      )),
                ],
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Categories',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: "Roboto Flex")),
                    Row(
                      children: [
                        Text(
                          'See All   ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto Flex"),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blueAccent),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  height: 470, // Adjust based on your needs
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length > 4 ? 4 : categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 222,
                    ),
                    itemBuilder: (context, index) {
                      String image = "$imageUrl${categories[index]['image']}";

                      return InkWell(
                          onTap: () {
                            int productid = categories[index]['id'];
                            String categrayname = categories[index]['name'];
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => Categories(
                                        productId: productid,
                                        categoryName: categrayname, selectedValues: {},
                                      )),
                            );
                            //Get.toNamed(MyPagesName.categories);
                          },
                          child:
                              //buildCategoryCard(categories[index]));
                              Container(
                            //height: 700, // Fixed height for the container
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black12,
                                  blurRadius: 5,
                                  spreadRadius: 2,
                                ),
                              ],
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                  child: Container(
                                    color: Colors.white,
                                    // height: 200, // Fixed height for the image grid
                                    child: Container(
                                        height: 157.42,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          // image: DecorationImage(
                                          //   image: (image),
                                          //   fit: BoxFit.cover,
                                          // ),
                                        ),
                                        child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                          child: CachedNetworkImage(
                                            imageUrl: image,
                                            fit: BoxFit.cover,
                                            height: 157.42,
                                          ),
                                          // Image.network(
                                          //   image,
                                          //   fit: BoxFit.cover,
                                          //   height: 157.42,
                                          // )
                                        )),
                                  ),
                                ),
                                SizedBox(height: 6),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${categories[index]['name']}',
                                      style: TextStyle(
                                          fontFamily: "Roboto Flex",
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(height: 5),
                                    // Container(
                                    //   padding: EdgeInsets.symmetric(
                                    //       horizontal: 10, vertical: 6),
                                    //   decoration: BoxDecoration(
                                    //     color: Colors.blue[100],
                                    //     borderRadius: BorderRadius.circular(20),
                                    //   ),
                                    //   child: Text(
                                    //     '${categories[index]['products_count']}',
                                    //     style: TextStyle(
                                    //         fontFamily: "Roboto Flex",
                                    //         fontSize: 12,
                                    //         color: Colors.black),
                                    //   ),
                                    // ),
                                  ],
                                )
                              ],
                            ),
                          ));
                    },
                  ),
                ),
              ),

              // Padding(
              //   padding: const EdgeInsets.all(16.0),
              //   child: Column(
              //     crossAxisAlignment: CrossAxisAlignment.center,
              //     children: [
              //       const Text(
              //         "ARTICALE REIMAGINED",
              //         style: TextStyle(
              //             fontSize: 16,
              //             fontWeight: FontWeight.bold,
              //             letterSpacing: 1.5,
              //             color: Colors.black,
              //             fontFamily: 'Roboto Flex'),
              //         textAlign: TextAlign.center,
              //       ),
              //       //const SizedBox(height: 20),
              //      // _buildVideoCard(_controller),
              //     ],
              //   ),
              // ),
              _buildProductSection('Top Products', 8),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('New Items',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: "Roboto Flex")),
                    Row(
                      children: [
                        Text(
                          'See All   ',
                          style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Roboto Flex"),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blueAccent),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 280,
                //width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        int? productId = products[index]['id'];
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Container(
                          width: 180,
                          decoration: BoxDecoration(
                            // color: Colors.grey[100],
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
                                      "${products[index]['images'][0]}",
                                      height: 134.63,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "${products[index]['title']}",
                                      style: TextStyle(
                                          fontSize: 14, fontFamily: "Roboto Flex"),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_favoriteIndices.contains(index)) {
                                        productdataid = products[index]['id'];
                                        _favoriteIndices.remove(index);
                                        deletewitchdata(productdataid);
                                      } else {
                                        productdataid = products[index]['id'];
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
                              ),
                              // Padding(
                              //   padding:
                              //       const EdgeInsets.symmetric(horizontal: 8.0),
                              //   child:
                              // ),
                              Row(
                                children: [
                                  Text(
                                    "₹ ${double.tryParse(products[index]['price'])?.toInt() ?? 0}",
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontFamily: "Roboto Flex",
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  SizedBox(width: 5,),
                                  Text(
                                    '₹ ${double.tryParse(products[index]['sale_price'])?.toInt() ?? 0}',
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
                                    child: products[index]['discount_offer'] ==
                                            null
                                        ? null
                                        : Container(
                                            height: 18,
                                            width: 39,
                                            decoration: BoxDecoration(
                                                borderRadius: BorderRadius.only(
                                                    topLeft: Radius.circular(9),
                                                    topRight:
                                                        Radius.circular(9),
                                                    bottomLeft:
                                                        Radius.circular(9)),
                                                gradient: LinearGradient(
                                                  colors: [
                                                    Color(0xffFF5790),
                                                    Color(0xffF81140)
                                                  ],
                                                )),
                                            child: Center(
                                                child: Text(
                                              '-${products[index]['discount_offer'] ?? ''}%',
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
                      ),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text('Flash Sale',
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                fontFamily: "Roboto Flex")),
                        Row(
                          children: [
                            Icon(Icons.timer, color: Colors.blue),
                            SizedBox(width: 5),
                            Text(
                              "${hours.toString().padLeft(2, '0')} : ${minutes.toString().padLeft(2, '0')} : ${seconds.toString().padLeft(2, '0')}",
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto Flex"),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    SizedBox(
                      height: 300,
                      child: GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 3,
                          crossAxisSpacing: 2,
                          mainAxisSpacing: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: Flashitems.length,
                        itemBuilder: (context, index) {
                          return Stack(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      image: DecorationImage(
                                        image: NetworkImage(
                                            '${Flashitems[index]}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Positioned(
                                top: 8,
                                right: 8,
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 8, vertical: 4),
                                  decoration: BoxDecoration(
                                    color: Colors.red,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    "-20%",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Roboto Flex"),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Most Popular',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 21,
                            fontFamily: "Roboto Flex")),
                    Row(
                      children: [
                        Text(
                          'See All   ',
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                              fontFamily: "Roboto Flex"),
                        ),
                        Container(
                          height: 30,
                          width: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: Colors.blueAccent),
                          child: Icon(
                            Icons.arrow_forward_rounded,
                            color: Colors.white,
                          ),
                        )
                      ],
                    )
                  ],
                ),
              ),
              Container(
                height: 200,
                //width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: popularproducts.length,
                  //mostList.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        int? productId = popularproducts[index]['id'];
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
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
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
                                      '$imageUrl/products/${popularproducts[index]['images'][0] ?? ''}',
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
                                          '₹${popularproducts[index]['price'] ?? ''} ',
                                          style: TextStyle(
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold,
                                              fontFamily: "Roboto Flex"),
                                        ),
                                        Icon(
                                          Icons.favorite_outlined,
                                          color: Colors.blue,
                                          size: 15,
                                        )
                                      ],
                                    ),
                                    Text(
                                        '${popularproducts[index]['brand'] ?? ''}',
                                        style: TextStyle(
                                            fontSize: 15,
                                            fontFamily: "Roboto Flex"))
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              _buildBannerSliders(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Sponsored',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 11,
                            fontFamily: "Roboto Flex")),
                  ],
                ),
              ),

              _buildFlashSaleSection(),
              SizedBox(
                height: 20,
              )
            ],
          ),
        ),

        //bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  // Widget _buildVideoCard(VideoPlayerController controller) {
  //   return SizedBox(
  //     height: 160,
  //     width: double.infinity, // Full width of the parent container
  //     child: controller.value.isInitialized
  //         ? Stack(
  //             children: [
  //               GestureDetector(
  //                 onTap: _togglePlayPause, // Toggle play/pause on tap
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: VideoPlayer(controller),
  //                 ),
  //               ),
  //               Positioned(
  //                 bottom: 8,
  //                 right: 8,
  //                 child: Container(
  //                   padding:
  //                       const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
  //                   decoration: BoxDecoration(
  //                     color: Color(0xff707070),
  //                     borderRadius: BorderRadius.circular(8),
  //                   ),
  //                   child: const Text(
  //                     "Ads",
  //                     style: TextStyle(color: Colors.white, fontSize: 12),
  //                   ),
  //                 ),
  //               ),
  //               if (!controller.value.isPlaying)
  //                 GestureDetector(
  //                   onTap: _togglePlayPause, // Also handle play on icon tap
  //                   child: Center(
  //                     child: Icon(
  //                       Icons.play_circle_outline,
  //                       color: Colors.white,
  //                       size: 50,
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           )
  //         : const Center(child: CircularProgressIndicator()),
  //   );
  // }

  // final List<VideoPlayerController> _controllers = [];

  final List<String> _videoUrls = [
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
  ];

  int? _currentlyPlayingIndex;

  // @override
  // void initState() {
  //   super.initState();
  //   _initializeControllers();
  // }

  // void _initializeControllers() {
  //   for (var url in _videoUrls) {
  //     final controller = VideoPlayerController.network(url)
  //       ..initialize().then((_) {
  //         setState(() {});
  //       })
  //       ..setLooping(true);
  //     _controllers.add(controller);
  //   }
  // }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  // void _toggleePlayPause(int index) {
  //   setState(() {
  //     if (_controllers[index].value.isPlaying) {
  //       _controllers[index].pause();
  //       _currentlyPlayingIndex = null;
  //     } else {
  //       // Pause all other videos
  //       for (int i = 0; i < _controllers.length; i++) {
  //         if (i != index) {
  //           _controllers[i].pause();
  //         }
  //       }
  //       // Play the selected video
  //       _controllers[index].play();
  //       _currentlyPlayingIndex = index;
  //     }
  //   });
  // }

  // Widget _builddVideoCard(int index) {
  //   final controller = _controllers[index];
  //   return SizedBox(
  //     width: 104,
  //     height: 174,
  //     child: controller.value.isInitialized
  //         ? Stack(
  //             children: [
  //               GestureDetector(
  //                 onTap: () => _toggleePlayPause(index),
  //                 child: ClipRRect(
  //                   borderRadius: BorderRadius.circular(10),
  //                   child: VideoPlayer(controller),
  //                 ),
  //               ),
  //               if (!controller.value.isPlaying ||
  //                   _currentlyPlayingIndex != index)
  //                 Center(
  //                   child: GestureDetector(
  //                     onTap: () => _toggleePlayPause(index),
  //                     child: Icon(
  //                       Icons.play_circle_outline,
  //                       color: Colors.white,
  //                       size: 50,
  //                     ),
  //                   ),
  //                 ),
  //             ],
  //           )
  //         : const Center(child: CircularProgressIndicator()),
  //   );
  // }

  Widget _buildBannerSliders() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: _bannerItems.map((i) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Rounded corners applied here
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/slider1.png'),
                      fit: BoxFit.cover, // Ensure image covers full area
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        // Row(
        //   mainAxisAlignment: MainAxisAlignment.center,
        //   children: _bannerItems.map((url) {
        //     int index = _bannerItems.indexOf(url);
        //     return AnimatedContainer(
        //       duration: Duration(milliseconds: 300),
        //       width: _currentIndex == index ? 25.0 : 8.0,
        //       height: 8.0,
        //       margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
        //       decoration: BoxDecoration(
        //         borderRadius: BorderRadius.circular(5.0),
        //         color: _currentIndex == index ? Colors.blue : Colors.grey,
        //       ),
        //     );
        //   }).toList(),
        // ),
      ],
    );
  }

  Widget _buildBannerSlider() {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150,
              autoPlay: true,
              viewportFraction: 1.0,
              enlargeCenterPage: true,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentIndex = index;
                });
              },
            ),
            items: _bannerItems.map((i) {
              return ClipRRect(
                borderRadius:
                    BorderRadius.circular(10), // Rounded corners applied here
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white,
                    image: DecorationImage(
                      image: AssetImage('assets/images/slider1.png'),
                      fit: BoxFit.cover, // Ensure image covers full area
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: _bannerItems.map((url) {
            int index = _bannerItems.indexOf(url);
            return AnimatedContainer(
              duration: Duration(milliseconds: 300),
              width: _currentIndex == index ? 25.0 : 8.0,
              height: 8.0,
              margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 4.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(5.0),
                color: _currentIndex == index ? Colors.blue : Colors.grey,
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget buildCategoryCard(Map<String, dynamic> category) {
    return Container(
      //height: 700, // Fixed height for the container
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 5,
            spreadRadius: 2,
          ),
        ],
      ),
      padding: EdgeInsets.all(10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              // height: 200, // Fixed height for the image grid
              child: ClipRRect(
            borderRadius: BorderRadius.circular(10),
            child: Image.network(
              "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/o/3/r/3xl-1075-ameerah-original-imah6g4z95yhc5hm.jpeg?q=70",
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          )
              // GridView.builder(
              //   shrinkWrap: true, // Ensures GridView doesn't take extra space
              //   physics:
              //       NeverScrollableScrollPhysics(), // Prevents scrolling inside
              //   gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              //     crossAxisCount: 2,
              //     crossAxisSpacing: 5,
              //     mainAxisSpacing: 5,
              //     childAspectRatio: 1, // Ensures square images
              //   ),
              //   itemCount: category["images"].length,
              //   itemBuilder: (context, index) {
              //     return ClipRRect(
              //       borderRadius: BorderRadius.circular(10),
              //       child: Image.network(
              //         category["images"][index],
              //         fit: BoxFit.cover,
              //         width: double.infinity,
              //         height: double.infinity,
              //       ),
              //     );
              //   },
              // ),
              ),
          SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                category["title"],
                style: TextStyle(
                    fontFamily: "Roboto Flex",
                    fontSize: 17,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 5),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.blue[100],
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  category["count"].toString(),
                  style: TextStyle(
                      fontFamily: "Roboto Flex",
                      fontSize: 12,
                      color: Colors.black),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _buildProductSection(String title, int count) {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(title,
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto Flex")),
              // Icon(Icons.arrow_forward, color: Colors.blue),
            ],
          ),
          SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(count, (index) {
                return Container(
                  width: 70,
                  height: 70,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.white, width: 5),
                      borderRadius: BorderRadius.circular(100),
                      color: Colors.red,
                      image: DecorationImage(
                          image: NetworkImage("${topitems[index]}"),
                          fit: BoxFit.cover)),
                  margin: EdgeInsets.only(right: 10),
                );
              }),
            ),
          ),
        ],
      ),
    );
  }

  final Set<int> _favoriteIndices = {};
  late int productdataid;
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

  Widget _buildFlashSaleSection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SingleChildScrollView(
          //   scrollDirection: Axis.horizontal,
          //   child: Row(
          //     children: List.generate(_controllers.length, (index) {
          //       return Padding(
          //         padding: const EdgeInsets.symmetric(horizontal: 8.0),
          //         child: _builddVideoCard(index),
          //       );
          //     }),
          //   ),
          // ),
          SizedBox(
            height: 10,
          ),
          Row(
            children: [
              Text('Just For You  ',
                  style: TextStyle(
                      fontSize: 21,
                      fontWeight: FontWeight.bold,
                      fontFamily: "Roboto Flex")),
              Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: Icon(
                  Icons.star,
                  color: Colors.blue,
                  size: 15,
                ),
              )
            ],
          ),
          SizedBox(height: 10),
          GridView.builder(
            shrinkWrap: true,
            physics: NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 0.7,
            ),
            itemCount: justforyou.length,
            itemBuilder: (context, index) {
              return GestureDetector(
                onTap: () {
                  int? productId = justforyou[index]['id'];
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
                  margin: EdgeInsets.all(5),
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
                              color: Colors.white),
                          //color: Colors.amber,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(18),
                                  image: DecorationImage(
                                      image: NetworkImage(
                                        "$imageUrl/products/${justforyou[index]['images'][0] ?? ''}",
                                      ),
                                      fit: BoxFit.cover)),
                              // child: Image.network('https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/o/9/6/5xl-c751-white-dennis-lingo-original-imahfgzs7p6abu8v.jpeg?q=70', height: 120, width: double.infinity, fit: BoxFit.cover)
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                    
                                  '${(justforyou[index]['title'] ?? '').length > 20  ? (justforyou[index]['title']?.substring(0, 20) ?? '') + '...' : justforyou[index]['title'] ?? ''}',
                                    
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontFamily: "Nunito Sans",
                                        fontSize: 12)),
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_favoriteIndices.contains(index)) {
                                        productdataid = justforyou[index]['id'];
                                        _favoriteIndices.remove(index);
                                        deletewitchdata(productdataid);
                                      } else {
                                        productdataid = justforyou[index]['id'];
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
                                Text('₹ ${double.tryParse(justforyou[index]['price'])?.toInt() ?? 0}',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontFamily: "Raleway",
                                    fontSize: 17)),
                                    SizedBox(
                                  width: 5,
                                ),
                                Text(
                                  '₹ ${double.tryParse(justforyou[index]['sale_price'])?.toInt() ?? 0}',
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
                                  child: justforyou[index]['discount_offer'] ==
                                          null
                                      ? null
                                      : Container(
                                          height: 18,
                                          width: 39,
                                          decoration: BoxDecoration(
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(9),
                                                  topRight: Radius.circular(9),
                                                  bottomLeft:
                                                      Radius.circular(9)),
                                              gradient: LinearGradient(
                                                colors: [
                                                  Color(0xffFF5790),
                                                  Color(0xffF81140)
                                                ],
                                              )),
                                          child: Center(
                                              child: Text(
                                            '-${justforyou[index]['discount_offer'] ?? ''}%',
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
            },
          ),
        ],
      ),
    );
  }
}
