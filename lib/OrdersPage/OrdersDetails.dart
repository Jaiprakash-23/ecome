import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class OrderDetailsPage extends StatefulWidget {
  @override
  State<OrderDetailsPage> createState() => _OrderDetailsPageState();
}

class _OrderDetailsPageState extends State<OrderDetailsPage> {
  final List<Map<String, String>> steps = [
    {'status': 'Order Confirmed', 'date': '24th April 2025'},
    {'status': 'Shipped', 'date': '26th April 2025'},
    {'status': 'Delivered', 'date': '28th April 2025'},
  ];

  final List<Map<String, String>> orders = [
    {
      'status': 'Arriving Today',
      'image': 'assets/image1.jpg',
      'orderId': '92287157',
      'description': 'Lorem ipsum dolor sit amet conse ...',
    },
    {
      'status': 'Arriving on Thursday',
      'image': 'assets/image2.jpg',
      'orderId': '92287157',
      'description': 'Lorem ipsum dolor sit amet conse ...',
    },
   
  ]; 
 int _selectedRating = 0;
  void _onStarTap(int rating) {
    setState(() {
      _selectedRating = rating;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xffFFFFFF),
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
          "Orders Details",
          style: TextStyle(
              color: Colors.black,
              fontFamily: 'Roboto Flex',
              fontSize: 24,
              fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
     
     
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
               Divider(),
              _buildOrderInfo(),
              //SizedBox(height: 16),
               Divider(),
              // Delivery Status
              _buildDeliveryStatus(),
               Divider(),
              // Order List
              _buildOrderList(),
              SizedBox(height: 16),
              Divider(),
              Center(
                child: Text(
                  'Cancel This Order',style: TextStyle(fontFamily: 'Roboto Flex',fontSize: 10,color: Color(0xff000000)),
                ),
              ),
               Divider(),
              //  Center(child: Text('Rate this product now',style: TextStyle(fontFamily: 'Roboto Flex',fontSize: 10,color: Color(0xff000000)))),
              Center(
        child: GestureDetector(
          onTap: (){
            setState(() {
              _showReviewBottomSheet(context);
            });
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Rate this product now',
                style: TextStyle(fontFamily: 'Roboto Flex',fontSize: 11,color: Color(0xff000000))
              ),
              SizedBox(width: 6),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(5, (index) {
                  return GestureDetector(
                    onTap: () => _onStarTap(index + 1),
                    child: Icon(
                      Icons.star,
                      size: 11,
                      color: _selectedRating > index
                          ? Colors.orange
                          : Color(0xffECA61B),
                    ),
                  );
                }),
              ),
              // SizedBox(height: 16),
              // if (_selectedRating > 0)
              //   Text(
              //     'You rated: $_selectedRating star${_selectedRating > 1 ? 's' : ''}',
              //     style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              //   ),
            ],
          ),
        ),
      ),
                Divider(),
              _buildSectionTitle('Shipping Address'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Balram Agarwal\nMagadi Main Rd, next to Prasanna Theatre, Cholurpalya,\nBengaluru, Karnataka 560023\n+91987654321',
                  style: TextStyle(fontFamily: 'Roboto Flex',fontSize: 11),
                ),
              ),
              SizedBox(height: 16),
              // Price Details
              _buildSectionTitle('Price Details'),
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    _buildPriceRow('Price (2 items)', '₹ 29,000'),
                    _buildPriceRow('Discount', '- ₹ 17.00'),
                    _buildPriceRow('Platform Fee', '₹ 10'),
                    _buildPriceRow(
                        'Delivery Charges', 'Free Delivery', Colors.green),
                    Divider(),
                    _buildPriceRow(
                      'Total Amount',
                      '₹ 30,710',
                      Colors.black,
                      FontWeight.bold,
                      
                    ),
                  ],
                ),
              ),
              SizedBox(height: 16),
              // Download Invoice Button
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text('Download Invoice'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildOrderInfo() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Order Number: OD426748484989',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
            SizedBox(height: 4),
            Text(
              'Order Date: 24th April 2025',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
          ],
        ),
        Column(
          children: [
            Text(
              'Total Amount',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
            Text(
              '₹ 2300.00',
              style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildDeliveryStatus() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          '1 Item Delivered',
          style: TextStyle(fontFamily: 'Roboto Flex', fontSize: 12),
        ),
        SizedBox(height: 8),
        Row(
          children: [
            Text(
              'Package Delivered on ',
              style: TextStyle(
                  fontFamily: 'Roboto Flex', fontSize: 12, color: Color(0xff95989A)),
            ),
            Text(
              '28th April, 2025',
              style: TextStyle(
                  fontFamily: 'Roboto Flex', fontSize: 12, color: Color(0xff000000)),
            ),
          ],
        ),
        SizedBox(height: 16),
        ...steps.map((step) {
          final isLast = steps.indexOf(step) == steps.length - 1;
          return Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Column(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.green,
                    size: 24,
                  ),
                  if (!isLast)
                    Container(
                      height: 40,
                      width: 2,
                      color: Colors.green,
                    ),
                ],
              ),
              SizedBox(width: 8),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      step['status']!,
                      style: TextStyle(
                        fontFamily: 'Roboto Flex',
                        fontSize: 12,
                        fontWeight: FontWeight.bold,
                        color: Colors.green,
                      ),
                    ),
                    Text(
                      step['date']!,
                      style: TextStyle(
                          fontFamily: 'Roboto Flex',
                          fontSize: 12,
                          color: Color(0xff95989A)),
                    ),
                    SizedBox(height: 16),
                  ],
                ),
              ),
            ],
          );
        }).toList(),
      ],
    );
  }

  Widget _buildOrderList() {
    return ListView.builder(
      physics: NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: orders.length,
      itemBuilder: (context, index) {
        final order = orders[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: ListTile(
            leading: Container(
              height: 60, 
              width: 56, 
              decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color:Colors.amber,border: Border.all(color: Colors.white,width: 4)),
            ),
            title: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("Lorem ipsum dolor \nsit amet consectetur.",style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12),),
                     Row(
                       children: [
                        Text("\$17,00",style: TextStyle(fontFamily: 'Raleway',fontSize: 16,fontWeight: FontWeight.bold,color: Color(0xffF1AEAE)),),
                         SizedBox(width: 5,),
                         Text("\$12,00",style: TextStyle(fontFamily: 'Raleway',fontSize: 16,fontWeight: FontWeight.bold),),
                         
                       ],
                     ),
                  ],
                ),
             Text("M - White",style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12,color: Color(0xff000000)),),
              Text("Qty: 1",style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 12,color: Color(0xff000000)),),

              ],
            ),
            
           
          ),
        );
      },
    );
  }

  Widget _buildSectionTitle(String title) {
    return Text(
      title,
      style: TextStyle( fontSize: 11,fontFamily: 'Roboto Flex'),
    );
  }

  Widget _buildPriceRow(String label, String value,
      [Color? color, FontWeight? fontWeight]) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label,style: TextStyle(fontFamily: 'Raleway'),),
          Text(
            value,
            style: TextStyle(
              color: color,
              fontFamily: 'Raleway',
              fontWeight: fontWeight ?? FontWeight.normal,
            ),
          ),
        ],
      ),
    );
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
                  'Review',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
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
                      Row(
                        children: [
                          CircleAvatar(
                            backgroundImage: AssetImage('assets/profile.jpg'), // Replace with your image
                            radius: 20,
                          ),
                          SizedBox(width: 10),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Lorem ipsum dolor sit \namet consectetur.',
                                style: TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Nunito Sans',
                                ),
                              ),
                              Text(
                                'Order #92287157',
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xff202020),
                                  fontFamily: 'Raleway',
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star_border,
                            color: Colors.orange,
                            size: 30,
                          );
                        }),
                      ),
                      SizedBox(height: 16),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'Your comment',
                          filled: true,
                          fillColor: Color(0xffF1F4FE),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: BorderSide.none,
                          ),
                        ),
                        maxLines: 3,
                      ),
                      SizedBox(height: 16),
                      GestureDetector(
                        onTap: (){
                          AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.warning,
                  customHeader: Icon(
                    Icons.done,
                    size: 50,
                    color: Color(0xff85A8FB),
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        Text(
                          'Done!',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        Text('Thank you for your review',style: TextStyle(
                              fontFamily: 'Nunito Sans',
                              fontSize: 13,
                              ),),
                               SizedBox(height: 20,),
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: List.generate(5, (index) {
                          return Icon(
                            Icons.star,
                            color: Colors.orange,
                            size: 30,
                          );
                        }),
                      ),
                      SizedBox(height: 20,)
                      ],
                    ),
                  ),
                  // btnOkColor:Color(0xff85A8FB),
                  // btnOkText:'De activate',
                  // btnCancelColor:Colors.black,
                  // btnCancelOnPress: () {},
                  // btnOkOnPress: () {},
                ).show();
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
                              'Say it!',
                              style: TextStyle(
                                color: Colors.white,
                                fontFamily: 'Nunito Sans',
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
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