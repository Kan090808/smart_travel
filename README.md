# Smart Travel

Smart Travel is a Flutter application that helps users manage trips, explore maps, and translate text or speech using the Gemini API. The app is currently under development and provides basic placeholders for the main features.

## Features

- **Manage Trips**: Create, edit, and delete your trips. Trips can contain locations and transportation notes.
- **Maps**: Explore your current location or search for specific places using Google Maps. Locations can be saved or added to a trip.
- **Translate**: Translate text or speech using the Gemini API. Supports text input, text-to-speech, and speech-to-text.
- **AI Trip Planning**: Use audio or text commands to let the app automatically create a trip for you (placeholder implementation).

## Getting Started

1. Ensure you have Flutter installed.
2. Run `flutter pub get` to fetch dependencies.
3. Replace `YOUR_GEMINI_API_KEY` in `lib/services/gemini_service.dart` with your own key.
4. Run the app with `flutter run`.

## Project Structure

```
lib/
  main.dart                - Entry point with bottom navigation
  models/                  - Basic models for trips and locations
  screens/                 - UI pages for trips, map, and translation
  services/                - Placeholder services for maps, translation, and speech
```

This is an early prototype and many features are not fully implemented. Contributions are welcome!
