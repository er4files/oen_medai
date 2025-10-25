import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart'; // Tambahkan ini
import 'package:intl/date_symbol_data_local.dart';
import 'app/routes/app_pages.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Inisialisasi GetStorage untuk penyimpanan lokal
  await GetStorage.init();

  // Inisialisasi format tanggal lokal Indonesia
  await initializeDateFormatting('id_ID', null);

  runApp(
    GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: "OEN MEDAI",
      initialRoute: Routes.SPLASH_SCREEN, // Mulai dari splash screen
      getPages: AppPages.routes,
    ),
  );
}
