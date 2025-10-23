import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';
import '../../home/controllers/home_controller.dart';
import '../../patients/controllers/patients_controller.dart';
import '../../speech_ai/controllers/speech_ai_controller.dart';
import '../../pharmacy/controllers/pharmacy_controller.dart';

class NavbarBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<NavbarController>(() => NavbarController());
    Get.lazyPut<HomeController>(() => HomeController());
    Get.lazyPut<PatientsController>(() => PatientsController());
    Get.lazyPut<SpeechAiController>(() => SpeechAiController());
    Get.lazyPut<PharmacyController>(() => PharmacyController());
  }
}