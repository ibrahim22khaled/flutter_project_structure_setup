# 🚀 Professional Flutter Starter Template

A production-ready, clean-architecture starter template for Flutter developers. Designed for scalability, testability, and maintainability.

---

## 🏗️ Architecture Overview

This project follows **Clean Architecture** principles, separated into four distinct layers:

### 1. Presentation Layer (UI & Logic)
*   **Cubits**: Manages state using the BLoC pattern.
*   **Widgets/Screens**: Pure UI components.
*   *Rule*: NOT allowed to import from the Data layer directly.

### 2. Domain Layer (The Brain)
*   **Entities**: Plain Dart objects representing business models.
*   **Usecases**: Specific application business rules.
*   **Repository Interfaces**: Contracts defined for data operations.
*   *Rule*: The core of the app. Has ZERO dependencies on other layers.

### 3. Data Layer (The Provider)
*   **Repositories Implementations**: Concrete implementation of domain contracts.
*   **Models (DTOs)**: JSON-serializable objects with mapping to entities.
*   **DataSources**: Raw data providers (Remote/Local).
*   *Rule*: Responsible for fetching and caching data. Converts Models to Entities.

### 4. Core Layer (The Infrastructure)
*   Network info, custom loggers, and dependency injection setups.

---

## 🛠️ Core Dependencies

| Package | Purpose |
| :--- | :--- |
| `flutter_bloc` | State management using Cubits for predictable logic. |
| `dio` | Powerful HTTP client for API interactions. |
| `get_it` & `injectable` | Service locator and DI for clean dependency management. |
| `freezed` | Code generation for immutable classes and unions. |
| `go_router` | Declarative routing system. |
| `dartz` | Functional programming (Either) for error handling. |

---

## 🚶 Step-by-Step Feature Implementation (The "Products" Example)

To build a new feature (e.g., "Products"), follow this workflow:

### 1. Domain Layer (Start Here)
1.  **Entity**: Create `domain/entities/product.dart`. A plain class for your data.
2.  **Repository Interface**: Create `domain/repositories/products_repository.dart` defining the `getProducts()` contract.
3.  **UseCase**: Create `domain/usecases/get_products.dart` that calls the repository.

### 2. Data Layer
1.  **Model**: Create `data/models/product_model.dart` with `@freezed`.
    > **Pro-Tip**: Add a `toEntity()` method in your model for a cleaner repository.
2.  **DataSource**: Create `data/datasources/products_remote_datasource.dart` using Dio.
3.  **Repository Impl**: Implement the interface in `data/repositories/products_repository_impl.dart`.

### 3. Presentation Layer
1.  **Cubit**: Create `presentation/cubit/products_cubit.dart` to handle loading/success/error states.
2.  **UI**: Build your screen in `presentation/screens/products_screen.dart` using `BlocBuilder`.

---

## 🚦 Getting Started

1.  **Get Packages**: `flutter pub get`
2.  **Generate Code**: `dart run build_runner build --delete-conflicting-outputs`
3.  **Run l10n**: `flutter gen-l10n`
4.  **Launch**: `flutter run`

---

## 📝 Best Practices

*   **Localization**: Add keys to `lib/l10n/app_en.arb` and `app_ar.arb`, then run `flutter gen-l10n`.
*   **Error Handling**: Use the `Failure` class and `Either` type to handle errors without throwing exceptions everywhere.
*   **Dependency Injection**: Use `@injectable` and `@lazySingleton` for automatic registration.
