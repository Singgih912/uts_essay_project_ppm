import '../data/activity_data.dart';
import '../models/activity_model.dart';

/// REPOSITORY: mengelola akses dan manipulasi data aktivitas.
class ActivityRepository {
  final ActivityData _data;

  ActivityRepository(this._data);

  List<ActivityModel> getAll() => List.unmodifiable(_data.activities);

  ActivityModel? getById(int id) {
    final index = _data.activities.indexWhere((a) => a.id == id);
    return index == -1 ? null : _data.activities[index];
  }

  void add(String name) {
    _data.activities.add(ActivityModel(id: _data.generateId(), name: name));
  }

  void updateName(int id, String name) {
    final index = _data.activities.indexWhere((a) => a.id == id);
    if (index == -1) return;
    _data.activities[index] = _data.activities[index].copyWith(name: name);
  }

  void delete(int id) {
    _data.activities.removeWhere((a) => a.id == id);
  }

  void updateCounter(int id, int value) {
    final index = _data.activities.indexWhere((a) => a.id == id);
    if (index == -1) return;
    _data.activities[index] =
        _data.activities[index].copyWith(counter: value);
  }
}
