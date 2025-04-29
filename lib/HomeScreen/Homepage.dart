import 'dart:async';
import 'dart:convert';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecome/Categories/Categories.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/get_navigation.dart';
import 'package:http/http.dart' as http;
import 'package:lucide_icons/lucide_icons.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:video_player/video_player.dart';

class ShopPage extends StatefulWidget {
  @override
  State<ShopPage> createState() => _ShopPageState();
}

class _ShopPageState extends State<ShopPage> {
 List products = [];
  bool isLoading = true;

 

  Future<void> fetchProducts() async {
   var headers = {
  'Authorization': 'Bearer 14|L3zoPZzZeEBH3tEbuxleoiQ9XPSjUeagLqiUAQaS410fd581'
};
var request = http.Request('GET', Uri.parse('https://ensantehealth.com/owngears/public/api/products'));

request.headers.addAll(headers);

http.StreamedResponse response = await request.send();

if (response.statusCode == 200) {
  //print(" products  ${await response.stream.bytesToString()}");
  String responseData = await response.stream.bytesToString();
      products = jsonDecode(responseData)['data'];
      print("products $products");
}
else {
  print(response.reasonPhrase);
}

  }
  int _currentIndex = 0;
  final List<int> _bannerItems = [1, 2, 3, 4];
  final List<Map<String, dynamic>> categories = [
    {
      "title": "Clothing",
      "count": 109,
      "images": [
        "https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/bra/n/o/k/lightly-padded-38d-1-multiway-yes-regular-7281133-dressberry-original-imah7cu2vfpbyhqe.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/a/m/m/xl-1012-janmantar-original-imah3np3npsxwcpz.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/h/s/g/xxl-1003-janmantar-original-imah76bgh2mxvucz.jpeg?q=70"
      ]
    },
    {
      "title": "Shoes",
      "count": 530,
      "images": [
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/o/3/r/3xl-1075-ameerah-original-imah6g4z95yhc5hm.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/m/c/m/3xl-1073-ameerah-original-imah2pg4pkqh5gyz.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/i/z/m/xl-womens-long-polo-good-thing-olv-pajama-gry-yy-clothing-original-imahfqxy8ydpkzeg.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/h/y/u/free-1100-lrt-original-imagn25u5dsrewtw.jpeg?q=70"
      ]
    },
    {
      "title": "Bags",
      "count": 87,
      "images": [
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/p/a/y/xl-pl-fur-nightsuit-peach-pollo-loco-original-imah6ba4ggcxmy3g.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/9/w/l/l-ss-nty40-cotnwhitefloral-swastik-stuffs-original-imah96wpaweb3dng.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/q/q/v/m-nc-gb00a-nivcy-original-imah5gchb47zgdwn.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/kst9gnk0/night-dress-nighty/v/x/v/s-nc-b005-nivcy-original-imag6at759cknghb.jpeg?q=70"
      ]
    },
    {
      "title": "Lingerie",
      "count": 218,
      "images": [
        "https://rukminim2.flixcart.com/image/612/612/ksw4ccw0/night-dress-nighty/p/m/g/xxl-nc-e001-nivcy-original-imag6cr84y79ght7.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/pyjama/e/y/s/5xl-7000-pink-cupid-original-imah8nnymzygncuz.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/g/w/0/3xl-db-5001-star-dreambe-original-imah97m5hhghsrge.jpeg?q=70",
        "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/e/v/r/xl-299-zw23p-cpt-rgn-zebu-original-imagp3swd6ybzhqk.jpeg?q=70"
      ]
    },
  ];
  final List<Map<String, String>> items = [
    {
      'image':
          'https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/y/f/x/xl-ns-110-plush-original-imagsgqtaezbdyzq.jpeg?q=70',
      'title': 'Lorem ipsum dolor sit amet consectetur.',
      'price': '\$17.00'
    },
    {
      'image':
          'https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/4/e/b/s-nightsuit-dreambe-original-imah52exz4fgm3hr.jpeg?q=70',
      'title': 'Lorem ipsum dolor sit amet consectetur.',
      'price': '\$32.00'
    },
    {
      'image':
          'https://rukminim2.flixcart.com/image/612/612/xif0q/apparel-set/c/2/v/l-kevzo-co-ordset-c-olivegreen-co-ords-kevzo-original-imah3yh6mza4n7yb.jpeg?q=70',
      'title': 'Lorem ipsum dolor sit amet consectetur.',
      'price': '\$21.00'
    },
  ];
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
   final List<dynamic>mostList=[
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/f/o/6/free-fk-mix-kf-r-05-capasino-original-imah2dfn8mnsffv6.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/track-suit/9/k/2/xl-5dz-jogging-dress-ladies-jogging-suit-for-women-summer-night-original-imah5qj8umjutrbp.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/k/p/p/s-nd-yellowzig-bachuu-original-imagtbhvjce8grqc.jpeg?q=70"
   ];
   final List<dynamic>justList=[

    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/r/c/j/m-db-t001-dreambe-original-imahyhe9vtkgwzpe.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/kvcpn680/night-dress-nighty/f/i/o/m-pcw00001409-piyali-s-creation-women-s-original-imag8ay73zazazja.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/k/0/0/m-nd-winestrip-bachuu-original-imahfpq9dmahbprb.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/w/g/r/free-11051-11054-trundz-original-imahyyr4zmxgkwyb.jpeg?q=70"
   ];
  int hours = 0, minutes = 36, seconds = 58;
  late Timer _timer;

  // @override
  // void initState() {
  //   super.initState();
  //   _startTimer();
  // }
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    fetchProducts();
    _startTimer();
   
    // Initialize video controller with a network video URL
    _controller = VideoPlayerController.network(
      'https://flutter.github.io/assets-for-api-docs/assets/videos/bee.mp4',
    )
      ..initialize().then((_) {
        setState(() {});
        _controller.pause();
      })
      ..setLooping(true);

       _initializeControllers();
  }

  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }


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

  @override
  void dispose() {
    _timer.cancel();
     _controller.dispose();
      for (var controller in _controllers) {
      controller.dispose();
    }
    super.dispose();
  }

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 16,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80), // Custom height
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            child: SafeArea(
              child: Row(
                children: [
                Image.asset('assets/images/logoapp.png',height: 27,width: 50,),
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
                        decoration: InputDecoration(
                          isDense: true, // tighter layout
                          contentPadding: const EdgeInsets.symmetric(
                              horizontal: 5, vertical: 10), // cursor padding
                          hintText: "Search",
                          prefixIcon: const SizedBox(
                              width: 5), // extra left padding for cursor
                          suffixIcon: const Icon(Icons.camera_alt_outlined,
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
                  overlayColor: MaterialStateProperty.resolveWith<Color?>((states) {
    if (states.contains(MaterialState.pressed) || states.contains(MaterialState.hovered)) {
      return Colors.transparent; // Set overlay color to red when pressed or hovered
    }
    return null; // Default behavior
  }),
                tabs: [
                  Tab(icon: Icon(Icons.shopping_bag), text: "All"),
                  Tab(icon: Icon(Icons.wb_sunny), text: "Summer"),
                  Tab(icon: Icon(Icons.headset), text: "Electronics"),
                  Tab(icon: Icon(Icons.brush), text: "Beauty"),
                  Tab(icon: Icon(Icons.child_friendly), text: "Kids"),
                   Tab(icon: Icon(Icons.shopping_bag), text: "Fashion"),
                  Tab(icon: Icon(Icons.home), text: "Home"),
                  Tab(icon: Icon(Icons.tram_sharp), text: "Travel"),
                  Tab(icon: Icon(Icons.gamepad_sharp), text: "Gadgets"),
                  Tab(icon: Icon(Icons.adf_scanner_outlined), text: "Appliances"),
                  Tab(icon: Icon(Icons.mobile_friendly_rounded), text: "Mobile"),
                  Tab(icon: Icon(Icons.laptop), text: "Laptops"),
                  Tab(icon: Icon(Icons.desktop_mac_outlined), text: "Desktops"),
                   Tab(icon: Icon(Icons.breakfast_dining_rounded), text: "Beauty"),
                  Tab(icon: Icon(Icons.width_full_rounded), text: "Furniture"),
                  Tab(icon: Icon(Icons.sports_baseball), text: "Sports"),
                ],
              ),
             
             
              // SizedBox(
              //   height: 3,
              //   child: TabBarView(
              //     children: [],
              //   ),
              // ),
              _buildBannerSlider(),
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
                  height: 450, // Adjust based on your needs
                  child: GridView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: categories.length,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      crossAxisSpacing: 10,
                      mainAxisSpacing: 10,
                      mainAxisExtent: 222,
                    ),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: (){
                           Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => Categories()),
            );
                          //Get.toNamed(MyPagesName.categories);
                        },
                        child: buildCategoryCard(categories[index]));
                    },
                  ),
                ),
              ),
              Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const Text(
              "ARTICALE REIMAGINED",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                letterSpacing: 1.5,
                color: Colors.black,
                fontFamily: 'Roboto Flex'
              ),
              textAlign: TextAlign.center,
            ),
            //const SizedBox(height: 20),
            _buildVideoCard(_controller),
          ],
        ),
      ),
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
                height: 250,
                //width: 200,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(9),
                ),
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                                    "${products[index]['images']}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${products[index]['name']}",
                                style: TextStyle(
                                    fontSize: 14, fontFamily: "Roboto Flex"),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "${products[index]['price']}",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontFamily: "Roboto Flex",
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
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
                child: 
                Row(
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
                  itemCount: mostList.length,
                  itemBuilder: (context, index) {
                    return Padding(
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
                                            fontFamily: "Roboto Flex"),
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
                                          fontSize: 15, fontFamily: "Roboto Flex"))
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
              SizedBox(height: 20,)
            ],
          ),
        ),
      
      
      
      
      
      
      

        //bottomNavigationBar: _buildBottomNavBar(),
      ),
    );
  }

  Widget _buildVideoCard(VideoPlayerController controller) {
    return SizedBox(
      height: 160,
      width: double.infinity, // Full width of the parent container
      child: controller.value.isInitialized
          ? Stack(
              children: [
                GestureDetector(
                  onTap: _togglePlayPause, // Toggle play/pause on tap
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoPlayer(controller),
                  ),
                ),
                Positioned(
                  bottom: 8,
                  right: 8,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 4, horizontal: 8),
                    decoration: BoxDecoration(
                      color: Color(0xff707070),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text(
                      "Ads",
                      style: TextStyle(color: Colors.white, fontSize: 12),
                    ),
                  ),
                ),
                if (!controller.value.isPlaying)
                  GestureDetector(
                    onTap: _togglePlayPause, // Also handle play on icon tap
                    child: Center(
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }
   final List<VideoPlayerController> _controllers = [];
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

  void _initializeControllers() {
    for (var url in _videoUrls) {
      final controller = VideoPlayerController.network(url)
        ..initialize().then((_) {
          setState(() {});
        })
        ..setLooping(true);
      _controllers.add(controller);
    }
  }

  // @override
  // void dispose() {
  //   for (var controller in _controllers) {
  //     controller.dispose();
  //   }
  //   super.dispose();
  // }

  void _toggleePlayPause(int index) {
    setState(() {
      if (_controllers[index].value.isPlaying) {
        _controllers[index].pause();
        _currentlyPlayingIndex = null;
      } else {
        // Pause all other videos
        for (int i = 0; i < _controllers.length; i++) {
          if (i != index) {
            _controllers[i].pause();
          }
        }
        // Play the selected video
        _controllers[index].play();
        _currentlyPlayingIndex = index;
      }
    });
  }

 Widget _builddVideoCard(int index) {
    final controller = _controllers[index];
    return SizedBox(
      width: 104,
      height: 174,
      child: controller.value.isInitialized
          ? Stack(
              children: [
                GestureDetector(
                  onTap: () => _toggleePlayPause(index),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: VideoPlayer(controller),
                  ),
                ),
                if (!controller.value.isPlaying || _currentlyPlayingIndex != index)
                  Center(
                    child: GestureDetector(
                      onTap: () => _toggleePlayPause(index),
                      child: Icon(
                        Icons.play_circle_outline,
                        color: Colors.white,
                        size: 50,
                      ),
                    ),
                  ),
              ],
            )
          : const Center(child: CircularProgressIndicator()),
    );
  }


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
                      image: AssetImage('asset/baner.png'),
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
            child: GridView.builder(
              shrinkWrap: true, // Ensures GridView doesn't take extra space
              physics:
                  NeverScrollableScrollPhysics(), // Prevents scrolling inside
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 5,
                mainAxisSpacing: 5,
                childAspectRatio: 1, // Ensures square images
              ),
              itemCount: category["images"].length,
              itemBuilder: (context, index) {
                return ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: Image.network(
                    category["images"][index],
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: double.infinity,
                  ),
                );
              },
            ),
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
                      fontFamily: "Roboto Flex", fontSize: 12, color: Colors.black),
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
                    border: Border.all(color: Colors.white,width: 5),
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

 
 
  Widget _buildFlashSaleSection() {
    return Padding(
      padding: EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(_controllers.length, (index) {
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: _builddVideoCard(index),
                  );
                }),
              ),
            ),
            SizedBox(height: 10,),
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
            itemCount: justList.length,
            itemBuilder: (context, index) {
              return Container(
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
                                      "${justList[index]}",
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
                          Text('Flash Sale Item',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontFamily: "Roboto Flex")),
                          Text('\$${(index + 1) * 15}',
                              style: TextStyle(
                                  color: Colors.black, fontFamily: "Roboto Flex")),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      
      
      
        ],
      ),
    );
  }
}

