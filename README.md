# News App

A Flutter application that displays news articles with optimized image handling and caching.

## Features

- Splash screen with 1-second delay
- News listing in a grid layout with optimized image loading
- Detailed view with pinch-to-zoom image viewing
- BLoC architecture for state management
- Image caching for better performance
- Memory optimizations for handling large datasets
- Unit tests and widget tests
- Beautiful loading animations with shimmer effects

## Getting Started

1. Clone the repository
2. Set up your API key:
   - Go to https://api.thenewsapi.com/ and sign up for an API key
   - Copy `.env.template` to `.env`
   - Replace `YOUR_API_KEY_HERE` with your actual API key
3. Run `flutter pub get` to install dependencies
4. Run `flutter run` to start the app

## API Key Setup

The app uses TheNewsAPI to fetch news data. To get started:

1. Visit https://api.thenewsapi.com/ and create an account
2. Get your API key from the dashboard
3. Copy `.env.template` to `.env`
4. Replace `YOUR_API_KEY_HERE` with your actual API key

Note: Never commit your actual API key to version control. The `.env` file is already in `.gitignore`.

## Architecture

The app follows the BLoC (Business Logic Component) pattern for state management:

- **Models**: Data classes representing the news articles
- **Repository**: Handles data fetching and caching
- **BLoC**: Manages the state and business logic
- **Screens**: UI components
- **Widgets**: Reusable UI components

## Image Optimization

The app implements several optimizations for handling images:

- Memory caching with size limits
- Disk caching with size limits
- Lazy loading of images
- Image resizing for thumbnails
- Efficient grid layout with viewport-based rendering

## Testing

Run the tests using:

```bash
flutter test
```

The app includes:
- Unit tests for the NewsBloc
- Widget tests for the ListingScreen

## Dependencies

- flutter_bloc: State management
- cached_network_image: Image caching
- photo_view: Pinch-to-zoom functionality
- shared_preferences: Local storage
- http: API calls
- equatable: Value equality
- mockito: Testing
- flutter_dotenv: Environment variable management
- shimmer: Loading animations

## Performance Considerations

- Images are cached both in memory and on disk
- Grid view uses lazy loading
- Images are resized for thumbnails
- Efficient state management with BLoC
- Proper error handling and fallbacks
