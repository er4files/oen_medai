import 'package:get/get.dart';

import '../controllers/speech_ai_controller.dart';

class SpeechAiBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SpeechAiController>(
      () => SpeechAiController(),
    );
  }
}
