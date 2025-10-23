import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/navbar_controller.dart';
import '../../home/views/home_view.dart';
import '../../patients/views/patients_view.dart';
import '../../speech_ai/views/speech_ai_view.dart';
import '../../pharmacy/views/pharmacy_view.dart';

class NavbarView extends StatelessWidget {
  const NavbarView({super.key});

  @override
  Widget build(BuildContext context) {
    final NavbarController controller = Get.find<NavbarController>();

    final List<Widget> pages = const [
      HomeView(),
      PatientsView(),
      SpeechAiView(),
      PharmacyView(),
    ];

    return Obx(() => Scaffold(
          body: IndexedStack(
            index: controller.selectedIndex.value,
            children: pages,
          ),
          bottomNavigationBar: _buildBottomNavBar(controller),
        ));
  }

  Widget _buildBottomNavBar(NavbarController controller) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 10,
            offset: Offset(0, -5),
          ),
        ],
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _buildNavItem(
                controller: controller,
                icon: Icons.home_outlined,
                activeIcon: Icons.home,
                label: 'Home',
                index: 0,
              ),
              _buildNavItem(
                controller: controller,
                icon: Icons.people_outline,
                activeIcon: Icons.people,
                label: 'Patients',
                index: 1,
              ),
              _buildCenterButton(controller),
              _buildNavItem(
                controller: controller,
                icon: Icons.medical_services_outlined,
                activeIcon: Icons.medical_services,
                label: 'Pharmacy',
                index: 3,
              ),
              _buildNavItem(
                controller: controller,
                icon: Icons.apps_outlined,
                activeIcon: Icons.apps,
                label: 'More',
                index: 4,
                isMore: true,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNavItem({
    required NavbarController controller,
    required IconData icon,
    required IconData activeIcon,
    required String label,
    required int index,
    bool isMore = false,
  }) {
    final isActive = controller.selectedIndex.value == index && !isMore;

    return InkWell(
      onTap: () => controller.changeTabIndex(index),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              isActive ? activeIcon : icon,
              color: isActive ? Color(0xFF00C9A7) : Colors.grey[600],
              size: 26,
            ),
            SizedBox(height: 4),
            Text(
              label,
              style: TextStyle(
                fontSize: 11,
                color: isActive ? Color(0xFF00C9A7) : Colors.grey[600],
                fontWeight: isActive ? FontWeight.w600 : FontWeight.normal,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCenterButton(NavbarController controller) {
    return GestureDetector(
      onTap: () => controller.changeTabIndex(2),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
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
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFF5B8DEF).withOpacity(0.4),
                  blurRadius: 12,
                  offset: Offset(0, 4),
                ),
              ],
            ),
            child: Icon(
              Icons.mic,
              color: Colors.white,
              size: 28,
            ),
          ),
          SizedBox(height: 4),
          Text(
            'Speech AI',
            style: TextStyle(
              fontSize: 11,
              color: controller.selectedIndex.value == 2
                  ? Color(0xFF0070C9)
                  : Colors.grey[600],
              fontWeight: controller.selectedIndex.value == 2
                  ? FontWeight.w600
                  : FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}