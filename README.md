# Habit Tracker App 🎯

A modern, beautifully designed habit tracking application with an Opal-inspired UI/UX, featuring gamification elements, achievements, and smooth animations.

## ✨ Features

### Core Functionality
- 📝 Create and manage multiple habits
- ✅ Track daily habit completions
- 📊 View detailed statistics and progress
- 🔥 Maintain streaks for consistency
- 🏆 Unlock achievements as you progress
- ⭐ XP and leveling system

### UI/UX Highlights
- 🎨 **Opal-Inspired Design**: Deep navy backgrounds with soft, muted colors
- 🌈 **Beautiful Gradients**: Smooth color transitions throughout the app
- ✨ **Glassmorphism**: Semi-transparent cards with subtle blur effects
- 🎭 **Smooth Animations**: Micro-interactions and transitions
- 📱 **Fully Responsive**: Adapts to different screen sizes
- 💫 **Haptic Feedback**: Tactile responses on interactions

### Gamification
- 🎯 **Level System**: Progress from level 1 with XP rewards
- 🏅 **Achievements**: 17 unique achievements with beautiful emoji icons
  - 🔥 Streak achievements
  - ⭐ Completion milestones
  - 🚀 Habit creation rewards
  - 👑 Level achievements
- 🎉 **Confetti Celebrations**: Celebrate perfect days
- 💬 **Motivational Quotes**: Daily inspiration

### Interactive Elements
- 👆 **Clickable Progress**: Tap to view detailed breakdowns
- 📊 **Level Details**: Interactive level progression modal
- 📈 **Profile Stats**: Comprehensive statistics view
- 🎪 **Achievement Details**: Bottom sheet modals for each achievement

## 🎨 Design Philosophy

Inspired by the Opal app, this habit tracker features:

- **Color Palette**:
  - Background: Deep Navy (#0D1321)
  - Cards: Semi-transparent (#1A1F35)
  - Accent: Soft Purple (#8B7CF6)
  - Secondary: Muted Pink (#E879A9)
  - Success: Soft Teal (#4FD1C5)
  - Text: Off-white (#F7FAFC)

- **Typography**: Clean, generous spacing with Google Fonts (Poppins)
- **Spacing**: Consistent 20-24px padding with 16px gaps
- **Border Radius**: Rounded corners at 20-24px
- **Shadows**: Subtle depth with soft shadows

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (3.10.1 or higher)
- Dart SDK
- iOS/Android development tools

### Installation

1. Clone the repository:
```bash
git clone https://github.com/medaziztounsi2004/habit-tracker-app.git
cd habit-tracker-app
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

## 📦 Dependencies

Key packages used:
- `provider`: State management
- `hive`: Local database
- `google_fonts`: Custom typography
- `flutter_animate`: Smooth animations
- `confetti_widget`: Celebration effects
- `glassmorphism`: Glass effect containers
- `fl_chart`: Charts and graphs
- `iconsax`: Beautiful icons

## 🏗️ Architecture

```
lib/
├── core/
│   ├── constants/     # App-wide constants
│   ├── theme/         # Theme configuration
│   └── utils/         # Helper utilities
├── data/
│   ├── models/        # Data models
│   ├── repositories/  # Data access layer
│   └── services/      # External services
├── presentation/
│   ├── screens/       # App screens
│   └── widgets/       # Reusable widgets
└── providers/         # State management
```

## 📱 Screens

1. **Home Screen**: Profile header, daily habits, progress tracking
2. **Achievements Screen**: Grid of unlocked/locked achievements
3. **Statistics Screen**: Detailed analytics and charts
4. **Settings Screen**: User profile and app preferences

## 🎯 Achievements

The app includes 17 achievements across 4 categories:

### 🔥 Streaks
- 7-Day Streak
- 30-Day Streak
- 100-Day Streak

### ⭐ Completions
- First Step (1 completion)
- Getting Started (10 completions)
- Habit Builder (50 completions)
- Habit Master (100 completions)
- Legendary (500 completions)

### 🚀 Habits
- First Habit
- Habit Collector (5 habits)
- Habit Enthusiast (10 habits)

### 🏆 Milestones
- Perfect Day
- Week Warrior
- Monthly Master
- Level 5, 10, and 25

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

## 📄 License

This project is licensed under the MIT License.

## 👨‍💻 Author

Created with ❤️ by [medaziztounsi2004](https://github.com/medaziztounsi2004)
