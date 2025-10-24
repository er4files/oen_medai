import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/login_controller.dart';

class LoginView extends GetView<LoginController> {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Title - Rata Kiri
              Text(
                'Sign in',
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Text(
                'Provide your credentials to sign in as a doctor',
                style: TextStyle(fontSize: 14, color: Colors.grey[600]),
              ),
              SizedBox(height: 40),

              // Username Field dengan Label di Atas
              Text(
                'Username',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              TextField(
                controller: controller.usernameController,
                decoration: InputDecoration(
                  hintText: "type your username",
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  prefixIcon: Icon(
                    Icons.person_outlined,
                    color: Colors.grey[500],
                  ),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[500]!),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Colors.grey[500]!),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                    borderSide: BorderSide(color: Color(0xFF00C9A7), width: 2),
                  ),
                ),
              ),
              SizedBox(height: 20),

              // Password Field dengan Label di Atas
              Text(
                'Password',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 8),
              Obx(
                () => TextField(
                  controller: controller.passwordController,
                  obscureText: !controller.isPasswordVisible.value,
                  decoration: InputDecoration(
                    hintText: "Type your password",
                    hintStyle: TextStyle(color: Colors.grey[400]),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: Icon(
                      Icons.lock_outlined,
                      color: Colors.grey[500],
                    ),
                    suffixIcon: IconButton(
                      icon: Icon(
                        controller.isPasswordVisible.value
                            ? Icons.visibility_outlined
                            : Icons.visibility_off_outlined,
                        color: Colors.grey[500],
                      ),
                      onPressed: () {
                        controller.isPasswordVisible.value =
                            !controller.isPasswordVisible.value;
                      },
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[500]!),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(color: Colors.grey[500]!),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12),
                      borderSide: BorderSide(
                        color: Color(0xFF00C9A7),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 16),

              // Remember Me dan Forgot Password
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Obx(
                        () => Transform.scale(
                          scale: 0.8, // Membuat toggle lebih kecil
                          child: Switch(
                            value: controller.rememberMe.value,
                            onChanged: (value) {
                              controller.rememberMe.value = value;
                            },
                            activeColor: Color(0xFF00C9A7),
                            activeTrackColor: Color(
                              0xFF00C9A7,
                            ).withOpacity(0.5),
                            inactiveThumbColor: Colors
                                .white, // Point warna putih saat tidak aktif
                            inactiveTrackColor: Colors
                                .grey[300], // Background abu-abu saat tidak aktif
                            trackOutlineColor: MaterialStateProperty.all(
                              Colors.transparent,
                            ), // Hilangkan outline
                          ),
                        ),
                      ),
                      SizedBox(width: 4),
                      Text(
                        'Remember Me',
                        style: TextStyle(color: Colors.grey[700], fontSize: 14),
                      ),
                    ],
                  ),
                  TextButton(
                    onPressed: () {},
                    child: Text(
                      'FORGOT PASSWORD?',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24),

              // Sign In Button dengan Gradient
              Obx(
                () => Container(
                  width: double.infinity,
                  height: 56,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Color(0xFF00C9A7), // Hijau tosca
                        Color(0xFF0070C9), // Biru
                      ],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: ElevatedButton(
                    onPressed: controller.isLoading.value
                        ? null
                        : () {
                            controller.isLoading.value = true;
                            controller.login();
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: controller.isLoading.value
                        ? CircularProgressIndicator(color: Colors.white)
                        : Text(
                            'SIGN IN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
