/// MODEL: mendefinisikan struktur data sebuah aktivitas.
class ActivityModel {
  final int id;
  final String name;
  final int counter;

  const ActivityModel({
    required this.id,
    required this.name,
    this.counter = 0,
  });

  /// Membuat salinan objek dengan sebagian nilai diganti.
  ActivityModel copyWith({String? name, int? counter}) {
    return ActivityModel(
      id: id,
      name: name ?? this.name,
      counter: counter ?? this.counter,
    );
  }
}
