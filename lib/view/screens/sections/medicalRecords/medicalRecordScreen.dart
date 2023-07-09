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
                        scanned
                            ? Container()
                            : Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomText(
                                    text:
                                        'DR. ${medicalRecords![index]!.doctor!.name!}',
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
                        Column(
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
