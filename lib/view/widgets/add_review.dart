import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import '../../constant.dart';

class AddReviewWidget extends StatelessWidget {
  final TextEditingController controller;

  const AddReviewWidget({required this.controller});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerLeft,
            child: RatingBar.builder(
              initialRating: 0,
              minRating: 1,
              direction: Axis.horizontal,
              allowHalfRating: true,
              itemCount: 5,
              itemSize: 24,
              itemPadding: EdgeInsets.symmetric(horizontal: 2),
              itemBuilder: (context, _) => Icon(
                Icons.star,
                color: primaryColor,
              ),
              onRatingUpdate: (rating) {
                print(rating);
              },
            ),
          ),
          SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        offset: Offset(0, 20),
                        blurRadius: 30,
                      ),
                    ],
                    color: primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                      topRight: Radius.circular(90),
                      bottomRight: Radius.circular(90),
                    ),
                  ),
                  height: 120,
                  child: Padding(
                    padding: EdgeInsets.only(
                      left: 20,
                      right: 40,
                    ),
                    child: TextFormField(
                      controller: controller,
                      style: TextStyle(color: secondryColor),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                      ),
                      maxLines: 4,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: IconButton(
                  iconSize: 32,
                  icon: Icon(Icons.telegram),
                  color: primaryColor,
                  onPressed: () {
                    print(controller.text);
                    controller.clear();
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
