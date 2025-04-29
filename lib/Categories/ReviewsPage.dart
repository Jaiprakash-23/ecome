import 'package:flutter/material.dart';


class ReviewsPage extends StatelessWidget {
  const ReviewsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        elevation: 0,
        title: const Text(
          'Reviews',
          style: TextStyle(
            color: Colors.black,
            fontSize: 28,
            fontFamily: 'Raleway',
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: false,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16.0),
        itemCount: 4, // Number of reviews to display
        itemBuilder: (context, index) {
          return _buildReviewItem(
            userName: 'Veronika',
            userImageUrl: 'assets/images/detailpage.png',
            reviewText:
                'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed diam nonumy eirmod tempor invidunt ut labore et dolore magna aliquyam erat, sed diam voluptua. At vero eos et accusam et justo duo dolores et ea rebum.',
            rating: 5,
          );
        },
      ),
    
    );
  }

  Widget _buildReviewItem({
    required String userName,
    required String userImageUrl,
    required String reviewText,
    required int rating,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 24,
            backgroundImage: AssetImage(userImageUrl),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontSize: 16,
                    fontFamily: 'Raleway',
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Row(
                  children: List.generate(
                    rating,
                    (index) => const Icon(
                      Icons.star,
                      color: Colors.amber,
                      size: 16,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  reviewText,
                  style: const TextStyle(
                    fontSize: 12,
                    fontFamily: 'Nunito Sans',
                    color: Colors.black87,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
