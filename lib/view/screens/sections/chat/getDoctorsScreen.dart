import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/doctorProfileScreen.dart';
import '/view/widgets/custom_dropDownFormField.dart';
import '/Model/Services/getDoctors_api.dart';
import '/constant.dart';

class GetDoctorsScreen extends StatefulWidget {
  static final String routeID = '/getDoctorsScreen';
  @override
  State<GetDoctorsScreen> createState() => _GetDoctorsScreenState();
}

class _GetDoctorsScreenState extends State<GetDoctorsScreen> {
  Icon customIcon = Icon(
    Icons.search,
    color: primaryColor,
  );
  Widget customWidget = Text(
    'All Chats',
    style: TextStyle(
      color: primaryColor,
      fontSize: 18,
      fontWeight: FontWeight.bold,
    ),
  );

  List<GetDoctorsApi?>? doctorsList;
  bool load = false;
  String medicalSpecializationValue = 'All Specializations';
  TextEditingController? doctorNameValue = TextEditingController();

  void fetch({String medicalSpecialization = '', String name = ''}) async {
    setState(() {
      load = true;
    });
    doctorsList = await getDoctors_api(
      medicalSpecialization: medicalSpecialization,
      name: name,
    );
    // globalDoctorList = doctorsList;
    // globalMedicalSpecialization = medicalSpecializationValue;
    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (globalDoctorList != null) {
      // doctorsList = globalDoctorList;
      // medicalSpecializationValue = globalMedicalSpecialization;
    } else if (doctorsList == null) {
      fetch(medicalSpecialization: '', name: '');
    }
  }

  @override
  Widget build(BuildContext context) {
    return load
        ? Center(
            child: CircularProgressIndicator(),
          )
        : Container(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 25),
            child: Column(
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: CustomDropDownFormField(
                    menuColor: Colors.grey.shade200,
                    itemList: [
                      'All Specializations',
                      'Surgical',
                      'Dentistry',
                      'Radiography',
                      'Emergency',
                      'Nursing',
                      'Optometric',
                      'Cardiovascular',
                      'Infectious',
                      'DietNutrition',
                      'Dermatology',
                      'Hematologic',
                    ],
                    lable: 'sss',
                    icon: Icon(Icons.medical_information_sharp),
                    onChanged: (newValue) {
                      setState(() {
                        medicalSpecializationValue = newValue.toString();
                        if (newValue == 'All Specializations') {
                          fetch(
                            medicalSpecialization: '',
                            name: doctorNameValue!.text,
                          );
                        } else {
                          fetch(
                            medicalSpecialization: medicalSpecializationValue,
                            name: doctorNameValue!.text,
                          );
                        }
                      });
                    },
                    startValue: medicalSpecializationValue,
                  ),
                ),
                SizedBox(height: 10),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      customWidget,
                      IconButton(
                        icon: customIcon,
                        onPressed: () {
                          setState(
                            () {
                              if (this.customIcon.icon == Icons.search) {
                                this.customIcon = Icon(Icons.cancel);
                                this.customWidget = Expanded(
                                  child: TextField(
                                    controller: doctorNameValue,
                                    decoration: InputDecoration(
                                      suffixIcon: IconButton(
                                        icon: Icon(Icons.search),
                                        onPressed: () {
                                          if (medicalSpecializationValue ==
                                              'All Specializations') {
                                            fetch(
                                              medicalSpecialization: '',
                                              name: doctorNameValue!.text,
                                            );
                                          } else {
                                            fetch(
                                              medicalSpecialization:
                                                  medicalSpecializationValue,
                                              name: doctorNameValue!.text,
                                            );
                                          }
                                        },
                                      ),
                                      hintText: 'Doctor name',
                                      border: OutlineInputBorder(
                                        borderRadius: BorderRadius.circular(15),
                                        borderSide: BorderSide(width: 1),
                                        gapPadding: 1,
                                      ),
                                    ),
                                    style: TextStyle(
                                      color: primaryColor,
                                      fontSize: 16,
                                    ),
                                  ),
                                );
                              } else {
                                doctorNameValue!.clear();
                                setState(() {
                                  if (medicalSpecializationValue ==
                                      'All Specializations') {
                                    fetch(
                                      medicalSpecialization: '',
                                      name: doctorNameValue!.text,
                                    );
                                  } else {
                                    fetch(
                                      medicalSpecialization:
                                          medicalSpecializationValue,
                                      name: doctorNameValue!.text,
                                    );
                                  }
                                });
                                this.customIcon = Icon(
                                  Icons.search,
                                  color: primaryColor,
                                );
                                this.customWidget = Text(
                                  'All Chats',
                                  style: TextStyle(
                                    color: primaryColor,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                  ),
                                );
                              }
                            },
                          );
                        },
                      ),
                    ],
                  ),
                ),
                Expanded(
                  child: doctorsList!.isEmpty
                      ? Center(
                          child: Text(
                            'No Doctors in $medicalSpecializationValue Department',
                            style: TextStyle(
                              color: primaryColor,
                              fontWeight: FontWeight.bold,
                              fontSize: 16,
                            ),
                          ),
                        )
                      : ListView.separated(
                          itemCount: doctorsList!.length,
                          separatorBuilder: (context, index) {
                            return SizedBox(height: 20);
                          },
                          itemBuilder: (context, index) {
                            var doctor = doctorsList![index]!;
                            return DoctorCard(
                              doctor: doctor,
                              onTap: () {
                                String? id = doctor.id;
                                print(id!);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => DoctorProfileScreen(
                                      doctorId: id,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        ),
                ),
              ],
            ),
          );
  }
}

class DoctorCard extends StatelessWidget {
  const DoctorCard({
    required this.doctor,
    required this.onTap,
  });

  final GetDoctorsApi doctor;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
          vertical: 10,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            CircleAvatar(
              radius: 30,
              backgroundImage: doctor.image_src == null
                  ? Image.asset('$imagePath/default.png').image
                  : Image.network('${doctor.image_src}').image,
            ),
            SizedBox(width: 24),
            Expanded(
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${doctor.name}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                  ),
                  SizedBox(height: 5),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${doctor.medicalSpecialization}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        color: primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
