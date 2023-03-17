import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';
import 'package:medical_records_mobile/view/widgets/custom_drawer.dart';
import '/Model/Services/medicalRedords_api.dart';

class MedicalRecordScreen extends StatefulWidget {
  static final String routeID = "/MedicalRecordScreen";
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
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (medicalRecord == null) {
      fetch('');
      print("data fetched");
    }
  }

  var selectedrecord = "All Records";
  List<String> actionTypeList = [
    "All Records",
    "Birth",
    "Generic",
    "Diagnosis",
    "Surgery",
    "Illness",
    "Allergy",
    "LabTest",
    "Death",
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
            Container(
              child: DropdownButtonFormField(
                value: selectedrecord,
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
                      selectedrecord = '$value';
                      print(value);
                      if (value == 'All Records') {
                        fetch('All Records');
                      } else {
                        fetch(value);
                      }
                    },
                  );
                },
              ),
            ),
            SizedBox(
              height: 30,
            ),
            // MedicalRecordListView(
            //   medicalRecord: medicalRecord,
            // ),
            Expanded(
              child: medicalRecord!.isEmpty
                  ? Center(
                child: Text('No data in $selectedrecord'),
              )
                  : ListView.separated(
                shrinkWrap: true,
                itemCount: medicalRecord!.length,
                scrollDirection: Axis.vertical,
                separatorBuilder:
                    (BuildContext context, int index) {
                  return SizedBox(
                    height: 20,
                  );
                },
                itemBuilder: (BuildContext context, int index) {
                  var data = medicalRecord![index]!;
                  return Container(
                    height: 70,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: MaterialButton(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("${data.actionType}"),
                          SizedBox(
                            width: 10,
                          ),
                          Text("${formateDateTime(
                            data.createdAt.toString(),
                          )}"),
                        ],
                      ),
                      onPressed: () {
                        showModalBottomSheet(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30),
                            ),
                          ),
                          context: context,
                          builder: (context) => Container(
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
                                SizedBox(
                                  height: 15,
                                ),
                                Expanded(
                                  child: ListView.builder(
                                      shrinkWrap: true,
                                      scrollDirection:
                                      Axis.vertical,
                                      itemBuilder:
                                          (BuildContext context,
                                          int index) {
                                        return Column(
                                          children: [
                                            SizedBox(
                                              height: 20,
                                            ),
                                            Container(
                                              decoration:
                                              BoxDecoration(
                                                borderRadius:
                                                BorderRadius
                                                    .circular(
                                                    15),
                                              ),
                                              child: Column(
                                                children: [
                                                  Card(
                                                    color:
                                                    primaryColor,
                                                    child: ListTile(
                                                      leading: Text(
                                                          "Title"),
                                                      title: Text(
                                                        "${data.title}",
                                                      ),
                                                    ),
                                                  ),
                                                  Card(
                                                    color:
                                                    primaryColor,
                                                    child: ListTile(
                                                      leading: Text(
                                                          "Time Created"),
                                                      title: Text(
                                                        "${formateDateTime(
                                                          data.createdAt
                                                              .toString(),
                                                        )},",
                                                      ),
                                                    ),
                                                  ),
                                                  Card(
                                                    color:
                                                    primaryColor,
                                                    child: ListTile(
                                                      leading: Text(
                                                          "Life Time"),
                                                      title: Text(
                                                        '${data.lifetime}',
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context:
                                                          context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                  content: Column(
                                                                    mainAxisAlignment:
                                                                    MainAxisAlignment.center,
                                                                    children: [
                                                                      SizedBox(
                                                                        height: 30,
                                                                      ),
                                                                      Text("${data.details![2].value}",
                                                                          style: TextStyle(
                                                                            color: primaryColor,
                                                                            fontWeight: FontWeight.bold,
                                                                          )),
                                                                    ],
                                                                  )));
                                                    },
                                                    child: Text(
                                                      'Details',
                                                      style: TextStyle(
                                                          color:
                                                          primaryColor,
                                                          fontSize:
                                                          15),
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    height: 10,
                                                  ),
                                                  MaterialButton(
                                                    onPressed: () {
                                                      showDialog(
                                                          context:
                                                          context,
                                                          builder: (context) =>
                                                              AlertDialog(
                                                                  content: Container(
                                                                    height:
                                                                    70,
                                                                    child:
                                                                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                                                                      SizedBox(
                                                                        width: 25,
                                                                      ),
                                                                      CircleAvatar(
                                                                        child: Text("${data.doctor?.image_src}"),
                                                                        radius: 50,
                                                                      ),
                                                                      Column(
                                                                        children: [
                                                                          SizedBox(
                                                                            height: 18,
                                                                          ),
                                                                          Text("${data.doctor?.name}",
                                                                              style: TextStyle(
                                                                                color: primaryColor,
                                                                                fontWeight: FontWeight.bold,
                                                                              )),
                                                                          Text("${data.doctor?.medicalSpecialization}",
                                                                              style: TextStyle(
                                                                                color: primaryColor,
                                                                                fontWeight: FontWeight.bold,
                                                                              )),
                                                                        ],
                                                                      )
                                                                    ]),
                                                                  )));
                                                    },
                                                    child: Text(
                                                      'Doctor',
                                                      style: TextStyle(
                                                          color:
                                                          primaryColor,
                                                          fontSize:
                                                          15),
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                      itemCount: 1),
                                ),


                              ],
                            ),
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

class MedicalRecordListView extends StatelessWidget {
  const MedicalRecordListView({
    required this.medicalRecord,
  });

  final List<MedicalRecordApi?>? medicalRecord;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.separated(
        shrinkWrap: true,
        itemCount: medicalRecord!.length,
        scrollDirection: Axis.vertical,
        separatorBuilder: (BuildContext context, int index) {
          return SizedBox(
            height: 20,
          );
        },
        itemBuilder: (BuildContext context, int index) {
          var data = medicalRecord![index]!;
          return Container(
            height: 70,
            decoration: BoxDecoration(
              color: primaryColor,
              borderRadius: BorderRadius.circular(10),
            ),
            child: MaterialButton(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("${data.actionType}"),
                  SizedBox(
                    width: 10,
                  ),
                  Text("${formateDateTime(
                    data.createdAt.toString(),
                  )}"),
                ],
              ),
              onPressed: () {
                showModalBottomSheet(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.vertical(
                      top: Radius.circular(30),
                    ),
                  ),
                  context: context,
                  builder: (context) => Container(
                    margin: EdgeInsets.all(20),
                    height: 500,
                    child: ListView(
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
                        Card(
                          color: primaryColor,
                          child: ListTile(
                            leading: Text("title"),
                            title: Text(
                              "${data.title}",
                            ),
                          ),
                        ),
                        Card(
                          color: primaryColor,
                          child: ListTile(
                            leading: Text("Time Created"),
                            title: Text(
                              "${formateDateTime(
                                data.createdAt.toString(),
                              )},",
                            ),
                          ),
                        ),
                        Card(
                          color: primaryColor,
                          child: ListTile(
                            leading: Text("is it life time disease?"),
                            title: Text(
                              '${data.lifetime}',
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
