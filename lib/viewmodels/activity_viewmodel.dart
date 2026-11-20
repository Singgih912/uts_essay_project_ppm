import 'package:flutter/foundation.dart';

import '../models/activity_model.dart';
import '../repositories/activity_repository.dart';

/// VIEWMODEL: mengelola logika aplikasi dan state.
/// Memberitahu View (notifyListeners) ketika data berubah.
class ActivityViewModel extends ChangeNotifier {
  final ActivityRepository _repository;

  ActivityViewModel(this._repository) {
    loadActivities();
  }

  List<ActivityModel> _activities = [];

  List<ActivityModel> get activities => _activities;

  /// Meminta data aktivitas dari Repository.
  void loadActivities() {
    _activities = _repository.getAll();
    notifyListeners();
  }

  ActivityModel? getById(int id) => _repository.getById(id);

  void addActivity(String name) {
    _repository.add(name.trim());
    loadActivities();
  }

  void updateActivityName(int id, String name) {
    _repository.updateName(id, name.trim());
    loadActivities();
  }

  void deleteActivity(int id) {
    _repository.delete(id);
    loadActivities();
  }

  void increment(int id) {
    final activity = _repository.getById(id);
    if (activity == null) return;
    _repository.updateCounter(id, activity.counter + 1);
    loadActivities();
  }

  /// Mengembalikan false jika counter sudah 0 (tidak boleh kurang dari 0).
  bool decrement(int id) {
    final activity = _repository.getById(id);
    if (activity == null || activity.counter <= 0) return false;
    _repository.updateCounter(id, activity.counter - 1);
    loadActivities();
    return true;
  }

  void reset(int id) {
    _repository.updateCounter(id, 0);
    loadActivities();
  }
}
