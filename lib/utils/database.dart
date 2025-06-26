import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseMethods {
  Future addUserInfor(Map<String, dynamic> userInforMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .set(userInforMap);
  }

  Future addHotel(Map<String, dynamic> hotelInforMap, String id) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .set(hotelInforMap);
  }

  Future<Stream<QuerySnapshot>> getAllHotels() async {
    return await FirebaseFirestore.instance.collection("Hotel").snapshots();
  }

  Future addHotelOwnerBooking(
      Map<String, dynamic> userInforMap, String id, String bookid) async {
    return await FirebaseFirestore.instance
        .collection("Hotel")
        .doc(id)
        .collection("Booking")
        .doc(bookid)
        .set(userInforMap);
  }

  Future addHotelUserBooking(
      Map<String, dynamic> userInforMap, String id, String bookid) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .doc(bookid)
        .set(userInforMap);
  }

  Future<Stream<QuerySnapshot>> getUserBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }
    Future<Stream<QuerySnapshot>> getAdminBooking(String id) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .doc(id)
        .collection("Booking")
        .snapshots();
  }

  Future<QuerySnapshot> getUserByEmail(String email) async {
    return await FirebaseFirestore.instance
        .collection("users")
        .where("email", isEqualTo: email)
        .get();
  }
}
