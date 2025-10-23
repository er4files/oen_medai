import 'package:get/get.dart';
import 'package:flutter/material.dart';
import '../../../routes/app_pages.dart'; // Sesuaikan dengan rute yang Anda gunakan

class LoginController extends GetxController {
  var isLoading = false.obs;
  var isPasswordVisible = false.obs;
  var rememberMe = false.obs;
  
  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  // Fungsi login yang akan memverifikasi username dan password
  void login() {
    String username = usernameController.text;
    String password = passwordController.text;

    // Validasi input kosong
    if (username.isEmpty || password.isEmpty) {
      isLoading.value = false;
      Get.snackbar(
        "Login Failed", 
        "Please fill in all fields",
        backgroundColor: Colors.red[400], 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
      );
      return;
    }

    // Validasi login
    if (username == 'admin' && password == 'admin') {
      isLoading.value = false;
      
      // Tampilkan snackbar sukses
      Get.snackbar(
        "Login Success", 
        "Welcome back, Doctor!",
        backgroundColor: Color(0xFF00C9A7), 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
      );
      
      // Setelah login berhasil, arahkan ke halaman Home
      Get.offAllNamed(Routes.NAVBAR);
    } else {
      isLoading.value = false;
      Get.snackbar(
        "Login Failed", 
        "Invalid username or password",
        backgroundColor: Colors.red[400], 
        colorText: Colors.white,
        snackPosition: SnackPosition.TOP,
        margin: EdgeInsets.all(10),
        borderRadius: 8,
      );
    }
  }

  @override
  void onClose() {
    // Bersihkan controller saat widget di-dispose
    usernameController.dispose();
    passwordController.dispose();
    super.onClose();
  }
}
