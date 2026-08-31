<p align="center">
  <img src="assets/images/logo.png" alt="GameDrop Logo" width="160" />
</p>

<h1 align="center">GameDrop</h1>

<p align="center">
  <strong>Track upcoming console releases, countdown to launch day, and discover your next gaming adventure.</strong>
</p>

<p align="center">
  <a href="https://github.com/captainsero/GameDrop/actions/workflows/ci-demo.yml">
    <img src="https://github.com/captainsero/GameDrop/actions/workflows/ci-demo.yml/badge.svg" alt="CI Demo Status" />
  </a>
  <a href="https://github.com/captainsero/GameDrop/actions/workflows/build-development.yml">
    <img src="https://github.com/captainsero/GameDrop/actions/workflows/build-development.yml/badge.svg" alt="Build APK Status" />
  </a>
  <img src="https://img.shields.io/badge/Flutter-3.x-02569B?style=flat&logo=flutter&logoColor=white" alt="Flutter" />
  <img src="https://img.shields.io/badge/Dart-3.11+-0175C2?style=flat&logo=dart&logoColor=white" alt="Dart" />
  <img src="https://img.shields.io/badge/Architecture-Clean%20Architecture-009688?style=flat" alt="Clean Architecture" />
  <img src="https://img.shields.io/badge/State%20Management-BLoC%20%2F%20Cubit-8A2BE2?style=flat" alt="BLoC" />
  <img src="https://img.shields.io/badge/Style-Very%20Good%20Analysis-2E7D32?style=flat" alt="Very Good Analysis" />
</p>

---

## 📖 Table of Contents

- [Overview](#-overview)
- [Key Features](#-key-features)
- [Application Architecture](#-application-architecture)
- [Edge Proxy Backend (Cloudflare Worker)](#-edge-proxy-backend-cloudflare-worker)
- [Tech Stack & Libraries](#-tech-stack--libraries)
- [Project Directory Structure](#-project-directory-structure)
- [Getting Started](#-getting-started)
  - [Prerequisites](#prerequisites)
  - [Installation & Setup](#installation--setup)
  - [Running the App](#running-the-app)
- [Testing & Quality Assurance](#-testing--quality-assurance)
- [CI/CD Automation](#-cicd-automation)
- [Contributing](#-contributing)
- [License](#-license)

---

## 🎮 Overview

**GameDrop** is a cross-platform mobile application built with **Flutter** designed for console gamers. It provides a release calendar and live launch count-downs for upcoming titles across major gaming platforms: **PlayStation 5**, **PlayStation 4**, **Xbox Series X/S**, **Xbox One**, and **Nintendo Switch**.

Powered by a secure **Cloudflare Workers** edge proxy and local **Hive** caching, GameDrop delivers fast load times, offline availability, low data consumption, and an interface styled in a sleek dark theme.

---

## ✨ Key Features

- **📅 Upcoming Releases Feed**: Real-time discovery feed of upcoming console games ordered by release date.
- **⏱️ Live Countdown Timers**: Countdown to launch date broken down into days, hours, minutes, and seconds.
- **🏷️ Dynamic Launch Badges**: Quick visual indicators displaying **Days Remaining**, **OUT NOW** for recent drops, or **TBA** for unannounced dates.
- **🎯 Console-Exclusive Filters**: Focuses on modern home consoles (PS5, PS4, Xbox Series X/S, Xbox One, Switch).
- **🔍 Fast Search**: Animated search bar with instant local search filtering over cached titles and on-demand remote queries.
- **📖 Deep Game Details**: Rich game cover art, platform availability tags, genre badges, and formatted storyline summaries.
- **📶 Offline-First Experience**: High-performance local caching with **Hive CE**, allowing seamless browsing even when disconnected.
- **⚡ Custom Skeleton Shimmers**: Polished skeleton loading animations matching the game card layout for smooth transitions.
- **🎨 Sleek Cyberpunk Dark Theme**: Specially crafted dark UI (`#0F1117`) paired with the **Outfit** typography.

---

## 🏛️ Application Architecture

GameDrop strictly implements **Clean Architecture** combined with a **Feature-First** structure. This guarantees complete separation of concerns, testability, and scalability.

```
┌──────────────────────────────────────────────────────────┐
│                   Presentation Layer                     │
│    • Views / Screens (GamesView, GameDetailsView)        │
│    • ViewModels / Cubits (GamesViewModel, etc.)         │
│    • UI State / BaseState (Loading, Success, Error)      │
│    • Custom Modular Widgets & Shimmers                   │
└────────────────────────────┬─────────────────────────────┘
                             │ invokes
                             ▼
┌──────────────────────────────────────────────────────────┐
│                      Domain Layer                        │
│    • Use Cases (GetUpcomingGamesUseCase, etc.)           │
│    • Business Entities (GameEntity, GameDetailEntity)    │
│    • Repository Contracts / Interfaces                   │
└────────────────────────────▲─────────────────────────────┘
                             │ implements
┌────────────────────────────┴─────────────────────────────┐
│                       Data Layer                         │
│    • Repository Implementation (GamesRepoImpl)           │
│    • Data Sources (Remote via Dio, Local via Hive CE)    │
│    • Data Models & JSON / Hive Serializers               │
└──────────────────────────────────────────────────────────┘
```

### Architectural Highlights

- **Unidirectional Data Flow (BLoC/Cubit)**: Predictable state transitions driven by events (`GamesEvent` -> `GamesState`).
- **Dependency Injection**: Powered by `get_it` and `injectable` for loose coupling and easy mocking.
- **Declarative Navigation**: Managed by `go_router` with type-safe parameterized routing (`/games`, `/game_details/:id`).
- **Standardized API Handling**: Uniform `BaseResponse<T>` and `BaseState<T>` abstractions across all layers.

---

## ☁️ Edge Proxy Backend (Cloudflare Worker)

Rather than calling the upstream [RAWG Video Games Database API](https://rawg.io/apidocs) directly from the client, GameDrop utilizes a custom **Cloudflare Worker** serverless proxy (`src/index.js`) paired with **Cloudflare Workers KV**:

```
[ Flutter Client ]
        │
        ▼ (HTTPS REST)
[ Cloudflare Worker Edge Proxy ]  ◄──►  [ Cloudflare KV Cache ]
        │                                 (1 hr TTL / 30 min Search TTL)
        ▼ (Proxies with Hidden API Key)
[ RAWG Upstream API ]
```

### Why this architecture?
1. **API Key Security**: The `RAWG_API_KEY` is kept server-side in Cloudflare secrets and is never exposed in the client binary.
2. **Rate Limit Protection & KV Edge Caching**: Responses are cached at the edge using Workers KV (`GAME_CACHE`) with a 1-hour TTL (30 minutes for search), mitigating upstream rate limits.
3. **Payload Optimization & Filtering**: RAWG payloads are stripped of excess metadata, pre-filtered exclusively for console platforms (IDs: `187`, `18`, `1`, `186`, `7`), and delivered in normalized JSON payloads tailored directly for the mobile app.

---

## 🛠️ Tech Stack & Libraries

| Category | Technology | Purpose |
|---|---|---|
| **Framework** | [Flutter](https://flutter.dev/) (Dart 3.11+) | Multi-platform client application |
| **State Management** | [flutter_bloc](https://pub.dev/packages/flutter_bloc) & [bloc](https://pub.dev/packages/bloc) | Predictable reactive state management |
| **Dependency Injection** | [get_it](https://pub.dev/packages/get_it) & [injectable](https://pub.dev/packages/injectable) | Compile-time service locator & DI generation |
| **Routing** | [go_router](https://pub.dev/packages/go_router) | Declarative URL-based routing & deep linking |
| **Networking** | [dio](https://pub.dev/packages/dio) & [retrofit](https://pub.dev/packages/retrofit) | Robust HTTP client with interceptors |
| **Local Database** | [hive_ce](https://pub.dev/packages/hive_ce) & [hive_ce_flutter](https://pub.dev/packages/hive_ce_flutter) | Fast, lightweight NoSQL key-value database |
| **Image Caching** | [cached_network_image](https://pub.dev/packages/cached_network_image) | High-performance remote image caching & memory management |
| **Code Generation** | [build_runner](https://pub.dev/packages/build_runner), [json_serializable](https://pub.dev/packages/json_serializable) | Boilerplate generation for models and DI |
| **Code Quality & Lint** | [very_good_analysis](https://pub.dev/packages/very_good_analysis) | Strict linter rules & static analysis |
| **Testing** | [mocktail](https://pub.dev/packages/mocktail), [bloc_test](https://pub.dev/packages/bloc_test), [golden_toolkit](https://pub.dev/packages/golden_toolkit) | Comprehensive unit, bloc, and widget testing |
| **Edge Serverless** | [Cloudflare Workers](https://workers.cloudflare.com/) + Wrangler | Edge API proxy with KV caching |

---

## 📂 Project Directory Structure

```plaintext
gamedrop/
├── .github/
│   └── workflows/
│       ├── ci-demo.yml             # CI: analyze, format, tests, and coverage
│       └── build-development.yml   # CI + CD: builds & uploads debug APK artifact
├── assets/
│   ├── fonts/                      # Outfit font family
│   └── images/                     # App logo and launcher icon assets
├── lib/
│   ├── config/                     # Dependency injection, Hive init, Dio client
│   │   ├── base_response/          # Generic API response wrapper
│   │   ├── base_state/             # Standardized UI state container
│   │   ├── di/                     # GetIt & Injectable configuration
│   │   ├── dio/                    # Dio client configuration & interceptors
│   │   └── hive/                   # Hive box initialization & type adapters
│   ├── core/                       # Shared design system, router, theme, utilities
│   │   ├── constants/              # Screen sizing, dimensions, values
│   │   ├── router/                 # GoRouter route definitions & navigation
│   │   ├── shared_widgets/         # Reusable widgets
│   │   └── theme/                  # Dark & Light theme specifications
│   ├── features/                   # Feature-First modules
│   │   ├── games/                  # Upcoming games & search feature
│   │   │   ├── api/                # Retrofit API interface
│   │   │   ├── data/               # Data sources, models, and repo implementation
│   │   │   ├── domain/             # Entities, repo contracts, and use cases
│   │   │   └── presentation/       # Views, Cubits, and UI widgets
│   │   ├── game_details/           # Game detail & countdown feature
│   │   │   ├── api/
│   │   │   ├── data/
│   │   │   ├── domain/
│   │   │   └── presentation/
│   │   └── error/                  # Fallback & error screens
│   ├── l10n/                       # Localization (.arb translation files)
│   └── main.dart                   # Application bootstrap & entry point
├── src/
│   └── index.js                    # Cloudflare Worker API proxy & KV cache logic
├── test/                           # Unit, Cubit, and Widget test suites
├── pubspec.yaml                    # Project dependencies and asset registry
├── wrangler.toml                   # Cloudflare Worker deployment configuration
└── analysis_options.yaml           # Strict lint configuration (Very Good Analysis)
```

---

## 🚀 Getting Started

### Prerequisites

Ensure you have the following installed on your machine:
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (`^3.11.5` or higher on the `stable` channel)
- [Dart SDK](https://dart.dev/get-dart)
- Android Studio / Xcode / VS Code with Flutter extensions
- (Optional) [Node.js](https://nodejs.org/) & [Wrangler](https://developers.cloudflare.com/workers/wrangler/) if modifying the Cloudflare Worker

### Installation & Setup

1. **Clone the repository:**
   ```bash
   git clone https://github.com/captainsero/GameDrop.git
   cd GameDrop
   ```

2. **Install Flutter dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run code generation:**
   Generate the Hive adapters, dependency injection files, and JSON serializers:
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

### Running the App

Launch on an emulator, simulator, or connected physical device:

```bash
# Run in debug mode
flutter run

# Run specifically on Android or iOS
flutter run -d android
flutter run -d ios
```

---

## 🧪 Testing & Quality Assurance

GameDrop maintains code quality through strict static analysis and automated test coverage.

### Static Analysis & Formatting

```bash
# Run strict static analysis
flutter analyze --fatal-infos

# Check code formatting
dart format --set-exit-if-changed .
```

### Running Tests with Coverage

```bash
# Run all unit, cubit, and widget tests
flutter test --coverage
```

To view HTML coverage reports:
```bash
# Generate HTML report (requires lcov)
genhtml coverage/lcov.info -o coverage/html
open coverage/html/index.html
```

---

## 🤖 CI/CD Automation

GameDrop includes automated **GitHub Actions** workflows:

- **`ci-demo.yml` (Demo Branch)**:
  - Triggers on every push & pull request to the `demo` branch.
  - Automatically runs dependency installation, `build_runner` generation, `flutter analyze`, code formatting verification, and `flutter test --coverage`.
  - Uploads code coverage reports as workflow artifacts.
- **`build-development.yml` (Development Branch)**:
  - Triggers on merges into the `development` branch.
  - Runs all quality checks, then compiles an Android **debug APK**.
  - Stores the build artifact (`gamedrop-debug-apk`) for 14 days, ready for direct device testing.

---

## 🤝 Contributing

Contributions, issues, and feature requests are welcome!

1. Fork the project.
2. Create your feature branch (`git checkout -b feat/amazing-feature`).
3. Commit your changes (`git commit -m 'feat: add amazing feature'`).
4. Ensure all tests and linter checks pass (`flutter test && flutter analyze`).
5. Push to the branch (`git push origin feat/amazing-feature`).
6. Open a Pull Request.

---

## 📄 License

This project is licensed under the [MIT License](LICENSE) - see the LICENSE file for details.

---

<p align="center">
  Crafted with ❤️ for console gamers by <a href="https://github.com/captainsero">captainsero</a>
</p>
