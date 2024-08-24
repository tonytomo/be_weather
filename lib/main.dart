import 'package:be_weather/view.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return GetMaterialApp(
      title: 'Be Weather',
      initialRoute: '/',
      transitionDuration: const Duration(milliseconds: 200),
      getPages: [
        GetPage(
          name: '/',
          page: () => const ViewPage(),
          transition: Transition.fade,
        ),
        GetPage(
          name: '/:region',
          page: () => const ViewPage(),
          transition: Transition.fade,
        ),
      ],
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(textTheme).apply(
          bodyColor: Colors.white,
          displayColor: Colors.white,
        ),
      ),
    );
  }
}
