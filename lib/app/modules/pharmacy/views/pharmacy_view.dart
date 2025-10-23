import 'package:flutter/material.dart';

import 'package:get/get.dart';

import '../controllers/pharmacy_controller.dart';

class PharmacyView extends GetView<PharmacyController> {
  const PharmacyView({super.key});
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('PharmacyView'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          'PharmacyView is working',
          style: TextStyle(fontSize: 20),
        ),
      ),
    );
  }
}
