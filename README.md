# Activity Counter (Flutter + MVVM)

Project UTS Pemrograman Mobile. Aplikasi untuk mencatat dan menghitung aktivitas
(olahraga, membaca buku, mengerjakan tugas, dll). Data disimpan sementara dalam
`List` selama aplikasi berjalan.

## Cara menjalankan

Folder ini hanya berisi `lib/` dan `pubspec.yaml`. Buat folder platform
(android/ios/web) satu kali dengan perintah berikut di dalam folder project:

```
flutter create .
flutter pub get
flutter run
```

`flutter create .` tidak menimpa file `lib/` dan `pubspec.yaml` yang sudah ada.

## Struktur folder

```
lib/
├── main.dart
├── models/activity_model.dart
├── data/activity_data.dart
├── repositories/activity_repository.dart
├── viewmodels/activity_viewmodel.dart
└── views/
    ├── home_view.dart
    ├── activity_form_view.dart
    └── activity_detail_view.dart
```

## Penjelasan MVVM (untuk persiapan tanya jawab)

| Lapisan | Tanggung jawab |
|---|---|
| Model | Mendefinisikan struktur data aktivitas: `id`, `name`, `counter`. |
| Data | Sumber data: data awal dan penyimpanan sementara berupa `List`. |
| Repository | Mengelola akses dan manipulasi data: ambil, tambah, ubah, hapus, update counter. |
| ViewModel | Logika aplikasi dan state. Meminta data ke Repository, lalu memanggil `notifyListeners()`. |
| View | Menampilkan antarmuka dan meneruskan aksi pengguna ke ViewModel. |

## Alur data

View (tombol ditekan) -> ViewModel (`increment`, `addActivity`, dll.) ->
Repository (`updateCounter`, `add`, dll.) -> Data (`List` diubah).

## Bagaimana perubahan tampil kembali di View

1. Setelah Repository mengubah `List`, ViewModel memanggil `loadActivities()`.
2. `loadActivities()` mengambil data terbaru lalu memanggil `notifyListeners()`.
3. `ListenableBuilder` di View mendengarkan ViewModel, sehingga widget dibangun
   ulang otomatis dan menampilkan data terbaru.

## Pemenuhan ketentuan

- 3 halaman dengan navigasi `Navigator.push`/`pop`.
- Validasi nama kosong pada form (`TextFormField` + `validator`).
- Counter tidak bisa kurang dari 0 (`decrement` mengembalikan `false` di angka 0).
- SnackBar: tambah, ubah, hapus, dan setiap counter berubah.
- AlertDialog: konfirmasi sebelum reset dan sebelum hapus.
