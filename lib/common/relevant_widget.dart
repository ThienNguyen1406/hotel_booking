import 'package:flutter/material.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart';

class RelevantWidget extends StatelessWidget {
  final String? title;
  final String? price;
  final String? location;
  final Image? image;
  final VoidCallback? onTap;

  const RelevantWidget({
    super.key,
    this.title,
    this.price,
    this.location,
    this.image,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
        ),
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GestureDetector(
              onTap: onTap ?? () {},
              child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: image ??
                    Image(
                      image: AssetImage(AppImges.hotel2),
                      width: MediaQuery.of(context).size.width * 0.8,
                      height: 220,
                      fit: BoxFit.cover,
                    ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        title ?? "Hotel Beach",
                        style: Themes.normalText(20),
                      ),
                      SizedBox(width: 90),
                      Text(price ?? "\$120", style: Themes.normalText(20)),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        Icons.location_on,
                        color: Colors.blue,
                      ),
                      SizedBox(width: 10),
                      Text(location ?? "Near Main Market, Da Nang",
                          style: Themes.normalText(16)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
