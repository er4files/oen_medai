import 'package:get/get.dart';

import '../modules/cppt/bindings/cppt_binding.dart';
import '../modules/cppt/views/cppt_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/login/bindings/login_binding.dart';
import '../modules/login/views/login_view.dart';
import '../modules/navbar/bindings/navbar_binding.dart';
import '../modules/navbar/views/navbar_view.dart';
import '../modules/patients/bindings/patients_binding.dart';
import '../modules/patients/views/patients_view.dart';
import '../modules/pharmacy/bindings/pharmacy_binding.dart';
import '../modules/pharmacy/views/pharmacy_view.dart';
import '../modules/speech_ai/bindings/speech_ai_binding.dart';
import '../modules/speech_ai/views/speech_ai_view.dart';
import '../modules/splash_screen/bindings/splash_screen_binding.dart';
import '../modules/splash_screen/views/splash_screen_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH_SCREEN,
      page: () => const SplashScreenView(),
      binding: SplashScreenBinding(),
    ),
    GetPage(
      name: _Paths.LOGIN,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: _Paths.PATIENTS,
      page: () => const PatientsView(),
      binding: PatientsBinding(),
    ),
    GetPage(
      name: _Paths.PHARMACY,
      page: () => const PharmacyView(),
      binding: PharmacyBinding(),
    ),
    GetPage(
      name: _Paths.SPEECH_AI,
      page: () => const SpeechAiView(),
      binding: SpeechAiBinding(),
    ),
    GetPage(
      name: _Paths.NAVBAR,
      page: () => const NavbarView(),
      binding: NavbarBinding(),
    ),
    GetPage(
      name: _Paths.CPPT,
      page: () => const CpptView(),
      binding: CpptBinding(),
    ),
  ];
}
