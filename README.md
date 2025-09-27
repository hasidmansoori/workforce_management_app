# Workforce Management App

A Flutter-based Workforce Management App with **Geo-based Attendance** and **Task Management** using **Clean Architecture** and **BLoC** pattern. The app supports offline caching, real-time task updates, push notifications, and location-based attendance.

---

## Table of Contents

- [Features](#features)
- [Architecture](#architecture)
- [Project Structure](#project-structure)
- [Packages Used](#packages-used)
- [Setup & Installation](#setup--installation)
- [Testing Credentials](#testing-credentials)
- [Screenshots](#screenshots)
- [License](#license)

---

## Features

### Authentication & Attendance
- Login/Register with JWT authentication.
- Geo-fenced Check-in/out (50m radius from office location).
- Attendance History: View daily/monthly records.
- Profile Management: Update name, email, and profile photo.

### Task Management & CRM
- Task Dashboard: Create, assign, and track tasks (To-Do, In Progress, Done).
- Client List: Add/edit client information.
- Follow-up Reminders: Push notifications for client follow-ups.
- Quick Actions: Call or email clients directly from the app.

### Smart Geofencing
- Real-time user location check before allowing attendance.
- Shows distance from office.
- Handles location permissions gracefully.

### Real-time & Offline Features
- Live task updates via WebSocket.
- Push notifications for task assignments.
- Offline task creation with sync when online.
- Local cache of attendance and tasks.

### Code Quality
- **Clean Architecture**: Layer separation for `presentation`, `domain`, `data`.
- **BLoC Pattern**: All state management.
- **Dependency Injection**: `get_it`.
- Proper error handling with custom exceptions.

---

## Architecture

The app follows **Clean Architecture** with three main layers:

# 🧱 Project Architecture Overview

## 🖥️ Presentation Layer (UI)
- **Screens / Widgets** – UI components and visual elements.
- **BLoC (State Management)** – Manages UI states and business logic interaction.
- **Handles user input & displays data** – Translates domain data into displayable views.

## 🧠 Domain Layer (Business Logic)
- **Entities** – Core models representing real-world objects.
- **Repositories (Abstract interfaces)** – Define contracts for data operations.
- **Use Cases** – Encapsulate application-specific business logic.

## 📦 Data Layer (Data Sources)
- **Remote** – Handles API and WebSocket communication.
- **Local** – Handles local data storage (Hive / SQLite).
- **Models** – Data Transfer Objects (DTOs) used to map API or local data.
- **Repository Implementations** – Concrete implementations that fulfill domain repository contracts.

---
```text
# 📁 Project Structure

lib/
├─ core/                          # Core utilities shared across the app
│  ├─ error/                      # Error handling (e.g., Failure classes, exceptions)
│  ├─ network/                    # Network utilities (e.g., NetworkInfo)
│  └─ utils/                      # General utility/helper functions
│
├─ features/                      # Feature-based architecture
│  ├─ auth/                       # Authentication (login, register, session)
│  │  ├─ data/                    # Data layer (models, datasources, repository impl)
│  │  ├─ domain/                  # Business logic layer (entities, repositories, usecases)
│  │  └─ presentation/            # UI layer (Bloc, pages, widgets for Auth)
│  │
│  ├─ attendance/                 # Attendance feature (check-in, check-out, logs)
│  │  ├─ data/                    # Local datasources, repositories
│  │  ├─ domain/                  # Entities, repositories
│  │  └─ presentation/            # Bloc, UI for attendance
│  │
│  ├─ tasks/                      # Task management feature
│  │  ├─ data/                    # Remote datasource (API), repository implementations
│  │  ├─ domain/                  # Task entities, repository contracts
│  │  └─ presentation/            # Bloc, UI (TaskPage, Task Widgets)
│  │
│  └─ profile/                    # User profile management feature
│     ├─ data/                    # Profile datasource, model, repository
│     ├─ domain/                  # Profile entity, repository abstraction
│     └─ presentation/            # Bloc, UI (ProfilePage, widgets)
│
├─ services/                      # Global services available across features
│  ├─ api_service.dart            # Handles HTTP requests using Dio
│  ├─ local_storage_service.dart  # Local persistence with Hive/SharedPreferences
│  ├─ websocket_service.dart      # WebSocket connection & stream handling
│  └─ location_service.dart       # Location & geolocation utilities
│
├─ widgets/                       # Reusable UI components
│  ├─ custom_button.dart          # Custom styled button widget
│  ├─ custom_textfield.dart       # Custom styled text input field
│  ├─ loading_indicator.dart      # Reusable loading spinner widget
│
├─ injection_container.dart       # Dependency injection setup (GetIt service locator)
└─ main.dart                      # Entry point of the Flutter app

```

## 📦 Packages Used

| Package              | Purpose                                                                 |
|----------------------|-------------------------------------------------------------------------|
| cupertino_icons      | iOS-style icons for Flutter apps                                        |
| flutter_bloc         | State management using the BLoC (Business Logic Component) pattern      |
| get_it               | Dependency injection & service locator                                 |
| equatable            | Simplifies equality checks in entities and states                      |
| dio                  | Powerful HTTP client for API requests                                  |
| connectivity_plus    | Monitor network status and connectivity                                |
| geolocator           | Access GPS location for attendance tracking                           |
| permission_handler   | Request and manage runtime permissions (location, storage, etc.)       |
| hive                 | Lightweight NoSQL database for local storage                           |
| hive_flutter         | Hive integration with Flutter                                          |
| shared_preferences   | Store small key-value persistent data (e.g., tokens, settings)         |
| web_socket_channel   | WebSocket client for real-time updates                                 |
| firebase_messaging   | Push notifications using Firebase Cloud Messaging                      |
| firebase_core        | Core Firebase services initialization                                  |
| fl_chart             | Beautiful charts for analytics and data visualization                  |
| dartz                | Functional programming utilities (Either, Option, etc.)                |


#🚀 Setup & Installation

## 1. Clone the Repository
```bash
git clone https://github.com/hasidmansoori/workforce_management_app.git
cd workforce_app
```

## 2. Install Dependencies
```bash
flutter pub get
```

## 3. Run the App
```bash
flutter run

```

## 4. Initialize Hive Local Storage
Add the following to your app’s `main()` function or initialization logic:
```bash
await LocalStorageService().init();
```

## 5. Update WebSocket and API URLs

### 🔗 WebSocket URL
Open `websocket_service.dart` and update the WebSocket URL:

```dart
wss://example.com/ws
```

## 🌐 API Base URL
Open `api_service.dart` and modify the base URL to match your backend:
```dart
baseUrl = "https://your-backend-url.com";
```
