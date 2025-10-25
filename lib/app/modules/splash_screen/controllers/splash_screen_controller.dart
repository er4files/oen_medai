import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import '../../../routes/app_pages.dart';

class SplashScreenController extends GetxController {
  final box = GetStorage();

  @override
  void onInit() {
    super.onInit();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    await Future.delayed(const Duration(seconds: 3)); // Durasi splash
    bool isLoggedIn = box.read('isLoggedIn') ?? false;

    if (isLoggedIn) {
      Get.offAllNamed(Routes.NAVBAR); // Jika sudah login
    } else {
      Get.offAllNamed(Routes.LOGIN); // Jika belum login
    }
  }
}
