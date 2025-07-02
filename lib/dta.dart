// import 'dart:convert';
// import 'package:flutter/material.dart';
// import 'package:http/http.dart' as http;

// class ProductDetailPage extends StatefulWidget {
//   @override
//   _ProductDetailPageState createState() => _ProductDetailPageState();
// }

// class _ProductDetailPageState extends State<ProductDetailPage> {
//   List<Map<String, dynamic>> variations = [];
//   bool isLoading = true;

//   Map<String, Set<String>> attributeGroups = {};

//   @override
//   void initState() {
//     super.initState();
//     fetchProductData();
//   }

//   Future<void> fetchProductData() async {
//     final url = Uri.parse('https://ensantehealth.com/owngears/public/api/product/1');
//     final response = await http.get(
//       url,
//       headers: {
//         'Authorization': 'Bearer 106|17FfQoj6P5rRHZneYF9LTHR8yc0ypLGHmpqgTgZf40c49574',
//         'Accept': 'application/json',
//       },
//     );

//     if (response.statusCode == 200) {
//       final jsonResponse = jsonDecode(response.body);
//       final data = jsonResponse['data'];
//       final fetchedVariations = List<Map<String, dynamic>>.from(data['variation']);

//       // Grouping attributes
//       Map<String, Set<String>> tempGroups = {};
//       for (var variation in fetchedVariations) {
//         final attrs = variation['attributes'] as Map<String, dynamic>;
//         attrs.forEach((key, value) {
//           if (!tempGroups.containsKey(key)) {
//             tempGroups[key] = {};
//           }
//           tempGroups[key]!.add(value.toString());
//         });
//       }

//       setState(() {
//         variations = fetchedVariations;
//         attributeGroups = tempGroups;
//         isLoading = false;
//       });
//     } else {
//       print('Failed to fetch data: ${response.statusCode}');
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }
//   Widget buildGroupedAttributes() {
//   return Padding(
//     padding: const EdgeInsets.all(16.0),
//     child: Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: attributeGroups.entries.map((entry) {
//         return Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               '${entry.key.capitalize()}:',
//               style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
//             ),
//             const SizedBox(height: 8),
//             Wrap(
//               spacing: 12,
//               runSpacing: 12,
//               children: entry.value.map((val) {
//                 if (entry.key.toLowerCase() == 'color') {
//                   return Column(
//                     mainAxisSize: MainAxisSize.min,
//                     children: [
//                       Container(
//                         width: 30,
//                         height: 30,
//                         decoration: BoxDecoration(
//                           color: getColorFromName(val),
//                           shape: BoxShape.circle,
//                           border: Border.all(color: Colors.black12),
//                         ),
//                       ),
//                       const SizedBox(height: 4),
//                       Text(
//                         val,
//                         style: TextStyle(fontSize: 12),
//                       ),
//                     ],
//                   );
//                 } else {
//                   return Chip(
//                     label: Text(val),
//                     backgroundColor: Colors.grey[200],
//                   );
//                 }
//               }).toList(),
//             ),
//             const SizedBox(height: 16),
//           ],
//         );
//       }).toList(),
//     ),
//   );
// }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text('Product Variations')),
//       body: isLoading
//           ? Center(child: CircularProgressIndicator())
//           : SingleChildScrollView(child: buildGroupedAttributes()),
//     );
//   }
// }

// extension StringExtension on String {
//   String capitalize() {
//     if (this.isEmpty) return this;
//     return this[0].toUpperCase() + substring(1);
//   }
// }
// Color getColorFromName(String name) {
//   switch (name.toLowerCase()) {
//     case 'red':
//       return Colors.red;
//     case 'blue':
//       return Colors.blue;
//     case 'green':
//       return Colors.green;
//     case 'black':
//       return Colors.black;
//     case 'white':
//       return Colors.white;
//     case 'yellow':
//       return Colors.yellow;
//     case 'orange':
//       return Colors.orange;
//     case 'pink':
//       return Colors.pink;
//     case 'purple':
//       return Colors.purple;
//     default:
//       return Colors.grey; // fallback if unknown color
//   }
// }


import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ProductDetailPage extends StatefulWidget {
  @override
  _ProductDetailPageState createState() => _ProductDetailPageState();
}

class _ProductDetailPageState extends State<ProductDetailPage> {
  List<Map<String, dynamic>> variations = [];
  bool isLoading = true;
  Map<String, Set<String>> attributeGroups = {};
  Map<String, String> selectedAttributes = {};

  @override
  void initState() {
    super.initState();
    fetchProductData();
  }

  Future<void> fetchProductData() async {
    print('Selected Attributes: $selectedAttributes');
    final attributesQuery = selectedAttributes.entries
        .map((e) => '${Uri.encodeComponent(e.key)}=${Uri.encodeComponent(e.value)}')
        .join('&');
    final url = Uri.parse(
        'https://ensantehealth.com/owngears/public/api/product/1?$attributesQuery');
    final response = await http.get(
      url,
      headers: {
        'Authorization':
            'Bearer 109|yCxLY2q5Odray4pFXhQe2J6W5osVgIJz53ryyLse96758656',
        'Accept': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final data = jsonResponse['data'];
      print('Fetched Data: $data');
      final fetchedVariations =
          List<Map<String, dynamic>>.from(data['variation']);

      Map<String, Set<String>> tempGroups = {};
      for (var variation in fetchedVariations) {
        final attrs = variation['attributes'] as Map<String, dynamic>;
        attrs.forEach((key, value) {
          tempGroups.putIfAbsent(key, () => {});
          tempGroups[key]!.add(value.toString());
        });
      }

      Map<String, String> defaultSelections = {
        for (var entry in tempGroups.entries) entry.key: entry.value.first
      };

      setState(() {
        variations = fetchedVariations;
        attributeGroups = tempGroups;
        selectedAttributes = selectedAttributes.isEmpty
            ? defaultSelections
            : selectedAttributes;
        isLoading = false;
      });
    } else {
      print('Failed to fetch data: ${response.statusCode}');
      setState(() {
        isLoading = false;
      });
    }
  }

  Widget buildGroupedAttributes() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: attributeGroups.entries.map((entry) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${entry.key.capitalize()}:',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 12,
                runSpacing: 12,
                children: entry.value.map((val) {
                  final isSelected = selectedAttributes[entry.key] == val;
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedAttributes[entry.key] = val;
                      });
                      fetchProductData();
                    },
                    child: entry.key.toLowerCase() == 'color'
                        ? Column(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Stack(
                                alignment: Alignment.center,
                                clipBehavior: Clip.none,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 30,
                                    decoration: BoxDecoration(
                                      color: getColorFromName(val),
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.red
                                            : Colors.black12,
                                        width: isSelected ? 2 : 1,
                                      ),
                                    ),
                                  ),
                                  if (isSelected)
                                    Positioned(
                                      top: -1,
                                      right: -5,
                                      child: Icon(Icons.check_circle,
                                          size: 16, color: Colors.black),
                                    ),
                                ],
                              ),
                              const SizedBox(height: 4),
                              Text(
                                val,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: isSelected
                                      ? FontWeight.bold
                                      : FontWeight.normal,
                                  color: isSelected ? Colors.red : Colors.black,
                                ),
                              ),
                            ],
                          )
                        : Chip(
                            label: Text(
                              val,
                              style: TextStyle(
                                color:
                                    isSelected ? Colors.white : Colors.black,
                              ),
                            ),
                            backgroundColor:
                                isSelected ? Colors.red : Colors.grey[200],
                          ),
                  );
                }).toList(),
              ),
              const SizedBox(height: 16),
            ],
          );
        }).toList(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Product Variations')),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: [
                Expanded(
                    child:
                        SingleChildScrollView(child: buildGroupedAttributes())),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => NextPage(
                            selectedAttributes: selectedAttributes,
                          ),
                        ),
                      );
                    },
                    child: Text('Continue'),
                  ),
                ),
              ],
            ),
    );
  }
}

class NextPage extends StatelessWidget {
  final Map<String, String> selectedAttributes;

  const NextPage({required this.selectedAttributes});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Selected Attributes')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: selectedAttributes.isEmpty
            ? Text('No attributes selected.')
            : Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: selectedAttributes.entries.map((entry) {
                  return Text('${entry.key.capitalize()}: ${entry.value}',
                      style: TextStyle(fontSize: 16));
                }).toList(),
              ),
      ),
    );
  }
}

Color getColorFromName(String name) {
  switch (name.toLowerCase()) {
    case 'red':
      return Colors.red;
    case 'blue':
      return Colors.blue;
    case 'green':
      return Colors.green;
    case 'black':
      return Colors.black;
    case 'white':
      return Colors.white;
    case 'yellow':
      return Colors.yellow;
    case 'orange':
      return Colors.orange;
    case 'pink':
      return Colors.pink;
    case 'purple':
      return Colors.purple;
    case 'grey':
      return Colors.grey;
    default:
      return Colors.grey[400]!;
  }
}

extension StringExtension on String {
  String capitalize() {
    if (this.isEmpty) return this;
    return this[0].toUpperCase() + substring(1);
  }
}

