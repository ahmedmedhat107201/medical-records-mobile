import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import '../../../Model/Services/getDoctorReviews_api.dart';
import '../../../constant.dart';
import '../../widgets/add_review.dart';
import '../../widgets/custom_text.dart';
import '../../widgets/review.dart';
import '/Model/Services/doctorProfile_api.dart';
import '/view/widgets/custom_drawer.dart';
import 'chat/chatScreen.dart';

class DoctorProfileScreen extends StatefulWidget {
  final String doctorId;

  const DoctorProfileScreen({required this.doctorId});
  @override
  State<DoctorProfileScreen> createState() => _DoctorProfileScreenState();
}

class _DoctorProfileScreenState extends State<DoctorProfileScreen> {
  TextEditingController addReviewController = TextEditingController();

  DoctorProfileAPI? doctorProfile;
  List<DoctorReviewAPI?>? doctorReviews;

  bool load = false;
  void fetch() async {
    setState(() {
      load = true;
    });
    doctorProfile = await doctorProfile_api(widget.doctorId);
    globalDoctorProfile = doctorProfile;

    doctorReviews = await getDoctorReview_api(widget.doctorId);
    globalDoctorReviews = doctorReviews;

    setState(() {
      load = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (doctorProfile == null) {
      fetch();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: secondryColor,
      drawer: CustomDrawer(),
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          centerTitle: true,
          backgroundColor: primaryColor,
          title: Center(
            child: Text("Doctor Profile"),
          ),
        ),
      ),
      body: load
          ? Center(
              child: CircularProgressIndicator(),
            )
          : SingleChildScrollView(
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 30,
                ),
                child: Column(
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            CustomText(
                              text: 'DR. ${doctorProfile!.name}',
                              color: primaryColor,
                              fontSize: 20,
                              fontWeight: FontWeight.w600,
                            ),
                            SizedBox(height: 10),
                            CustomText(
                              text: doctorProfile!.medicalSpecialization,
                              color: primaryColor,
                              fontSize: 16,
                              fontWeight: FontWeight.w400,
                            ),
                            SizedBox(height: 5),
                            RatingCard(
                              totalRating:
                                  doctorProfile!.doctorData!.totalRating!,
                            ),
                          ],
                        ),
                        Material(
                          elevation: 10,
                          child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 4),
                            width: 90,
                            height: 90,
                            decoration: BoxDecoration(
                              color: primaryColor,
                              borderRadius: BorderRadius.circular(5),
                            ),
                            child: CircleAvatar(
                              backgroundImage: doctorProfile!.image_src == null
                                  ? Image.asset('imagePath/default.png').image
                                  : Image.network(
                                      doctorProfile!.image_src.toString(),
                                    ).image,
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    CustomText(
                      alignment: Alignment.center,
                      text: 'Reviews',
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 8),
                    doctorReviews!.length == 0
                        ? Center(
                            child: CustomText(
                              text:
                                  'There\'s no reviews for DR. ${doctorProfile!.name}',
                            ),
                          )
                        : ListView.separated(
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemCount: doctorReviews!.length,
                            separatorBuilder: (context, index) {
                              return SizedBox(height: 20);
                            },
                            itemBuilder: (context, index) {
                              var review = doctorReviews![index]!;
                              return ReviewWidget(
                                name: review.reviewer!.name!,
                                image: review.reviewer!.image_src!,
                                createdAt: review.createdAt!,
                                rating: review.rating!,
                                // comment: review.comment!,
                                comment:
                                    'in my whole life I did not see a doctor as mush as good and helpful like you, from all of my heart, thank you dr sherif',
                              );
                            },
                          ),
                    SizedBox(height: 20),
                    CustomText(
                      alignment: Alignment.center,
                      text: 'Add Review',
                      color: primaryColor,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                    ),
                    SizedBox(height: 8),
                    AddReviewWidget(
                      controller: addReviewController,
                    ),
                    SizedBox(height: 20),
                    Container(
                      alignment: Alignment.topLeft,
                      margin: EdgeInsets.symmetric(horizontal: 80),
                      child: TextButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.all<Color>(
                            primaryColor,
                          ),
                          elevation: MaterialStateProperty.all<double>(10),
                          minimumSize: MaterialStateProperty.all<Size>(
                            Size(double.infinity, 40),
                          ),
                        ),
                        child: CustomText(
                          text: 'Chat Now',
                          color: secondryColor,
                          fontSize: 16,
                          alignment: Alignment.center,
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ChatScreen(
                                userId: widget.doctorId,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}

class RatingCard extends StatelessWidget {
  const RatingCard({
    required this.totalRating,
  });

  final num totalRating;

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          12,
        ),
      ),
      margin: EdgeInsets.zero,
      elevation: 10,
      color: primaryColor,
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            RatingBar.builder(
              ignoreGestures: true,
              initialRating: totalRating.toDouble(),
              minRating: 0,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 20,
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: secondryColor,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
            SizedBox(width: 5),
            if (totalRating == 0)
              CustomText(
                text: 'none',
                color: Colors.white,
              )
            else if (totalRating <= 2)
              CustomText(
                text: 'Bad',
                color: Colors.white,
              )
            else if (totalRating <= 4)
              CustomText(
                text: 'Good',
                color: Colors.white,
              )
            else if (totalRating > 4)
              CustomText(
                text: 'Excellent',
                color: Colors.white,
              ),
          ],
        ),
      ),
    );
  }
}
