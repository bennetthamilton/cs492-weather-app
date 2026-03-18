# Weather App (Flutter)

## Overview

This application is a cross-platform mobile weather app built using Flutter.

The app allows users to:
- View current weather conditions
- Retrieve weather data dynamically
- Interact with a responsive and modern mobile interface

The application is structured using Flutter’s widget-based architecture and is intended to run on both Android and iOS devices.

---

## Deployment Instructions

### 1. Install Flutter

Follow the official Flutter installation guide for your operating system:

https://docs.flutter.dev/get-started/install

After installation, verify everything is set up correctly:

```bash
flutter doctor
```

Once all checks are passing move on to the next step.

### 2. Install Tools

You will also need:
- VS Code
- Flutter and Dart extensions
- An emulator OR a physical device

Follow the Flutter setup guide for VS Code:

https://docs.flutter.dev/tools/vs-code

### 3. Clone the Repository

Clone GitHub repository using these terminal commands:

```bash
git clone https://github.com/YOUR_USERNAME/cs492-weather-app.git
cd cs492-weather-app
```

### 4. Install Dependancies

Run the following command inside the project directory:

```bash
flutter pub get
```

This app currently uses Pexels image library. You will need to set up a free account in order to access your own API key:

https://www.pexels.com/

Once you have your API key, create a `.env` file in the root directory and insert the following:

```env
PEXELS_API_KEY=your_api_key_here
```

#### Notes

- Do **not** commit your `.env` file to GitHub
- Ensure `.env` is listed in `.gitignore`

### 5. Select a Device

In VS Code, choose a device from the bottom-right corner. (Should appear as "No Device" or an automatically selected simulator/emulator).

Then, select a mobile device from the dropdown. You may need to set up a simulator on your computer for it to show up. There are many tutorials online on how to do this based on what platform (Windows, MacOS), environment (VSCode, Android Studio), and emulator (Android, iOS) you are trying to run. 

Once you have a simulator running, move onto the next step.

### Run the Application

Start the app with: 

```bash
flutter run
```

The app should now build and launch on your selected device.

---

## Demonstration Video

[![Watch the demo](https://img.youtube.com/vi/v2ENtjBdm4U/0.jpg)](https://youtu.be/v2ENtjBdm4U)

---

## Technologies Used

- Flutter
- Dart
- Mobile emulators (Android/iOS)
- Pexels image library

---
## Changelog

**UI Enhancements**
- Implemented dynamic image retrieval using the Pexels API:
  - Images now reflect **location, time of day, and forecast conditions**
  - Added **randomization** for more visual variety
- Introduced a **new color palette** and updated app branding
- Simplified layout into a **single scrollable screen** for improved usability
- Moved theme toggle to the bottom of the page to reduce visual clutter
- Removed tab-based navigation to keep focus on the core weather experience
- Added **responsive layouts**:
  - Landscape mode reorganizes forecast components for better readability
  - Widgets dynamically resize across different screen sizes
- Improved detailed forecast layout to prioritize key information:
  - Forecast name, city, icon, date, and temperature

**User Experience Improvements**
- Removed redundant controls:
  - Eliminated "Set Location" and "Clear" buttons
- Improved location handling:
  - Automatically sets location after permissions are granted
  - Redirects users to system settings if permissions were previously denied

---

### Refactoring & Technical Improvements

- Centralized theming via `theme_provider.dart`
- Removed unused file: `location_provider_json.dart`
- Reorganized project structure for better clarity and scalability
- Renamed files for improved readability outside of folder context
- Enabled deployment and testing on a **physical iOS device**
- Updated and improved project documentation (`README.md`)

---

## Future Work

- Adjust detailed forecast widget to include date and update overall layout
- Automatically remove duplicate locations
- Display forecasts of selected date hour-by-hour
- Toggle temperature unit scale (Fahrenheit vs Celsius)
- Display temperature highs and lows
- Include additional metrics (perciptation, humidity, air quality, etc)
- Create custom weather icons, logos, brand name, etc.