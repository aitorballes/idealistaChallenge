# Idealista Technical Challenge

![UIKit](https://img.shields.io/badge/UIKit-%23007AFF.svg?style=for-the-badge&logo=apple&logoColor=white)
![Swift](https://img.shields.io/badge/Swift-%23FA7343.svg?style=for-the-badge&logo=swift&logoColor=white)
![XCTest](https://img.shields.io/badge/XCTest-%23323330.svg?style=for-the-badge&logo=apple&logoColor=white)

An iOS application built with UIKit and MVVM architecture as a technical test for Idealista, the leading real estate portal. The app demonstrates advanced UIKit development, robust architecture, and integration of modern Swift features.

## Features

- **Property Listings:** Browse a dynamic list of real estate ads with images, title, price, and property details.
- **Favorites:** Mark/unmark properties as favorites. The date when a property was favorited appears next to the title.
- **Pull-to-Refresh:** Instantly refresh the listings with a swipe gesture.
- **Detail View:** Tap a property to see full details, including:
  - A SwiftUI-based image detail view for a modern, interactive experience.
  - A map displaying the location of the property for better context.
- **SF Symbols:** Uses SF Symbols for clear and modern UI icons.
- **Responsive UI:** Programmatic Auto Layout for a clean and adaptive interface.

## Architecture & Patterns

- **MVVM:** Clean separation of concerns between Views, ViewModels, and Models for maintainability and scalability.
- **Interactor Layer:** Handles all API requests and response decoding, ensuring a clear separation between networking and presentation logic.
- **UIKit & SwiftUI:** Main UI built in UIKit; selected views (like the image detail) leverage SwiftUI for enhanced user experience.
- **Unit Testing:** Business logic and networking are covered by unit tests using XCTest.

## Persistence

For data persistence, the app uses **UserDefaults** to store user preferences such as favorites. For a larger-scale application, I would opt for **CoreData** due to its robustness and scalability. In this case, **SwiftData** was not an option because it requires iOS 17 as a minimum, while the technical test specified a minimum deployment target of iOS 16.

## Project Structure

    
    IdealistaTest/
    ├── Models/ # Data models and DTOs
    ├── ViewModels/ # MVVM view models
    ├── Interface/ # Interactor API calls and response decoding
    ├── Repositories/ # Network and persitance respository
    ├── Views/ # UIKit views and controllers
    └── Tests/ # XCTest unit tests
    


## Getting Started

### Prerequisites

- Xcode 15 or later
- iOS 17 or later
- Swift 5.9

### Installation

1. **Clone the repository:**

    ```bash
    git clone https://github.com/aitorballes/idealistaChallenge.git
    cd IdealistaTechTest
    ```

2. **Open in Xcode**:

   ```bash
   open IdealistaTechTest.xcodeproj
   ```

## Testing

Run the unit tests in Xcode (`⌘U`) to verify models, repositories, and view models are working as expected.

**Author:** Aitor Ballesteros  
**Contact:** aitorballesteros@gmail.com


