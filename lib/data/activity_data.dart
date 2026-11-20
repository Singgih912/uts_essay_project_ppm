import '../models/activity_model.dart';

/// DATA: sumber data aplikasi. Data disimpan sementara dalam List
/// selama aplikasi berjalan (tanpa database/API).
class ActivityData {
  final List<ActivityModel> _activities = [
    const ActivityModel(id: 1, name: 'Olahraga', counter: 3),
    const ActivityModel(id: 2, name: 'Membaca Buku', counter: 1),
    const ActivityModel(id: 3, name: 'Mengerjakan Tugas', counter: 5),
  ];

  int _nextId = 4;

  List<ActivityModel> get activities => _activities;

  int generateId() => _nextId++;
}
