//
//  README.md
//  KidsTTT
//
//  Created by Harpreet Singh on 2/27/25
//

# Kids Tic Tac Toe

A modern, engaging Tic Tac Toe game built with SwiftUI, designed specifically for kids with colorful themes and interactive gameplay.

## Features

- 🎮 Interactive gameplay with smooth animations
- 🎨 Multiple color themes to choose from
- 👥 Two-player mode with customizable player names
- 🏆 Score tracking and winning streak system
- 🌓 Supports both light and dark mode
- 📱 Responsive design (supports both portrait and landscape)
- 🎉 Engaging victory celebrations and animations

## Game Rules

1. Players take turns placing their symbols (X or O) on the board
2. First player to get 3 symbols in a row (horizontal, vertical, or diagonal) wins
3. Players need to achieve a winning streak to become the champion
4. Game tracks remaining chances based on the winning streak target

## Technical Details

### Architecture
- Built with SwiftUI
- MVVM architecture pattern
- Follows Apple's Human Interface Guidelines
- Modular component-based design

### Key Components

#### Views
- `GameView`: Main game board and gameplay interface
- `PlayerSetupView`: Player name and theme selection
- `PlayerTurnIndicatorView`: Shows current player and scores
- `GameTitleView`: Displays game title with theme-based styling
- `PlayerScoreView`: Shows player information and score
- `PlayAgainButtonView`: Reset game functionality
- `ChancesCounterView`: Displays remaining chances
- `VSeparatorView`: Visual separator between players
- `BackButtonView`: Navigation control

#### Models
- `GameState`: Manages game logic and state
- `Player`: Player information and symbols
- `GameTheme`: Theme colors and configurations
- `GameLogic`: Core game rules and win conditions

#### Constants
- `StringConstants`: Centralized string management
- Consistent styling with custom fonts and colors

### Requirements

- iOS 15.0+
- Xcode 13.0+
- Swift 5.5+

### Design Features

- Gradient-based color themes
- Dynamic animations for user interactions
- Responsive layout for different screen sizes
- Accessibility support
- Dark mode compatibility
- Custom fonts and styling

### Game Features

- Player name customization
- Multiple theme options
- Score tracking system
- Winning streak mechanic
- Champion recognition
- Draw detection
- Reset functionality

## Installation

1. Clone the repository
2. Open KidsTTT.xcodeproj in Xcode
3. Build and run the project

## Customization

- Multiple theme options with different color schemes
- Customizable player names
- Adjustable winning streak requirement
- Visual feedback for player turns
- Animated transitions and effects

## Future Enhancements

- Online multiplayer support
- Additional themes and animations
- Achievement system
- Game statistics and history
- AI opponent for single-player mode
- Sound effects and background music
- Tutorial mode for new players
- Localization support

## Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## Credits

Created by Harpreet Singh on 2/27/25

## License

This project is licensed under the MIT License - see the LICENSE file for details

## Support

For support, please open an issue in the repository or contact the developer.

---

Made with ❤️ using SwiftUI
