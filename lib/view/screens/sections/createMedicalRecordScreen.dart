import 'package:flutter/material.dart';
import 'package:medical_records_mobile/Model/Services/medicalRedords_api.dart';
import 'package:medical_records_mobile/constant.dart';
import 'package:medical_records_mobile/view/screens/sections/QRCheckScreen.dart';
import 'package:medical_records_mobile/view/widgets/medicalRecord_text_form_field.dart';

import '../../widgets/custom_dropDownFormField.dart';

class CreateMedicalRecordScreen extends StatelessWidget {
  static final String routeID = "/createMedicalRecordScreen";
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController lifetime = TextEditingController();
    TextEditingController actiontype = TextEditingController();

    var formkey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                // Container(
                //   padding: EdgeInsets.only(top: 30),
                //   height: 300,
                //   width: double.infinity,
                //   color: primaryColor,
                //   child: Column(
                //     children: [
                //       Align(
                //         alignment: Alignment.topLeft,
                //         child: IconButton(
                //           iconSize: 30,
                //           onPressed: () {
                //             Navigator.pushNamed(
                //               context,
                //               QRCheckScreen.routeID,
                //             );
                //           },
                //           icon: Icon(Icons.arrow_back),
                //           alignment: Alignment.topLeft,
                //           color: Colors.white,
                //         ),
                //       ),
                //       Container(
                //         width: 120,
                //         height: 120,
                //         decoration: BoxDecoration(
                //           shape: BoxShape.circle,
                //           color: Colors.white,
                //         ),
                //         child: globalScannedUser!.image_src == null
                //             ? Image.asset(
                //                 '$imagePath/default.png',
                //               )
                //             : CircleAvatar(
                //                 backgroundImage: NetworkImage(
                //                   '${globalScannedUser!.image_src}',
                //                 ),
                //               ),
                //       ),
                //       Text(
                //         '${globalScannedUser!.name}',
                //         style: TextStyle(
                //           color: Colors.white,
                //           fontSize: 40,
                //           fontWeight: FontWeight.bold,
                //         ),
                //       ),
                //     ],
                //   ),
                // ),

                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      MedicalRecordFormField(
                        IconData: Icon(Icons.title),
                        control: title,
                        label: "Title",
                        keyboardType: TextInputType.text,
                        onsubmit: (value) {
                          print(value);
                        },
                        validate: (value) => value.isEmpty
                            ? 'This field shouldn\'t be empty'
                            : null,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MedicalRecordFormField(
                        IconData: Icon(Icons.info_outline),
                        control: lifetime,
                        label: "Life Time",
                        keyboardType: TextInputType.text,
                        onsubmit: (value) {
                          print(value);
                        },
                        validate: (value) => value.isEmpty
                            ? 'This field shouldn\'t be empty'
                            : null,
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      MedicalRecordFormField(
                        IconData: Icon(Icons.info_outline),
                        control: actiontype,
                        label: "Action Type",
                        keyboardType: TextInputType.text,
                        onsubmit: (value) {
                          print(value);
                        },
                        validate: (value) => value.isEmpty
                            ? 'This field shouldn\'t be empty'
                            : null,
                      ),
                      SizedBox(height: 15),
                      CustomDropDownFormField(
                        itemList: <String>['s', 's'],
                        icon: Icon(Icons.abc),
                        lable: '',
                      ),
                      SizedBox(height: 15),
                      Container(
                        width: 190,
                        height: 50,
                        child: ElevatedButton(
                          onPressed: () async {
                            if (formkey.currentState!.validate()) {
                              // showDialog(
                              //   context: context,
                              //   builder: (context) {
                              //     return Center(
                              //       child: CircularProgressIndicator(),
                              //     );
                              //   },
                              // );

                              await createMedicalRecord(
                                userId: '${globalScannedUser!.id}',
                                actionType: actiontype.text,
                                lifeTime: true,
                                title: title.text,
                                details: [],
                              );

                              // ScaffoldMessenger.of(context).showSnackBar(
                              //   SnackBar(
                              //     backgroundColor: primaryColor,
                              //     duration: Duration(seconds: 5),
                              //     content: Text('$errorMessage'),
                              //     action: SnackBarAction(
                              //       label: 'dismiss',
                              //       onPressed: () {},
                              //     ),
                              //   ),
                              // );
                            }
                          },
                          child: Text(
                            "Add",
                            style: TextStyle(
                              fontSize: 25,
                              fontWeight: FontWeight.w800,
                              color: Colors.blue[50],
                            ),
                          ),
                          style: ButtonStyle(
                            shape: MaterialStateProperty.all<
                                RoundedRectangleBorder>(
                              RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            backgroundColor:
                                MaterialStateProperty.all<Color>(primaryColor!),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
