import 'package:flutter/material.dart';

class FilterPage extends StatefulWidget {
  @override
  State<FilterPage> createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  final List<Map<String, dynamic>> categories = [
    {'label': 'Dresses', 'image': 'assets/dresses.png', 'selected': true},
    {'label': 'Pants', 'image': 'assets/pants.png', 'selected': true},
    {'label': 'Skirts', 'image': 'assets/skirts.png', 'selected': false},
    {'label': 'Shorts', 'image': 'assets/shorts.png', 'selected': false},
    {'label': 'Jackets', 'image': 'assets/jackets.png', 'selected': false},
  ];
  String selectedCategory = 'Clothes';
  String selectedSize = 'M';
  
  final List<Color> colors = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.red,
    Colors.teal,
    Colors.amber,
    Colors.purple,
  ];
 String selectedOption = 'Popular';

  void _onOptionSelected(String option) {
    setState(() {
      selectedOption = option;
    });
  }

  int selectedColorIndex = 0;
  RangeValues _currentRangeValues = const RangeValues(40, 80);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text('Filter',style: TextStyle(fontFamily: 'Raleway',fontSize: 28,fontWeight: FontWeight.bold),),
        actions: [
          IconButton(
            icon: Icon(Icons.close),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Category Selection

            SizedBox(height: 8),
            SizedBox(
              height: 110, // Constraining ListView height
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                itemBuilder: (context, index) {
                  final category = categories[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 8.0),
                    child: Column(
                      children: [
                        Stack(
                          alignment: Alignment.topRight,
                          children: [
                            CircleAvatar(
                              radius: 40,
                              backgroundImage: AssetImage(category['image']),
                            ),
                            if (category['selected'])
                              CircleAvatar(
                                radius: 12,
                                backgroundColor: Colors.black,
                                child: Icon(
                                  Icons.check,
                                  color: Colors.white,
                                  size: 16,
                                ),
                              ),
                          ],
                        ),
                        SizedBox(height: 8),
                        Text(
                          category['label'],
                          style: TextStyle(fontSize: 13,fontFamily: 'Raleway'),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(height: 16),

            // Size Selection
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        ' Size',
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold,fontFamily: 'Raleway'),
                      ),
                      Row(
                        //mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          ChoiceChip(
                            label: Text('Clothes',style: TextStyle(fontFamily: 'Raleway',fontSize: 13,fontWeight: FontWeight.normal),),
                            selected: selectedCategory == 'Clothes',
                            selectedColor: Color(0xffE5EBFC),
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = 'Clothes';
                              });
                            },
                          ),
                          SizedBox(width: 8),
                          ChoiceChip(
                            label: Text('Shoes',style: TextStyle(fontFamily: 'Raleway',fontSize: 14,fontWeight: FontWeight.normal)),
                            selected: selectedCategory == 'Shoes',
                            selectedColor: Color(0xffFFFFFF),
                            onSelected: (selected) {
                              setState(() {
                                selectedCategory = 'Shoes';
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  Container(
                    height: 25,
                    decoration: BoxDecoration(
                      color: Color(0xffF4F6FE),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    padding:
                        const EdgeInsets.symmetric(vertical: 0, horizontal: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: ['XS', 'S', 'M', 'L', 'XL', '2XL'].map((size) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedSize = size;
                            });
                          },
                          child: CircleAvatar(
                            backgroundColor: selectedSize == size
                                ? Color(0xffFFFFFF)
                                : Color(0xffF4F6FE),
                            radius: 15,
                            child: Text(
                              size,
                              style: TextStyle(
                                color: selectedSize == size
                                    ? Colors.black
                                    : Color(0xffAAC3FF),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Color Selection
            Padding(
              padding: const EdgeInsets.all(0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Color",
                    style: TextStyle(fontSize: 20,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: List.generate(colors.length, (index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedColorIndex = index;
                          });
                        },
                        child: Stack(
                          alignment: Alignment.topRight,
                          children: [
                            Container(
                              width: 40,
                              height: 40,
                              decoration: BoxDecoration(
                                color: colors[index],
                                shape: BoxShape.circle,
                                border: Border.all(
                                  color: selectedColorIndex == index
                                      ? Colors.black
                                      : Colors.transparent,
                                  width: 2,
                                ),
                              ),
                            ),
                            if (selectedColorIndex == index)
                              Positioned(
                                top: 0,
                                right: 4,
                                child: Container(
                                  height: 20,
                                  width: 20,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(100),
                                      color: Colors.black),
                                  child: Icon(
                                    Icons.check,
                                    color: Colors.white,
                                    size: 16,
                                  ),
                                ),
                              ),
                          ],
                        ),
                      );
                    }),
                  ),
                ],
              ),
            ),

            SizedBox(height: 16),

            // Price Range
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Price',
                  style: TextStyle(fontSize: 20,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Text('\$10',style: TextStyle(fontFamily: 'Raleway',fontSize: 19,fontWeight: FontWeight.normal),),
                    Text(' - ',style: TextStyle(fontFamily: 'Raleway',fontSize: 19,fontWeight: FontWeight.normal),),
                    Text('\$150',style: TextStyle(fontFamily: 'Raleway',fontSize: 19,fontWeight: FontWeight.normal),),
                  ],
                )
              ],
            ),
            RangeSlider(
              activeColor:Color(0xff004CFF),
             
              values: _currentRangeValues,
              max: 100,
              divisions: 5,
              labels: RangeLabels(
                _currentRangeValues.start.round().toString(),
                _currentRangeValues.end.round().toString(),
              ),
              onChanged: (RangeValues values) {
                setState(() {
                  _currentRangeValues = values;
                });
              },
            ),
            SizedBox(height: 16),

            Row(
              children: [
                Container(
                  height: 30, 
                  width: 162, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color:Color(0xffE5EBFC)),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('        Popular',style: TextStyle(fontFamily: 'Raleway',fontSize: 15,fontWeight: FontWeight.bold),),
                      Container(
                         height: 22, 
                         width: 22, 
                         decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color:Colors.black),
                         child: Icon(Icons.check,color:Colors.white),
                      )
                    ],
                  ),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 30, 
                  width: 162, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color:Color(0xffF9F9F9)),
                  child:  Center(child: Text('Raleway',style: TextStyle(fontFamily: 'Raleway',fontSize: 15,fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
            SizedBox(height: 20,),
            Row(
              children: [
                Container(
                  height: 30, 
                  width: 162, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color:Color(0xffF9F9F9)),
                  child:   Center(child: Text('Price High to Low',style: TextStyle(fontFamily: 'Raleway',fontSize: 15,fontWeight: FontWeight.bold),)),
                ),
                SizedBox(width: 10,),
                Container(
                  height: 30, 
                  width: 162, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(18),color:Color(0xffF9F9F9)),
                  child:  Center(child: Text('Price Low to High',style: TextStyle(fontFamily: 'Raleway',fontSize: 15,fontWeight: FontWeight.bold),)),
                ),
              ],
            ),
            
           
            Spacer(),

            // Buttons
            Row(
              children: [
                Container(
                  height: 50, 
                  width: 91, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),border: Border.all(color: Colors.black)),
                  child: Center(child: Text('Clear',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 22),)),
                ),
                SizedBox(width: 8),
                Expanded(
                  child: Container(
                    height: 50, 
                    width: 236, 
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),color: Colors.black),
                     child: Center(child: Text('Apply',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 22,color: Colors.white),)),
                  )
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
   
}
