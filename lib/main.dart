import 'package:ecommerce_getx/controller/auth/auth_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:ecommerce_getx/core/constant/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

  // FirebaseMessaging.onBackgroundMessage((message) async {
  //   final notification = message.notification;
  //   print("${notification?.title}");
  // });

  // SystemChrome

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Get.put(() => AuthController());

    return GetMaterialApp(
      title: 'GetX Ecommerce',
      debugShowCheckedModeBanner: false,
      getPages: AppRoutes.getPages,
      theme: AppTheme.lightTheme,
    );
  }
}
