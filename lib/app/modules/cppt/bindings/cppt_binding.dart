import 'package:get/get.dart';

import '../controllers/cppt_controller.dart';

class CpptBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<CpptController>(
      () => CpptController(),
    );
  }
}
