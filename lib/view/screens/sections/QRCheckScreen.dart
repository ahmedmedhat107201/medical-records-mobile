import 'package:flutter/material.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:medical_records_mobile/view/screens/sections/medicalRecords/createMedicalRecordScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../widgets/custom_text.dart';
import '/view/widgets/custom_drawer.dart';
import '../../../Model/Services/QR_code_api.dart';
import '/constant.dart';

class QRCheckScreen extends StatefulWidget {
  static final String routeID = "/QRCeackScreen";

  @override
  State<QRCheckScreen> createState() => _QRCheckScreenState();
}

class _QRCheckScreenState extends State<QRCheckScreen> {
  ScannedUser? scannedUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              text: 'Create Medical Record',
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
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
                    },
                  );
                },
              ),
              globalUser!.medicalSpecialization == null
                  ? Text('')
                  : MaterialButton(
                      child: Text('Scan QR Code (doctors)'),
                      color: primaryColor,
                      onPressed: () async {
                        globalScannedQRCode =
                            await FlutterBarcodeScanner.scanBarcode(
                          '#ff6666',
                          'Cancel',
                          true,
                          ScanMode.BARCODE,
                        );

                        // globalScannedQRCode =
                        //     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYXRpb25hbElkIjoiMTExMTExMTExMTExMTEiLCJpZCI6IjMwNGE2ZGY2LWZlOTMtNDc5OC1iYTQ2LTQ5OWJlNDE1NDljZSIsIm5hbWUiOiJBaG1lZCBNZWRoYXQiLCJpYXQiOjE2ODkxMjA0MzEsImV4cCI6MTY4OTEyMDczMX0.LtGWBg4HY0mbZDja834kqx3nY1GBiKvVHLd3FVdeMj4';

                        showDialog(
                          context: context,
                          builder: (context) {
                            return Center(
                              child: CircularProgressIndicator(),
                            );
                          },
                        );
                        scannedUser = await scanQRCode_api(
                          globalScannedQRCode!,
                        );
                        globalScannedUser = scannedUser;

                        Navigator.of(context).pop();
                        if (scannedUser!.id != null) {
                          Navigator.pushNamed(
                            context,
                            CreateMedicalRecordScreen.routeID,
                          );
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              backgroundColor: primaryColor,
                              duration: Duration(seconds: 5),
                              content: Text('Try To Scan Again'),
                              action: SnackBarAction(
                                label: 'dismiss',
                                onPressed: () {},
                              ),
                            ),
                          );
                        }
                      },
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
