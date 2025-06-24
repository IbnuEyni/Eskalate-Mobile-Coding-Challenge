# 🌍 Flutter Countries App

A Flutter application for exploring independent countries, viewing their details, and managing a list of favorite countries.  
This app fetches country data from the [REST Countries API](https://restcountries.com) and uses **BLoC** for state management with **shared_preferences** for local persistence.

## 📋 Table of Contents
- [Features](#features)
- [API Used](#api-used)
- [State Management](#state-management)
- [Local Storage](#local-storage)
- [Installation](#installation)
- [Usage](#usage)
- [Dependencies](#dependencies)


## ✨ Features
- **View All Countries**: Browse a list of independent countries with their flags, names, and populations.
- **Search Functionality**: Search for countries by name.
- **Country Details Page**: Tap any country to view area, population, region, subregion, and timezones.
- **Favorites Management**: Mark/unmark countries as favorites from the list or detail view.
- **Favorites Page**: Dedicated tab for all favorited countries.
- **Responsive UI**: Works well on various screen sizes.
- **Dynamic Flag Display**: Supports both SVG URLs and emoji flags.

## 🌐 API Used
Country data is fetched from:

[https://restcountries.com/v3.1/independent?status=true\&fields=name,population,flag,area,region,subregion,timezones](https://restcountries.com/v3.1/independent?status=true&fields=name,population,flag,area,region,subregion,timezones)

## 🧠 State Management
Uses the **BLoC (Business Logic Component)** pattern for predictable and testable state management—especially for favorite countries.

## 💾 Local Storage
Uses **shared_preferences** to persist favorites locally across app restarts.


## 🛠️ Installation

1. **Clone the repository** (or download the code):
   ```bash
   git clone [repository_url]
   cd [project_folder_name]


2. **Install dependencies**:

   flutter pub get
   

3. **Run the app**:

   flutter run
   

> Replace `[repository_url]` and `[project_folder_name]` with your actual GitHub details.

## 🚀 Usage

* **Browse Countries**: Starts on the “Countries” tab with a grid of countries.
* **Search**: Filter countries using the top search bar.
* **View Details**: Tap a country card to see detailed info.
* **Manage Favorites**:

  * Tap the 🖤 icon on any country card.
  * Filled heart = favorited, outlined = not favorited.
* **View Favorites**: Go to the "Favorites" tab via bottom navigation.

## 📦 Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  flutter_bloc: ^8.1.3
  shared_preferences: ^2.2.2
  http: ^1.1.0
  cupertino_icons: ^1.0.2
```

* **flutter\_bloc**: For BLoC state management.
* **shared\_preferences**: For local storage.
* **http**: For making API requests.

```

Let me know if you want a GitHub-flavored version (with badges, screenshots, etc.) or a version suitable for publishing on pub.dev.
```
