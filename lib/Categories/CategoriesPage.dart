import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/Categories.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

class CategoriesPage extends StatefulWidget {
   final VoidCallback onNavigateBack;
   const CategoriesPage({required this.onNavigateBack});
  @override
  _CategoriesPageState createState() => _CategoriesPageState();
}

class _CategoriesPageState extends State<CategoriesPage> {
 String token = ''; // Replace with your token
  List<Map<String, dynamic>> _categories = [];
  Map<int, List<Map<String, dynamic>>> _subcategoriesMap =
      {}; // Cache for subcategories
  bool _isLoading = true;

 bool isLoading = true;
 Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String savedToken = (prefs.getString("token") ?? '').trim();

    if (savedToken.isNotEmpty) {
      setState(() {
        token = savedToken;
        isLoading = true;
      });
      await fetchCategories(token);
      setState(() {
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Token not available.');
    }
  }
  @override
  void initState() {
    super.initState();
    getToken();
  }

  Future<void> fetchCategories(token) async {
    try {
      final response = await http.get(
        Uri.parse('$BasseUrl/api/category-names'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _categories = List<Map<String, dynamic>>.from(
              (data['data'] as List).map((category) => {
                    "id": category['id'],
                    "title": category['name'],
                    "image": category['image'],
                  }),
            );
            _isLoading = false;
          });
        }
      } else {
        print("Failed to load categories: ${response.body}");
      }
    } catch (e) {
      print("Error fetching categories: $e");
    }
  }

  Future<void> fetchSubcategories(int categoryId) async {
    if (_subcategoriesMap.containsKey(categoryId)) return; // Use cached data

    try {
      final response = await http.get(
        Uri.parse('$BasseUrl/api/subcategories/by/$categoryId'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        if (data['success']) {
          setState(() {
            _subcategoriesMap[categoryId] = List<Map<String, dynamic>>.from(
              (data['subcategories'] as List).map((sub) => {
                    'id': sub['id'], // Subcategory ID
                    'name': sub['name'], // Subcategory name
                  }),
            );
          });
        }
      } else {
        print("Failed to load subcategories: ${response.body}");
      }
    } catch (e) {
      print("Error fetching subcategories: $e");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
       backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "All Categories",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            fontFamily: 'Raleway',
            color: Colors.black,
          ),
        ),
        // actions: [
        //   Padding(
        //     padding: const EdgeInsets.only(right: 20),
        //     child: Icon(Icons.close),
        //   )
        // ],
        backgroundColor: Colors.white,
        iconTheme: IconThemeData(color: Colors.black),
        elevation: 0,
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: _categories.length + 1, // Add 1 for "Just for You"
                itemBuilder: (context, index) {
                  if (index < _categories.length) {
                    final category = _categories[index];
                    final categoryId = category['id'];

                    return Card(
                      margin: EdgeInsets.only(bottom: 16.0),
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0),
                      ),
                      child: Theme(
                        data: Theme.of(context)
                            .copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          leading: Container(
                            height: 44,
                            width: 44,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(5),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        '$imageUrl${category['image']}'))),
                          ),

                          // CircleAvatar(
                          //   radius: 24,
                          //   backgroundImage: NetworkImage(
                          //       '$imageUrl${category['image']}'),
                          // ),
                          title: Text(
                            category['title'],
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Raleway',
                              fontSize: 17,
                            ),
                          ),
                          trailing: Icon(
                            Icons.expand_more,
                            color: Colors.black,
                          ),
                          onExpansionChanged: (expanded) {
                            if (expanded) {
                              fetchSubcategories(categoryId);
                            }
                          },
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(12.0),
                              child: _subcategoriesMap[categoryId] == null
                                  ? Center(child: CircularProgressIndicator())
                                  : Wrap(
                                      spacing: 8.0,
                                      runSpacing: 8.0,
                                      alignment: WrapAlignment.start,
                                      children: _subcategoriesMap[categoryId]!
                                          .map((sub) => SizedBox(
                                                width: (MediaQuery.of(context)
                                                            .size
                                                            .width -
                                                        64) /
                                                    2,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    int subcategoryId = sub[
                                                        'id']; // Get subcategory ID
                                                    String subcategoryName = sub[
                                                        'name']; // Get subcategory name

                                                    print(
                                                        'Subcategory ID: $subcategoryId');
                                                    print(
                                                        'Subcategory Name: $subcategoryName');

                                                    // Navigation or other actions
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (_) =>
                                                              Categories(
                                                                productId:
                                                                    subcategoryId,
                                                                categoryName:
                                                                    subcategoryName,
                                                              )),
                                                    );
                                                  },
                                                  style:
                                                      ElevatedButton.styleFrom(
                                                    backgroundColor:
                                                        Colors.white,
                                                    foregroundColor:
                                                        Colors.black,
                                                    shape:
                                                        RoundedRectangleBorder(
                                                      side: BorderSide(
                                                          color: Color(
                                                              0xffFFEBEB)),
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              8.0),
                                                    ),
                                                    elevation: 0,
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            vertical: 12.0),
                                                  ),
                                                  child: Text(
                                                    sub['name'], // Display subcategory name
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: 'Raleway',
                                                      fontSize: 15.0,
                                                    ),
                                                  ),
                                                ),
                                              ))
                                          .toList(),
                                    ),
                            ),
                          ],

                          // children: [
                          //   Padding(
                          //     padding: const EdgeInsets.all(12.0),
                          //     child: _subcategoriesMap[categoryId] == null
                          //         ? Center(child: CircularProgressIndicator())
                          //         : Wrap(
                          //             spacing: 8.0,
                          //             runSpacing: 8.0,
                          //             alignment: WrapAlignment.start,
                          //             children: _subcategoriesMap[categoryId]!
                          //                 .map((sub) => SizedBox(
                          //                       width: (MediaQuery.of(context)
                          //                                   .size
                          //                                   .width -
                          //                               64) /
                          //                           2,
                          //                       child: ElevatedButton(
                          //                         onPressed: () {
                          //                           int productid = _subcategoriesMap['id'] as int;
                          //                           String categrayname = sub;
                          //                           // Navigator.push(
                          //                           //   context,
                          //                           //   MaterialPageRoute(
                          //                           //       builder: (_) =>
                          //                           //           Categories(
                          //                           //             productId:
                          //                           //                 productid,
                          //                           //             categoryName:
                          //                           //                 categrayname,
                          //                           //           )),
                          //                           // );

                          //                           print('_subcategoriesMap $_subcategoriesMap');
                          //                         },
                          //                         style:
                          //                             ElevatedButton.styleFrom(
                          //                           backgroundColor:
                          //                               Colors.white,
                          //                           foregroundColor:
                          //                               Colors.black,
                          //                           shape:
                          //                               RoundedRectangleBorder(
                          //                             side: BorderSide(
                          //                                 color: Color(
                          //                                     0xffFFEBEB)),
                          //                             borderRadius:
                          //                                 BorderRadius.circular(
                          //                                     8.0),
                          //                           ),
                          //                           elevation: 0,
                          //                           padding:
                          //                               EdgeInsets.symmetric(
                          //                                   vertical: 12.0),
                          //                         ),
                          //                         child: Text(
                          //                           sub,
                          //                           textAlign: TextAlign.center,
                          //                           style: TextStyle(
                          //                             fontWeight:
                          //                                 FontWeight.bold,
                          //                             fontFamily: 'Raleway',
                          //                             fontSize: 15.0,
                          //                           ),
                          //                         ),
                          //                       ),
                          //                     ))
                          //                 .toList(),
                          //           ),
                          //   ),
                          // ],
                        ),
                      ),
                    );
                  } else {
                    // "Just for You" card
                    return SizedBox(
                      height: 70,
                      child: Card(
                        elevation: 4,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12.0),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(.0),
                          child: ListTile(
                            leading: Container(
                              height: 44,
                              width: 44,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(5),
                                  image:
                                      DecorationImage(image: NetworkImage(''))),
                            ),
                            title: Text(
                              'Just for You',
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                            trailing: Container(
                              height: 30,
                              width: 30,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Colors.black,
                              ),
                              child: Icon(
                                Icons.arrow_forward,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                },
              ),
            ),
    );
  }
}
