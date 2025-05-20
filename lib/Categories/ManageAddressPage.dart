import 'dart:convert';

import 'package:ecome/Bassurl.dart';
import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class ManageAddressPage extends StatefulWidget {
  const ManageAddressPage({super.key});

  @override
  State<ManageAddressPage> createState() => _ManageAddressPageState();
}

class _ManageAddressPageState extends State<ManageAddressPage> {
  String token = '';
  bool isLoading = false;
  final _formKey = GlobalKey<FormState>();
  String selectedType = 'Home';

  final TextEditingController nameController = TextEditingController();
  final TextEditingController numberController = TextEditingController();
  final TextEditingController addressController = TextEditingController();
  final TextEditingController postalCodeController = TextEditingController();
  final TextEditingController roadController = TextEditingController();

  Future<void> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      token = (prefs.getString("token") ?? '').trim();
      GetAddress(token);
    });
    print('Cleaned datatoken: $token');
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getToken();
  }

  List<dynamic> Address = [];

  Future<void> GetAddress(String token) async {
    try {
      var headers = {
        'Authorization': 'Bearer $token',
      };
      var request = http.Request(
        'GET',
        Uri.parse('$BasseUrl/api/address/list'),
      );

      request.headers.addAll(headers);

      http.StreamedResponse response = await request.send();

      if (response.statusCode == 200) {
        String responseData = await response.stream.bytesToString();
        print(responseData);
        setState(() {
          Address = jsonDecode(responseData)['address'] ?? [];
        });
      } else {
        print("Error fetching address: ${response.reasonPhrase}");
      }
    } catch (e) {
      print('An error occurred while fetching address: $e');
    }
  }

  String Addressid = '';

  Future<void> EditAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$BasseUrl/api/address/update/$Addressid'),
    );
    request.fields.addAll({
      'contact_person_name': nameController.text,
      'address_type': selectedType.toLowerCase(),
      'contact_person_number': numberController.text,
      'address': addressController.text,
      'postal_code': postalCodeController.text,
      'road': roadController.text,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        print(responseBody);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(' Address Update successfully!')),
        );
        setState(() {
          GetAddress(token);
          Navigator.pop(context);
        });
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to Update address: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  Future<void> saveAddress() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      isLoading = true;
    });

    var headers = {'Authorization': 'Bearer $token'};
    var request = http.MultipartRequest(
      'POST',
      Uri.parse('$BasseUrl/api/add/address'),
    );
    request.fields.addAll({
      'contact_person_name': nameController.text,
      'address_type': selectedType.toLowerCase(),
      'contact_person_number': numberController.text,
      'address': addressController.text,
      'postal_code': postalCodeController.text,
      'road': roadController.text,
    });

    request.headers.addAll(headers);

    try {
      http.StreamedResponse response = await request.send();
      if (response.statusCode == 200) {
        String responseBody = await response.stream.bytesToString();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Address saved successfully!')),
        );
        //GetAddress(token);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => ManageAddressPage()),
        );
        // Navigator.pop(context);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text('Failed to save address: ${response.reasonPhrase}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('An error occurred: $e')),
      );
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  // Future<void> _getCurrentLocation() async {
  //   bool serviceEnabled;
  //   LocationPermission permission;

  //   // Check if location services are enabled
  //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
  //   if (!serviceEnabled) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Location services are disabled.')),
  //     );
  //     return;
  //   }

  //   // Check for location permissions
  //   permission = await Geolocator.checkPermission();
  //   if (permission == LocationPermission.denied) {
  //     permission = await Geolocator.requestPermission();
  //     if (permission == LocationPermission.denied) {
  //       ScaffoldMessenger.of(context).showSnackBar(
  //         SnackBar(content: Text('Location permissions are denied.')),
  //       );
  //       return;
  //     }
  //   }

  //   if (permission == LocationPermission.deniedForever) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(
  //         content: Text(
  //             'Location permissions are permanently denied, we cannot request permissions.'),
  //       ),
  //     );
  //     return;
  //   }

  //   // Retrieve the current location
  //   try {
  //     Position position = await Geolocator.getCurrentPosition(
  //         desiredAccuracy: LocationAccuracy.high);

  //     // Reverse geocoding to get the address
  //     List<Placemark> placemarks = await placemarkFromCoordinates(
  //       position.latitude,
  //       position.longitude,
  //     );

  //     if (placemarks.isNotEmpty) {
  //       Placemark place = placemarks.first;
  //       String address =
  //           '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

  //       setState(() {
  //         roadController.text = address;
  //       });
  //     } else {
  //       setState(() {
  //         roadController.text = 'Address not found';
  //       });
  //     }
  //   } catch (e) {
  //     ScaffoldMessenger.of(context).showSnackBar(
  //       SnackBar(content: Text('Failed to get location: $e')),
  //     );
  //   }
  // }

  int? selectedIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7E8EB),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: () {
              Navigator.of(context).pop();
            },
            child: Container(
              height: 10,
              width: 10,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(100),
                color: const Color(0xff004CFF),
              ),
              child: const Center(
                child: Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
              ),
            ),
          ),
        ),
        title: const Text(
          "Manage Address",
          style: TextStyle(
            color: Colors.black,
            fontFamily: 'Raleway',
            fontSize: 24,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: Address.length + 1,
              itemBuilder: (context, index) {
                bool isSelected = selectedIndex == index;
                if (index < Address.length) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedIndex = index; // Update the selected index
                        });
                      },
                      child: Card(
                        color: isSelected
                            ? Colors.blue.shade100
                            : Color(0xffF9F9F9),
                        // color: const Color(0xffF9F9F9),
                        elevation: 2,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      '${(Address[index]['address_type'] ?? 'Unknown').toUpperCase()}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                        fontFamily: 'Raleway',
                                      ),
                                    ),
                                    SizedBox(height: 4),
                                    Text(
                                      '${Address[index]['full_address'] ?? ''}',
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: Colors.black,
                                        fontFamily: 'Nunito Sans',
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Addressid = "${Address[index]['id']}";
                                  showModalBottomSheet(
                                    context: context,
                                    isScrollControlled: true,
                                    shape: const RoundedRectangleBorder(
                                      borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(16)),
                                    ),
                                    builder: (context) => SingleChildScrollView(
                                      padding: EdgeInsets.only(
                                        bottom: MediaQuery.of(context)
                                                .viewInsets
                                                .bottom +
                                            16,
                                        top: 16,
                                        left: 16,
                                        right: 16,
                                      ),
                                      child: Form(
                                        key: _formKey,
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Text(
                                              'Shipping Address',
                                              style: TextStyle(
                                                fontFamily: 'Raleway',
                                                fontSize: 22,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 10),
                                            LabelText('Your Name'),
                                            CustomInputField(
                                              controller: nameController
                                                ..text =
                                                    "${Address[index]['contact_person_name']} ",
                                              hintText: 'Enter your name',
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Name is required'
                                                      : null,
                                            ),
                                            const SizedBox(height: 16),
                                            LabelText('Mobile Number'),
                                            CustomInputField(
                                              controller: numberController
                                                ..text =
                                                    '${Address[index]['contact_person_number']}',
                                              hintText:
                                                  'Enter your mobile number',
                                              validator: (value) => value!
                                                      .isEmpty
                                                  ? 'Mobile number is required'
                                                  : null,
                                            ),
                                            const SizedBox(height: 16),
                                            LabelText('Address'),
                                            CustomInputField(
                                              controller: addressController
                                                ..text =
                                                    '${Address[index]['address']}',
                                              hintText: 'Enter your address',
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Address is required'
                                                      : null,
                                            ),
                                            const SizedBox(height: 16),
                                            LabelText('Postcode'),
                                            CustomInputField(
                                              controller: postalCodeController
                                                ..text =
                                                    '${Address[index]['postal_code']}',
                                              hintText:
                                                  'Enter your postal code',
                                              validator: (value) =>
                                                  value!.isEmpty
                                                      ? 'Postcode is required'
                                                      : null,
                                            ),
                                            const SizedBox(height: 16),
                                            const LabelText('Location'),
                                            Container(
                                              decoration: BoxDecoration(
                                                color: const Color(0xFFF1F4FE),
                                                borderRadius:
                                                    BorderRadius.circular(12),
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              child: TextFormField(
                                                controller: roadController,
                                                style: const TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.black,
                                                  fontFamily: 'Nunito Sans',
                                                ),
                                                //onTap: _getCurrentLocation,
                                                decoration:
                                                    const InputDecoration(
                                                  hintText: 'select Location',
                                                  suffixIcon: Icon(Icons
                                                      .my_location_rounded),
                                                  border: InputBorder.none,
                                                ),
                                                // validator: (value) =>
                                                //     value!.isEmpty
                                                //         ? 'Location is required'
                                                //         : null,
                                              ),
                                            ),
                                            const SizedBox(height: 16),
                                            LabelText('Save this address as'),
                                            const SizedBox(height: 16),
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                _buildTab('    Home    '),
                                                const SizedBox(width: 10),
                                                _buildTab('    Office    '),
                                                const SizedBox(width: 10),
                                                _buildTab('    Other    '),
                                              ],
                                            ),
                                            const SizedBox(height: 32),
                                            Center(
                                              child: isLoading
                                                  ? CircularProgressIndicator()
                                                  : SizedBox(
                                                      width: 250,
                                                      height: 50,
                                                      child: ElevatedButton(
                                                        onPressed: () {
                                                          setState(() {});
                                                          EditAddress();
                                                          // Navigator.pop(context);
                                                        },
                                                        style: ElevatedButton
                                                            .styleFrom(
                                                          backgroundColor:
                                                              Colors.black,
                                                          shape:
                                                              RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        16),
                                                          ),
                                                        ),
                                                        child: const Text(
                                                          'Edit Address',
                                                          style: TextStyle(
                                                              fontSize: 16,
                                                              color:
                                                                  Colors.white),
                                                        ),
                                                      ),
                                                    ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  );
                                },
                                child: Container(
                                  height: 30,
                                  width: 30,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(100),
                                    color: const Color(0xff004BFE),
                                  ),
                                  child: const Icon(Icons.edit,
                                      color: Colors.white),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                } else {
                  return Container(
                    width: double.infinity,
                    color: const Color(0xFFEAF0FF),
                    padding: const EdgeInsets.symmetric(vertical: 24),
                    child: Center(
                      child: OutlinedButton(
                        onPressed: () {
                          showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(16)),
                            ),
                            builder: (context) => SingleChildScrollView(
                              padding: EdgeInsets.only(
                                bottom:
                                    MediaQuery.of(context).viewInsets.bottom +
                                        16,
                                top: 16,
                                left: 16,
                                right: 16,
                              ),
                              child: Form(
                                key: _formKey,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      'Shipping Address',
                                      style: TextStyle(
                                        fontFamily: 'Raleway',
                                        fontSize: 22,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 10),
                                    LabelText('Your Name'),
                                    CustomInputField(
                                      controller: nameController,
                                      hintText: 'Enter your name',
                                      validator: (value) => value!.isEmpty
                                          ? 'Name is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    LabelText('Mobile Number'),
                                    CustomInputField(
                                      controller: numberController,
                                      hintText: 'Enter your mobile number',
                                      validator: (value) => value!.isEmpty
                                          ? 'Mobile number is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    LabelText('Address'),
                                    CustomInputField(
                                      controller: addressController,
                                      hintText: 'Enter your address',
                                      validator: (value) => value!.isEmpty
                                          ? 'Address is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    LabelText('Postcode'),
                                    CustomInputField(
                                      controller: postalCodeController,
                                      hintText: 'Enter your postal code',
                                      validator: (value) => value!.isEmpty
                                          ? 'Postcode is required'
                                          : null,
                                    ),
                                    const SizedBox(height: 16),
                                    const LabelText('Location'),
                                    Container(
                                      decoration: BoxDecoration(
                                        color: const Color(0xFFF1F4FE),
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 12),
                                      child: TextFormField(
                                        controller: roadController,
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                          fontFamily: 'Nunito Sans',
                                        ),
                                        // onTap: _getCurrentLocation,
                                        decoration: const InputDecoration(
                                          hintText: 'select Location',
                                          suffixIcon:
                                              Icon(Icons.my_location_rounded),
                                          border: InputBorder.none,
                                        ),
                                        // validator: (value) =>
                                        //     value!.isEmpty ? 'Location is required' : null,
                                      ),
                                    ),
                                    const SizedBox(height: 16),
                                    LabelText('Save this address as'),
                                    const SizedBox(height: 16),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceEvenly,
                                      children: [
                                        _buildTab('    Home    '),
                                        const SizedBox(width: 10),
                                        _buildTab('    Office    '),
                                        const SizedBox(width: 10),
                                        _buildTab('    Other    '),
                                      ],
                                    ),
                                    const SizedBox(height: 32),
                                    Center(
                                      child: isLoading
                                          ? CircularProgressIndicator()
                                          : SizedBox(
                                              width: 250,
                                              height: 50,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  setState(() {
                                                    saveAddress();
                                                  });
                                                  Navigator.pop(context);
                                                },
                                                style: ElevatedButton.styleFrom(
                                                  backgroundColor: Colors.black,
                                                  shape: RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            16),
                                                  ),
                                                ),
                                                child: const Text(
                                                  'Save Changes',
                                                  style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.white),
                                                ),
                                              ),
                                            ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                        style: OutlinedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 32, vertical: 16),
                          side: const BorderSide(color: Colors.black),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8),
                          ),
                        ),
                        child: const Text(
                          'Add New Address',
                          style: TextStyle(
                              fontSize: 16,
                              color: Colors.black,
                              fontFamily: 'Nunito Sans'),
                        ),
                      ),
                    ),
                  );
                }
              },
            ),
          ),

          // Use Selected Address Button
          SafeArea(
            child: Address.isEmpty
                ? Container()
                : Container(
                    padding: const EdgeInsets.all(12),
                    color: Colors.white,
                    child: ElevatedButton(
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.black,
                        minimumSize: const Size.fromHeight(50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                      ),
                      child: const Text(
                        'Use Selected Address',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                    ),
                  ),
          ),
        ],
      ),
    );
  }

  Widget _buildTab(String type) {
    bool isSelected = selectedType == type;
    return GestureDetector(
      onTap: () {
        setState(() {
          selectedType = type;
        });
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected ? Colors.blue : Colors.grey,
          ),
          borderRadius: BorderRadius.circular(8),
          color: isSelected ? Colors.blue.shade50 : Colors.white,
        ),
        child: Text(
          type,
          style: TextStyle(
            color: isSelected ? Colors.blue : Colors.black,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class AddressCard extends StatelessWidget {
  final dynamic address;
  final VoidCallback onEdit;

  const AddressCard({required this.address, required this.onEdit, Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    (address['address_type'] ?? 'Unknown').toUpperCase(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                      fontFamily: 'Raleway',
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    address['address'] ?? '',
                    style: const TextStyle(
                        fontSize: 13, fontFamily: 'Nunito Sans'),
                  ),
                ],
              ),
            ),
            IconButton(
              icon: const Icon(Icons.edit, color: Color(0xff004BFE)),
              onPressed: onEdit,
            ),
          ],
        ),
      ),
    );
  }
}

// class ActiveCouponBottomSheet extends StatefulWidget {
//   const ActiveCouponBottomSheet({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<ActiveCouponBottomSheet> createState() =>
//       _ActiveCouponBottomSheetState();
// }

// class _ActiveCouponBottomSheetState extends State<ActiveCouponBottomSheet> {
//   final _formKey = GlobalKey<FormState>();
//   String selectedType = 'Home';

//   final TextEditingController nameController = TextEditingController();
//   final TextEditingController numberController = TextEditingController();
//   final TextEditingController addressController = TextEditingController();
//   final TextEditingController postalCodeController = TextEditingController();
//   final TextEditingController roadController = TextEditingController();

//   bool isLoading = false;
//   String token = '';

//   Future<void> getToken() async {
//     SharedPreferences prefs = await SharedPreferences.getInstance();
//     setState(() {
//       token = (prefs.getString("token") ?? '').trim();
//     });
//     print('Cleaned datatoken: $token');
//   }

//   @override
//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     getToken();
//   }

//   Future<void> saveAddress() async {
//     if (!_formKey.currentState!.validate()) return;

//     setState(() {
//       isLoading = true;
//     });

//     var headers = {'Authorization': 'Bearer $token'};
//     var request = http.MultipartRequest(
//       'POST',
//       Uri.parse('$BasseUrl/api/add/address'),
//     );
//     request.fields.addAll({
//       'contact_person_name': nameController.text,
//       'address_type': selectedType.toLowerCase(),
//       'contact_person_number': numberController.text,
//       'address': addressController.text,
//       'postal_code': postalCodeController.text,
//       'road': roadController.text,
//     });

//     request.headers.addAll(headers);

//     try {
//       http.StreamedResponse response = await request.send();
//       if (response.statusCode == 200) {
//         String responseBody = await response.stream.bytesToString();
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(content: Text('Address saved successfully!')),
//         );

//         Navigator.pop(context);
//       } else {
//         ScaffoldMessenger.of(context).showSnackBar(
//           SnackBar(
//               content:
//                   Text('Failed to save address: ${response.reasonPhrase}')),
//         );
//       }
//     } catch (e) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         SnackBar(content: Text('An error occurred: $e')),
//       );
//     } finally {
//       setState(() {
//         isLoading = false;
//       });
//     }
//   }

//   // Future<void> _getCurrentLocation() async {
//   //   bool serviceEnabled;
//   //   LocationPermission permission;

//   //   // Check if location services are enabled
//   //   serviceEnabled = await Geolocator.isLocationServiceEnabled();
//   //   if (!serviceEnabled) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Location services are disabled.')),
//   //     );
//   //     return;
//   //   }

//   //   // Check for location permissions
//   //   permission = await Geolocator.checkPermission();
//   //   if (permission == LocationPermission.denied) {
//   //     permission = await Geolocator.requestPermission();
//   //     if (permission == LocationPermission.denied) {
//   //       ScaffoldMessenger.of(context).showSnackBar(
//   //         SnackBar(content: Text('Location permissions are denied.')),
//   //       );
//   //       return;
//   //     }
//   //   }

//   //   if (permission == LocationPermission.deniedForever) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(
//   //         content: Text(
//   //             'Location permissions are permanently denied, we cannot request permissions.'),
//   //       ),
//   //     );
//   //     return;
//   //   }

//   //   // Retrieve the current location
//   //   try {
//   //     Position position = await Geolocator.getCurrentPosition(
//   //         desiredAccuracy: LocationAccuracy.high);

//   //     // Reverse geocoding to get the address
//   //     List<Placemark> placemarks = await placemarkFromCoordinates(
//   //       position.latitude,
//   //       position.longitude,
//   //     );

//   //     if (placemarks.isNotEmpty) {
//   //       Placemark place = placemarks.first;
//   //       String address =
//   //           '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';

//   //       setState(() {
//   //         roadController.text = address;
//   //       });
//   //     } else {
//   //       setState(() {
//   //         roadController.text = 'Address not found';
//   //       });
//   //     }
//   //   } catch (e) {
//   //     ScaffoldMessenger.of(context).showSnackBar(
//   //       SnackBar(content: Text('Failed to get location: $e')),
//   //     );
//   //   }
//   // }

//   @override
//   Widget build(BuildContext context) {
//     return SafeArea(
//       child:
//       SingleChildScrollView(
//         padding: EdgeInsets.only(
//           bottom: MediaQuery.of(context).viewInsets.bottom + 16,
//           top: 16,
//           left: 16,
//           right: 16,
//         ),
//         child: Form(
//           key: _formKey,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const Text(
//                 'Shipping Address',
//                 style: TextStyle(
//                   fontFamily: 'Raleway',
//                   fontSize: 22,
//                   fontWeight: FontWeight.bold,
//                 ),
//               ),
//               const SizedBox(height: 10),
//               LabelText('Your Name'),
//               CustomInputField(
//                 controller: nameController,
//                 hintText: 'Enter your name',
//                 validator: (value) =>
//                     value!.isEmpty ? 'Name is required' : null,
//               ),
//               const SizedBox(height: 16),
//               LabelText('Mobile Number'),
//               CustomInputField(
//                 controller: numberController,
//                 hintText: 'Enter your mobile number',
//                 validator: (value) =>
//                     value!.isEmpty ? 'Mobile number is required' : null,
//               ),
//               const SizedBox(height: 16),
//               LabelText('Address'),
//               CustomInputField(
//                 controller: addressController,
//                 hintText: 'Enter your address',
//                 validator: (value) =>
//                     value!.isEmpty ? 'Address is required' : null,
//               ),
//               const SizedBox(height: 16),
//               LabelText('Postcode'),
//               CustomInputField(
//                 controller: postalCodeController,
//                 hintText: 'Enter your postal code',
//                 validator: (value) =>
//                     value!.isEmpty ? 'Postcode is required' : null,
//               ),
//               const SizedBox(height: 16),
//               const LabelText('Location'),
//               Container(
//                 decoration: BoxDecoration(
//                   color: const Color(0xFFF1F4FE),
//                   borderRadius: BorderRadius.circular(12),
//                 ),
//                 padding: const EdgeInsets.symmetric(horizontal: 12),
//                 child: TextFormField(
//                   controller: roadController,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     color: Colors.black,
//                     fontFamily: 'Nunito Sans',
//                   ),
//                   // onTap: _getCurrentLocation,
//                   decoration: const InputDecoration(
//                     hintText: 'select Location',
//                     suffixIcon: Icon(Icons.my_location_rounded),
//                     border: InputBorder.none,
//                   ),
//                   // validator: (value) =>
//                   //     value!.isEmpty ? 'Location is required' : null,
//                 ),
//               ),
//               const SizedBox(height: 16),
//               LabelText('Save this address as'),
//               const SizedBox(height: 16),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                 children: [
//                   _buildTab('    Home    '),
//                   const SizedBox(width: 10),
//                   _buildTab('    Office    '),
//                   const SizedBox(width: 10),
//                   _buildTab('    Other    '),
//                 ],
//               ),
//               const SizedBox(height: 32),
//               Center(
//                 child: isLoading
//                     ? CircularProgressIndicator()
//                     : SizedBox(
//                         width: 250,
//                         height: 50,
//                         child: ElevatedButton(
//                           onPressed: () {
//                             saveAddress();
//                             Navigator.pop(context);
//                           },
//                           style: ElevatedButton.styleFrom(
//                             backgroundColor: Colors.black,
//                             shape: RoundedRectangleBorder(
//                               borderRadius: BorderRadius.circular(16),
//                             ),
//                           ),
//                           child: const Text(
//                             'Save Changes',
//                             style: TextStyle(fontSize: 16, color: Colors.white),
//                           ),
//                         ),
//                       ),
//               ),
//             ],
//           ),
//         ),
//       ),

//     );
//   }

//   Widget _buildTab(String type) {
//     bool isSelected = selectedType == type;
//     return GestureDetector(
//       onTap: () {
//         setState(() {
//           selectedType = type;
//         });
//       },
//       child: Container(
//         padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//         decoration: BoxDecoration(
//           border: Border.all(
//             color: isSelected ? Colors.blue : Colors.grey,
//           ),
//           borderRadius: BorderRadius.circular(8),
//           color: isSelected ? Colors.blue.shade50 : Colors.white,
//         ),
//         child: Text(
//           type,
//           style: TextStyle(
//             color: isSelected ? Colors.blue : Colors.black,
//             fontSize: 16,
//           ),
//         ),
//       ),
//     );
//   }
// }

class LabelText extends StatelessWidget {
  final String text;

  const LabelText(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String? Function(String?)? validator;

  const CustomInputField({
    Key? key,
    this.controller,
    required this.hintText,
    this.validator,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: const TextStyle(
        fontSize: 16,
        color: Colors.black,
        fontFamily: 'Nunito Sans',
      ),
      controller: controller,
      validator: validator,
      decoration: InputDecoration(
        hintText: hintText,
        filled: true,
        fillColor: const Color(0xFFF1F4FE),
        border: InputBorder.none,
      ),
    );
  }
}
