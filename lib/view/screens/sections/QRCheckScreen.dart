import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/screens/sections/createMedicalRecordScreen.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '/view/widgets/custom_drawer.dart';
import '../../../Model/Services/QR_code_api.dart';
import '/constant.dart';
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';

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
                            child: QrImage(
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
                            'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYXRpb25hbElkIjoiMzExMTExMTExMTExMTEiLCJpYXQiOjE2ODA1NTYwMDksImV4cCI6MTY4MDU1NjMwOX0.heuK44F1ajOXVzf87PshHtSbeGk6sA71AclHRH7uM3o';

                        setState(
                          () async {
                            scannedUser = await scanQRCode_api(
                              globalScannedQRCode!,
                            );
                            globalScannedUser = scannedUser;

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
