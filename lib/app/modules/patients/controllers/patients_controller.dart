import 'package:get/get.dart';

// Model untuk Patient
class Patient {
  final String id;
  final String bedNumber;
  final String name;
  final String birthDate;
  final String admissionDate;
  final String identityNumber;
  final String insuranceType;
  final String address;
  final String registrationNumber;
  final DateTime visitDate;
  final int daysStayed;
  final String doctor;
  final String room;
  final String roomStatus;
  final String roomClass;
  final List<String> tags; // untuk icon-icon seperti K, S, dll

  Patient({
    required this.id,
    required this.bedNumber,
    required this.name,
    required this.birthDate,
    required this.admissionDate,
    required this.identityNumber,
    required this.insuranceType,
    required this.address,
    required this.registrationNumber,
    required this.visitDate,
    required this.daysStayed,
    required this.doctor,
    required this.room,
    required this.roomStatus,
    required this.roomClass,
    required this.tags,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'] ?? '',
      bedNumber: json['bedNumber'] ?? '',
      name: json['name'] ?? '',
      birthDate: json['birthDate'] ?? '',
      admissionDate: json['admissionDate'] ?? '',
      identityNumber: json['identityNumber'] ?? '',
      insuranceType: json['insuranceType'] ?? '',
      address: json['address'] ?? '',
      registrationNumber: json['registrationNumber'] ?? '',
      visitDate: DateTime.tryParse(json['visitDate'] ?? '') ?? DateTime.now(),
      daysStayed: json['daysStayed'] ?? 0,
      doctor: json['doctor'] ?? '',
      room: json['room'] ?? '',
      roomStatus: json['roomStatus'] ?? '',
      roomClass: json['roomClass'] ?? '',
      tags: List<String>.from(json['tags'] ?? []),
    );
  }
}

class PatientsController extends GetxController {
  final patients = <Patient>[].obs;
  final isLoading = false.obs;

  // Filter variables
  final selectedRoom = 'Semua'.obs;
  final selectedStatus = 'Semua'.obs;
  final selectedDoctor = 'Semua'.obs;
  final searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    patients.value = [
      Patient(
        id: '1',
        bedNumber: 'ANAK.14.03',
        name: 'KANJENG RADEN AYU MAS IT SEHAT',
        birthDate: '01-00-00-01',
        admissionDate: '24-JUN-1981, LAKI-LAKI, PENGGUNA BPJS KEPERCAYAAN',
        identityNumber: '',
        insuranceType: 'JKN KARTU INDONESIA SEHAT (KIS)',
        address: 'A.J. CENTRAL ASIA RAYA, RT RW, GEDONGAN, BAKI, SUKOHARJO, 0',
        registrationNumber: 'IPR/20250321/00001',
        visitDate: DateTime(2025, 3, 21, 11, 17),
        daysStayed: 217,
        doctor: 'DR. SPESIALIS ANAK 1',
        room: 'PERAWATAN IBU & ANAK 1',
        roomStatus: 'SUITE',
        roomClass: 'SUITE',
        tags: ['K', 'S', 'A', 'O'],
      ),
      Patient(
        id: '2',
        bedNumber: 'ANAK.14.01',
        name: 'PASIEN 2',
        birthDate: '01-00-00-02',
        admissionDate: '05-APR-2023, LAKI-LAKI, ISLAM',
        identityNumber: '085269697009',
        insuranceType: 'JKN KARTU INDONESIA SEHAT (KIS)',
        address: 'NOLOBAYAN 03/01, DUWET, BAKI, SUKOHARJO',
        registrationNumber: 'IPR/20250321/00003',
        visitDate: DateTime(2025, 7, 24, 10, 00),
        daysStayed: 92,
        doctor: 'DR. SPESIALIS PENYAKIT DALAM 1',
        room: 'PERAWATAN IBU & ANAK 1',
        roomStatus: 'VIP',
        roomClass: 'VIP',
        tags: ['K', 'S', 'A', 'O'],
      ),
      Patient(
        id: '3',
        bedNumber: 'ANAK.03.01',
        name: 'PASIEN 3',
        birthDate: '01-00-00-03',
        admissionDate: '16-JUN-2012, PEREMPUAN, ISLAM',
        identityNumber: '081328771807',
        insuranceType: 'PERSONAL',
        address: 'GENTAN 03/00, CATURHARJO, PANDAK, BANTUL',
        registrationNumber: 'IPR/20250321/00004',
        visitDate: DateTime(2025, 7, 31, 13, 00),
        daysStayed: 85,
        doctor: 'DR. SPESIALIS PENYAKIT DALAM 2',
        room: 'PERAWATAN IBU & ANAK 1',
        roomStatus: 'I',
        roomClass: 'I',
        tags: ['K', 'S', 'A', 'O'],
      ),
    ];
  }

  void setRoomFilter(String room) => selectedRoom.value = room;
  void setStatusFilter(String status) => selectedStatus.value = status;
  void setDoctorFilter(String doctor) => selectedDoctor.value = doctor;
  void searchPatients(String query) => searchQuery.value = query;

  Future<void> fetchPatientsFromAPI() async {
    try {
      isLoading.value = true;
      await Future.delayed(const Duration(seconds: 1));
      loadDummyData();
    } catch (e) {
      Get.snackbar('Error', 'Failed to load patients: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> refreshPatients() async => fetchPatientsFromAPI();
}