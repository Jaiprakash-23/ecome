import 'dart:convert';
import 'package:ecome/Bassurl.dart';
import 'package:ecome/HomeScreen/ProductDetailScreen.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ShoppingHomePage extends StatefulWidget {
  const ShoppingHomePage({super.key});

  @override
  State<ShoppingHomePage> createState() => _ShoppingHomePageState();
}

class _ShoppingHomePageState extends State<ShoppingHomePage> {
  final TextEditingController _searchController = TextEditingController();
  List<String> recentSearches = [];
  final List<String> recommendations = [
    'Skirt',
    'Accessories',
    'Black T-Shirt',
    'Jeans',
    'White Shoes'
  ];
  List<dynamic> searchResults = [];
  List<String> filteredSuggestions = [];
  final String apiUrl = "$BasseUrl/api/search";
  //final String token = "56|SsvSXqLRb9lf81JBFfAbX2GTNv4Zd470LtU7fzYG6ba1afea";
  bool isLoading = false;
  String token = '';
  @override
  void initState() {
    super.initState();
    getToken();
    _loadRecentSearches();
    _searchController.addListener(_updateSuggestions);
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString("token") ?? '').trim();

    if (token.isNotEmpty) {
      await _loadRecentSearches();
    } else {
      print('Token not available.');
    }
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches = prefs.getStringList('recentSearches') ?? [];
    });
  }

  Future<void> _addToRecentSearches(String search) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      if (recentSearches.contains(search)) {
        recentSearches.remove(search);
      }
      recentSearches.insert(0, search);
      if (recentSearches.length > 10) {
        recentSearches = recentSearches.sublist(0, 10);
      }
    });
    await prefs.setStringList('recentSearches', recentSearches);
  }

  Future<void> _fetchSearchResults(String keyword, String token) async {
    if (isLoading) return;

    setState(() {
      isLoading = true;
    });

    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var url = Uri.parse('$apiUrl?keyword=$keyword');

      var response = await http.get(url, headers: headers);

      if (response.statusCode == 200) {
        final dynamic responseBody = json.decode(response.body);

        if (responseBody is Map<String, dynamic> &&
            responseBody['results'] is List) {
          setState(() {
            searchResults = responseBody['results'][0]['data'];
          });
          print('searchResults $searchResults');
        } else {
          setState(() {
            searchResults = [];
          });
          print('Unexpected data format or missing "results" key.');
        }
      } else {
        print(
            'Failed to fetch results: ${response.statusCode} ${response.reasonPhrase}');
        setState(() {
          searchResults = [];
        });
      }
    } catch (e) {
      print('Error fetching search results: $e');
      setState(() {
        searchResults = [];
      });
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void _onSearchSubmit(String value) {
    if (value.trim().isNotEmpty) {
      _addToRecentSearches(value.trim());
      _fetchSearchResults(value.trim(), token);
    }
  }

  void _updateSuggestions() {
    String query = _searchController.text.toLowerCase();
    if (query.isEmpty) {
      setState(() {
        filteredSuggestions = [];
      });
      return;
    }

    setState(() {
      filteredSuggestions = [
        ...recentSearches.where((item) => item.toLowerCase().contains(query)),
        ...recommendations.where((item) => item.toLowerCase().contains(query)),
      ].toSet().toList(); // Remove duplicates
    });
  }

  void _clearRecentSearches() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      recentSearches.clear();
    });
    await prefs.remove('recentSearches');
  }

  void _onChipTap(String value) {
    _searchController.text = value;
    _onSearchSubmit(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 0, backgroundColor: Colors.transparent, elevation: 0),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: ListView(children: [
            // Search Bar
            Row(
              children: [
                Container(
                  height: 40,
                  width: 40,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xff004CFF),
                  ),
                  child: Center(
                    child: IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _searchController,
                    onSubmitted: _onSearchSubmit,
                    decoration: InputDecoration(
                      hintText: "Search",
                      prefixIcon: const SizedBox(width: 2),
                      suffixIcon: const Icon(Icons.camera_alt_outlined),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30),
                      ),
                      contentPadding: EdgeInsets.zero,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Suggestions
            if (filteredSuggestions.isNotEmpty && searchResults.isEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: filteredSuggestions
                    .map(
                      (suggestion) => GestureDetector(
                        onTap: () => _onChipTap(suggestion),
                        child: Padding(
                            padding: const EdgeInsets.symmetric(vertical: 4),
                            child: Container(
                                margin: EdgeInsets.all(4),
                                height: 20,
                                width: double.infinity,
                                child: ListTile(
                                  leading: Icon(Icons.search),
                                  title: Text(suggestion,
                                      style: const TextStyle(fontSize: 16)),
                                  trailing: Icon(Icons.arrow_outward_outlined),
                                ))),
                      ),
                    )
                    .toList(),
              ),

            if (_searchController.text.isNotEmpty &&
                searchResults.isNotEmpty) ...[
              const SizedBox(height: 16),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: searchResults.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (_, index) => Column(
                  children: [
                    Expanded(
                      child: GestureDetector(
                        onTap: (){
                          int? productId = searchResults[index]['id'];
                if (productId != null) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => ProductDetailScreen(productId: productId),
                    ),
                  );
                }
                        },
                        child: Container(
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Colors.grey[200],
                            image: DecorationImage(
                              image: NetworkImage(
                                  '$imageUrl/products/${searchResults[index]['images'][0]}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          (searchResults[index]['title'] ?? '')
                              .toString()
                              .substring(
                                  0,
                                  (searchResults[index]['title'] ?? '')
                                              .toString()
                                              .length >
                                          10
                                      ? 10
                                      : (searchResults[index]['title'] ?? '')
                                          .toString()
                                          .length), // Limit to 5 characters
                          maxLines:
                              1, // Ensure it's a single line for 5 characters
                          overflow:
                              TextOverflow.ellipsis, // Add ellipsis if needed
                          style: TextStyle(
                            fontFamily: "Nunito Sans",
                            fontSize: 12,
                            color: Color(0xff000000),
                          ),
                        ),
                        Icon(
                          Icons.favorite_outline_sharp,
                          color: Color(0xffE7E8EB),
                          size: 14,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        Text(
                          '₹ ${searchResults[index]['sale_price'] ?? ''}',
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                              fontFamily: 'Raleway'),
                        ),
                        Text(
                          '₹ ${searchResults[index]['price'] ?? ''}',
                          style: TextStyle(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.red,
                            fontFamily: 'Raleway',
                            decoration: TextDecoration.lineThrough,
                          ),
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
                            '-${searchResults[index]['discount_offer'] ?? ''}%',
                            style: TextStyle(
                                fontFamily: 'Raleway',
                                fontSize: 13,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],

            // Hide other sections if suggestions are visible
            if (filteredSuggestions.isEmpty) ...[
              const SizedBox(height: 16),
              sectionTitle("Recent Searches", onDelete: _clearRecentSearches),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: recentSearches
                    .map((item) => GestureDetector(
                          onTap: () => _onChipTap(item),
                          child: chip(item),
                        ))
                    .toList(),
              ),
              const SizedBox(height: 16),
              sectionTitle("Recommendations"),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: recommendations.map((item) => chip(item)).toList(),
              ),
              const SizedBox(height: 16),
              Text("Popular Products",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              const SizedBox(height: 12),
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: 4,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemBuilder: (_, index) => Column(
                  children: [
                    Expanded(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(12),
                          color: Colors.grey[200],
                          image: DecorationImage(
                            image: AssetImage(
                                'assets/images/product${index + 1}.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text("Lorem ipsum",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Text("Women's Clothes",
                        style: TextStyle(color: Colors.grey)),
                  ],
                ),
              ),
            ],
          ]),
        ),
      ),
    );
  }

  Widget chip(String label) => Chip(
        label: Text(label),
        backgroundColor: Colors.grey[200],
      );

  Widget sectionTitle(String text, {VoidCallback? onDelete}) => Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text,
              style:
                  const TextStyle(fontWeight: FontWeight.bold, fontSize: 14)),
          if (text == "Recent Searches")
            IconButton(
              icon:
                  const Icon(Icons.delete, size: 18, color: Color(0xffD97474)),
              onPressed: onDelete,
            ),
        ],
      );
}
