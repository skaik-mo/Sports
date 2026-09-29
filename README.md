# Sports App

A modular, offline-first iOS sports application built with **SwiftUI**, **Clean Architecture**, and **Swift 6**. The app tracks live match scores, upcoming fixtures, league standings, and participants across four sports (Football, Basketball, Cricket, and Tennis) with persistent local caching and a custom design system.

---

## Overview

Sports App connects to the [AllSportsAPI](https://apiv2.allsportsapi.com/) to deliver fixtures, completed match results, and league rosters. Built for iOS 17+, the codebase serves as a reference implementation of a multi-package modular architecture with strict dependency boundaries, reactive state modeling with Swift Observation, optimistic UI interactions, and automated CI pipelines.

### Key Capabilities

- **Multi-Sport Coverage**: Dedicated data pipelines for Football, Basketball, Cricket, and Tennis.
- **Dynamic Home Layout**: Switch seamlessly between a 2-column **Waterfall Grid** and a single-column layout via `LayoutSegmentedControl`.
- **Fixtures & Results**: Upcoming matches carousel, historical results list, and participant rosters with score indicators.
- **Sport-Aware Participant Resolution**: Automatically maps participants to **Teams** (Football, Basketball, Cricket) or **Individual Players** (Tennis).
- **Offline Resilience**: Remote-first caching strategy powered by **SwiftData** that silently caches data and falls back to local storage when network connectivity is unavailable.
- **Favorites System**: Save leagues for quick access with optimistic UI state toggling, grouped by sport type with instant search filtering.
- **Custom Design System**: Bespoke color tokens, custom Poppins typography loaded dynamically via CoreText, adaptive light/dark mode, and reusable UI components.
- **Custom Navigation Architecture**: Hybrid Coordinator + Router pattern driving SwiftUI's `NavigationStack` with floating contextual tab bar management.

---

## App Showcase

Watch the video walkthrough demonstrating navigation flows, match schedules, and offline caching:

[![Watch Demo Video](https://img.shields.io/badge/YouTube-Watch%20Demo-red?style=for-the-badge&logo=youtube)](https://www.youtube.com/watch?v=8XvwArcxcpo)

---

## Technical Stack

| Layer / Concern | Technology | Notes |
| :--- | :--- | :--- |
| **Language** | Swift 6 (`swiftLanguageModes: [.v6]`) | Strict concurrency checks across SPM modules |
| **UI Framework** | SwiftUI (iOS 17.0+) | Observation framework (`@Observable`, `@Bindable`) |
| **Architecture** | Modular Clean Architecture + MVVM | Layered isolation with strict dependency inversion |
| **Navigation** | Hybrid Coordinator + Router | `NavigationStack(path:)` driven by type-erased `Router` |
| **Dependency Injection** | [Factory](https://github.com/hmlongco/Factory) (`FactoryKit` 3.2.1) | Compile-time safe, containerized injection at the app root |
| **Networking** | [Alamofire](https://github.com/Alamofire/Alamofire) (5.12.0) | Layered behind protocol abstractions with JSON decoding |
| **Image Caching** | [Kingfisher](https://github.com/onevcat/Kingfisher) (8.0+) | Downsampling, caching, and placeholder rendering |
| **Persistence** | Apple SwiftData (`@Model`) | SQLite-backed local schema with compound primary keys |
| **Typography** | Dynamic CoreText Loader | Poppins (Regular, Medium, Bold) embedded in DesignSystem |
| **Build & CI/CD** | Fastlane + GitHub Actions | Selective matrix builds based on dependency-aware git diffs |
| **External API** | AllSportsAPI REST v2 | Configured via `Secrets.xcconfig` into `Info.plist` |

---

## Architecture & Code Organization

The repository is organized into five standalone Swift Package Manager (SPM) packages plus a main application target that acts as the **Composition Root**. The packages are structured around Clean Architecture principles, ensuring that inner domain layers remain independent of UI and third-party frameworks.

```
┌────────────────────────────────────────────────────────┐
│                      Sports App                        │
│          (Composition Root, DI Wiring, App Entry)      │
└──────────┬─────────────────────────────────┬───────────┘
           │                                 │
           ▼                                 ▼
┌───────────────────────┐         ┌──────────────────────┐
│     Presentation      │         │         Data         │
│  (Coordinators, VM,   │         │  (Repositories,      │
│   SwiftUI Views)      │         │   SwiftData, DTOs)   │
└─────┬───────────┬─────┘         └────┬───────────┬─────┘
      │           │                    │           │
      │           ▼                    ▼           │
      │   ┌───────────────┐   ┌────────────────┐   │
      │   │ DesignSystem  │   │   Networking   │   │
      │   │ (Fonts, Cards)│   │  (Alamofire)   │   │
      │   └───────────────┘   └────────────────┘   │
      │                                            │
      └───────────────────► ◄──────────────────────┘
                     ┌────────────┐
                     │   Domain   │
                     │ (Entities, │
                     │ Use Cases, │
                     │ Protocols) │
                     └────────────┘
```

### Module Responsibilities

1. **`Domain` (Pure Business Logic)**
   - No external dependencies; written in strict Swift 6 mode.
   - Contains core entities (`League`, `Event`, `Participant`, `SportType`, `Country`).
   - Declares repository interfaces (`LeagueRepository`, `EventRepository`, `TeamRepository`, `PlayerRepository`, `FavoriteRepository`).
   - Implements atomic use cases (`GetAllLeaguesUseCase`, `GetUpcomingEventsUseCase`, `GetLatestEventsUseCase`, `ToggleFavoriteUseCase`, etc.).
   - Defines domain-level errors (`DomainException`).

2. **`Data` (Data Orchestration & Caching)**
   - Depends on `Domain` and `Networking`.
   - Implements domain repository protocols (`LeagueRepositoryImpl`, `EventRepositoryImpl`, etc.).
   - Manages remote data sources (`LeagueRemoteDataSource`, `EventRemoteDataSource`) and local SwiftData storage (`LeagueLocalDataSource`, `EventLocalDataSource`, `FavoriteLocalDataSource`).
   - Implements a resilient **remote-first, cache-fallback** strategy: fetches fresh data over the network, writes payloads to SwiftData silently, and falls back to cached records when offline (`DomainException.noInternet`).
   - Maps DTOs to domain entities and SwiftData `@Model` classes (`LeagueCache`, `EventCache`, `ParticipantCache`, `FavoriteCache`).

3. **`Networking` (HTTP Abstraction)**
   - Encapsulates Alamofire behind `NetworkManagerProtocol` and `APIClient`.
   - Supports parameter serialization, multipart uploads, header generation, Bearer token interceptor hooks, and centralized HTTP status validation.
   - Converts raw responses and HTTP errors into typed `NetworkError` instances.

4. **`Presentation` (UI & User Interaction)**
   - Depends on `Domain`, `DesignSystem`, and `FactoryKit`. Does **not** import `Data`.
   - Follows the MVVM pattern with `@Observable` state holders subclassing `BaseViewModel<State>`.
   - Manages navigation through the **Hybrid Coordinator + Router** architecture.
   - Uses `TaskManager` to tie async task execution to ViewModel lifecycles, enabling task cancellation on screen exit (`onDisappear`).
   - String Catalog localization (`Localizable.xcstrings`) wrapped with typed keys (`L10n`).

5. **`DesignSystem` (Tokens & Reusable Components)**
   - Standalone design library depending only on Kingfisher.
   - Provides design tokens: `AppColors` (semantic light/dark mode assets), `AppSpacing`, `AppRadius`, and `AppIcons`.
   - Includes custom Poppins fonts loaded into the system runtime via `DesignSystemFontLoader` using CoreText.
   - Reusable components: `ParticipantCard`, `EventCard`, `LeagueCard`, `SportsCard`, `HorizontalCarousel`, `RemoteImage`, and `LayoutSegmentedControl`.

6. **`Sports` (App Target & Composition Root)**
   - Configures application bootstrap in `SportsApp.swift`.
   - Initializes `DesignSystemFontLoader.registerFonts()`.
   - Wires dependency injection containers using Factory extensions (`ContainerPresentation`, `ContainerDomain`, `ContainerData`).
   - Holds application-level assets, `Launch Screen.storyboard`, and `Secrets.xcconfig`.

---

## Key Implementation Highlights

### 1. Hybrid Router + Coordinator Navigation

Navigation in SwiftUI is decoupled from views using a custom coordination layer:
- **`Router`**: An `@Observable` navigation stack driver conforming to `RouterProtocol`. It controls an array of type-erased `AnyHashableView` values, exposing `push()`, `pop()`, `popToRoot()`, and `pop(to id:)`.
- **`Coordinator`**: Feature-level flow coordinators (`HomeCoordinator`, `FavoriteCoordinator`, `MainTabCoordinator`) conform to `Coordinator`. They handle view instantiation, delegate callbacks from ViewModels, and invoke `router.push(id:view:)`.
- **`CustomTabBar`**: A custom floating tab bar in `MainTabView` that automatically monitors navigation depth across active coordinators and hides itself whenever a child view is pushed onto the stack.

### 2. Structured Concurrency & Parallel Section Fetching

On the Events screen, `EventsViewModel` uses structured concurrency (`async let`) to fetch upcoming events, latest events, and participants concurrently:

```swift
async let upcoming = self.fetchOrEmpty {
    try await self.getUpcomingEventsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModel()
}
async let latest = self.fetchOrEmpty {
    try await self.getLatestEventsUseCase.execute(sportType: self.sportType, leagueId: self.leagueId).toUIModel()
}
async let participants = self.fetchOrEmpty {
    try await self.getParticipants()
}

let (upcomingResult, latestResult, participantsResult) = try await (upcoming, latest, participants)
```

The `fetchOrEmpty` helper catches `DomainException.noDataFound` per section, ensuring that an empty section (such as no upcoming matches scheduled) does not fail the entire screen.

### 3. Concurrency Protection & Task Lifecycle

The `TaskManager` class ensures thread-safe, cancellable asynchronous operations:
- Automatically cancels running tasks with matching IDs to prevent race conditions during rapid user input or reloads.
- Cancels all active tasks on `deinit` and when views dismiss via `viewModel.cancelAllTasks()`.

### 4. SwiftData Offline Caching Strategy

The data layer uses compound keys to ensure unique cache records without collisions across sports:
- **Leagues**: `cacheId = "\(id)-\(sport)"`
- **Participants**: `uniqueKey = "\(leagueId)-\(type.rawValue)-\(id)"`
- **Events**: Unique event key indexed by section (`upcoming` vs `latest`).

When fetching leagues or events:
1. `LeagueRepositoryImpl` attempts remote network retrieval via `LeagueRemoteDataSource`.
2. Upon success, payloads are persisted silently into SwiftData.
3. If the network call fails with `DomainException.noInternet`, the repository catches the error and serves locally cached records.

### 5. Optimistic UI Updates

Toggling favorite leagues updates the in-memory state immediately for instantaneous user feedback. If the underlying persistence or removal operation fails, the ViewModel automatically rolls the UI back to its previous state.

---

## Repository Structure

```
Sports App/
├── Sports.xcworkspace                  # Unified workspace linking app target and SPM packages
├── Sports/                             # Main application target
│   ├── Config/
│   │   └── Secrets.xcconfig            # API key definitions (ignored in production)
│   ├── Sports/
│   │   ├── SportsApp.swift             # App entry point & composition root
│   │   ├── DI/                         # Factory DI container registrations
│   │   │   ├── ContainerPresentation.swift
│   │   │   ├── ContainerDomain.swift
│   │   │   └── ContainerData.swift
│   │   └── SupportingFiles/            # Assets, Info.plist, Launch storyboard
├── Domain/                             # Pure business logic package (Swift 6)
│   └── Sources/Domain/
│       ├── Entity/                     # Domain models (League, Event, Participant, SportType)
│       ├── Repository/                 # Repository protocol interfaces
│       ├── UseCase/                    # Granular use cases
│       └── Exception/                  # DomainException error definitions
├── Data/                               # Data layer & caching package (Swift 6)
│   └── Sources/Data/
│       ├── Shared/Persistence/         # SwiftDataStack & ModelContainer setup
│       ├── League/                     # League repositories, DTOs, mappers, SwiftData models
│       ├── Event/                      # Event repositories, DTOs, mappers, SwiftData models
│       ├── Participant/                # Team & Player data sources and models
│       └── Favorite/                   # Local favorite persistence
├── Networking/                         # Networking engine package (Swift 6)
│   └── Sources/Networking/
│       ├── Core/                       # APIClient, NetworkManager, NetworkError
│       ├── Protocols/                  # NetworkManagerProtocol, TokenInterceptorProtocol
│       └── Request/                    # BaseRequest, multipart & parameter builders
├── Presentation/                       # Feature views, ViewModels, navigation (Swift 6)
│   └── Sources/Presentation/
│       ├── Navigation/                 # Router, RouterView, Coordinator, AnyHashableView
│       ├── Home/                       # HomeView, HomeViewModel, WaterfallGrid
│       ├── League/                     # LeaguesView, LeaguesViewModel, LeagueList
│       ├── Event/                      # EventsView, EventsViewModel, match carousels
│       ├── Favorite/                   # FavoriteView, FavoriteViewModel, sectioned lists
│       ├── TabBar/                     # Custom floating TabBar and coordinator
│       └── Resources/                  # Localizable.xcstrings String Catalog
├── DesignSystem/                       # Reusable UI package (Swift 6)
│   └── Sources/DesignSystem/
│       ├── Components/                 # Cards, Carousels, Segmented controls
│       ├── Typography/                 # Custom Poppins font loader & styles
│       ├── Colors/                     # Semantic light & dark mode tokens
│       └── Resources/                  # Bundled Poppins font files & assets
├── fastlane/                           # Fastlane build & CI automation
│   ├── Fastfile                        # Selective CI lanes & dependency graph detection
│   └── Appfile                         # App metadata
└── .github/workflows/
    └── ci.yml                          # GitHub Actions matrix CI workflow
```

---

## Getting Started

### Prerequisites

- **macOS Sonoma 14.5+** or **macOS Sequoia 15.0+**
- **Xcode 16.0+** (configured with Swift 6 compiler toolchain)
- **Ruby 3.3+** and **Bundler** (for Fastlane automation)
- An active API key from [AllSportsAPI](https://apiv2.allsportsapi.com/)

### Configuration

1. Clone the repository:
   ```bash
   git clone https://github.com/skaik-mo/Sports.git
   cd Sports
   ```

2. Configure your API key in `Sports/Config/Secrets.xcconfig`:
   ```xcconfig
   SPORTS_API_KEY = your_allsportsapi_key_here
   ```
   *Note: `APIConstants.swift` reads this key at runtime via `Bundle.main.object(forInfoDictionaryKey: "SPORTS_API_KEY")`.*

3. Install Ruby dependencies for Fastlane:
   ```bash
   bundle install
   ```

---

## Build & Run Instructions

### Building and Running in Xcode

1. Select the **Sports** scheme in the Xcode scheme selector.
2. Choose an iOS 17+ Simulator (e.g., iPhone 16 Pro or iPhone 17 Pro).
3. Press `Cmd + R` to build and launch the application.

### Building via Fastlane

```bash
# Build a specific module
bundle exec fastlane ios build_single_module module:Domain

# Build all modules
bundle exec fastlane ios build_modules

# Build the main application target
bundle exec fastlane ios build_main_app
```

---

## CI/CD Pipeline

The project includes an intelligent GitHub Actions workflow (`.github/workflows/ci.yml`) powered by Fastlane:

1. **Smart Module Detection**: On every pull request or push to `main`/`develop`, the `detect` job checks changed files against the target branch using `git diff`.
2. **Dependency-Aware Matrix**: Fastlane understands the dependency graph:
   - If `Domain` changes, dependent modules (`Data` and `Presentation`) are also compiled and verified.
   - If `DesignSystem` changes, `Presentation` is also compiled and verified.
   - If `Data` changes, `Data` is compiled and verified.
3. **Parallel Execution**: Each affected module runs as an isolated matrix job on `macos-15` runners.
4. **App Validation**: If all affected module jobs pass, the workflow completes with a full build of the `Sports` application scheme.

---

## Engineering Highlights & Technical Decisions

- **Modular Migration**: The project evolved from an initial monolithic structure into five decoupled SPM packages, improving build times, enforcing architectural boundaries, and preventing circular dependencies.
- **Strict Dependency Inversion**: `Presentation` has zero compile-time awareness of `Data` or `Networking`. Concrete repositories and data sources are injected exclusively at the Composition Root (`Sports/Sports/DI`).
- **Modern Observation**: Uses iOS 17's `@Observable` macro over `ObservableObject` and `@Published`, minimizing view invalidations and eliminating Combine boilerplate.
- **Polymorphic Participant Handling**: Because the API returns different schemas for individual sports vs team sports, the Domain layer models this through unified `Participant` entities and branches execution based on `SportType`.
- **String Catalog Localization**: Localized strings are managed centrally in `Localizable.xcstrings` within the Presentation package, exposed through compile-safe accessor types (`L10n`).

---

## Author

**Mohammed Skaik**  
- Email: [mohamedsaeb.skaik@gmail.com](mailto:mohamedsaeb.skaik@gmail.com)  
- GitHub: [@skaik-mo](https://github.com/skaik-mo)
