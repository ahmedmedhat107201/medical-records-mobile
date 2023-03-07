import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';
import 'package:medical_records_mobile/view/widgets/custom_drawer.dart';

class MedicalRecordScreen extends StatefulWidget {
  static final String routeID = "/MedicalRecordScreen";
  @override
  State<MedicalRecordScreen> createState() => MedicalRecordState();
}
//..
class MedicalRecordState extends State<MedicalRecordScreen> {
  var selectedrecord = "All Records";
  List<String> MedicalRecords = [
    "All Records",
    "Birth",
    "Operations",
    "Examination",
    "Diseases",
    "Chronic Diseases",
    "Allergy Diseases"
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: CustomDrawer(),
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Center(
            child: Text('Medical Record'),
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Container(
                  child: DropdownButtonFormField(
                      value: selectedrecord,
                      items: MedicalRecords.map((e) {
                        return DropdownMenuItem(
                          child: Text(e),
                          value: e,
                        );
                      }).toList(),
                      onChanged: (value) {
                        setState(() {
                          selectedrecord = value as String;
                        });
                      })),
              SizedBox(
                height: 30,
              ),
              Expanded(
                child: ListView.separated(
                    scrollDirection: Axis.vertical,
                    itemBuilder: (BuildContext context, int index) {
                      return Container(
                          height: 70,
                          decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(10)),
                          child: MaterialButton(
                            onPressed: () {
                              showModalBottomSheet(
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.vertical(top: Radius.circular(30))
                                ),
                                  context: context,
                                  builder: (context) => Center(
                                          child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Text(
                                            "Details",
                                            style: TextStyle(
                                                fontSize: 90,
                                                fontWeight: FontWeight.bold,
                                                color: primaryColor),
                                          ),
                                          IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Icon(Icons.arrow_back))
                                        ],
                                      )));
                            },
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text("Name"),
                                SizedBox(
                                  width: 100,
                                ),
                                Text("Date")
                              ],
                            ),
                          ));
                    },
                    separatorBuilder: (BuildContext context, int index) {
                      return SizedBox(
                        height: 10,
                      );
                    },
                    itemCount: 120),
              )
            ],
          ),
        ));
  }
}
