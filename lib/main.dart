import 'package:ecommerce_getx/controller/auth/auth_controller.dart';
import 'package:ecommerce_getx/core/constant/get_pages.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();

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
      theme: ThemeData(
        primaryColor: const Color(0xFF00c569),
        colorScheme: const ColorScheme.light(primary: Color(0xFF00c569)),
        fontFamily: "opensans",
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: AppBarTheme(
          elevation: 0,
          color: Colors.white,
          foregroundColor: Colors.black,
          titleTextStyle:
              Get.textTheme.headline3!.copyWith(fontWeight: FontWeight.w500),
          centerTitle: true,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.dark,
          ),
        ),
        textTheme: const TextTheme(
          headline1: TextStyle(
            fontSize: 30,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline2: TextStyle(
            fontSize: 26,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline3: TextStyle(
            fontSize: 20,
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
          headline4: TextStyle(
            fontSize: 18,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
          headline5: TextStyle(
            fontSize: 16,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          headline6: TextStyle(
            fontSize: 15,
            color: Colors.black,
            fontWeight: FontWeight.w400,
          ),
          bodyText1: TextStyle(
            color: Colors.black54,
            fontWeight: FontWeight.normal,
            fontSize: 15,
            height: 2,
          ),
          bodyText2: TextStyle(
            color: Colors.black54,
            fontSize: 13,
            fontWeight: FontWeight.normal,
          ),
          // bodyLarge: const TextStyle(
          //   color: Colors.black54,
          //   fontSize: 15,
          //   fontWeight: FontWeight.normal,
          // ),
        ),
      ),
    );
  }
}
