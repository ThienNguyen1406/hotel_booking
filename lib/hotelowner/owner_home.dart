import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:online_shopping/utils/shared_preferences.dart';

class OwnerHome extends StatefulWidget {
  const OwnerHome({super.key});

  @override
  State<OwnerHome> createState() => _OwnerHomeState();
}

class _OwnerHomeState extends State<OwnerHome> {
  Stream? bookingsStream;
  String? id;
   getonthesharedpref() async {
    id = await SharedPreferencesHelper().getUserId();
    setState(() {});
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(40),
                  bottomRight: Radius.circular(40),
                ),
                child: Image.asset(
                  AppImges.homeImg,
                  width: MediaQuery.of(context).size.width,
                  height: 280,
                  fit: BoxFit.cover,
                ),
              ),
              Container(
                padding: const EdgeInsets.only(top: 40, left: 20, right: 20),
                width: MediaQuery.of(context).size.width,
                height: 280,
                decoration: BoxDecoration(
                  color: Colors.black87.withOpacity(0.25),
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(40),
                    bottomRight: Radius.circular(40),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        const Image(
                          image: AssetImage("lib/assets/images/wave.png"),
                          height: 40,
                          width: 40,
                        ),
                        const SizedBox(width: 10),
                        Text("Hello Owner", style: Themes.whiteTextStyle(20)),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      "Ready to manage your hotel?",
                      style: Themes.whiteTextStyle(24),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20.0,
          ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xffececf8),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.asset(
                    "lib/assets/images/boy.jpg",
                    height: 120,
                    width: 120,
                    fit: BoxFit.cover,
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.hotel, color: Colors.blue[700], size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text("Name of Owner", style: Themes.normalText(18)),
                      ],
                    ),
                    Row(
                      children: [
                        SizedBox(
                          width: 10,
                        ),
                        Icon(Icons.calendar_month,
                            color: Colors.blue[700], size: 30),
                        SizedBox(
                          width: 10,
                        ),
                        Text("24/06/2025- 26/06/2025",
                            style: Themes.normalText(16))
                      ],
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.people,
                                color: Colors.blue[700], size: 30),
                            SizedBox(
                              width: 10,
                            ),
                            Text("4 Guests", style: Themes.normalText(16))
                          ],
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 10,
                            ),
                            Icon(Icons.money,
                                color: Colors.blue[700], size: 30),
                            SizedBox(
                              width: 10,
                            ),
                            Text("\$100", style: Themes.normalText(16))
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget allAdminBookings() {
    return StreamBuilder(
      stream: bookingsStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        return snapshot.hasData
            ? ListView.builder(
                shrinkWrap: true,
                itemCount: snapshot.data.docs.length,
                itemBuilder: (context, index) {
                  DocumentSnapshot ds = snapshot.data.docs[index];
                  final format = DateFormat('dd/MM/yyyy');
                  final date = DateTime.parse(ds["CheckIn"]);
                  final now = DateTime.now();
                  return date.isBefore(now)
                      ? Container(
                          width: MediaQuery.of(context).size.width,
                          decoration: BoxDecoration(
                            color: const Color(0xffececf8),
                          ),
                          child: Row(
                            children: [
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.asset(
                                  AppImges.hotel2,
                                  height: 120,
                                  width: 120,
                                  fit: BoxFit.cover, // rất quan trọng!
                                ),
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.hotel,
                                          color: Colors.blue[700], size: 30),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(ds["HotelName"] ?? "",
                                          style: Themes.normalText(18)),
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Icon(Icons.calendar_month,
                                          color: Colors.blue[700], size: 30),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          ds["CheckIn"] +
                                              "to " +
                                              ds["CheckOut"],
                                          style: Themes.normalText(16))
                                    ],
                                  ),
                                  Row(
                                    children: [
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.people,
                                              color: Colors.blue[700],
                                              size: 30),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text(ds["Guests"] ?? "",
                                              style: Themes.normalText(16))
                                        ],
                                      ),
                                      Row(
                                        children: [
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Icon(Icons.money,
                                              color: Colors.blue[700],
                                              size: 30),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          Text("\$" + ds["Total"],
                                              style: Themes.normalText(16))
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ))
                      : date.isBefore(now)
                          ? Container(
                              padding: const EdgeInsets.all(12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(16),
                                color: Colors.red[100],
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.3),
                                    spreadRadius: 2,
                                    blurRadius: 5,
                                    offset: const Offset(0, 3),
                                  )
                                ],
                              ),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Image.asset(
                                    "lib/assets/images/incoming.png",
                                    height: 80,
                                  ),
                                  const SizedBox(height: 10),
                                  Text(
                                    "Incoming\n Bookings",
                                    style: Themes.text500(18),
                                    textAlign: TextAlign.center,
                                  ),
                                ],
                              ),
                            )
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.hotel,
                                        color: Colors.blue[700], size: 30),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(ds["HotelName"] ?? "",
                                        style: Themes.normalText(18)),
                                  ],
                                ),
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Icon(Icons.calendar_month,
                                        color: Colors.blue[700], size: 30),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    Text(ds["CheckIn"] + "to " + ds["CheckOut"],
                                        style: Themes.normalText(16))
                                  ],
                                ),
                                Row(
                                  children: [
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.people,
                                            color: Colors.blue[700], size: 30),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text(ds["Guests"] ?? "",
                                            style: Themes.normalText(16))
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Icon(Icons.money,
                                            color: Colors.blue[700], size: 30),
                                        SizedBox(
                                          width: 10,
                                        ),
                                        Text("\$" + ds["Total"],
                                            style: Themes.normalText(16))
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            );
                },
              )
            : Container();
      },
    );
  }
}
