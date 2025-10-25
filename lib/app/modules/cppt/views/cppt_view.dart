import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/cppt_controller.dart';
import '../../../widgets/custom_curved_appbar.dart';
import '../../../widgets/custom_modal_area.dart';
import '../../../widgets/custom_timepicker.dart';

class CpptView extends GetView<CpptController> {
  const CpptView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            const CustomCurvedAppBar(title: 'Catatan Terintegrasi'),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    _buildHeaderSection(context),
                    const SizedBox(height: 16),
                    _buildFormSection(),
                    const SizedBox(height: 20),
                    _buildSaveButton(),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ---------------- HEADER SECTION ----------------
  Widget _buildHeaderSection(BuildContext context) {
    return Obx(() {
      return Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.15),
              blurRadius: 8,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              controller.patient.name,
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.bold,
                fontSize: 16,
                color: Colors.black87,
              ),
            ),
            Text(
              controller.patient.bedNumber,
              style: GoogleFonts.poppins(color: Colors.grey[600], fontSize: 13),
            ),
            const SizedBox(height: 16),

            // === DATE & TIME ===
            Row(
              children: [
                Expanded(child: _buildDatePicker(context)),
                const SizedBox(width: 8),
                Expanded(child: _buildTimePicker(context)),
              ],
            ),
            const SizedBox(height: 16),

            // === BUTTONS ===
            Row(
              children: [
                _buildMicButton(),
                const SizedBox(width: 8),
                _buildInfoButton(context),
                const SizedBox(width: 8),
                _buildSoapButton(),
              ],
            ),
          ],
        ),
      );
    });
  }

  // DATE PICKER
  Widget _buildDatePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedDate = await CustomDateTimePicker.showDate(
          context: context,
          initialDate: controller.selectedDate.value,
        );
        if (pickedDate != null) controller.selectedDate.value = pickedDate;
      },
      child: _buildHeaderItem(
        title: 'Tanggal',
        value: CustomDateTimePicker.formatDate(controller.selectedDate.value),
      ),
    );
  }

  // TIME PICKER
  Widget _buildTimePicker(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        final pickedTime = await CustomDateTimePicker.showTime(
          context: context,
        );
        if (pickedTime != null) {
          controller.selectedTime.value = CustomDateTimePicker.formatTime(
            pickedTime,
          );
        }
      },
      child: _buildHeaderItem(
        title: 'Waktu',
        value: controller.selectedTime.value,
      ),
    );
  }

  Widget _buildHeaderItem({required String title, required String value}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      decoration: BoxDecoration(
        color: Colors.grey[50],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.grey[300]!),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(color: Colors.teal[400], fontSize: 12, height: 1),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 14),
          ),
        ],
      ),
    );
  }

  // ---------------- BUTTONS ----------------
  Widget _buildMicButton() {
    return Expanded(
      child: Obx(() {
        final isListening = controller.isListening.value;
        return ElevatedButton.icon(
          onPressed: controller.toggleRecording,
          icon: Icon(
            isListening ? Icons.stop : Icons.mic,
            color: Colors.white,
            size: 20,
          ),
          label: Text(
            isListening ? "Stop" : "Rekam",
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: isListening
                ? Colors.redAccent
                : const Color(0xFF00C9A7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10),
            ),
            padding: const EdgeInsets.symmetric(vertical: 10),
          ),
        );
      }),
    );
  }

  Widget _buildInfoButton(BuildContext context) {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {
          CustomModalArea.show(
            title: "Hasil Percakapan",
            controller: TextEditingController(
              text: controller.recognizedText.value,
            ),
            readOnly: true,
            hintText: "Hasil transkrip percakapan akan tampil di sini...",
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blueGrey,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: const Text(
          "Info",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  Widget _buildSoapButton() {
    return Expanded(
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.orangeAccent,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          padding: const EdgeInsets.symmetric(vertical: 10),
        ),
        child: const Text(
          "Salin SOAPI",
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
      ),
    );
  }

  // ---------------- FORM ----------------
  Widget _buildFormSection() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildInputField(
            label: "Subjective",
            hintText: "Masukkan keluhan pasien...",
            controller: controller.subjectiveController,
          ),
          _buildInputField(
            label: "Objective",
            hintText: "Masukkan hasil pemeriksaan...",
            controller: controller.objectiveController,
          ),
          _buildInputField(
            label: "Assessment",
            hintText: "Masukkan diagnosis...",
            controller: controller.assessmentController,
          ),
          _buildInputField(
            label: "Planning",
            hintText: "Masukkan rencana tindakan...",
            controller: controller.planningController,
          ),
          _buildInputField(
            label: "Instruksi",
            hintText: "Masukkan instruksi...",
            controller: controller.instructionController,
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required String label,
    required String hintText,
    required TextEditingController controller,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.teal[400],
            fontWeight: FontWeight.w600,
            fontSize: 14,
          ),
        ),
        const SizedBox(height: 8),
        TextField(
          controller: controller,
          minLines: 3,
          maxLines: 5,
          decoration: InputDecoration(
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[400]),
            filled: true,
            fillColor: Colors.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: BorderSide(color: Colors.grey[400]!),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12),
              borderSide: const BorderSide(color: Color(0xFF00C9A7), width: 2),
            ),
          ),
        ),
        const SizedBox(height: 20),
      ],
    );
  }

  // ---------------- SAVE BUTTON ----------------
  Widget _buildSaveButton() {
    return Obx(() {
      return SizedBox(
        width: double.infinity,
        height: 50,
        child: ElevatedButton(
          onPressed: controller.isLoading.value
              ? null
              : () => controller.saveCppt(),
          style: ElevatedButton.styleFrom(
            backgroundColor: const Color(0xFF00C9A7),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12),
            ),
          ),
          child: controller.isLoading.value
              ? const CircularProgressIndicator(color: Colors.white)
              : const Text(
                  "SIMPAN",
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
        ),
      );
    });
  }
}
