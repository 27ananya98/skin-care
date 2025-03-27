import 'package:get/get.dart';
import 'package:skin_care/bindings/routine_bindings.dart';
import 'package:skin_care/views/auth_screen.dart';
import 'package:skin_care/views/home_screen.dart';
import 'package:skin_care/views/log_routine_function.dart';
import 'package:skin_care/wrapper/auth_wrapper.dart';

import '../bindings/home_binding.dart';
import '../views/home_view.dart';
import '../views/routine_screen.dart';


part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const initial = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () =>  HomeScreen(),

    ),

    GetPage(
      name: _Paths.AUTH,
      page: () =>  AuthScreen(),

    ),
    GetPage(
      name: _Paths.ROUTINE,
      page: () =>  LogRoutineScreen(),

    ),
    GetPage(
      name: _Paths.AUTHWRAP,
      page: () =>  AuthenticationWrapper(),

    ),

  ];
}
