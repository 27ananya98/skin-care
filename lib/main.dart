import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/bindings_interface.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:sizer/sizer.dart';
import 'package:skin_care/routes/app_pages.dart';
import 'package:skin_care/views/auth_screen.dart';
import 'package:skin_care/views/home_screen.dart';
import 'package:skin_care/views/log_routine_function.dart';
import 'package:skin_care/views/routine_screen.dart';
import 'package:skin_care/wrapper/auth_wrapper.dart';

import 'controller/home_controller.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,

  );
  runApp(const SkinCareApp());
}

class SkinCareApp extends StatelessWidget {
  const SkinCareApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Sizer(builder: (context, orientation, deviceType) {
      return GetMaterialApp(  // Use GetMaterialApp
        title: 'Skincare App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
          fontFamily: 'Inter',
        ),
        initialRoute: Routes.AUTHWRAP,
        getPages: AppPages.routes,
      );
    }
    );
  }
}
