# GitHub Repository Explorer

A Flutter app to search and explore GitHub repositories with offline support.

## Features

- Search repositories by keyword
- Responsive UI with Material 3 design
- Light and dark theme support
- View repository details (stars, forks, language, topics)
- Offline caching with GetStorage
- Pull-to-refresh functionality
- Network connectivity checking

## Tech Stack

- **Framework:** Flutter 3.10+
- **State Management:** GetX
- **UI:** Material 3, ScreenUtil (responsive design)
- **API:** GitHub REST API
- **Storage:** GetStorage (offline caching)
- **HTTP Client:** http package
- **Network:** connectivity_plus

## Architecture

Clean architecture with repository pattern:
```
lib/
├── core/           # Utilities, themes, API services
├── data/           # Models, repositories, local storage
├── modules/        # Feature screens and widgets
└── controllers/    # GetX controllers
```

## Getting Started

1. **Clone the repository**
```bash
git clone <repository-url>
cd github_per
```

2. **Install dependencies**
```bash
flutter pub get
```

3. **Run the app**
```bash
flutter run
```

## Usage

1. Enter a keyword in the search bar
2. Browse search results
3. Tap on a repository to view details
4. Pull down to refresh results
5. Works offline with cached data
