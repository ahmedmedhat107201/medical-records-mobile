import 'package:flutter/material.dart';
import '/Model/Services/login_api.dart';
import '/constant.dart';
import 'sections/homeScreen.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  /*
    ui of the login screen with all the textFields validations
    call login_api() 
  */

  static final String routeID = "/loginScreen";
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formState = GlobalKey<FormState>();
    String _pass = "";
    String _id = "";
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(child: Text("Login")),
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                padding: EdgeInsets.all(20),
                child: Form(
                  key: _formState,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      //Logo
                      Image.asset(
                        '$imagePath/logo.png',
                        width: double.infinity,
                        height: 150,
                      ),
                      SizedBox(height: 20),
                      //ID
                      CustomTextFormField(
                        keyboardType: TextInputType.number,
                        onChanged: (input) {
                          _id = input;
                        },
                        isHiden: false,
                        text: "National ID",
                        hint: "14 Numbers ID",
                        onSaved: (String? text) {},
                        validator: (String? text) {
                          final n = num.tryParse(text!);
                          if (n == null || text.length != 14) {
                            return 'The National ID must be 14 numbers';
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: 20),
                      //Password
                      CustomTextFormField(
                        onChanged: (input) {
                          _pass = input;
                        },
                        onSaved: (onSaved) {},
                        validator: (String? text) {
                          if (text!.length < 6) {
                            return 'Password must be at least 6 letters';
                          }
                          return null;
                        },
                        hint: "*********",
                        text: "Password",
                        isHiden: true,
                      ),
                      SizedBox(height: 40),
                      //Sign In Button
                      CustomButton(
                        text: "SIGN IN",
                        onPressed: () async {
                          var formData = _formState.currentState;
                          if (!formData!.validate()) {
                          } else {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            int statusCode = await login_api(_id, _pass);
                            if (statusCode == 200) {
                              Navigator.of(context).pop();
                              Navigator.pushNamedAndRemoveUntil(
                                context,
                                HomeScreen.routeID,
                                (route) => false,
                              );
                            } else {
                              Navigator.of(context).pop();
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text("Invalid Email or Password"),
                                  backgroundColor: primaryColor,
                                ),
                              );
                            }
                          }
                          // Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
