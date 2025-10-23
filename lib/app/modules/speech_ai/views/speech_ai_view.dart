import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/speech_ai_controller.dart';

class SpeechAiView extends GetView<SpeechAiController> {
  const SpeechAiView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('SpeechAiView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'SpeechAiView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
