import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/patients_controller.dart';

class PatientsView extends GetView<PatientsController> {
  const PatientsView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PatientsView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PatientsView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
