# Rysync - Dating & Relationship App

<div align="center">
  <h3>Find Your Perfect Match with AI-Powered Dating</h3>
  <p><em>"Where Hearts Sync"</em></p>
</div>

## 🌟 Features

### Core Functionality
- **User Authentication**: Google Sign-In and email registration
- **Profile Management**: Complete profile setup with photos, interests, and relationship preferences
- **Location-Based Matching**: Find potential matches near you
- **Relationship Expectations**: Set clear relationship goals (temporary, serious, marriage, etc.)
- **AI Dating Assistant**: Personalized dating advice and suggestions
- **Real-time Chat**: Message with matches
- **Swipe Interface**: Tinder-like card swiping for browsing profiles

### AI Assistant Features
- **Date Suggestions**: Get personalized date ideas based on preferences and occasion
- **Conversation Starters**: AI-generated conversation topics
- **Relationship Advice**: Get help with dating questions and decisions
- **Location Recommendations**: Discover popular spots in your city
- **Profile Insights**: Get suggestions to improve your profile

### Relationship Types Supported
- Temporary Companion
- Casual Dating
- Serious Relationship
- Marriage
- Friendship
- Companionship

## 🎨 Design

### Color Scheme
- **Primary Pink**: #E91E63
- **Purple**: #9C27B0
- **Light Pink**: #F8BBD9
- **White**: #FFFFFF
- **Dark Mode**: Fully supported

### Themes
- Light theme with pink and white aesthetics
- Dark theme for nighttime use
- Automatic theme switching based on system preferences

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (latest version)
- Dart SDK
- Android Studio / VS Code
- Firebase account (for backend services)

### Installation

1. **Install dependencies**
   ```bash
   flutter pub get
   ```

2. **Enable Developer Mode (Windows)**
   - Run `start ms-settings:developers` in cmd/PowerShell
   - Enable Developer Mode to support symlinks

3. **Run the app**
   ```bash
   flutter run
   ```

## 📱 Supported Platforms

- ✅ Android
- ✅ iOS
- ✅ Windows (with Developer Mode enabled)
- ✅ macOS
- ✅ Linux
- ✅ Web

## 🏗️ Architecture

```
lib/
├── core/
│   └── theme/
│       └── app_theme.dart          # App theming and colors
├── models/
│   └── user_model.dart             # User data model
├── services/
│   ├── auth_service.dart           # Authentication logic
│   └── ai_assistant_service.dart   # AI dating assistant
├── screens/
│   ├── splash_screen.dart          # App splash screen
│   └── auth/
│       ├── welcome_screen.dart     # Welcome/onboarding
│       ├── login_screen.dart       # Sign in
│       └── register_screen.dart    # Sign up
└── main.dart                       # App entry point
```

## 🔮 Future Features

### Planned Features
- **Video Calls**: In-app video calling with matches
- **Events**: Local dating events and meetups
- **Compatibility Score**: AI-powered compatibility analysis
- **Advanced Filters**: Height, education, lifestyle preferences
- **Safety Features**: Background checks and verification
- **Premium Features**: Unlimited likes, super likes, profile boosting

### AI Assistant Enhancements
- **Real-time Coaching**: Live dating advice during conversations
- **Mood Analysis**: Analyze conversation tone and suggest responses
- **Date Planning**: Complete date planning from start to finish
- **Relationship Coaching**: Long-term relationship guidance

---

<div align="center">
  <p>Made with ❤️ for meaningful connections</p>
  <p><strong>Rysync - Where Hearts Sync</strong></p>
</div>
