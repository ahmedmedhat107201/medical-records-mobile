import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../../Model/Services/medicalRedords_api.dart';
import '../../../widgets/custom_text.dart';
import '/view/widgets/custom_button.dart';
import '/view/widgets/medicalRecord_text_form_field.dart';

import '../../../widgets/custom_dropDownFormField.dart';
import '/constant.dart';
import '../QRCheckScreen.dart';

class CreateMedicalRecordScreen extends StatefulWidget {
  static final String routeID = "/createMedicalRecordScreen";

  @override
  State<CreateMedicalRecordScreen> createState() =>
      _CreateMedicalRecordScreenState();
}

class _CreateMedicalRecordScreenState extends State<CreateMedicalRecordScreen> {
  String? lifeTime;
  bool? lifeTimeValue;
  String? detailTypeValue;
  String? actionType;

  TextEditingController title = TextEditingController();
  TextEditingController detailKey = TextEditingController();
  TextEditingController detailValue = TextEditingController();

  List<Widget> detailsWidgets = [];
  List<Map<String, String>> detailListApi = [];

  @override
  Widget build(BuildContext context) {
    var formkey = GlobalKey<FormState>();
    var secondFormkey = GlobalKey<FormState>();

    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
            child: Column(
              children: [
                //Profile Design
                Container(
                  padding: EdgeInsets.only(top: 30),
                  height: 300,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                  ),
                  child: Column(
                    children: [
                      Align(
                        alignment: Alignment.topLeft,
                        child: IconButton(
                          iconSize: 30,
                          onPressed: () {
                            Navigator.pushNamed(
                              context,
                              QRCheckScreen.routeID,
                            );
                          },
                          icon: Icon(Icons.arrow_back),
                          alignment: Alignment.topLeft,
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        width: 120,
                        height: 120,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                        ),
                        child: globalScannedUser!.image_src == null
                            ? Image.asset(
                                '$imagePath/default.png',
                              )
                            : CircleAvatar(
                                backgroundImage: NetworkImage(
                                  '${globalScannedUser!.image_src}',
                                ),
                              ),
                      ),
                      SizedBox(height: 10),
                      Text(
                        '${globalScannedUser!.name}',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.all(15),
                  child: Column(
                    children: [
                      //Title
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
                      SizedBox(height: 25),
                      //Action Type
                      CustomDropDownFormField(
                        itemList: [
                          "Generic",
                          "Diagnosis",
                          "Surgery",
                          "Illness",
                          "Allergy",
                          "LabTest",
                        ],
                        lable: 'ActionType',
                        icon: Icon(Icons.type_specimen_outlined),
                        onChanged: (newValue) {
                          actionType = newValue;
                        },
                        startValue: actionType,
                        validator: (value) {
                          if (value == null) {
                            return 'empty';
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(height: 25),
                      //Life Time
                      CustomDropDownFormField(
                        validator: (value) {
                          if (value == null) {
                            return 'empty';
                          } else {
                            return null;
                          }
                        },
                        startValue: lifeTime,
                        itemList: <String>[
                          'true',
                          'false',
                        ],
                        icon: Icon(Icons.info_outline),
                        lable: 'Chronic',
                        onChanged: (String? newValue) {
                          lifeTimeValue = toBool(newValue.toString());
                          lifeTime = newValue;
                        },
                      ),
                      //Details List
                      detailsWidgets.length == 0
                          ? SizedBox.shrink()
                          : Column(
                              children: [
                                SizedBox(height: 20),
                                Center(
                                  child: Text(
                                    'Details',
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 26,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                ListView.separated(
                                  physics: NeverScrollableScrollPhysics(),
                                  separatorBuilder:
                                      (BuildContext context, int index) {
                                    return SizedBox(height: 10);
                                  },
                                  shrinkWrap: true,
                                  itemCount: detailsWidgets.length,
                                  itemBuilder: (context, index) {
                                    return Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 20,
                                      ),
                                      child: detailsWidgets[index],
                                    );
                                  },
                                ),
                              ],
                            ),
                      SizedBox(height: 25),
                      //Add Details
                      ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            primaryColor,
                          ),
                        ),
                        onPressed: () {
                          showDialog(
                            context: context,
                            builder: (context) {
                              return Form(
                                key: secondFormkey,
                                child: AddDetailsWidget(secondFormkey, context),
                              );
                            },
                          );
                        },
                        child: Text('Add Details'),
                      ),
                      SizedBox(height: 15),
                      //Add Record Button
                      CustomButton(
                        onPressed: () async {
                          if (formkey.currentState!.validate()) {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return Center(
                                  child: CircularProgressIndicator(),
                                );
                              },
                            );

                            await createMedicalRecord(
                              userId: '${globalScannedUser!.id}',
                              actionType: actionType,
                              lifeTime: lifeTimeValue,
                              title: title.text,
                              details: detailListApi,
                            );
                            Navigator.of(context).pop();
                            setState(
                              () {
                                title.clear();
                                detailKey.clear();
                                detailValue.clear();
                                detailsWidgets.clear();
                                detailListApi.clear();
                              },
                            );
                          }
                        },
                        text: "Add Record",
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

  AlertDialog AddDetailsWidget(
    GlobalKey<FormState> secondFormkey,
    BuildContext context,
  ) {
    return AlertDialog(
      scrollable: true,
      content: Column(
        children: [
          Center(
            child: Text(
              'Add Details',
              style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold,
                fontSize: 26,
              ),
            ),
          ),
          SizedBox(height: 10),
          Column(
            children: [
              //DetailType
              CustomDropDownFormField(
                itemList: <String>[
                  'text',
                  'date',
                  'email',
                  'url',
                  'phone',
                ],
                onChanged: (newValue) {
                  setState(
                    () {
                      detailTypeValue = newValue;
                    },
                  );
                },
                lable: 'Detail Type',
                icon: Icon(
                  Icons.align_horizontal_left_rounded,
                ),
                startValue: detailTypeValue,
                onSaved: (newValue) {
                  setState(() {
                    detailTypeValue = newValue;
                  });
                },
                validator: (value) {
                  if (value == null) {
                    return 'empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              //Detail Key
              MedicalRecordFormField(
                IconData: Icon(
                  Icons.type_specimen_outlined,
                ),
                control: detailKey,
                label: "Key",
                validate: (value) {
                  if (value.isEmpty) {
                    return 'empty';
                  } else {
                    return null;
                  }
                },
              ),
              SizedBox(height: 10),
              DetailTypeWidget(
                detail: detailValue,
                type: detailTypeValue ?? 'text',
              ),
              SizedBox(height: 10),
              ElevatedButton(
                child: Text('Add Detail'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                    primaryColor,
                  ),
                ),
                onPressed: () {
                  if (!secondFormkey.currentState!.validate()) {
                    print('not validate');
                  } else {
                    print('validate');
                    setState(() {
                      detailsWidgets.add(
                        // MedicalRecordCard(
                        //   color: Color.fromARGB(255, 3, 57, 102),
                        //   title: detailKey.text,
                        //   text: detailValue.text,
                        // ),
                        Container(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              CustomText(
                                text: detailKey.text,
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: primaryColor,
                                maxLines: 1,
                                overFlow: TextOverflow.ellipsis,
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Align(
                                  alignment: Alignment.centerLeft,
                                  child: ExpandableText(
                                    '${detailValue.text}',
                                    maxLines: 2,
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 18,
                                    ),
                                    expandText: 'Read more',
                                    collapseText: 'Show less',
                                    linkStyle:
                                        TextStyle(fontWeight: FontWeight.bold),
                                    linkColor: primaryColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                      detailListApi.add({
                        "type": "${detailTypeValue}",
                        "key": "${detailKey.text}",
                        "value": "${detailValue.text}"
                      });
                      detailKey.clear();
                      detailValue.clear();
                      Navigator.pop(context);
                    });
                  }
                },
              )
            ],
          ),
        ],
      ),
    );
  }
}

class DetailTypeWidget extends StatefulWidget {
  final String type;
  final TextEditingController detail;
  const DetailTypeWidget({
    required this.type,
    required this.detail,
  });
  @override
  State<DetailTypeWidget> createState() => _DetailTypeWidgetState();
}

class _DetailTypeWidgetState extends State<DetailTypeWidget> {
  Widget build(BuildContext context) {
    return Container(
      child: MedicalRecordFormField(
        readOnly: widget.type == 'date' ? true : false,
        onTap: widget.type == 'date'
            ? () async {
                DateTime? pickedDate = await showDatePicker(
                  context: context,
                  initialDate: DateTime.now(),
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2100),
                );

                final DateFormat formatter = DateFormat('yMMMMd');
                final String formatted = formatter.format(pickedDate!);
                widget.detail.text = formatted;
                print(formatted);
              }
            : () {},
        control: widget.detail,
        label: 'Detail',
        IconData: widget.type == 'date'
            ? Icon(Icons.date_range_outlined)
            : Icon(Icons.text_fields),
        validate: (value) {
          if (value.isEmpty) {
            return 'empty';
          } else {
            return null;
          }
        },
      ),
    );
  }
}
