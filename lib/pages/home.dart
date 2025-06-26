import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:online_shopping/assets/images/app_imges.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:online_shopping/common/discover_widget.dart';
import 'package:online_shopping/common/relevant_widget.dart';
import 'package:online_shopping/pages/detail_page.dart';
import 'package:online_shopping/utils/database.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Stream? hotelStream;

  getontheload() async {
    hotelStream = await DatabaseMethods().getAllHotels();
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getontheload();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.only(
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
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(40),
                      bottomRight: Radius.circular(40),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.location_on, color: Colors.white),
                          SizedBox(width: 10),
                          Text("Hanoi, Vietnam",
                              style: Themes.whiteTextStyle(20)),
                        ],
                      ),
                      SizedBox(height: 30),
                      Text(
                        "Hey, Welcome to my Valley, Search for your favorite hotels",
                        style: Themes.whiteTextStyle(24),
                      ),
                      SizedBox(height: 30),
                      Container(
                        decoration: BoxDecoration(
                          color: const Color.fromARGB(103, 255, 255, 255),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Search",
                            prefixIcon: Icon(Icons.search, color: Colors.white),
                            hintStyle: Themes.whiteTextStyle(20),
                            contentPadding: EdgeInsets.symmetric(vertical: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("The most relevant", style: Themes.normalText(22)),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 300,
              child: allHotel(),
            ),
            SizedBox(height: 20),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text("Discover more", style: Themes.normalText(22)),
            ),
            SizedBox(height: 20),
            SizedBox(
              height: 250,
              child: ListView(
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                physics: BouncingScrollPhysics(),
                children: const [
                  SizedBox(width: 20),
                  DiscoverWidget(),
                  DiscoverWidget(),
                  DiscoverWidget(),
                  SizedBox(width: 20),
                ],
              ),
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

//render widget
  Widget allHotel() {
    return StreamBuilder(
      stream: hotelStream,
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        }

        if (!snapshot.hasData || snapshot.data.docs.isEmpty) {
          return Center(child: Text("No hotels found"));
        }

        return ListView.builder(
          scrollDirection: Axis.horizontal,
          shrinkWrap: true,
          itemCount: snapshot.data.docs.length,
          itemBuilder: (context, index) {
            DocumentSnapshot ds = snapshot.data.docs[index];

            return GestureDetector(
              onTap: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => DetailPage(
                              name: ds["HotelName"],
                              price: ds["HotelCharges"],
                              wifi: ds["Wifi"] ?? false,
                              hdtv: ds["HDTV"] ?? false,
                              kitchen: ds["Kitchen"] ?? false,
                              bathroom: ds["Bathroom"] ?? false,
                              description: ds["HotelDescription"],
                              hotelId: ds.id,
                            )));
              },
              child: Container(
                height: 300,
                margin: EdgeInsets.only(left: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: Image.asset(
                        AppImges.hotel2,
                        width: MediaQuery.of(context).size.width * 0.8,
                        height: 220,
                        fit: BoxFit.cover,
                      ),
                    ),
                    SizedBox(height: 10),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                ds["HotelName"] ?? "No name",
                                style: Themes.normalText(20),
                              ),
                              SizedBox(width: 20),
                              // Text("\$${ds["Charges"] ?? "N/A"}",
                              //     style: Themes.normalText(20)),
                            ],
                          ),
                          Row(
                            children: [
                              Icon(Icons.location_on, color: Colors.blue),
                              SizedBox(width: 5),
                              Text(
                                ds["HotelAddress"] ?? "Unknown",
                                style: Themes.normalText(16),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
