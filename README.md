# Sprints Shopping App with Firebase Authentication

A shopping app with Firebase authentication, localization, and animations.

## App Demo Video 🎥

[Watch the firebase auth demo video here]()

## Screenshots

| Login      | Signup      |
| ---------- | ----------- |
| ![Login]() | ![Signup]() |

## Features

- **Firebase Authentication**: The app supports user authentication using Firebase.
- **Localization**: The app supports English and Arabic languages.
- **Animations**: The app includes animations for a better user experience.

## Packages Used

- **[cached_network_image](https://pub.dev/packages/cached_network_image)**: For efficient image loading and caching.
- **[another_flushbar](https://pub.dev/packages/another_flushbar)**: For displaying beautiful and customizable in-app notifications.
- **[flutter_bloc](https://pub.dev/packages/flutter_bloc)**: For state management using the BLoC pattern.
- **[flutter_screenutil](https://pub.dev/packages/flutter_screenutil)**: For adapting screen and font size to different screen sizes.
- **[flutter_secure_storage](https://pub.dev/packages/flutter_secure_storage)**: For storing data securely.
- **[firebase_core](https://pub.dev/packages/firebase_core)**: For Firebase core functionalities.
- **[firebase_auth](https://pub.dev/packages/firebase_auth)**: For Firebase authentication.
- **[lottie](https://pub.dev/packages/lottie)**: For Lottie animations.
- **[cupertino_icons](https://pub.dev/packages/cupertino_icons)**: For iOS style icons.
- **[dio](https://pub.dev/packages/dio)**: For networking.
- **[retrofit](https://pub.dev/packages/retrofit)**: For type-safe HTTP client.
- **[pretty_dio_logger](https://pub.dev/packages/pretty_dio_logger)**: For logging network requests.
- **[shared_preferences](https://pub.dev/packages/shared_preferences)**: For local storage.
- **[flutter_native_splash](https://pub.dev/packages/flutter_native_splash)**: For splash screen.
- **[flutter_svg](https://pub.dev/packages/flutter_svg)**: For SVG support.
- **[json_serializable](https://pub.dev/packages/json_serializable)**: For JSON serialization.
- **[json_annotation](https://pub.dev/packages/json_annotation)**: For JSON annotations.
- **[get_it](https://pub.dev/packages/get_it)**: For dependency injection.
- **[freezed](https://pub.dev/packages/freezed)**: For code generation.
- **[freezed_annotation](https://pub.dev/packages/freezed_annotation)**: For annotations used with Freezed.
- **[page_transition](https://pub.dev/packages/page_transition)**: For page transition animations.
- **[intl](https://pub.dev/packages/intl)**: For internationalization and localization.

## Getting Started

To get started with this project, follow these steps:

1. **Clone the repository**:
   ```sh
   git clone https://github.com/OmarAmeer96/Sprints-Firebase-Auth-Task.git
   ```
2. **Navigate to the project directory**:
   ```sh
   cd Sprints-Firebase-Auth-Task
   ```
3. **Install dependencies**:
   ```sh
   flutter pub get
   ```
4. **Run the app**:
   ```sh
   flutter run
   ```

## Project Structure

- **lib/main.dart**: The entry point of the application.
- **lib/features/home/ui.dart**: The home screen of the application.
- **lib/features/home/logic/**: Contains the BLoC logic for the home screen.
- **lib/features/home/data.dart**: Contains the data models and repos for the home screen.
- **lib/features/signin/ui.dart**: The sign-in screen of the application.
- **lib/features/signin/logic/**: Contains the BLoC logic for the sign-in screen.
- **lib/features/signin/data.dart**: Contains the data models and repos for the sign-in screen.
- **lib/features/signup/ui.dart**: The sign-up screen of the application.
- **lib/features/signup/logic/**: Contains the BLoC logic for the sign-up screen.
- **lib/features/signup/data.dart**: Contains the data models and repos for the sign-up screen.
