import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_shopping/assets/themes/themes.dart';
import 'package:online_shopping/hotelowner/owner_home.dart';
import 'package:online_shopping/utils/database.dart';
import 'package:online_shopping/utils/shared_preferences.dart';
import 'package:random_string/random_string.dart';

class HotelDetail extends StatefulWidget {
  const HotelDetail({super.key});

  @override
  State<HotelDetail> createState() => _HotelDetailState();
}

class _HotelDetailState extends State<HotelDetail> {
  bool wifi = false;
  bool hdtv = false;
  bool kitchen = false;
  bool bathroom = false;

  String? id;

  getonthesharedpref() async {
    id = await SharedPreferencesHelper().getUserId();
    setState(() {});
  }

  File? selectedImage;
  final ImagePicker _picker = ImagePicker();
  TextEditingController hotelNameController = TextEditingController();
  TextEditingController hotelChargesController = TextEditingController();
  TextEditingController hotelAddressController = TextEditingController();
  TextEditingController hotelDescriptionController = TextEditingController();

  Future getImage() async {
    var image = await _picker.pickImage(source: ImageSource.gallery);
    selectedImage = File(image!.path);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getonthesharedpref();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue,
      body: Container(
        margin: EdgeInsets.only(top: 40.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hotel Details",
                  style: Themes.whiteTextStyleBold(22),
                )
              ],
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(30),
                      topRight: Radius.circular(30)),
                ),
                width: MediaQuery.of(context).size.width,
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      selectedImage != null
                          ? Container(
                              height: 200,
                              width: 200,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    selectedImage!,
                                    fit: BoxFit.cover,
                                  )),
                            )
                          : GestureDetector(
                              onTap: () {
                                getImage();
                              },
                              child: Center(
                                child: Container(
                                  height: 200,
                                  width: 200,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        width: 2.0, color: Colors.black45),
                                  ),
                                  child: Icon(
                                    Icons.camera_alt,
                                    color: Colors.blue,
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                      SizedBox(
                        height: 20.0,
                      ),
                      Text(
                        "Hotel Name",
                        style: Themes.normalText(18),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0XFFECECF8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: hotelNameController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Hotel Name",
                            hintStyle: Themes.text500(16),

                            // hintStyle:
                          ),
                        ),
                      ),
                      Text(
                        "Hotel Room Charges",
                        style: Themes.normalText(18),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0XFFECECF8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: hotelChargesController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Hotel Charges",
                            hintStyle: Themes.text500(16),

                            // hintStyle:
                          ),
                        ),
                      ),
                      Text(
                        "Hotel Address",
                        style: Themes.normalText(18),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        decoration: BoxDecoration(
                            color: Color(0XFFECECF8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: hotelAddressController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter Hotel Address",
                            hintStyle: Themes.text500(16),

                            // hintStyle:
                          ),
                        ),
                      ),

                      const Text(
                        "What service you want to offer?",
                        style: TextStyle(
                            fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 10),

                      // WiFi
                      Row(
                        children: [
                          Checkbox(
                            value: wifi,
                            onChanged: (value) => setState(() => wifi = value!),
                            activeColor: Colors.blue,
                          ),
                          const Icon(Icons.wifi, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text("WiFi"),
                        ],
                      ),

                      // HDTV
                      Row(
                        children: [
                          Checkbox(
                            value: hdtv,
                            onChanged: (value) => setState(() => wifi = value!),
                            activeColor: Colors.blue,
                          ),
                          const Icon(Icons.tv, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text("HDTV"),
                        ],
                      ),

                      // Kitchen
                      Row(
                        children: [
                          Checkbox(
                            value: kitchen,
                            onChanged: (value) => setState(() => wifi = value!),
                            activeColor: Colors.blue,
                          ),
                          const Icon(Icons.kitchen, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text("Kitchen"),
                        ],
                      ),

                      // Bathroom
                      Row(
                        children: [
                          Checkbox(
                            value: bathroom,
                            onChanged: (value) => setState(() => wifi = value!),
                            activeColor: Colors.blue,
                          ),
                          const Icon(Icons.bathroom, color: Colors.blue),
                          const SizedBox(width: 8),
                          const Text("Bathroom"),
                        ],
                      ),
                      Text(
                        "Hotel Description",
                        style: Themes.normalText(18),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(vertical: 8),
                        padding: EdgeInsets.symmetric(
                          horizontal: 20,
                        ),
                        height: 60,
                        decoration: BoxDecoration(
                            color: Color(0XFFECECF8),
                            borderRadius: BorderRadius.circular(10)),
                        child: TextField(
                          controller: hotelDescriptionController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: "Enter About Hotel",
                            hintStyle: Themes.text500(16),

                            // hintStyle:
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () async {
                          String addID = randomAlphaNumeric(100);
                          // Reference firebaseStorageRef = FirebaseStorage
                          //     .instance
                          //     .ref()
                          //     .child("blogImage")
                          //     .child(addID);
                          // final UploadTask task =
                          //     firebaseStorageRef.putFile(selectedImage!);

                          // var downLoadUrl =
                          //     await (await task).ref.getDownloadURL();

                          Map<String, dynamic> addHotel = {
                            "Image": "",
                            "HotelName": hotelNameController.text,
                            "HotelCharges": hotelChargesController.text,
                            "HotelAddress": hotelAddressController.text,
                            "HotelDescription": hotelDescriptionController.text,
                            "Wifi": wifi ? "true" : "false",
                            "HDTV": hdtv ? "true" : "false",
                            "Kitchen": kitchen ? "true" : "false",
                            "Bathroom": bathroom ? 'true' : "false",
                            "Id": id
                          };
                          await DatabaseMethods().addHotel(addHotel, id!);
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.greenAccent,
                              content: Text(
                                "Hotel Details has been Uploaded Successfully!",
                                style: Themes.text500(18),
                              )));
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => OwnerHome()));
                        },
                        child: Center(
                          child: Container(
                            margin: EdgeInsets.symmetric(vertical: 8),
                            width: MediaQuery.of(context).size.width * 0.6,
                            height: 40,
                            decoration: BoxDecoration(
                                color: Colors.blue,
                                borderRadius: BorderRadius.circular(8)),
                            child: Center(
                              child: Text(
                                "Submit",
                                style: Themes.whiteTextStyleBold(18),
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
