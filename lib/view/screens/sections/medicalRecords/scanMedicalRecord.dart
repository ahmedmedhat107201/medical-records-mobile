import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/medicalRecords/medicalRecordScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../../Model/Services/QR_code_api.dart';
import '../../../../constant.dart';
import '../../../widgets/custom_drawer.dart';

class ScanMedicalRecord extends StatefulWidget {
  static final String routeID = "/scanMedicalRecordScreen";

  @override
  State<ScanMedicalRecord> createState() => _ScanMedicalRecordState();
}

class _ScanMedicalRecordState extends State<ScanMedicalRecord> {
  ScannedUser? scannedUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: primaryColor,
        title: Center(child: Text('New Medical Record')),
      ),
      drawer: CustomDrawer(),
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              MaterialButton(
                child: Text('Generate QR Code'),
                color: primaryColor,
                onPressed: () async {
                  globalGeneratedQRCode = await generateQRCode_api();
                  showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          scrollable: true,
                          content: Center(
                            child: QrImageView(
                              data: globalGeneratedQRCode.toString(),
                              size: 200,
                              version: QrVersions.auto,
                            ),
                          ),
                        );
                      });
                },
              ),
              globalUser!.medicalSpecialization == null
                  ? Text('')
                  : MaterialButton(
                      child: Text('Scan QR Code (doctors)'),
                      color: primaryColor,
                      onPressed: () async {
                        // globalScannedQRCode =
                        //     await FlutterBarcodeScanner.scanBarcode(
                        //   '#ff6666',
                        //   'Cancel',
                        //   true,
                        //   ScanMode.BARCODE,
                        // );

                        globalScannedQRCode =
                            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYXRpb25hbElkIjoiMjExMTExMTExMTExMTEiLCJpZCI6IjNjZmQ1ZjBjLTJlYzctNDllZi1iNDI3LWZkNGQ3MmZlNTljMiIsIm5hbWUiOiJhaG1lZCBtZWRoYXQiLCJpYXQiOjE2ODgzNzE3MzR9.ksR43Hn9tgK7XZ1p5yRt0bMPlfJSBNefMgLUcuFDPew';

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        setState(
                          () async {
                            Navigator.of(context).pop();

                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MedicalRecordScreen(
                                  isScanned: true,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
