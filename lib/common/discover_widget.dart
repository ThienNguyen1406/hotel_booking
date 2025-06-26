import 'package:flutter/material.dart';
import 'package:online_shopping/assets/images/app_imges.dart';

class DiscoverWidget extends StatelessWidget {
  final String? title;
  final String? description;
  final Image? image;
  final VoidCallback? onTap;
  const DiscoverWidget(
      {super.key, this.title, this.description, this.image, this.onTap});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width * 0.45,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20),
            child: GestureDetector(
              onTap: onTap ?? () {},
              child: image ??
                  Image.asset(
                    AppImges.newplace1,
                    width: MediaQuery.of(context).size.width * 0.4,
                    height: 150,
                    fit: BoxFit.cover,
                  ),
            ),
          ),
          SizedBox(height: 10),
          Text(
            title ?? "Mumbai",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          Row(
            children: [
              Icon(
                Icons.hotel,
                color: Colors.blue,
              ),
              Text(
                description ?? "10 Hotels",
                style: TextStyle(
                  fontSize: 16,
                  color: Colors.grey,
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
