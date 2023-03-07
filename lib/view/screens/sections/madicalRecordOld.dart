import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/mrecordscreens/operationsscreen.dart';
import 'package:medical_records_mobile/view/widgets/mrsizedbox.dart';
import '../../../constant.dart';
import '../../widgets/custom_MedicalRecordButton.dart';
import '../../widgets/custom_drawer.dart';

class MedicalRecordScreenOld extends StatelessWidget {
  static final String routeID = '/diseaseScreen';
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
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                MRCard(
                  onpressed: () {
                    Navigator.pushNamedAndRemoveUntil(
                      context,
                      Operation.routeID,
                      (route) => false,
                    );
                  },
                  label: "Operations",
                ),
                MRSpace(),
                MRCard(onpressed: () {}, label: "Medical examination"),
                MRSpace(),
                MRCard(onpressed: () {}, label: "Medical tests"),
                MRSpace(),
                MRCard(onpressed: () {}, label: "Disease "),
                MRSpace(),
                MRCard(onpressed: () {}, label: "Chronic Disease"),
                MRSpace(),
                MRCard(onpressed: () {}, label: "Allergic Disease"),
                MRSpace(),
                MRCard(onpressed: () {}, label: "Operations "),
              ],
            ),
          )),
    );
  }
}
