# README.md
# ClubDeLucha

A SwiftUI-based iOS application for managing BJJ training sessions, fights, and club memberships.

## Requirements

- iOS 17.0+
- Xcode 15.0+
- Swift 5.9+

## Installation

1. Clone the repository
```bash
git clone https://github.com/yourusername/ClubDeLucha.git
cd ClubDeLucha
```

2. Open the project in Xcode
```bash
open ClubDeLucha.xcodeproj
```

3. Build and run

## Architecture

The app follows MVVM-C (Model-View-ViewModel-Coordinator) architecture:

- `Views/`: SwiftUI views
- `ViewModels/`: Business logic and state management
- `Models/`: Data models
- `Services/`: Network and local services
- `Coordinators/`: Navigation management

## Features

- QR code-based entry system
- Training schedule management
- Fight tracking
- Profile management
- Push notifications
- Settings and preferences

## Testing

Run the tests in Xcode:
```bash
CMD + U
```

## License

MIT License. See LICENSE for details.
