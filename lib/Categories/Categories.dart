import 'package:ecome/HomeScreen/Homepage.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart'; // Fixed the Get package import
import 'package:lucide_icons/lucide_icons.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
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

  final List<String> topitems = [
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/y/g/l/xl-ltpj-urbe-original-imagxm79jjfvssxd.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/s/k/e/xs-dn-01-night-suits-for-ladies-night-suits-for-ladies-sexy-original-imaghecjhsgdj6hm.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/c/v/t/s-550-lotik-original-imagwzqum86ekhhf.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/z/i/p/xl-ns-104-plush-original-imagg36fzsbgefgx.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/l/6/y/s-ns-109-plush-original-imagq42yagcxgtmr.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/a/c/l/free-veer3913-mahaarani-original-imah5ggcn2j6njgz.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-suit/t/e/q/l-ns-109-plush-original-imagq42ygvg3zzxz.jpeg?q=70",
    "https://rukminim2.flixcart.com/image/612/612/xif0q/night-dress-nighty/f/c/x/free-10147-49-trundz-original-imagpcg55pfxhdbg.jpeg?q=70",
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: SafeArea(
            child: Row(
              children: [
                Image.asset('assets/images/logoapp.png', height: 27, width: 50),
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
                        isDense: true,
                        contentPadding: EdgeInsets.symmetric(
                            horizontal: 10, vertical: 10),
                        hintText: "Search",
                        suffixIcon: Icon(Icons.camera_alt_outlined,
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
      body: Column(
        children: [
          _buildProductSection('', topitems.length),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Categories',
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      fontFamily: "raleway"),
                ),
                // Row(
                //   children: [
                //     const Text(
                //       'See All   ',
                //       style: TextStyle(
                //           fontSize: 15,
                //           fontWeight: FontWeight.bold,
                //           fontFamily: "raleway"),
                //     ),
                //     Container(
                //       height: 30,
                //       width: 30,
                //       decoration: BoxDecoration(
                //           borderRadius: BorderRadius.circular(100),
                //           color: Colors.blueAccent),
                //       child: const Icon(
                //         Icons.arrow_forward_rounded,
                //         color: Colors.white,
                //       ),
                //     )
                //   ],
                // )
              ],
            ),
          ),
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(5),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.7,
              ),
              itemCount: justList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: (){
                     Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => ProductDetailScreen()),
            );
                    //Get.toNamed(MyPagesName.productDetailScreen);
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
                                'Flash Sale Item',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontFamily: "raleway"),
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
     
    );
  }

  Widget _buildProductSection(String title, int count) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
                fontSize: 21, fontWeight: FontWeight.bold, fontFamily: "raleway"),
          ),
          const SizedBox(height: 10),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: List.generate(count, (index) {
                return Column(
                  children: [
                    Container(
                      width: 70,
                      height: 70,
                      decoration: BoxDecoration(
                         boxShadow: [new BoxShadow(
            color: Colors.white,
            blurRadius: 20.0,
          ),],
                        border: Border.all(color: Colors.white,width: 5),
                        borderRadius: BorderRadius.circular(100),
                        image: DecorationImage(
                          image: NetworkImage(topitems[index]),
                          fit: BoxFit.cover,
                        ),
                      ),
                      margin: const EdgeInsets.only(right: 10),
                    ),
                    Text('Dresses',style: TextStyle(
                      fontSize: 13,fontFamily: 'Raleway'
                    ),),
                  ],
                );
              }),
            ),
          ),
        ],
      ),
    );
  }
}
