
import 'dart:convert';
import 'package:ecome/Bassurl.dart';
import 'package:ecome/Categories/Categories.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class FilterPage extends StatefulWidget {
  FilterPage({Key? key}) : super(key: key);

  @override
  _FilterPageState createState() => _FilterPageState();
}

class _FilterPageState extends State<FilterPage> {
  late int productId;
  RangeValues _currentRangeValues = const RangeValues(0, 600);
  double sliderMin = 0;
  double sliderMax = 600;

  Map<String, dynamic> variations = {};
  Map<String, dynamic> price_range = {};
  Map<String, List<String>> selectedValues = {};
  String selectedCategory = '';
  String token = '';

  @override
  void initState() {
    super.initState();
    productId = Get.arguments?['productId'] ?? 0;
    getToken();
  }

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = (prefs.getString("token") ?? '').trim();

    if (token.isNotEmpty) {
      await fetchFilters(token);
    } else {
      print('Token not available.');
    }
  }

  Future<void> fetchFilters(String token) async {
    try {
      final response = await http.get(
        Uri.parse("$BasseUrl/api/page/filter/$productId"),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          variations = data['variations'] ?? {};
          price_range = data['price_range'] ?? {};

          double min = double.tryParse(price_range["min_price"].toString()) ?? 0;
          double max = double.tryParse(price_range["max_price"].toString()) ?? 600;

          if (min > max) {
            final temp = min;
            min = max;
            max = temp;
          }

          _currentRangeValues = RangeValues(min, max);
          sliderMin = min;
          sliderMax = max;

          selectedCategory = variations.keys.isNotEmpty ? variations.keys.first : '';
        });
      } else {
        print('Failed to load data. Status code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error fetching filters: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: const Text('Filters'),
        actions: [
          TextButton(
            onPressed: () {
              setState(() {
                selectedValues.clear();
                _currentRangeValues = RangeValues(sliderMin, sliderMax);
              });
            },
            child: const Text(
              'Clear All',
              style: TextStyle(color: Colors.blue),
            ),
          ),
        ],
      ),
      body: variations.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : Row(
              children: [
                Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  color: const Color(0xffF3F3F3),
                  child: ListView(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedCategory = "Price";
                          });
                        },
                        child: Container(
                          margin: const EdgeInsets.all(1),
                          height: 40,
                          color: selectedCategory == "Price"
                              ? const Color(0xffFFFFFF)
                              : const Color(0xffF3F3F3),
                          child: Center(
                            child: Text(
                              "Price",
                              style: TextStyle(
                                color: selectedCategory == "Price"
                                    ? Colors.black
                                    : Colors.black,
                              ),
                            ),
                          ),
                        ),
                      ),
                      ...variations.keys.map((key) {
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              selectedCategory = key;
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.all(1),
                            height: 40,
                            color: selectedCategory == key
                                ? const Color(0xffFFFFFF)
                                : const Color(0xffF3F3F3),
                            child: Center(
                              child: Text(
                                key[0].toUpperCase() + key.substring(1),
                                style: TextStyle(
                                  color: selectedCategory == key
                                      ? Colors.black
                                      : Colors.black,
                                ),
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ],
                  ),
                ),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      if (selectedCategory == "Price")
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  " Price ",
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Roboto Flex",
                                  ),
                                ),
                                Text(
                                  " ₹${_currentRangeValues.start.round()} - ₹${_currentRangeValues.end.round()}",
                                  style: const TextStyle(
                                    fontSize: 12,
                                    fontFamily: "Roboto Flex",
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                            RangeSlider(
                              values: _currentRangeValues,
                              min: sliderMin,
                              max: sliderMax,
                              divisions: 10,
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
                          ],
                        )
                      else
                        ...?variations[selectedCategory]?.map((item) {
                          return CheckboxListTile(
                            controlAffinity: ListTileControlAffinity.leading,
                            title: Text(item),
                            value: selectedValues[selectedCategory]?.contains(item) ?? false,
                            onChanged: (isChecked) {
                              setState(() {
                                if (isChecked == true) {
                                  selectedValues.putIfAbsent(selectedCategory, () => []).add(item);
                                } else {
                                  selectedValues[selectedCategory]?.remove(item);
                                }
                              });
                            },
                          );
                        }).toList(),
                    ],
                  ),
                ),
              ],
            ),
      bottomNavigationBar: BottomAppBar(
        height: 50,
        color: const Color(0xffFFFFFF),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: Container(
                height: double.infinity,
                width: MediaQuery.of(context).size.width / 3,
                color: const Color(0xffFFFFFF),
                child: const Center(
                  child: Text(
                    "CLOSE",
                    style: TextStyle(
                        fontFamily: "Roboto Flex",
                        color: Color(0xff707070),
                        fontSize: 15),
                  ),
                ),
              ),
            ),
            Container(
              height: 40,
              width: 2,
              color: Colors.black,
            ),
            GestureDetector(
              onTap: () {
                Map<String, List<String>> newSelectedValues = Map.from(selectedValues);
                newSelectedValues["min_price"] = ["${_currentRangeValues.start.round()}"];
                newSelectedValues["max_price"] = ["${_currentRangeValues.end.round()}"];
              Navigator.pushReplacement(
context,MaterialPageRoute(builder: (context) => Categories(
   selectedValues: newSelectedValues,
                      productId: productId,
                      categoryName: '',
                      showBackIcon: true,
)),);
                
              },
              child: Container(
                height: double.infinity,
                 width: MediaQuery.of(context).size.width / 3,
                //width: MediaQuery.of(context).size.width * 2 / 3 - 2,
                color: const Color(0xffFFFFFF),
                child: const Center(
                  child: Text(
                    "APPLY",
                    style: TextStyle(
                        fontFamily: "Roboto Flex",
                        color: Colors.blue,
                        fontSize: 15),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}