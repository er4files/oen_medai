import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  final box = GetStorage();

  void login() {
    String username = usernameController.text.trim();
    String password = passwordController.text.trim();

    if (username.isEmpty || password.isEmpty) {
      Get.snackbar(
        "Login Failed",
        "Please fill in all fields",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    if (username == 'admin' && password == 'admin') {
      // Simpan status login ke GetStorage
      box.write('isLoggedIn', true);
      box.write('username', username);

      Get.snackbar(
        "Login Success",
        "Welcome back, Doctor!",
        backgroundColor: const Color(0xFF00C9A7),
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );

      Get.offAllNamed(Routes.NAVBAR);
    } else {
      Get.snackbar(
        "Login Failed",
        "Invalid username or password",
        backgroundColor: Colors.red[400],
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: const EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  void logout() {
    box.erase(); // Hapus semua data login
    Get.offAllNamed(Routes.LOGIN);
  }

  @override
  void onClose() {
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
