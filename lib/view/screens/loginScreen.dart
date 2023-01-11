import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/signed.dart';
import '../widgets/custom_button.dart';
import '../widgets/custom_text.dart';
import '../widgets/custom_text_form_field.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    GlobalKey<FormState> _formState = GlobalKey<FormState>();
    String? _pass;
    int? _id;
    return Container(
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
                      'assets/images/logo.jpg',
                      width: double.infinity,
                      height: 150,
                    ),

                    //Welcome
                    // CustomText(
                    //   alignment: Alignment.center,
                    //   text: "Welcome",
                    //   fontSize: 30,
                    // ),
                    SizedBox(height: 20),
                    //ID
                    CustomTextFormField(
                      keyboardType: TextInputType.number,
                      onChanged: (input) {
                        _id = int.tryParse(input);
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
                      },
                      hint: "*********",
                      text: "Password",
                      isHiden: true,
                    ),
                    SizedBox(height: 20),
                    //Forget Password
                    GestureDetector(
                      child: CustomText(
                        alignment: Alignment.topRight,
                        text: "Forget Password ?",
                        color: Colors.black54,
                      ),
                      onTap: () {},
                    ),
                    SizedBox(height: 30),
                    //Sign In Button
                    CustomButton(
                      text: "SIGN IN",
                      onPressed: () {
                        var formData = _formState.currentState;
                        if (!formData!.validate()) {
                          print("not valid button");
                        } else {
                          print('valid button');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Signed(
                                id: _id,
                                password: _pass,
                              ),
                            ),
                          );
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
