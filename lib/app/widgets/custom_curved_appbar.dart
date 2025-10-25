import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomCurvedAppBar extends StatelessWidget {
  final String title;
  final List<Color> gradientColors;
  final double bottomRadius;
  final bool showBackButton;
  final VoidCallback? onBack;

  const CustomCurvedAppBar({
    super.key,
    required this.title,
    this.gradientColors = const [
      Color(0xFF00C9A7), // Hijau tosca
      Color(0xFF0070C9),
    ],
    this.bottomRadius = 30,
    this.showBackButton = true,
    this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: gradientColors,
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(bottomRadius),
        ),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          if (showBackButton)
            Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: onBack ?? () => Get.back(),
              ),
            ),
          Text(
            title,
            style: GoogleFonts.poppins(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
