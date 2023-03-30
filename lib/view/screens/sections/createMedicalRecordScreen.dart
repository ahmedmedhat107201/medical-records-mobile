import 'package:image_picker/image_picker.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:medical_records_mobile/constant.dart';
import 'package:medical_records_mobile/view/screens/sections/medicalRecordScreen.dart';
import 'package:medical_records_mobile/view/widgets/medicalRecord_text_form_field.dart';

class CreateMedicalRecordScreen extends StatelessWidget {
  static final String routeID = "/createMedicalRecordScreen";
  @override
  Widget build(BuildContext context) {
    TextEditingController title = TextEditingController();
    TextEditingController lifetime = TextEditingController();
    TextEditingController actiontype = TextEditingController();
    TextEditingController createdat = TextEditingController();
    TextEditingController updatedat = TextEditingController();
    TextEditingController doctorid = TextEditingController();
    TextEditingController doctorname = TextEditingController();
    TextEditingController doctorspecialization = TextEditingController();
    var formkey = GlobalKey<FormState>();

    Future chooseanimage() async {
      final XFile? image =
          await ImagePicker().pickImage(source: ImageSource.gallery);
    }

    Future takeanimage() async {
      final XFile? photo =
          await ImagePicker().pickImage(source: ImageSource.camera);
    }

    Future uploadingfiles() async {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['jpg', 'pdf', 'doc'],
      );
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(child: Text('New Medical Record')),
        leading: IconButton(
          onPressed: () {
            Navigator.pushNamed(context, MedicalRecordScreen.routeID);
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Form(
            key: formkey,
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
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
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
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
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
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                MedicalRecordFormField(
                  IconData: Icon(Icons.timelapse),
                  control: createdat,
                  label: "Created At",
                  keyboardType: TextInputType.text,
                  onsubmit: (value) {
                    print(value);
                  },
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                MedicalRecordFormField(
                  IconData: Icon(Icons.timelapse),
                  control: updatedat,
                  label: "Updated At",
                  keyboardType: TextInputType.text,
                  onsubmit: (value) {
                    print(value);
                  },
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                MedicalRecordFormField(
                  IconData: Icon(Icons.person),
                  control: doctorname,
                  label: "Doctor Name",
                  keyboardType: TextInputType.text,
                  onsubmit: (value) {
                    print(value);
                  },
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                MedicalRecordFormField(
                  IconData: Icon(Icons.numbers),
                  control: doctorid,
                  label: "Doctor ID",
                  keyboardType: TextInputType.text,
                  onsubmit: (value) {
                    print(value);
                  },
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                MedicalRecordFormField(
                  IconData: Icon(Icons.medical_information_rounded),
                  control: doctorspecialization,
                  label: "Doctor Specialization",
                  keyboardType: TextInputType.text,
                  onsubmit: (value) {
                    print(value);
                  },
                  validate: (value) =>
                      value.isEmpty ? 'This field shouldn\'t be empty' : null,
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                                content: Container(
                                  height: 110,
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      MaterialButton(
                                          onPressed: () {
                                            takeanimage();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.camera_alt_outlined,
                                                color: primaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Camera",
                                                style: TextStyle(
                                                    color: primaryColor),
                                              )
                                            ],
                                          )),
                                      MaterialButton(
                                          onPressed: () {
                                            chooseanimage();
                                          },
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.image,
                                                color: primaryColor,
                                              ),
                                              SizedBox(
                                                width: 10,
                                              ),
                                              Text(
                                                "Gallerry",
                                                style: TextStyle(
                                                    color: primaryColor),
                                              )
                                            ],
                                          ))
                                    ],
                                  ),
                                ),
                              ));
                    },
                    child: Text(
                      "Upload Doctor Image",
                    ),
                    style: ButtonStyle(
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor!),
                    ),
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.note_alt_sharp,
                      color: primaryColor,
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Text(
                      "Details",
                      style: TextStyle(color: primaryColor),
                    ),
                  ],
                ),
                SizedBox(
                  height: 15,
                ),
                Container(
                    decoration: BoxDecoration(
                      color: Colors.blue[50],
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      children: [
                        TextFormField(
                          maxLines: 20,
                          keyboardType: TextInputType.text,
                        ),
                        MaterialButton(
                          onPressed: () {
                            uploadingfiles();
                          },
                          child: Text(
                            "Upload Attachments",
                            style: TextStyle(color: primaryColor),
                          ),
                        )
                      ],
                    )),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 190,
                  child: ElevatedButton(
                    onPressed: () {
                      if (formkey.currentState!.validate()) {
                        print(" this is ready");
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      backgroundColor:
                          MaterialStateProperty.all<Color>(primaryColor!),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
