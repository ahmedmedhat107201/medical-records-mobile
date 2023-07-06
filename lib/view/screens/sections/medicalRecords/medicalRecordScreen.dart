import 'package:flutter/material.dart';

import '/Model/Services/medicalRedords_api.dart';
import '/constant.dart';
import '/view/widgets/custom_drawer.dart';

class MedicalRecordScreen extends StatefulWidget {
  static final String routeID = "/medicalRecordScreen";

  final bool isScanned;
  const MedicalRecordScreen({required this.isScanned});

  @override
  State<MedicalRecordScreen> createState() => MedicalRecordState();
}

class MedicalRecordState extends State<MedicalRecordScreen> {
  List<MedicalRecordApi?>? medicalRecord;
  bool load = false;

  void fetch(String? actionType) async {
    setState(() {
      load = true;
    });
    medicalRecord = await medicalRecord_api(actionType);
    globalMedicalRecord = medicalRecord;
    setState(() {
      load = false;
    });
  }

  void scanFetch(String? actionType) async {
    setState(() {
      load = true;
    });
    medicalRecord = await scannedMedicalRecord_api(
      actionType: actionType!,
      qrCode: globalScannedQRCode!,
    );
    globalScannedMedicalRecord = medicalRecord;
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.isScanned) {
      if (medicalRecord == null) {
        scanFetch('');
      }
    } else {
      if (medicalRecord == null) {
        fetch('');
        print("data fetched");
      }
    }
  }

  var selectedRecord = "All Records";
  List<String> actionTypeList = [
    "All Records",
    "Birth",
    "Generic",
    "Diagnosis",
    "Surgery",
    "Illness",
    "Allergy",
    "LabTest",
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
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                children: [
                  //
                  // dropDownList
                  //
                  Container(
                    child: DropdownButtonFormField(
                      value: selectedRecord,
                      items: actionTypeList.map(
                        (e) {
                          return DropdownMenuItem(
                            child: Text(e),
                            value: e,
                          );
                        },
                      ).toList(),
                      onChanged: (value) {
                        setState(
                          () {
                            selectedRecord = '$value';
                            print(value);
                            if (value == 'All Records') {
                              if (widget.isScanned)
                                scanFetch('All Records');
                              else
                                fetch('All Records');
                            } else {
                              if (widget.isScanned)
                                scanFetch(value);
                              else
                                fetch(value);
                            }
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 30),
                  //
                  // List Of Records
                  //
                  Expanded(
                    child: medicalRecord!.isEmpty
                        ? Center(
                            child: Text('No data in $selectedRecord'),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            itemCount: medicalRecord!.length,
                            scrollDirection: Axis.vertical,
                            separatorBuilder:
                                (BuildContext context, int index) {
                              return SizedBox(height: 20);
                            },
                            itemBuilder: (BuildContext context, int index) {
                              var data = medicalRecord![index]!;
                              //
                              // single medical record
                              //
                              return Container(
                                height: 70,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: MaterialButton(
                                  textColor: Colors.white,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text("${data.actionType}"),
                                      SizedBox(width: 10),
                                      Text("${formateDateTimeToDate(
                                        data.createdAt.toString(),
                                      )}"),
                                    ],
                                  ),
                                  onPressed: () {
                                    //
                                    // modal bottom sheet
                                    //
                                    showModalBottomSheet(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.vertical(
                                          top: Radius.circular(30),
                                        ),
                                      ),
                                      context: context,
                                      builder: (context) => BottomSheet(
                                        data: data,
                                      ),
                                    );
                                  },
                                ),
                              );
                            },
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

class BottomSheet extends StatelessWidget {
  const BottomSheet({
    required this.data,
  });

  final MedicalRecordApi data;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(20),
      height: 500,
      child: Column(
        children: [
          Center(
            child: Text(
              '${data.actionType}',
              style: TextStyle(
                color: primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          SizedBox(height: 25),
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  //
                  // medical cards
                  //
                  MedicalRecordCard(
                    title: 'Title',
                    text: '${data.title}',
                  ),
                  MedicalRecordCard(
                    title: 'Time Created',
                    text: formateDateTimeToDate(data.createdAt.toString()),
                  ),
                  MedicalRecordCard(
                    title: 'Life Time',
                    text: data.lifetime.toString(),
                  ),
                  //
                  // details button
                  //
                  MaterialButton(
                    child: Text(
                      'Details',
                      style: TextStyle(color: primaryColor, fontSize: 15),
                    ),
                    onPressed: () {
                      var details = data.details;
                      showDialog(
                        context: context,
                        builder: (context) => AlertDialog(
                          scrollable: true,
                          content: details!.isEmpty
                              ? Text('No Details for this patient')
                              : ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: details.length,
                                  itemBuilder: (context, index) {
                                    return Card(
                                      color: primaryColor,
                                      child: ListTile(
                                        textColor: Colors.white,
                                        leading: Text("${details[index].key}"),
                                        title: Text(
                                          "${details[index].value}",
                                        ),
                                      ),
                                    );
                                  },
                                ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MedicalRecordCard extends StatelessWidget {
  final String? title;
  final String? text;
  final Color? color;

  const MedicalRecordCard({
    this.title,
    this.text,
    this.color = primaryColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Card(
        color: color,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(left: 20),
              child: Text(
                "$title",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
            SizedBox(width: 10),
            Padding(
              padding: const EdgeInsets.only(right: 20),
              child: Text(
                "${text}",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
