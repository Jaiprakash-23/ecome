import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

class PrivacyCenterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
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
          "Privacy Center",
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
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.0),
        children: [
          _buildListTile('Privacy Policy', context),
          Divider(),
          _buildListTile('Consent Management', context),
          Divider(),
          _buildListTile('Grievance Redressal', context),
          Divider(),
          // SizedBox(height: 16.0),

          // Special options for deactivating or deleting account
          InkWell(
              onTap: () {
                AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.warning,
                  customHeader: Icon(
                    Icons.warning,
                    size: 50,
                    color: Color(0xff85A8FB),
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        Text(
                          '  You are sure to de activate\n            your account',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' You can restore your account via our support',
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  btnOkColor:Color(0xff85A8FB),
                  btnOkText:'De activate',
                  btnCancelColor:Colors.black,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();
              },
              child: _buildSpecialOption('De-activate My Account', context)),
          Divider(),
          GestureDetector(
            onTap: (){
               AwesomeDialog(
                  context: context,
                  animType: AnimType.scale,
                  dialogType: DialogType.warning,
                  customHeader: Icon(
                    Icons.warning,
                    size: 50,
                    color: Color(0xffF1AEAE),
                  ),
                  body: Center(
                    child: Column(
                      children: [
                        Text(
                          '   You are going to delete \n          your account',
                          style: TextStyle(
                              fontFamily: 'Raleway',
                              fontSize: 19,
                              fontWeight: FontWeight.bold),
                        ),
                        Text(
                          ' You won`t be able to restore your data',
                          style: TextStyle(
                            fontFamily: 'Nunito Sans',
                            fontSize: 13,
                          ),
                        ),
                      ],
                    ),
                  ),
                  btnOkColor:Color(0xffD97474),
                  btnOkText:'Delete',
                  btnCancelColor:Colors.black,
                  btnCancelOnPress: () {},
                  btnOkOnPress: () {},
                ).show();

            },
            child: _buildSpecialOption('Delete My Account', context)),
        ],
      ),
    );
  }

  Widget _buildListTile(String title, BuildContext context) {
    return ListTile(
      onTap: () {},
      title: Text(
        title,
        style: TextStyle(fontFamily: 'Nunito Sans', fontSize: 16),
      ),
      trailing: Icon(Icons.arrow_forward_ios, size: 16.0),
    );
  }

  Widget _buildSpecialOption(String title, BuildContext context) {
    return ListTile(
      //onTap: () {},
      title: Text(
        title,
        style: TextStyle(
          fontSize: 16,
          fontFamily: 'Nunito Sans',
          color: Color(0xff85A8FB),
        ),
      ),
      trailing:
          Icon(Icons.arrow_forward_ios, size: 16.0, color: Color(0xff85A8FB)),
    );
  }
}
