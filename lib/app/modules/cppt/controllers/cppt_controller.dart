import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
import '../../patients/controllers/patients_controller.dart';

class CpptController extends GetxController {
  late Patient patient;

  // Form controllers
  final subjectiveController = TextEditingController();
  final objectiveController = TextEditingController();
  final assessmentController = TextEditingController();
  final planningController = TextEditingController();
  final instructionController = TextEditingController();

  final isLoading = false.obs;
  final selectedDate = Rx<DateTime>(DateTime.now());
  final selectedTime = '08:37'.obs;

  // 🔊 Speech-to-text
  late stt.SpeechToText speech;
  final isListening = false.obs;
  final recognizedText = ''.obs;

  @override
  void onInit() {
    super.onInit();
    patient = Get.arguments as Patient;
    objectiveController.text = 'Lihat Tanda Vital';
    speech = stt.SpeechToText();
    _initSpeech();
  }

  Future<void> _initSpeech() async {
    bool available = await speech.initialize(
      onStatus: (status) {
        debugPrint('Speech status: $status');
        // jika status done tapi user masih ingin merekam, restart lagi
        if (status == 'done' && isListening.value) {
          _restartListening();
        }
      },
      onError: (error) => debugPrint('Speech error: $error'),
    );

    if (!available) {
      Get.snackbar(
        'Gagal',
        'Speech recognition tidak tersedia di perangkat ini',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  // 🔘 Toggle Record
  void toggleRecording() async {
    if (!isListening.value) {
      await startListening();
    } else {
      await stopListening();
    }
  }

  Future<void> startListening() async {
    isListening.value = true;
    recognizedText.value = '';
    await speech.listen(
      onResult: (result) {
        // update teks secara terus-menerus ke textarea
        recognizedText.value = result.recognizedWords;
      },
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
      localeId: 'id_ID',
    );
  }

  Future<void> _restartListening() async {
    if (!isListening.value) return;
    await speech.listen(
      onResult: (result) {
        recognizedText.value = result.recognizedWords;
      },
      listenMode: stt.ListenMode.dictation,
      partialResults: true,
      localeId: 'id_ID',
    );
  }

  Future<void> stopListening() async {
    isListening.value = false;
    await speech.stop();

    // simpan hasil percakapan terakhir ke Subjective
    if (recognizedText.value.isNotEmpty) {
      subjectiveController.text +=
          (subjectiveController.text.isEmpty ? '' : '\n') +
          recognizedText.value;
    }
  }

  // --- Fitur lainnya tetap sama ---
  Future<void> saveCppt() async {
    try {
      isLoading.value = true;
      if (subjectiveController.text.isEmpty ||
          objectiveController.text.isEmpty ||
          assessmentController.text.isEmpty ||
          planningController.text.isEmpty) {
        Get.snackbar(
          'Perhatian',
          'Mohon lengkapi semua field yang diperlukan',
          backgroundColor: Colors.orange,
          colorText: Colors.white,
        );
        return;
      }

      await Future.delayed(const Duration(seconds: 1));

      Get.snackbar(
        'Berhasil',
        'Catatan terintegrasi berhasil disimpan',
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );

      clearForm();
    } catch (e) {
      Get.snackbar(
        'Error',
        'Gagal menyimpan data: $e',
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    subjectiveController.clear();
    objectiveController.text = 'Lihat Tanda Vital';
    assessmentController.clear();
    planningController.clear();
    instructionController.clear();
  }
}
