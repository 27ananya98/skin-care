

import 'package:get/get.dart';
import 'package:skin_care/controller/routine_controller.dart';

class RoutineBindings extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut<RoutineController>(
            () => RoutineController());
  }

}