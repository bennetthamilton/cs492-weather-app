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

[insert video link]

---

## Technologies Used

- Flutter
- Dart
- Mobile emulators (Android/iOS)
- Pexels image library

---