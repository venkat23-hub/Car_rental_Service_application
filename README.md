# Car Rental App

## Overview

This Flutter app allows users to browse available cars, filter them based on various criteria, and book cars. The app uses local dummy data to simulate a car rental service, without relying on Firebase or other external databases.

## Features

- Browse a list of available cars
- Search for cars by make, model, and other criteria
- Filter cars by rental rate and availability
- View car details and make bookings

## Project Structure

- **`lib/`**: Contains all Dart code for the Flutter application.
  - **`models/`**: Contains data models for the app.
    - `car.dart`: Defines the `Car` model.
    - `booking.dart`: Defines the `Booking` model.
  - **`services/`**: Contains service classes for managing data.
    - `car_service.dart`: Manages car data and booking updates.
  - **`screens/`**: Contains all screen widgets.
    - `home_screen.dart`: Displays the list of available cars and handles navigation to booking details.
    - `search_screen.dart`: Allows users to search and filter cars.
    - `display_car_screen.dart`: Shows a list of available cars.
    - `booking_screen_user.dart`: Displays car details and handles the booking process.
  - **`data/`**: Contains dummy data for cars and bookings.
    - `dummy_cars.dart`: Provides a list of dummy cars.
    - `dummy_bookings.dart`: Provides a list of dummy bookings.

## Setup

### Prerequisites

- Flutter SDK: [Install Flutter](https://flutter.dev/docs/get-started/install)
- Dart SDK: Included with Flutter

### Installation

1. Clone the repository:

   ```sh
   git clone <repository-url>
   cd <project-directory>
