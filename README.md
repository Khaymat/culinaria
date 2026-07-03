# Culinaria

Aplikasi resep makanan berbasis Flutter menggunakan **TheMealDB API**.

## Fitur

- **Browse Kategori** — Lihat daftar kategori makanan (Beef, Chicken, Dessert, dll)
- **Lihat Resep** — Tap kategori untuk melihat daftar makanan
- **Detail Resep** — Lihat instruksi memasak, bahan, gambar, dan area asal
- **Cari Resep** — Cari makanan berdasarkan nama
- **Favorit** — Simpan resep favorit ke database lokal (SQLite)
- **Clean Architecture** — Data, Domain, Presentation layers
- **State Management** — BLoC (flutter_bloc)
- **Dependency Injection** — get_it

## Cara Menjalankan

```bash
# Clone & masuk folder
cd culinaria

# Install dependencies
flutter pub get

# Run di device/emulator
flutter run

# Build APK release
flutter build apk --release
```

## Tech Stack

| Komponen | Library |
|----------|---------|
| State Management | flutter_bloc |
| HTTP Client | http |
| Local DB | sqflite |
| DI | get_it |
| Functional | dartz |
| Equatable | equatable |

## Struktur Proyek

```
lib/
├── core/           # Shared utilities, errors, usecase
├── data/           # Data layer (models, datasources, repositories)
│   ├── datasources/   # API & DB calls
│   ├── models/        # JSON serialization
│   └── repositories/  # Repository implementations
├── domain/         # Domain layer (entities, repositories, usecases)
│   ├── entities/      # Business objects
│   ├── repositories/  # Abstract repository interfaces
│   └── usecases/      # Business logic
├── presentation/   # Presentation layer (BLoCs, pages)
│   ├── blocs/         # State management
│   └── pages/         # UI screens
└── injection_container.dart  # DI setup
```

## API

Menggunakan [TheMealDB API](https://www.themealdb.com/api.php) — database resep makanan gratis.
