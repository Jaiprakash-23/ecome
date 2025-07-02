import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/Function.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class ReviewsPage extends StatefulWidget {
  final int productId; // The ID to be passed

  ReviewsPage(this.productId, {Key? key}) : super(key: key);


  @override
  State<ReviewsPage> createState() => _ReviewsPageState();
}

class _ReviewsPageState extends State<ReviewsPage> {
  String token = '';
  List<dynamic> ratings = [];

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString("token") ?? '').trim();

    if (token.isNotEmpty) {
      await fetchRatings(token);
    } else {
      print('Token not available.');
    }
  }

  Future<void> fetchRatings(String token) async {
    try {
      var headers = {
        'Authorization': 'Bearer $token'
      };

      var url = Uri.parse('$BasseUrl/api/all/reviews/${widget.productId}');
      var request = http.Request('GET', url);
      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        var decodedData = jsonDecode(responseBody);

        if (decodedData is List) {
          setState(() {
            ratings = decodedData;
          });
          print('Fetched ratings: $ratings');
        } else {
          print('Unexpected response format.');
        }
      } else {
        print('Failed to fetch ratings: ${response.reasonPhrase}');
      }
    } catch (error) {
      print('Error fetching ratings: $error');
    }
  }

  @override
  void initState() {
    super.initState();
    getToken();
  }

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
        itemCount: ratings.length, // Number of reviews to display
        itemBuilder: (context, index) {
          return _buildReviewItem(
            userName: capitalizeFirstLetter('${ratings[index]['reviewer_name']}'),
            userImageUrl: '${ratings[index]['profile_image']}',
            reviewText:
                '${ratings[index]['review_text']}',
            rating: int.tryParse('${ratings[index]['rating']}') ?? 0,
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
            backgroundColor: Colors.white,
            radius: 24,
            backgroundImage: NetworkImage(userImageUrl),
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
