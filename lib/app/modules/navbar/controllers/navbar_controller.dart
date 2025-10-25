import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get_storage/get_storage.dart';
import '../../../widgets/more_menu_bottom_sheet.dart';
import '../../../routes/app_pages.dart';

class NavbarController extends GetxController {
  var selectedIndex = 0.obs;
  final box = GetStorage();

  void changeTabIndex(int index) {
    if (index == 4) {
      showMoreMenu();
    } else {
      selectedIndex.value = index;
    }
  }

  void showMoreMenu() {
    Get.bottomSheet(
      const MoreMenuBottomSheet(),
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
    );
  }

  void logout() {
    box.erase(); // Hapus data login
    Get.offAllNamed(Routes.LOGIN);
  }
}
