import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';

import '../../../widgets/custom_text.dart';
import '../doctorProfileScreen.dart';
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
      backgroundColor: secondryColor,
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: primaryColor,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
          ),
          child: Align(
            alignment: Alignment.center,
            child: CustomText(
              alignment: Alignment.center,
              text: 'Medical Records',
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
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
                  SingleChildScrollView(
                    child: Container(
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
                  ),
                  SizedBox(height: 30),
                  //
                  // List Of Records
                  //
                  Container(
                    child: medicalRecord!.isEmpty
                        ? Center(
                            child: Text('No data in $selectedRecord'),
                          )
                        : NewMedicalRecord(
                            medicalRecords: medicalRecord!,
                            scanned: widget.isScanned,
                          ),
                  ),
                ],
              ),
            ),
    );
  }
}

class NewMedicalRecord extends StatelessWidget {
  final List<MedicalRecordApi?>? medicalRecords;
  final bool scanned;
  NewMedicalRecord({
    this.medicalRecords,
    required this.scanned,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: medicalRecords!.length,
        separatorBuilder: (context, index) {
          return SizedBox(height: 20);
        },
        itemBuilder: (context, index) {
          var record = medicalRecords![index]!;
          var details = medicalRecords![index]!.details!;
          return InkWell(
            child: Material(
              elevation: 15,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Container(
                padding: EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(12),
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      primaryColor,
                      primaryColor.withOpacity(0.95),
                      primaryColor.withOpacity(0.9),
                      primaryColor.withOpacity(0.85),
                      primaryColor.withOpacity(0.8),
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    CustomText(
                      alignment: Alignment.center,
                      text: record.actionType,
                      color: secondryColor,
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                    SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        scanned
                            ? Container()
                            : InkWell(
                                child: CircleAvatar(
                                  radius: 32,
                                  backgroundImage: medicalRecords![index]!
                                              .doctor!
                                              .image_src ==
                                          null
                                      ? Image.asset('$imagePath/default.png')
                                          .image
                                      : Image.network(
                                              '${medicalRecords![index]!.doctor!.image_src}')
                                          .image,
                                ),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => DoctorProfileScreen(
                                        doctorId:
                                            medicalRecords![index]!.doctor!.id!,
                                      ),
                                    ),
                                  );
                                },
                              ),
                        SizedBox(width: 5),
                        scanned
                            ? Container()
                            : Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    CustomText(
                                      text:
                                          '${medicalRecords![index]!.doctor!.name!}',
                                      maxLines: 1,
                                      overFlow: TextOverflow.ellipsis,
                                      color: secondryColor,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                    CustomText(
                                      text: medicalRecords![index]!
                                          .doctor!
                                          .medicalSpecialization!,
                                      color: secondryColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ],
                                ),
                              ),
                        Expanded(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Container(child: Text('')),
                              CustomText(
                                text: formateDateTimeToDate(record.createdAt!),
                                color: Colors.grey.shade400,
                                fontWeight: FontWeight.w400,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            onTap: () {
              showModalBottomSheet(
                backgroundColor: secondryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(30),
                  ),
                ),
                context: context,
                builder: (context) {
                  return Container(
                    height: double.infinity,
                    padding: EdgeInsets.all(20),
                    child: Column(
                      children: [
                        CustomText(
                          text: 'Details',
                          alignment: Alignment.center,
                          fontWeight: FontWeight.bold,
                          fontSize: 22,
                          color: primaryColor,
                        ),
                        SizedBox(height: 20),
                        Expanded(
                          child: ListView(
                            shrinkWrap: true,
                            children: [
                              CustomText(
                                text: 'Title',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: primaryColor,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ExpandableText(
                                  '${record.title}',
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
                              SizedBox(height: 20),
                              CustomText(
                                text: 'Chronic',
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                                color: primaryColor,
                              ),
                              Align(
                                alignment: Alignment.centerLeft,
                                child: ExpandableText(
                                  '${record.lifetime}',
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
                              SizedBox(height: 20),
                              ListView.separated(
                                physics: NeverScrollableScrollPhysics(),
                                shrinkWrap: true,
                                itemCount: details.length,
                                separatorBuilder: (context, index) {
                                  return SizedBox(height: 20);
                                },
                                itemBuilder: (context, index) {
                                  var detail = details[index];
                                  return Column(
                                    children: [
                                      CustomText(
                                        text: '${detail.key}',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 22,
                                        color: primaryColor,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: ExpandableText(
                                          '${detail.value}',
                                          maxLines: 2,
                                          style: TextStyle(
                                            color: primaryColor,
                                            fontSize: 18,
                                          ),
                                          expandText: 'Read more',
                                          collapseText: 'Show less',
                                          linkStyle: TextStyle(
                                            fontWeight: FontWeight.bold,
                                          ),
                                          linkColor: primaryColor,
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
