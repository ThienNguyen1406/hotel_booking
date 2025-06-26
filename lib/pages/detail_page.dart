import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:intl/intl.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:http/http.dart' as http;
import 'package:online_shopping/utils/constant.dart';
import 'package:online_shopping/utils/database.dart';
import 'package:random_string/random_string.dart';

class DetailPage extends StatefulWidget {
  final String name;
  final String address;
  final String price;
  final String description;
  final bool wifi;
  final bool hdtv;
  final bool kitchen;
  final bool bathroom;
  final String hotelId;

  const DetailPage(
      {super.key,
      required this.name,
      required this.price,
      required this.description,
      required this.wifi,
      required this.hdtv,
      required this.kitchen,
      required this.bathroom,
      required this.hotelId,
      required this.address});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  DateTime? startDate;
  DateTime? endDate;
  int? daysDifference;
  // ignore: prefer_typing_uninitialized_variables
  var finalAmout;
  Map<String, dynamic>? paymentIntent;
  String? username, userid;

  Future<void> _selectStartDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: startDate ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        startDate = picked;
        _calculateDiffernce();
      });
    }
  }

  Future<void> _selectEndtDate(BuildContext context) async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate:
          endDate ?? (startDate ?? DateTime.now().add(Duration(days: 1))),
      firstDate: startDate ?? DateTime.now(),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      setState(() {
        endDate = picked;
        _calculateDiffernce();
      });
    }
  }

  void _calculateDiffernce() {
    if (startDate != null && endDate != null) {
      daysDifference = endDate!.difference(startDate!).inDays;
      finalAmout = int.parse(widget.price) * daysDifference!;
      print(daysDifference);
    }
  }

  String _formatDate(DateTime? date) {
    return date != null
        ? DateFormat("dd, MMM yyyy").format(date)
        : "Selected Date";
  }

  TextEditingController guestController = TextEditingController();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    finalAmout = int.parse(widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Stack(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height * 0.3,
                    child: ClipRRect(
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                      child: Image(
                          image: AssetImage(AppImges.hotel2),
                          fit: BoxFit.cover),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.black87.withOpacity(0.5),
                      borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(30.0),
                        bottomRight: Radius.circular(30.0),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(left: 20.0, right: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      widget.name ?? "Hotel Beach",
                      style: Themes.normalText(27),
                    ),
                    Text(
                      "\$" + widget.price ?? "null",
                      style: Themes.normalText(27.0),
                    ),
                    Divider(
                      thickness: 2.0,
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Text(
                      "What this place offers",
                      style: Themes.normalText(22.0),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    widget.wifi == true
                        ? Row(
                            children: [
                              Icon(
                                Icons.wifi,
                                color: const Color.fromARGB(255, 10, 85, 147),
                                size: 25,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "WiFi",
                                style: Themes.text500(18.0),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 20,
                    ),
                    widget.hdtv == true
                        ? Row(
                            children: [
                              Icon(
                                Icons.tv,
                                color: const Color.fromARGB(255, 10, 85, 147),
                                size: 25,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "HDTV",
                                style: Themes.text500(18.0),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 20,
                    ),
                    widget.kitchen == true
                        ? Row(
                            children: [
                              SizedBox(
                                height: 20,
                              ),
                              Icon(
                                Icons.kitchen,
                                color: const Color.fromARGB(255, 10, 85, 147),
                                size: 25,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Kitchen",
                                style: Themes.text500(18.0),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    SizedBox(
                      height: 20,
                    ),
                    widget.bathroom == true
                        ? Row(
                            children: [
                              Icon(
                                Icons.bathroom,
                                color: const Color.fromARGB(255, 10, 85, 147),
                                size: 25,
                              ),
                              SizedBox(
                                width: 10.0,
                              ),
                              Text(
                                "Bathroom",
                                style: Themes.text500(18.0),
                              ),
                            ],
                          )
                        : SizedBox.shrink(),
                    Divider(
                      thickness: 2.0,
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "About this place",
                      style: Themes.normalText(22.0),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    Text(
                      widget.description ?? "No description",
                      style: Themes.text500(14),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Material(
                      elevation: 2.0,
                      borderRadius: BorderRadius.circular(20),
                      child: Container(
                        padding: EdgeInsets.all(10),
                        height: 350,
                        width: MediaQuery.of(context).size.width,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20)),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                                "\$" +
                                    finalAmout.toString() +
                                    " for " +
                                    daysDifference.toString() +
                                    " nights ",
                                style: Themes.normalText(20)),
                            Text("Check-in Date", style: Themes.text500(16)),
                            Divider(thickness: 2.0),
                            InkWell(
                              onTap: () => _selectStartDate(context),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: Colors.blue, size: 30),
                                  SizedBox(width: 10),
                                  Text(
                                    _formatDate(startDate),
                                    style: Themes.text500(18),
                                  ),
                                ],
                              ),
                            ),
                            Text("Check-out Date", style: Themes.text500(16)),
                            Divider(thickness: 2.0),
                            InkWell(
                              onTap: () => _selectEndtDate(context),
                              child: Row(
                                children: [
                                  Icon(Icons.calendar_month,
                                      color: Colors.blue, size: 30),
                                  SizedBox(width: 10),
                                  Text(
                                    _formatDate(endDate),
                                    style: Themes.text500(18),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              "Numbers of guests",
                              style: Themes.text500(18),
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 20),
                              decoration: BoxDecoration(
                                  color: Color(0XFFECECF8),
                                  borderRadius: BorderRadius.circular(8)),
                              child: TextField(
                                controller: guestController,
                                onChanged: (value) {
                                  finalAmout = finalAmout * int.parse(value);
                                  setState(() {});
                                },
                                decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: "Enter number of guests",
                                    hintStyle: TextStyle(
                                      color: Colors.black45,
                                      fontWeight: FontWeight.w500,
                                    )),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            GestureDetector(
                              onTap: () {
                                makePayment(finalAmout.toString());
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: 40,
                                decoration: BoxDecoration(
                                  color: Colors.lightBlue,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                child: Center(
                                    child: Text("Book Now",
                                        style: Themes.whiteTextStyle(
                                          18,
                                        ))),
                              ),
                            )
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<void> makePayment(String amount) async {
    try {
      paymentIntent = await createdPaymentIntent(amount, "USD");
      if (paymentIntent == null) return;

      await Stripe.instance
          .initPaymentSheet(
            paymentSheetParameters: SetupPaymentSheetParameters(
              paymentIntentClientSecret: paymentIntent!['client_secret'],
              style: ThemeMode.dark,
              merchantDisplayName: 'Online Booking App',
            ),
          )
          .then(
            (value) {},
          );

      displayPaymentSheet(amount);
    } catch (e, s) {
      print('exception:$e$s');
    }
  }

  displayPaymentSheet(String amount) async {
    try {
      await Stripe.instance.presentPaymentSheet().then(
        (value) async {
          String addId = randomAlphaNumeric(10);
          Map<String, dynamic> userHotelBooking = {
            "UserName": username,
            "CheckIn": " ${_formatDate(startDate).toString()}",
            "CheckOut": " ${_formatDate(endDate).toString()}",
            "Guests": guestController.text.trim(),
            "Total": finalAmout.toString(),
            "HotelName": widget.name,
          };
          await DatabaseMethods()
              .addHotelUserBooking(userHotelBooking, userid!, addId);
          await DatabaseMethods()
              .addHotelOwnerBooking(userHotelBooking, widget.hotelId, addId);
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
              backgroundColor: Colors.green,
              content: Text(
                "Booking Successfully!",
                style: Themes.text500(18),
              )));
          // Navigator.push(context,
          //     MaterialPageRoute(builder: (context) => BottomNavigation()));
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    content: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.check_circle,
                              color: Colors.green,
                            ),
                            Text("Payment Successfull")
                          ],
                        )
                      ],
                    ),
                  ));
        },
      );
    } on StripeException catch (e) {
      print("Error is:------> $e");
      showDialog(
          context: context,
          builder: (_) => AlertDialog(
                content: Text("Cancelled"),
              ));
    } catch (e) {
      print("$e");
    }
  }

  createdPaymentIntent(String amount, String currency) async {
    try {
      Map<String, String> body = {
        "amount": calculateAmount(amount),
        "currency": currency,
        "payment_method_types[]": "card"
      };

      var response = await http.post(
        Uri.parse("https://api.stripe.com/v1/payment_intents"),
        headers: {
          "Authorization": "Bearer $secretkey",
          "Content-Type": "application/x-www-form-urlencoded",
        },
        body: body,
      );

      return jsonDecode(response.body);
    } catch (err) {
      print("err charging user: ${err.toString()}");
    }
  }

  calculateAmount(String amount) {
    final calculatedAmount = (int.parse(amount) * 100);

    return calculatedAmount.toString();
  }
}
