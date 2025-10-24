import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../modules/patients/controllers/patients_controller.dart';

class PatientCard extends StatelessWidget {
  final Patient patient;
  const PatientCard({super.key, required this.patient});

  @override
  Widget build(BuildContext context) {
    Color tagColor = Colors.blue;
    if (patient.tags.contains("K")) tagColor = Colors.orange;
    if (patient.tags.contains("S")) tagColor = Colors.green;

    return Card(
      elevation: 3,
      color: Colors.white, // ✅ gunakan "color" bukan "backgroundColor"
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        borderRadius: BorderRadius.circular(16),
        onTap: () => Get.snackbar('Info', 'Detail pasien ${patient.name}'),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // 🔹 Header
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [Color(0xFF00C9A7), Color(0xFF0070C9)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      patient.bedNumber,
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 13,
                      ),
                    ),
                  ),
                  Wrap(
                    spacing: 4,
                    children: patient.tags
                        .map((tag) => _buildTag(tag))
                        .toList(),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              const Divider(height: 1, color: Colors.grey),

              const SizedBox(height: 12),
              // 🔹 Nama & Info Pasien
              Text(
                patient.name,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF0070C9),
                ),
              ),
              const SizedBox(height: 4),
              Text(
                patient.address,
                style: const TextStyle(color: Colors.grey, fontSize: 12),
              ),
              const SizedBox(height: 4),
              Text(
                patient.insuranceType,
                style: const TextStyle(color: Colors.black54, fontSize: 12),
              ),

              const SizedBox(height: 12),
              Row(
                children: [
                  const Icon(
                    Icons.local_hospital,
                    color: Color(0xFF00C9A7),
                    size: 18,
                  ),
                  const SizedBox(width: 6),
                  Text(
                    patient.room,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const Spacer(),
                  Text(
                    '${patient.daysStayed} Hari',
                    style: const TextStyle(fontSize: 12, color: Colors.grey),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTag(String tag) {
    Color color;
    switch (tag) {
      case 'K':
        color = Colors.orange;
        break;
      case 'S':
        color = Colors.green;
        break;
      case 'A':
        color = Colors.blue;
        break;
      case 'O':
        color = Colors.amber;
        break;
      default:
        color = Colors.grey;
    }

    return Container(
      width: 24,
      height: 24,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Center(
        child: Text(
          tag,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 11,
          ),
        ),
      ),
    );
  }
}
