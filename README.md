# The Tiny Toes

Welcome to **The Tiny Toes**, an imaginary baby gallery app built with Flutter. This project is organized into a structured layout, utilizes local storage and network services, and implements state management for smooth navigation across various pages.

## Table of Contents
- [Project Structure](#project-structure)
- [Setup and Installation](#setup-and-installation)
- [Services Implemented](#services-implemented)
- [State Management](#state-management)
- [App Features](#app-features)
  - [Login](#login)
  - [User Session Management](#user-session-management)
  - [User Page](#user-page)
  - [Album Page](#album-page)
  - [Gallery Page](#gallery-page)
  - [Photo View](#photo-view)
- [Shared Navbar](#shared-navbar)
- [Dependencies](#dependencies)
- [Flutter Versions](#flutter-versions)
- [Contact](#contact)

## Project Structure

1. **Root Folder**: `the-tiny-toes`
2. **Subfolders**:
   - `apps/`: Contains the Flutter project files.
   - `services/`: Manages local storage and network operations.
   - `providers/`: Stores the state management logic.
   - `pages/`: Separate directories for Login, User, Album, Gallery, and View Photo pages.

## Setup and Installation

1. **Upgrade Flutter** to version 3 or above if necessary.
2. **Initialize Flutter Project**:
   - Inside the `apps/` folder, create a Flutter project with the app's name.
3. **Specify Versions** in `pubspec.yaml`:
   - Flutter, Dart, and Java versions used in this project are specified for compatibility.

## Services Implemented

1. **Storage Service**:
   - Uses `shared_preferences` for local storage to save login information.
   - Stores username upon successful login to enable automatic redirection.

2. **Network Service**:
   - Utilizes HTTP REST APIs to fetch data from JSONPlaceholder API for users, albums, and photos.
   - Refer to [Fetch Data](https://docs.flutter.dev/cookbook/networking/fetch-data) for more.

## State Management

This app uses the `Provider` package with `MultiProvider` to efficiently manage the app’s state. Each page is connected to a relevant provider for data retrieval and state management. Refer to [Provider Documentation](https://docs.flutter.dev/data-and-backend/state-mgmt/simple) for more details.

## App Features

### Login

- **Design**: Simple login form with username, password, and a login button.
- **Authentication**: Hardcoded username and password in the provider.
- **Validation**: Validates user input against hardcoded values.
  - Redirects to the Users page on success.
  - Shows an error message on failure.

### User Session Management

- **Persistent Login**: Stores username in local storage upon successful login.
- **Auto-Login**: Checks storage upon app open; redirects to Users page if username exists.
- **Logout**: Clears stored username and redirects back to the login page.

### User Page

- **Design**: Displays a list of users fetched from JSONPlaceholder API.
- **Network States**: Shows loading, success, and failure states.
- **Provider Integration**: Data is fetched through the provider and displayed on the Users page.

### Album Page

- **Design**: Displays a list of albums, showing each album's title and thumbnail.
- **Network Integration**: Fetches albums for the selected user.
- **Provider Connection**: Fetches data from the provider, handling network states for loading, success, and failure.

### Gallery Page

- **Design**: Displays photos from a selected album in a grid layout.
- **Data Fetching**: Photos are fetched from the network service.
- **Network States**: Manages loading, success, and failure states through provider integration.

### Photo View

- **Feature**: On photo selection, expands to show the photo and its details.

## Shared Navbar

Each page has a shared navigation bar with the following features:
- **Logged-in Username Display**
- **Back Button**: Navigates to the previous page.
- **Logout Button**: Clears stored session and redirects to login.

## Dependencies

Here are the core dependencies used in this project:

- **shared_preferences**: For local storage management.
- **provider**: For state management.
- **http**: For network service and API requests.

## Flutter Versions

- **Flutter**: Version 3.0+
- **Dart**: Version (specified in `pubspec.yaml`)
- **Java**: Version (specified in `pubspec.yaml`)

## Contact

For any questions or suggestions, please contact us at [nidarshanauthpala90@gmail.com].




