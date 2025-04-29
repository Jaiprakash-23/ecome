import 'package:carousel_slider/carousel_slider.dart';
import 'package:ecome/Categories/CartPage.dart';
import 'package:ecome/Categories/ReviewsPage.dart';
import 'package:ecome/Dashbord.dart';
import 'package:ecome/HomeScreen/VariationsPage.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:photo_view/photo_view.dart';
import 'package:photo_view/photo_view_gallery.dart';

class ProductDetailScreen extends StatefulWidget {
  @override
  State<ProductDetailScreen> createState() => _ProductDetailScreenState();
}

class _ProductDetailScreenState extends State<ProductDetailScreen> {
   int quantity = 1;
   int _currentIndex = 0;
    final List<int> _bannerItems = [1, 2, 3, 4];
  final variations = [
    {"color": "Grey", "image": "assets/grey_shoe.png"},
    {"color": "Yellow", "image": "assets/yellow_mic.png"},
    {"color": "White", "image": "assets/white_sneaker.png"},
    {"color": "Green", "image": "assets/green_skirt.png"},
    {"color": "Black", "image": "assets/black_sweater.png"},
  ];
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
   final List<dynamic>mostList=[
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/f/o/6/free-fk-mix-kf-r-05-capasino-original-imah2dfn8mnsffv6.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/track-suit/9/k/2/xl-5dz-jogging-dress-ladies-jogging-suit-for-women-summer-night-original-imah5qj8umjutrbp.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/k/p/p/s-nd-yellowzig-bachuu-original-imagtbhvjce8grqc.jpeg?q=70"
   ];
      
  final List<String> _imageList = [
    'assets/images/detailpage.png',
    'assets/images/detailpage.png',
    'assets/images/detailpage.png',
  ];
    
  PageController _dotController = PageController();

  @override
  void dispose() {
    _dotController.dispose();
    super.dispose();
  }

  void _openFullScreen(int index) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => FullScreenGallery(
          imageList: _imageList,
          initialIndex: index,
        ),
      ),
    );
  }
  @override
  Widget build(BuildContext context) {
    final sizes = [
      {"label": "S", "enabled": true},
      {"label": "M", "enabled": true},
      {"label": "L", "enabled": true},
      {"label": "XL", "enabled": true},
      {"label": "XXL", "enabled": false},
      {"label": "XXXL", "enabled": false},
    ];
  
    return Scaffold(
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
        child: Padding(
          padding: const EdgeInsets.all(0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               _buildBannerSlider(),
              // Product Image Placeholder
    //         Container(
    //   height: 450,
    //   decoration: BoxDecoration(
    //     color: Colors.grey[200],
    //     borderRadius: BorderRadius.circular(10),
    //   ),
    //   child: Stack(
    //     children: [
    //       // Image Slider
    //       CarouselSlider.builder(
    //         itemCount: _imageList.length,
    //         itemBuilder: (context, index, realIndex) {
    //           return GestureDetector(
    //             onTap: () => _openFullScreen(index),
    //             child: Container(
    //               decoration: BoxDecoration(
    //                 borderRadius: BorderRadius.circular(10),
    //                 image: DecorationImage(
    //                   image: AssetImage(_imageList[index]),
    //                   fit: BoxFit.cover,
    //                 ),
    //               ),
    //             ),
    //           );
    //         },
    //         options: CarouselOptions(
    //           height: 450,
    //           viewportFraction: 1.0,
    //           onPageChanged: (index, reason) {
    //             setState(() {
    //               _currentIndex = index;
    //               _dotController.animateToPage(
    //                 index,
    //                 duration: Duration(milliseconds: 300),
    //                 curve: Curves.easeInOut,
    //               );
    //             });
    //           },
    //         ),
    //       ),

    //       // Sliding Dots
    //       Positioned(
    //         bottom: 20,
    //         left: 0,
    //         right: 0,
    //         child: SizedBox(
    //           height: 20,
    //           child: PageView.builder(
    //             controller: _dotController,
    //             itemCount: _imageList.length,
    //             physics: NeverScrollableScrollPhysics(),
    //             itemBuilder: (context, index) {
    //               return Row(
    //                 mainAxisAlignment: MainAxisAlignment.center,
    //                 children: _imageList.asMap().entries.map((entry) {
    //                   return AnimatedContainer(
    //                     duration: Duration(milliseconds: 300),
    //                     curve: Curves.easeInOut,
    //                     width: _currentIndex == entry.key ? 20.0 : 10.0,
    //                     height: 10.0,
    //                     margin: EdgeInsets.symmetric(horizontal: 5.0),
    //                     decoration: BoxDecoration(
    //                       shape: BoxShape.rectangle,
    //                       borderRadius: BorderRadius.circular(10),
    //                       color: _currentIndex == entry.key
    //                           ? Color(0xff0042E0)
    //                           : Colors.grey,
    //                     ),
    //                   );
    //                 }).toList(),
    //               );
    //             },
    //           ),
    //         ),
    //       ),
    //     ],
    //   ),
    // ),
             
            
            
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Stylish girls hot Dress',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          fontFamily: 'Raleway'),
                    ),
                    SizedBox(height: 16),
                    Text(
                      '\$17,00',
                      style: TextStyle(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                          fontFamily: 'Raleway'),
                    ),
                    Row(
                      children: [
                        Text(
                          '\$17,00',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                              color: Colors.red,
                              fontFamily: 'Raleway'),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Container(
                          height: 18,
                          width: 39,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(9),
                                  topRight: Radius.circular(9),
                                  bottomLeft: Radius.circular(9)),
                              gradient: LinearGradient(
                                colors: [Color(0xffFF5790), Color(0xffF81140)],
                              )),
                          child: Center(
                              child: Text(
                            '-20%',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        )
                      ],
                    ),
                    SizedBox(height: 8),
                    Text(
                      'Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam arcu mamis, sedienique eu mamis id, pretium pulvinar sapien.',
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
                    Container(
                      height: 120,
                      //color: Colors.amber,
                      child: ListView.separated(
                        scrollDirection: Axis.horizontal,
                        itemCount: variations.length,
                        separatorBuilder: (context, index) =>
                            SizedBox(width: 16),
                        itemBuilder: (context, index) {
                          final item = variations[index];
                          return Column(
                            children: [
                              Stack(
                                alignment: Alignment.topRight,
                                children: [
                                   Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white,width: 5),
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: AssetImage('assets/images/detailpage.png'),
                          fit: BoxFit.cover,
                        ),
                      ),
                     // margin: const EdgeInsets.only(right: 10),
                    ),
                                  // CircleAvatar(
                                    
                                  //   radius: 30,
                                  //   backgroundImage: AssetImage('assets/images/detailpage.png'),
                                  // ),
                                  if (index ==
                                      1) // Add checkmark for selected item
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
                                ],
                              ),
                              //SizedBox(height: 8),
                              Text(
                                item['color']!,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                    Text('Size',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontFamily: 'Raleway',
                            fontSize: 17)),
                    SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: sizes.map((size) {
                        final isSelected = selectedSize == size["label"];
                        final isEnabled =
                            size["enabled"] == true; // Ensures it's a boolean

                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4.0),
                          child: GestureDetector(
                            onTap: isEnabled
                                ? () {
                                    setState(() {
                                      selectedSize = '${size["label"]!}';
                                    });
                                  }
                                : null,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 16, vertical: 8),
                              decoration: BoxDecoration(
                                color: isSelected
                                    ? Colors.blue.shade50
                                    : isEnabled
                                        ? Colors.white
                                        : Colors.blue.shade100,
                                border: isSelected
                                    ? Border.all(
                                        color: Colors.black, width: 1.5)
                                    : null,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '${size["label"]!}',
                                style: TextStyle(
                                  color: isEnabled ? Colors.black : Colors.grey,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 26),
                    Divider(height: 0),
                    SizedBox(height: 8),
                    Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
              "Quantity",
              style: TextStyle(fontSize: 17,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            Row(
              children: [
                GestureDetector(
                  onTap: (){
                     setState(() {
                            quantity--;
                          });
                      //  quantity > 1
                      // ? () {
                         
                      //   }
                      // : null;

                  },
                  child: Container(
                    height: 37, 
                    width: 37, 
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black)),
                    child: Center(child: Icon(Icons.remove)),
                  ),
                ),
                SizedBox(width: 8,),
                // IconButton(
                //   onPressed: quantity > 1
                //       ? () {
                //           setState(() {
                //             quantity--;
                //           });
                //         }
                //       : null,
                //   icon: Icon(Icons.remove),
                // ),
                Container(
                  height: 31, 
                  width: 33, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xffE5EBFC)),
                  child: Center(
                    child: Text(
                    quantity.toString(),
                    style: TextStyle(fontSize: 16),
                                    ),
                  ),
                ),
                 SizedBox(width: 8,),
                GestureDetector(
                  onTap: (){
                    setState(() {
                      quantity++;
                    });

                  },
                  child: Container(
                      height: 37, 
                      width: 37, 
                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),border: Border.all(color: Colors.black)),
                      child: Center(child: Icon(Icons.add)),
                    ),
                ),
                 SizedBox(width: 8,),
                // IconButton(
                //   onPressed: () {
                //     setState(() {
                //       quantity++;
                //     });
                //   },
                //   icon: Icon(Icons.add),
                // ),
              ],
            ),
          

            ],
           ),
              SizedBox(height: 8),
              GestureDetector(
                onTap: (){
                   Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => CartScreen()),
            );
                },
                child: Container(
                  height: 40, 
                 width: double.infinity,
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xffECA61B)),
                  child: Center(child: Text('Add To Cart',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 16),)),
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
                                SizedBox(width: 70,),
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
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Color(0xffFFEBEB)),
                                      child:Center(child: Text('Cotton 95%',style: TextStyle(fontSize: 14,fontFamily: 'Raleway'),))
                                    ),
                                    SizedBox(width: 9,),
                                    Container(
                                      height: 25, 
                                      width: 95, 
                                      decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color:Color(0xffFFEBEB)),
                                      child:Center(child: Text('Nylon 5%',style: TextStyle(fontSize: 14,fontFamily: 'Raleway'),))
                                    )
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
                                     Text('Lorem ipsum dolor sit amet,  consetetur adipscing elitr, sed diam nonumy eirmodtempor invidunt ut labore et dolore magnaaliquyam erat, sed ... ut labore et dolore magnaaliquyam erat, sed ... ut labore et dolore magnaaliquyam erat, sed ... ',
                                style: TextStyle(
                                   // fontWeight: FontWeight.normal,
                                    fontFamily: 'Nunito Sans',
                                    fontSize: 16)),
                                 SizedBox(height: 26),
                                Text('Rating & Reviews',
                      style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Raleway',fontSize: 20)),
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
                          style: TextStyle(fontSize: 14, fontFamily: 'Raleway'),
                        ))),
                      ],
                    ),
                    SizedBox(height: 8),
                     ListTile(
                contentPadding: EdgeInsets.zero,
                leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/detailpage.png'),
                  radius: 30,
                  backgroundColor: Colors.grey[200]),
                title: Text('Vercellula',style: TextStyle(fontFamily: 'Raleway',fontSize: 16),),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: List.generate(
                          4,
                          (index) =>
                              Icon(Icons.star, color: Colors.amber, size: 16)),
                    ),
                    Text(
                        'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sedienique eu mamis id, pretium pulvinar sapien.',style:TextStyle(fontFamily: 'Nunito Sans',fontSize: 12,color: Color(0xff000000))),
                  ],
                ),
              ),
               SizedBox(height: 15), 
               GestureDetector(
                onTap: (){
                    Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ReviewsPage()),
            );
                  //Get.toNamed(MyPagesName.reviewsPage);
                },
                 child: Container(
                  height: 40, 
                  width: 335, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xff004CFF)),
                  child: Center(child: Text('View All Reviews',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 16,color: Colors.white),)),
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
                          onTap: (){
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
                                          fontSize: 15, fontFamily: "raleway"))
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
                  style: TextStyle(fontWeight: FontWeight.bold,fontFamily: 'Raleway',fontSize: 20)),

                   Container(
                    height: 980,
            child: GridView.builder(
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: justList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
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
                            crossAxisAlignment: CrossAxisAlignment.start,
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
      // bottomNavigationBar: Container(
      //   padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      //   child:Row(
      //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //       children: [
      //         // Favorite Button
      //         ElevatedButton(
      //           onPressed: () {
      //              Get.toNamed(MyPagesName.dashbord, arguments: {'index': 1});
      //             // Handle favorite button press
      //           },
      //           style: ElevatedButton.styleFrom(
      //             elevation: 0,
      //             backgroundColor: Colors.white,
      //             shape: RoundedRectangleBorder(
      //               borderRadius: BorderRadius.circular(12),
      //               side: BorderSide(color: Colors.grey.shade300),
      //             ),
      //             padding: EdgeInsets.symmetric(vertical: 16, horizontal: 16),
      //           ),
      //           child: Icon(
      //             Icons.favorite_border,
      //             color: Colors.black,
      //           ),
      //         ),
      //         // Add to Cart Button
      //         Expanded(
      //           child: Padding(
      //             padding: const EdgeInsets.symmetric(horizontal: 8.0),
      //             child: ElevatedButton(
      //               onPressed: () {
      //                 Get.toNamed(MyPagesName.productPage);
      //                 // Handle add to cart button press
      //               },
      //               style: ElevatedButton.styleFrom(
      //                 backgroundColor: Colors.black,
      //                 shape: RoundedRectangleBorder(
      //                   borderRadius: BorderRadius.circular(12),
      //                 ),
      //                 padding: EdgeInsets.symmetric(vertical: 16),
      //               ),
      //               child: Text(
      //                 "Add to cart",
      //                 style: TextStyle(
      //                   color: Colors.white,
      //                   fontSize: 16,
      //                 ),
      //               ),
      //             ),
      //           ),
      //         ),
      //         // Buy Now Button
      //         Expanded(
      //           child: ElevatedButton(
      //             onPressed: () {
      //               // Handle buy now button press
      //             },
      //             style: ElevatedButton.styleFrom(
      //               backgroundColor: Colors.amber.shade700,
      //               shape: RoundedRectangleBorder(
      //                 borderRadius: BorderRadius.circular(12),
      //               ),
      //               padding: EdgeInsets.symmetric(vertical: 16),
      //             ),
      //             child: Text(
      //               "Buy now",
      //               style: TextStyle(
      //                 color: Colors.white,
      //                 fontSize: 16,
      //               ),
      //             ),
      //           ),
      //         ),
      //       ],
      //     ),
      
      // ),
   
   
    );
  }
  Widget _buildBannerSlider() {
  return SizedBox(
    height: 450,
    child: Stack(
      children: [
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
          items: _imageList.asMap().entries.map((entry) {
            int index = entry.key;
            String imagePath = entry.value;
            return GestureDetector(
              onTap: () => _openFullScreen(index),
              child: Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(imagePath),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            );
          }).toList(),
        ),

        // DOTS
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
                  color: _currentIndex == index ? Colors.blue : Colors.white,
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
// import 'package:flutter/material.dart';
// import 'package:photo_view/photo_view_gallery.dart';

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
                imageProvider: AssetImage(widget.imageList[index]),
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

// class FullScreenGallery extends StatelessWidget {
//   final List<String> imageList;
//   final int initialIndex;

//   const FullScreenGallery({
//     required this.imageList,
//     required this.initialIndex,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.white,
//       body: PhotoViewGallery.builder(
//         itemCount: imageList.length,
//         pageController: PageController(initialPage: initialIndex),
//         builder: (context, index) {
//           return PhotoViewGalleryPageOptions(
//             imageProvider: AssetImage(imageList[index]),
//             minScale: PhotoViewComputedScale.contained,
//             maxScale: PhotoViewComputedScale.covered * 2,
//             heroAttributes: PhotoViewHeroAttributes(tag: imageList[index]),
//           );
//         },
//         scrollPhysics: BouncingScrollPhysics(),
//         backgroundDecoration: BoxDecoration(color: Colors.white),
//       ),
//     );
//   }
// }
