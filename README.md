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

# 📁 Project Structure

lib/
├─ core/                             # Core utilities and helpers
│  ├─ error/                         # Error handling (e.g., exceptions, failures)
│  ├─ network/                       # Network utilities and interceptors
│  └─ utils/                         # General utility functions/helpers
├─ features/                         # Feature-based modular structure
│  ├─ auth/                          # Authentication feature
│  │  ├─ data/                       # Data sources, models, implementations
│  │  ├─ domain/                     # Entities, repositories, use cases
│  │  └─ presentation/               # UI, BLoC, widgets
│  ├─ attendance/                    # Attendance tracking
│  ├─ tasks/                         # Task management
│  └─ profile/                       # User profile
├─ services/                         # Shared services
│  ├─ api_service.dart               # API client using Dio
│  ├─ local_storage_service.dart     # Local storage using Hive
│  ├─ websocket_service.dart         # WebSocket communication
│  └─ location_service.dart          # Geolocation handling
└─ main.dart                         # App entry point

#🧩 Packages Used

| Package             | Purpose                                 |
| ------------------- | --------------------------------------- |
| `flutter_bloc`      | State management                        |
| `get_it`            | Dependency injection                    |
| `dio`               | HTTP API requests                       |
| `geolocator`        | Location services                       |
| `hive`              | Local data storage / offline caching    |
| `fl_chart`          | Data visualization and analytics charts |
| `connectivity_plus` | Internet/network status detection       |

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