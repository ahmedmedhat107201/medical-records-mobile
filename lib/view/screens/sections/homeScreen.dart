import 'package:flutter/material.dart';
import 'package:medical_records_mobile/view/widgets/custom_text.dart';
import '../../../Model/Services/getDoctors_api.dart';
import '../../../constant.dart';
import '../../widgets/custom_drawer.dart';
import '../../../Model/Services/home_api.dart';

class HomeScreen extends StatefulWidget {
  static final String routeID = "/homeScreen";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  /*
    load the data between the 2 setStates 
    while 'load' boolean is true
      it's loading
    when false
      data loaded successfully
  */
  User? user;
  bool load = false;

  List<GetDoctorsApi?>? doctorsList;

  void fetch() async {
    setState(() {
      load = true;
    });
    user = await home_api();
    globalUser = user;

    doctorsList = await getDoctors_api(
      medicalSpecialization: '',
      name: '',
    );

    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (user == null && doctorsList == null) {
      fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        elevation: 0,
        flexibleSpace: Padding(
          padding: EdgeInsets.only(
            top: 20,
            left: 20,
          ),
          child: Align(
            alignment: Alignment.center,
            child: CustomText(
              alignment: Alignment.center,
              fontSize: 20,
              // fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
        ),
        backgroundColor: primaryColor,
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Column(
                children: [
                  Container(
                    height: 150,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(15),
                        bottomRight: Radius.circular(15),
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: 'Keep Track of your health',
                          color: secondryColor,
                          alignment: Alignment.center,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                        Row(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    bottomLeft: Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: CircleAvatar(
                                radius: 50,
                                backgroundImage: Image.asset(
                                  '$imagePath/logo.png',
                                ).image,
                                backgroundColor: Colors.transparent,
                              ),
                            ),
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(15),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 15),
                  CustomText(
                    alignment: Alignment.center,
                    text: 'Categories',
                    color: primaryColor,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Image.asset('$imagePath/home1.png'),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: 'Health Care',
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Image.asset('$imagePath/home2.png'),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: 'consultant',
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            width: 70,
                            height: 70,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade400,
                              borderRadius: BorderRadius.circular(25),
                            ),
                            child: Image.asset('$imagePath/home3.png'),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: 'Communicate',
                            color: primaryColor,
                            fontWeight: FontWeight.w500,
                            fontSize: 16,
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      CustomText(
                        text: 'Recommended Doctors',
                        color: primaryColor,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                      TextButton(
                        onPressed: () {},
                        child: CustomText(
                          text: 'View More',
                          color: Colors.black,
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            child: Material(
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      doctorsList![0]!.image_src == null
                                          ? Image.asset('imagePath/default.png')
                                              .image
                                          : Image.network(
                                              '${doctorsList![0]!.image_src.toString()}',
                                            ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: doctorsList![0]!.name,
                            color: primaryColor,
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            child: Material(
                              elevation: 10,
                              child: Container(
                                padding: EdgeInsets.symmetric(horizontal: 4),
                                width: 70,
                                height: 70,
                                decoration: BoxDecoration(
                                  color: primaryColor,
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                child: CircleAvatar(
                                  backgroundImage:
                                      doctorsList![1]!.image_src == null
                                          ? Image.asset('imagePath/default.png')
                                              .image
                                          : Image.network(
                                              '${doctorsList![1]!.image_src.toString()}',
                                            ).image,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          CustomText(
                            text: doctorsList![1]!.name,
                            color: primaryColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
    );
  }
}

// 'https://medical-records-web.vercel.app'