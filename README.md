# RecipeApp

RecipeApp is a mobile application developed using Flutter that provides users with access to a collection of recipes. Users can explore various recipes, save their favorite ones, and even add custom recipes. The app offers a seamless user experience with features like integration with Google Maps for discovering nearby stores and restaurants.

## Screenshots

### ㅤㅤㅤㅤㅤHome Page: ㅤㅤㅤㅤㅤㅤㅤㅤFavorite Recipes Page: ㅤㅤㅤㅤㅤㅤCustom Recipes Page:
<div>
  <img src="https://github.com/DenisGrudin1n/RecipeMobileApp/assets/157652311/bfb744d1-4f14-45b0-9b60-33ee69aece0d" width="300" />ㅤ
  <img src="https://github.com/DenisGrudin1n/RecipeMobileApp/assets/157652311/370e8b26-a745-4bf0-90bd-8283c0498d4d" width="300" />ㅤ
  <img src="https://github.com/DenisGrudin1n/RecipeMobileApp/assets/157652311/871cfd89-11ec-4a8b-9357-3927b573ee6b" width="300" />ㅤ
</div>

### ㅤㅤㅤCustom Recipes Form: ㅤㅤㅤㅤㅤㅤGoogle Maps Page: ㅤㅤㅤㅤ ㅤㅤㅤㅤSettings Page:
<div>
  <img src="https://github.com/DenisGrudin1n/RecipeMobileApp/assets/157652311/f9a114e7-9c7f-4e02-9503-0ce0fa12510b" width="300" /> ㅤ
  <img src="https://github.com/DenisGrudin1n/RecipeMobileApp/assets/157652311/1f68c153-73ff-4a90-a28a-c472bd9661f9" width="300" />ㅤ
  <img src="https://github.com/DenisGrudin1n/RecipeMobileApp/assets/157652311/a10c94ab-1d61-4d5a-9ea9-25632e6cf2dc" width="300" />ㅤ
</div>

## Features

- Recipe Exploration: Users can browse through a collection of recipes, view details, and ingredients.
- Favorite Recipes: Users can save their favorite recipes for quick access.
- Custom Recipes: Users can add their own custom recipes to the app and see custom recipes of others.
- Nearby Stores and Restaurants: Users can see nearby stores and restautants at google maps integrated into the project
- Dark Mode Support: The app offers a dark mode for enhanced readability and reduced eye strain.

## Libraries & Tools

- [GetX](https://pub.dev/packages/get): For state management and navigation.
- [Firebase Core](https://firebase.google.com/docs/flutter/setup): For Firebase services initialization.
- [Firebase Authentication](https://firebase.google.com/docs/auth): For user authentication.
- [Firebase Firestore](https://firebase.google.com/docs/firestore): For real-time database to store recipes and favorites.
- [Firebase Storage](https://firebase.google.com/docs/storage): For storing recipe images and user avatars.
- [Google Maps Flutter](https://pub.dev/packages/google_maps_flutter): For integrating Google Maps into the application for location-based services.
- [Flutter Polyline Points](https://pub.dev/packages/flutter_polyline_points): For handling polylines on Google Maps.
- [Geolocator](https://pub.dev/packages/geolocator): For retrieving the user's current location.
- [Geocoding](https://pub.dev/packages/geocoding): For converting coordinates to addresses and vice versa.
- [Get Storage](https://pub.dev/packages/get_storage): For simple key-value storage in Flutter.
- [Shared Preferences](https://pub.dev/packages/shared_preferences): For persisting simple data locally on the device.
- [Flutter Hooks](https://pub.dev/packages/flutter_hooks): For using hooks-based state management in Flutter.
- [HTTP](https://pub.dev/packages/http): For making HTTP requests to fetch data from remote servers.
- [Flutter Screen Util](https://pub.dev/packages/flutter_screenutil): For responsive UI design across different screen sizes.
- [Google Fonts](https://pub.dev/packages/google_fonts): For accessing a variety of fonts provided by Google Fonts.
- [Flutter Vector Icons](https://pub.dev/packages/flutter_vector_icons): For using vector icons in the application.
- [Cached Network Image](https://pub.dev/packages/cached_network_image): For caching and displaying network images.
- [Flutter Rating Bar](https://pub.dev/packages/flutter_rating_bar): For displaying rating bars for recipe ratings.
- [Shimmer](https://pub.dev/packages/shimmer): For adding shimmering effect placeholders for loading content.
- [Glass](https://pub.dev/packages/glass): For creating glass-like UI effects.
- [Flutter SVG](https://pub.dev/packages/flutter_svg): For displaying SVG images in Flutter.
- [Lottie](https://pub.dev/packages/lottie): For integrating Lottie animations into the application.
- [Webview Flutter](https://pub.dev/packages/webview_flutter): For displaying web content within the application.
- [Device Preview](https://pub.dev/packages/device_preview): For previewing UI designs on different devices directly from the Flutter IDE.
- [OTP Text Field](https://pub.dev/packages/otp_text_field): For creating OTP input fields with validation.
- [Country Picker](https://pub.dev/packages/country_picker): For selecting countries from a predefined list.
- [Badges](https://pub.dev/packages/badges): For adding badges to indicate new or unread content.
- [JSON Annotation](https://pub.dev/packages/json_annotation): For JSON serialization and deserialization.
- [Image Picker](https://pub.dev/packages/image_picker): For picking images from the device's gallery.
- [Photo View](https://pub.dev/packages/photo_view): For displaying images with zooming functionality.
- [Flutter Settings Screen Ex](https://pub.dev/packages/flutter_settings_screen_ex): For creating settings screens with various UI components.

## Project Structure Overview

The project follows a MVC+S structure, organized into various directories:

### constants

The constants directory holds various constants used throughout the application, such as app themes, colors, fonts, API endpoints, and other configuration-related values:

- **constants.dart:** This file contains various constants used throughout the application, including white, light blue, and light purple for light mode, and black, dark blue, and dark purple for dark mode. It also defines constants for medium and bold font weights.
- **uidata.dart:** This file contains additional UI-related constants such as font sizes, padding values, and icon sizes.

### controllers

In the controllers directory, you'll find classes responsible for handling business logic related to specific features or functionalities of your application. These controllers often interact with services, models, and views to manage data flow and application behavior:

- **custom_recipe_controller.dart:** This controller manages operations related to custom recipes, such as adding, updating, and deleting recipes.
- **google_maps_controller.dart:** This controller handles interactions with Google Maps, including fetching nearby locations and displaying them on the map.
- **recipe_controller.dart:** This controller manages operations related to recipes, such as fetching recipes from the database and filtering recipes based on categories.
- **tab_index_controller.dart:** This controller manages the current tab index for navigation within the application.
- **theme_controller.dart:** This controller manages the theme state of the application, allowing users to toggle between light and dark modes.
- **user_controller.dart:** This controller handles user-related operations, such as authentication, user data management, and profile updates.

### models

The models directory contains data models used to represent entities within your application. These models typically define the structure of data fetched from APIs or stored locally, making it easier to work with data in a structured manner:

- **custom_recipe.dart:** This model represents a custom recipe entity, including attributes such as recipe name, ingredients, preparation steps, and image URL.
- **recipe.dart:** This model represents a recipe entity retrieved from the database, containing information such as recipe name, ingredients, preparation steps, and category.
- **user.dart:** This model represents a user entity, including attributes such as user ID, username, email, and profile image URL.

### services

Services in the services directory encapsulate functionality related to external services, such as Firebase services, API clients, database interactions, authentication, and more. They provide a clean abstraction layer for interacting with external dependencies:

- **auth_methods.dart:** This service handles user authentication methods, such as sign-in, sign-up, and sign-out using Firebase Authentication.
- **google_maps_services.dart:** This service provides methods for interacting with Google Maps API, including fetching nearby locations and calculating routes.

### themes

The themes directory houses theme-related configurations, such as light mode, dark mode, font styles, and other visual settings. Keeping theme-related code separate helps maintain a consistent look and feel across the application and facilitates easy theming adjustments:

- **themes.dart:** This file defines theme data for both light mode and dark mode. It includes colors such as background, primary, secondary, and tertiary colors, as well as primary and highlight colors. These theme data are used throughout the application to maintain consistent styling.

### views

Views in the views directory represent the various screens or pages of your application. Each view typically corresponds to a specific user interface and functionality, encapsulating the layout, widgets, and user interactions for that particular screen:

- **custom_recipes:**
  - **add_custom_recipe_form.dart:** This file contains the form for adding a custom recipe, including input fields for recipe name, ingredients, preparation steps, and image upload.
  - **add_custom_recipe_page.dart:** This file contains the page for adding a custom recipe, including the form for adding a new recipe.
- **favorite_recipes:**
  - **favorite_recipes_page.dart:** This file contains the page for displaying favorite recipes, including a list of recipes marked as favorites.
- **google_maps:**
  - **google_maps_page.dart:** This file contains the page for displaying Google Maps, including the map view and nearby locations.
- **home:**
  - **widgets:**
    - **appbar.dart:** This file contains the custom app bar used in the home screen, including navigation options and search functionality.
    - **category_list.dart:** This file contains the list of recipe categories displayed on the home screen.
    - **dailymeal.dart:** This file contains the widget for displaying the daily meal recommendation on the home screen.
  - **home_page.dart:** This file contains the home page of the application, including the app bar, recipe categories, and recommended daily meal.
- **login:**
  - **login_form.dart:** This file contains the login form, including input fields for email and password.
  - **login_page.dart:** This file contains the login page, including the login form and navigation options for signing up.
  - **signup_form.dart:** This file contains the signup form, including input fields for username, email, and password.
  - **signup_page.dart:** This file contains the signup page, including the signup form and navigation options for logging in.
- **profile:**
  - **profile_page.dart:** This file contains the user profile page, including user information and options for editing profile details.
- **settings:**
  - **settings_page.dart:** This file contains the settings page, including options for changing theme settings and logging out.
- **entrypoint.dart:** This file serves as the entry point for the application, initializing necessary dependencies and configurations.

### firebase_options.dart

This file contains configurations and options required for initializing Firebase services in your application, such as Firebase Core and Firestore.

### main.dart

The main.dart file serves as the entry point for your Flutter application. It initializes the app, configures routes, and sets up any required dependencies or configurations before running the app's main widget.


## Getting Started

To run the RecipeApp locally:

1. Clone this repository.
2. Navigate to the project directory.
3. Run `flutter pub get` to install dependencies.
4. Run the app using `flutter run`.

## Contributing

Contributions are welcome! Feel free to open issues or submit pull requests to improve the RecipeApp project.
