import 'package:movies_n_tvshows_app/layar/layar_utama.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:movies_n_tvshows_app/opening.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return OrientationBuilder(
          builder: (context, orientation) {
            SystemChrome.setPreferredOrientations([
              DeviceOrientation.portraitUp,
            ]);

            return GetMaterialApp(
              title: 'Movies & Tv Shows',
              debugShowCheckedModeBanner: false,
              theme: ThemeData(
                primarySwatch: Colors.purple,
              ),
              home: const Opening(),
            );
          },
        );
      },
    );
  }
}
