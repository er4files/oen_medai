import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final GetStorage storage = GetStorage();

  @override
  void onInit() {
    super.onInit();

    // Delay 5 detik lalu navigasi ke Login
    Future.delayed(const Duration(seconds: 5), () {
      Get.offAllNamed(Routes.LOGIN);
    });
  }
}
