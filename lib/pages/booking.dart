import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart' show Themes;
import 'package:online_shopping/utils/database.dart';
import 'package:online_shopping/utils/shared_preferences.dart';

class Booking extends StatefulWidget {
  const Booking({super.key});

  @override
  State<Booking> createState() => _BookingState();
}

class _BookingState extends State<Booking> {
  String? id;
  Stream? bookingsStream;
  getontheload() async {
    id = await SharedPreferencesHelper().getUserId();
    bookingsStream = await DatabaseMethods().getUserBooking(id!);
    setState(() {});
  }

  bool incomingBookings =
      true; // Biến để xác định trạng thái của incoming bookings
  bool pastBookings = false; // Biến để xác định trạng thái của past bookings
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheload();
  }

  Widget allUserBookings() {
    return StreamBuilder(
      stream: bookingsStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        
        return snapshot.hasData? ListView.builder(
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];
            final format = DateFormat('dd/MM/yyyy');
            final date = DateTime.parse(ds["CheckIn"]);
            final now = DateTime.now();
            return  date.isBefore(now)&& incomingBookings? Container(
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
                    )
                  ],
                )): date.isBefore(now) && incomingBookings ? Container(
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
                ) : Column(
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
        ): Container();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Booking",
          style: Themes.normalText(22.0),
        ),
        backgroundColor: Colors.blueGrey[700],
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              children: [
                // Incoming Bookings
                incomingBookings
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 200, // Đã có
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueGrey[100],
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
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            incomingBookings =
                                true; // Chuyển sang trạng thái incoming bookings
                            pastBookings = false; // Đặt past bookings về false
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 200, // Đã có
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueGrey[100],
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
                        ),
                      ),
                const SizedBox(width: 20),
                // Past Bookings
                pastBookings
                    ? Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 200, // ✅ Thêm dòng này
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueGrey[100],
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
                                "lib/assets/images/past.png",
                                height: 100,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Past \nBookings",
                                style: Themes.text500(18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      )
                    : GestureDetector(
                        onTap: () {
                          setState(() {
                            pastBookings =
                                true; // Chuyển sang trạng thái past bookings
                            incomingBookings =
                                false; // Đặt incoming bookings về false
                          });
                        },
                        child: Container(
                          padding: const EdgeInsets.all(12),
                          height: 200, // ✅ Thêm dòng này
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            color: Colors.blueGrey[100],
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
                                "lib/assets/images/past.png",
                                height: 100,
                              ),
                              const SizedBox(height: 10),
                              Text(
                                "Past \nBookings",
                                style: Themes.text500(18),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
              ],
            ),
            SizedBox(
              height: 20.0,
            ),
            Container(
                height: MediaQuery.of(context).size.height * 0.5,
                child: incomingBookings
                    ? allUserBookings()
                    : pastBookings
                        ? allUserBookings()
                        : allUserBookings()),
          ],
        ),
      ),
    );
  }
}
