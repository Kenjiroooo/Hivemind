# 🐝 Hivemind

<div align="center">

![Hivemind Banner](https://img.shields.io/badge/Flutter-02569B?style=for-the-badge&logo=flutter&logoColor=white)
![Dart](https://img.shields.io/badge/Dart-0175C2?style=for-the-badge&logo=dart&logoColor=white)
![Riverpod](https://img.shields.io/badge/State_Management-Riverpod-blueviolet?style=for-the-badge)
![License](https://img.shields.io/badge/License-MIT-green.style=for-the-badge)

**A modern, gamified academic community platform connecting students through Q&A, subject resources, AI-powered summaries, and peer reputation.**

[Features](#-key-features) • [Tech Stack](#-tech-stack) • [Architecture](#-architecture) • [Getting Started](#-getting-started) • [Project Structure](#-project-structure)

</div>

---

## 🌟 Overview

**Hivemind** is designed to empower university students by blending collaborative academic discussions with engaging gamification and AI tools. Whether you're searching for past engineering exam solutions, asking coding questions, sharing curated course notes, or climbing the campus leaderboard, Hivemind makes academic collaboration seamless, intuitive, and modern.

---

## ✨ Key Features

### 🚀 1. Dynamic Feed & Subject Discovery
- **Personalized "For You" Feed:** Tailored discussion streams matching your enrolled courses and interests.
- **Subject Filtering:** Instant categorization across disciplines like Computer Engineering (CPE), Software Development, Electronics, Mathematics, and more.
- **Trending & Explore:** Discover high-impact questions and trending academic threads across the entire university.

### ❓ 2. Rich Q&A System
- **Interactive Voting & Resolution:** Upvote helpful questions/answers and mark verified solutions.
- **Drafting & Markdown:** Ask questions with full formatting support, code blocks, and topic tags.
- **Question Details & Threading:** Nested responses with timestamps, author badges, and verification status.

### 🤖 3. AI-Powered Assistant & Summaries
- **Instant AI Breakdown:** Integrated smart summary cards summarizing lengthy discussions and complex explanations in seconds using formatted markdown.

### 🏆 4. Gamification & Student Profiles
- **XP & Level Progression:** Earn experience points by asking insightful questions and providing accepted answers.
- **Dynamic Badges:** Unlock achievements (e.g., *Top Contributor*, *Bug Hunter*, *Math Wizard*).
- **Campus Leaderboard:** Compete with peers for campus-wide reputation rankings.

### 📚 5. Resource Hub & Communities
- **Organized Study Material:** Share, filter, and access study notes, cheatsheets, and past papers.
- **Course Communities:** Dedicated hubs for cohort-specific announcements and group discussions.

### 📱 6. Responsive & Modern Glassmorphic UI
- **Cross-Platform Adaptive Layout:** Seamless transition between desktop sidebar navigation and mobile floating navigation.
- **Modern Design System:** Powered by `Google Fonts` (Plus Jakarta Sans & Inter), vibrant electric gradients, smooth hover states, and fluid micro-animations via `flutter_animate`.

---

## 🛠 Tech Stack

| Category | Technology |
| :--- | :--- |
| **Framework** | [Flutter](https://flutter.dev/) (Web, Desktop, Android, iOS) |
| **Language** | [Dart](https://dart.dev/) |
| **State Management** | [Flutter Riverpod](https://riverpod.dev/) (`riverpod_generator`, `riverpod_annotation`) |
| **Routing** | [GoRouter](https://pub.dev/packages/go_router) with custom animated page transitions |
| **Data & Models** | [Freezed](https://pub.dev/packages/freezed), [json_serializable](https://pub.dev/packages/json_serializable) |
| **Typography & Styling** | [Google Fonts](https://pub.dev/packages/google_fonts) (Plus Jakarta Sans, Inter) |
| **Animations** | [flutter_animate](https://pub.dev/packages/flutter_animate) |
| **Markdown** | [flutter_markdown](https://pub.dev/packages/flutter_markdown) |
| **Backend Integration** | Firebase Ready (Auth, Firestore, Cloud Functions) |

---

## 📂 Project Structure

```
lib/
├── core/
│   ├── theme/          # App colors, typography, radius, spacing, and ThemeData
│   └── widgets/        # Shared UI components (TopAppBar, Sidebar, BottomNav, QuestionCard, Avatars)
├── features/
│   ├── auth/           # Authentication (Login, Register, User model, AuthService)
│   ├── feed/           # Home & Explore feed screens, Question domain models, Feed service
│   ├── qa/             # Ask question flow, Detail view, Answer cards, AI Summary widgets
│   ├── resources/      # Resource repository, Resource hub & detail screens
│   ├── communities/    # Subject community hub and channel views
│   ├── profile/        # Gamified Profile screen, XP progress, Badges, Leaderboard
│   └── notifications/  # Notifications center and mock real-time alerts
├── routing/            # GoRouter configuration with ShellRoute and transition builders
└── main.dart           # App entry point and ProviderScope setup
```

---

## 🚀 Getting Started

### Prerequisites
- [Flutter SDK](https://docs.flutter.dev/get-started/install) (Version `>=3.3.0`)
- Dart SDK `>=3.3.0 <4.0.0`
- Chrome (for web development) or an iOS/Android emulator

### Installation & Run

1. **Clone the repository:**
   ```bash
   git clone https://github.com/Kenjiroooo/Hivemind.git
   cd Hivemind/hivemind
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Generate code (Freezed / Riverpod / JSON serialization):**
   ```bash
   dart run build_runner build --delete-conflicting-outputs
   ```

4. **Launch the application:**
   - For **Chrome (Web)**:
     ```bash
     flutter run -d chrome
     ```
   - For **Windows Desktop**:
     ```bash
     flutter run -d windows
     ```
   - For **Mobile Emulator**:
     ```bash
     flutter run
     ```

---

## 🧪 Testing & Code Quality

Run static analysis to ensure code quality:
```bash
flutter analyze
```

Run test suite:
```bash
flutter test
```

---

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.
