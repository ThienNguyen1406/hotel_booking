import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:online_shopping/hotelowner/owner_home.dart';
import 'package:online_shopping/pages/booking.dart';
import 'package:online_shopping/pages/bottom_navigator.dart';
import 'package:online_shopping/pages/on_boarding.dart';
import 'package:online_shopping/utils/constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Stripe.publishableKey = publishedkey;
  await Stripe.instance.applySettings();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Bookig App',
        debugShowCheckedModeBanner: false,
        home: BottomNavigation());
  }
}
