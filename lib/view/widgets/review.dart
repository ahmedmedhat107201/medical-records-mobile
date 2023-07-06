import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constant.dart';
import 'custom_text.dart';

class ReviewWidget extends StatelessWidget {
  final String? name;
  final String? image;
  final String? createdAt;
  final num? rating;
  final String? comment;

  ReviewWidget({
    required this.name,
    required this.image,
    required this.createdAt,
    required this.rating,
    required this.comment,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      color: secondryColor,
      elevation: 10,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        padding: EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  radius: 16,
                  backgroundImage: image == null
                      ? Image.asset('$imagePath/default.png').image
                      : Image.network('${image}').image,
                ),
                SizedBox(width: 8),
                CustomText(
                  text: name!,
                  color: primaryColor,
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 8),
            Row(
              children: [
                RatingBar.builder(
                  ignoreGestures: true,
                  initialRating: rating!.toDouble(),
                  minRating: 0,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemSize: 12,
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: primaryColor,
                  ),
                  onRatingUpdate: (rating) {
                    print(rating);
                  },
                ),
                SizedBox(width: 6),
                CustomText(
                  text: formateDateTimeToDate(createdAt!),
                  color: primaryColor,
                  fontWeight: FontWeight.bold,
                ),
              ],
            ),
            SizedBox(height: 8),
            ExpandableText(
              '$comment',
              maxLines: 2,
              style: TextStyle(
                color: primaryColor,
                fontSize: 16,
              ),
              expandText: 'Read more',
              collapseText: 'Show less',
              linkStyle: TextStyle(fontWeight: FontWeight.bold),
              linkColor: primaryColor,
            ),
          ],
        ),
      ),
    );
  }
}
