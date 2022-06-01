import 'package:autofill_otp_application/autofill_otp.dart';
import 'package:autofill_otp_application/dashboard.dart';
import 'package:autofill_otp_application/send_otp.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/': (context)=>const SendOtp(),
        '/verify_otp':(context)=>const AutoFillOtp(),
        '/home_page':(context)=>const HomePage()
      },
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
