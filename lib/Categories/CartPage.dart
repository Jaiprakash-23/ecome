import 'package:ecome/MyRoutes/myPagesName.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';


class CartScreen extends StatefulWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  int quantity = 1;
  @override
  Widget build(BuildContext context) {
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
            SizedBox(width: 5,),
            CircleAvatar(
            radius: 14,
            backgroundColor: Colors.blue,
            child: const Text(
              '2',
              style: TextStyle(color: Colors.white, fontSize: 12),
            ),
          ),
          ],
        ),
       
      ),
      body: Column(
        children: [
         // SizedBox(height: 120,),
          Expanded(
            child: ListView(
              children: [
                _buildCartItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildCartItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'From Your Wishlist',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
                _buildWishlistItem(
                  imageUrl: 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
                  title: 'Lorem ipsum dolor sit amet consectetur.',
                  price: 17.00,
                  size: 'M',
                  color: 'Pink',
                  onRemove: () {},
                ),
              ],
            ),
          ),
          _buildFooter(total: 34.00, onCheckout: () {}),
        ],
      ),
      
    );
  }

  Widget _buildCartItem({
  required String imageUrl,
  required String title,
  required double price,
  required String size,
  required String color,
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
              Text(title, style: const TextStyle(fontSize: 12,fontFamily: 'Nunito Sans')),
              Text('$color, Size $size', style: const TextStyle(color: Color(0xff000000),fontFamily: 'Raleway')),
              Text('\$$price', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Raleway')),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
           
            children: [
              IconButton(
                icon: const Icon(Icons.remove_circle_outline, color: Color(0xff004BFE)),
                onPressed: () {
                   setState(() {
                            quantity--;
                          });
                },
              ),
              Container(
                height: 30, 
                width: 37, 
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xffE5EBFC)),
                child: Center(child: Text(quantity.toString(), style: TextStyle(fontSize: 16))),
              ),
              
              IconButton(
                icon: const Icon(Icons.add_circle_outline_sharp, color: Color(0xff004BFE)),
                onPressed: () {
                  setState(() {
                      quantity++;
                    });
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}

  Widget _buildWishlistItem({
  required String imageUrl,
  required String title,
  required double price,
  required String size,
  required String color,
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
              Text(title, style: const TextStyle(fontSize: 12,fontFamily: 'Nunito Sans')),
              Text('\$$price', style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 18,fontFamily: 'Raleway')),
               Row(
                 children: [
                   Container(
                    height: 30, 
                    width: 37, 
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Color(0xffE5EBFC)),
                    child: Center(child: Text('$size', style: const TextStyle(color: Color(0xff000000),fontFamily: 'Raleway',fontSize: 14)))),
                     SizedBox(width: 9,),
                     Container(
                    height: 30, 
                    width: 37, 
                    decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color: Color(0xffE5EBFC)),
                    child: Center(child: Text('$color', style: const TextStyle(color: Color(0xff000000),fontFamily: 'Raleway',fontSize: 14)))),
                 ],
               ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Row(
           
            children: [
              
              Container(
                height: 30, 
                width: 37, 
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),),
                child: Image.asset('assets/images/Add.png'),
              ),
              
              
            ],
          ),
        ),
      ],
    ),
  );
}

 
 
  Widget 
  
  
  
  _buildFooter({required double total, required VoidCallback onCheckout}) {
    
    return Container(
     // color: Colors.amber,
      color: Color(0xffF5F5F5),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Total: \$$total',
              style: const TextStyle(fontSize: 20,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
            ),
            GestureDetector(
              onTap: (){
                Get.toNamed(MyPagesName.orderSummaryPage);
              },
              child: Container(
                height: 40, 
                width: 128,
                decoration: BoxDecoration(borderRadius: BorderRadius.circular(9),color:Color(0xff004CFF)),
                child: Center(child: const Text('Checkout',style: TextStyle(fontFamily: 'Nunito Sans',fontSize: 16,color: Color(0xffF3F3F3)),)),
              ),
            )
            // ElevatedButton(
            //   onPressed: onCheckout,
            //   child: const Text('Checkout'),
            // ),
          ],
        ),
      ),
    );
  }


}
