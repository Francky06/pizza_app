import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/widgets/small_text.dart';
import '../utils/colors.dart';
import '../utils/dimensions.dart';
import 'big_text.dart';
import 'icon_and_text.dart';

class AppColumnIcon extends StatelessWidget {
  final String text;

  const AppColumnIcon({Key? key,
    required this.text
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BigText(text: text, size: Dimensions.font26),
        SizedBox(height: Dimensions.height10),
        Row(
          children: [
            Wrap(
                children: List.generate(5, (index) => Icon(Icons.star, color: AppColors.mainColor, size: 15))
            ),
            SizedBox(width: 10),
            SmallText(text: "4.9"),
            SizedBox(width: 10),
            SmallText(text: "123"),
            SizedBox(width: 5),
            SmallText(text: "Commentaires"),

          ],
        ),
        SizedBox(height: Dimensions.height20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            IconAndText(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
            IconAndText(icon: Icons.location_on, text: "1.7Km", iconColor: AppColors.mainColor),
            IconAndText(icon: Icons.access_time_filled_rounded, text: "27 min", iconColor: AppColors.iconColor2),
          ],
        )
      ],
    );
  }
}
