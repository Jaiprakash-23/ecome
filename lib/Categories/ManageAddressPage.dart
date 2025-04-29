import 'package:flutter/material.dart';

class ManageAddressPage extends StatelessWidget {
  const ManageAddressPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffE7E8EB),
      appBar: AppBar(
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: GestureDetector(
            onTap: (){
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
              itemCount: 4, // 3 addresses + 1 "Add New Address" button
              itemBuilder: (context, index) {
                if (index < 3) {
                  return Container(
                    margin: const EdgeInsets.only(bottom: 4),
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(0),
                    ),
                    child: Card(
                      color: const Color(0xffF9F9F9),
                      elevation: 2,
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: const [
                                  Text(
                                    'Select Address',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                      fontFamily: 'Raleway',
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    'Magadi Main Rd, next to Prasanna Theatre,\nCholourpalya, Bengaluru, Karnataka 560023',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontFamily: 'Nunito Sans',
                                    ),
                                  ),
                                  SizedBox(height: 4),
                                  Text(
                                    '+91987654321',
                                    style: TextStyle(
                                      fontSize: 10,
                                      color: Colors.black,
                                      fontFamily: 'Nunito Sans',
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            GestureDetector(
                              onTap: (){
                                 showModalBottomSheet(
                            context: context,
                            isScrollControlled: true,
                            shape: const RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            builder: (context) => ActiveCouponBottomSheet(),
                          );
                              },
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(100),
                                  color: const Color(0xff004BFE),
                                ),
                                child:
                                    const Icon(Icons.edit, color: Colors.white),
                              ),
                            ),
                          ],
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
                              borderRadius:
                                  BorderRadius.vertical(top: Radius.circular(16)),
                            ),
                            builder: (context) => ActiveCouponBottomSheet(),
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
            child: Container(
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
}

class ActiveCouponBottomSheet extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.only(
          bottom: MediaQuery.of(context).viewInsets.bottom + 16,
          top: 16,
          left: 16,
          right: 16,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Shipping Address',
              style: TextStyle(
                  fontFamily: 'Raleway',
                  fontSize: 22,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            const Text('Country', style: TextStyle(fontFamily: 'Nunito Sans')),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'India',
                  style: TextStyle(
                      fontFamily: 'Raleway',
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: Color(0xffE7E8EB)),
                ),
                Container(
                  height: 30,
                  width: 30,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: const Color(0xffE7E8EB),
                  ),
                  child: const Icon(Icons.arrow_forward_rounded,
                      color: Colors.white),
                )
              ],
            ),
            const SizedBox(height: 10),
            const LabelText('Address'),
            const CustomInputField(
                hintText: 'Magadi Main Rd, next to Prasanna Theatre'),
            const SizedBox(height: 16),
            const LabelText('Town / City'),
            const CustomInputField(hintText: 'Bengaluru, Karnataka 560023'),
            const SizedBox(height: 16),
            const LabelText('Postcode'),
            const CustomInputField(hintText: '70000'),
            const SizedBox(height: 16),
            const LabelText('Mobile Number'),
            const CustomInputField(hintText: '9313484654'),
            const SizedBox(height: 32),
            Center(
              child: SizedBox(
                width: 250,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.black,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  child: const Text(
                    'Save Changes',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}



class LabelText extends StatelessWidget {
  final String text;
  const LabelText(this.text, {super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontWeight: FontWeight.w600,
        fontSize: 14,
        fontFamily: 'Raleway',
      ),
    );
  }
}

class CustomInputField extends StatelessWidget {
  final String hintText;
  const CustomInputField({super.key, required this.hintText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: const Color(0xFFF1F4FE),
        borderRadius: BorderRadius.circular(12),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: TextFormField(
        initialValue: hintText,
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
          fontFamily: 'Nunito Sans',
        ),
        decoration: const InputDecoration(
          border: InputBorder.none,
        ),
      ),
    );
  }
}
