import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/patients_controller.dart';
import '../../../widgets/patient_card.dart';

class PatientsView extends StatelessWidget {
  const PatientsView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(PatientsController());

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // 🔹 Filter Section
            Container(
              color: Colors.white,
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  // 🔹 Dropdowns
                  Row(
                    children: [
                      Expanded(
                        child: _buildFilterDropdown(
                          label: 'Ruang Perawatan',
                          value: controller.selectedRoom,
                          items: ['Semua', 'PERAWATAN IBU & ANAK 1'],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildFilterDropdown(
                          label: 'Status Perawatan',
                          value: controller.selectedStatus,
                          items: ['Semua', 'Masih dirawat', 'Pulang'],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),

                  // 🔹 Search Input
                  Text(
                    'Cari Pasien',
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextField(
                    onChanged: controller.searchPatients,
                    decoration: InputDecoration(
                      hintText: 'Ketik nama pasien...',
                      hintStyle: TextStyle(color: Colors.grey[400]),
                      filled: true,
                      fillColor: Colors.white,
                      prefixIcon: Icon(Icons.search, color: Colors.grey[500]),
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
                        borderSide: const BorderSide(
                          color: Color(0xFF00C9A7), // tosca seperti login
                          width: 2,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // 🔹 List Pasien
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (controller.patients.isEmpty) {
                  return const Center(
                    child: Text(
                      'Tidak ada data pasien',
                      style: TextStyle(color: Colors.grey),
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: controller.refreshPatients,
                  child: ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: controller.patients.length,
                    itemBuilder: (context, index) {
                      final patient = controller.patients[index];
                      return PatientCard(patient: patient);
                    },
                  ),
                );
              }),
            ),
          ],
        ),
      ),
    );
  }

  // 🔹 Custom Dropdown mirip TextField
  Widget _buildFilterDropdown({
    required String label,
    required RxString value,
    required List<String> items,
  }) {
    return Obx(
      () => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          const SizedBox(height: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[500]!),
            ),
            child: DropdownButton<String>(
              value: value.value,
              isExpanded: true,
              underline: const SizedBox(),
              icon: const Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.grey,
              ),

              // ✅ Tambahkan properti ini agar background dropdown popup berwarna putih
              dropdownColor: Colors.white,

              items: items.map((String item) {
                return DropdownMenuItem<String>(
                  value: item,
                  child: Text(
                    item,
                    style: const TextStyle(fontSize: 13, color: Colors.black),
                  ),
                );
              }).toList(),
              onChanged: (String? newValue) {
                if (newValue != null) value.value = newValue;
              },
            ),
          ),
        ],
      ),
    );
  }
}
