import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  const WishlistPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mock data for wishlist items
   final wishlistItems = [
  {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Lorem ipsum dolor sit amet consectetur.',
    'price': 17.00, // Explicit double
    'size': 'M',
    'color': 'Pink',
  },
  {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Another item for the wishlist.',
    'price': 25.00, // Explicit double
    'size': 'L',
    'color': 'Blue',
  },
    {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Lorem ipsum dolor sit amet consectetur.',
    'price': 17.00, // Explicit double
    'size': 'M',
    'color': 'Pink',
  },
  {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Another item for the wishlist.',
    'price': 25.00, // Explicit double
    'size': 'L',
    'color': 'Blue',
  },
    {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Lorem ipsum dolor sit amet consectetur.',
    'price': 17.00, // Explicit double
    'size': 'M',
    'color': 'Pink',
  },
  {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Another item for the wishlist.',
    'price': 25.00, // Explicit double
    'size': 'L',
    'color': 'Blue',
  },
    {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Lorem ipsum dolor sit amet consectetur.',
    'price': 17.00, // Explicit double
    'size': 'M',
    'color': 'Pink',
  },
  {
    'imageUrl': 'https://rukminim2.flixcart.com/image/612/612/xif0q/shirt/n/o/w/s-c301-d-blue-dennis-lingo-original-imah3mzamwpbzzzg.jpeg?q=70',
    'title': 'Another item for the wishlist.',
    'price': 25.00, // Explicit double
    'size': 'L',
    'color': 'Blue',
  },

];

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Wishlist',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView(
        children: [
           Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recently viewed',
                  style: TextStyle(fontSize: 21,fontFamily: 'Raleway', fontWeight: FontWeight.bold),
                ),
                Container(
                  height: 30,
                  width: 30, 
                  decoration: BoxDecoration(borderRadius: BorderRadius.circular(100),color:Color(0xff004CFF)),
                  child: Icon(Icons.arrow_forward,color: Colors.white,),
                )
              ],
            ),
          ),
          _buildRecentlyViewedList(),
          // const Padding(
          //   padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          //   child: Text(
          //     'Wishlist',
          //     style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          //   ),
          // ),
          ListView.builder(
            physics: const NeverScrollableScrollPhysics(),
            shrinkWrap: true,
            itemCount: wishlistItems.length,
            itemBuilder: (context, index) {
              final item = wishlistItems[index];
              return _buildWishlistItem(
               imageUrl: item['imageUrl'] as String,
      title: item['title'] as String,
      price: item['price'] as double,
      size: item['color'] as String,
      color: item['size'] as String,
                onRemove: () {
                  // Handle remove action
                  print('Removed item at index $index');
                },
              );
            },
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
                  height: 101.64,
                  width: 121.18,
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
                Text(title, style: const TextStyle(fontSize: 12, fontFamily: 'Nunito Sans')),
                Text('\$$price', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18, fontFamily: 'Raleway')),
                Row(
                  children: [
                    Container(
                      height: 30,
                      width: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xffE5EBFC),
                      ),
                      child: Center(
                          child: Text('$size', style: const TextStyle(color: Color(0xff000000), fontFamily: 'Raleway', fontSize: 14))),
                    ),
                    const SizedBox(width: 9),
                    Container(
                      height: 30,
                      width: 37,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(9),
                        color: const Color(0xffE5EBFC),
                      ),
                      child: Center(
                          child: Text('$color', style: const TextStyle(color: Color(0xff000000), fontFamily: 'Raleway', fontSize: 14))),
                    ),
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
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Image.asset('assets/images/Add.png'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildRecentlyViewedList() {
    return SizedBox(
      height: 100,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        itemCount: 6,
        separatorBuilder: (context, index) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          return CircleAvatar(
            radius: 36,
            backgroundImage: NetworkImage('https://via.placeholder.com/100'),
          );
        },
      ),
    );
  }
}
