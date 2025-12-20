# More Vocab 📚

A modern, gamified vocabulary learning application designed to help users master English vocabulary through interactive flashcards, quizzes, and daily challenges.

![Version](https://img.shields.io/badge/version-2.5-blue)
![License](https://img.shields.io/badge/license-MIT-green)

## ✨ Features

### 🎴 Learning Modes
- **Flashcard Mode** - Swipe-based learning with word definitions, synonyms, and examples
- **Quiz Mode** - Multiple choice questions to test your knowledge
- **Sentence Fill** - Context-based learning with fill-in-the-blank exercises
- **Speed Run** - 60-second timed challenge for quick learners

### 🎮 Gamification
- **XP & Leveling System** - Earn experience points and level up
- **Daily Goals** - Track your daily learning progress
- **Badges & Achievements** - Unlock rewards as you progress
- **Daily Streak** - Maintain your learning streak

### 🎨 Themes
- **Default** - Clean, modern design
- **Ocean** 🌊 - Cool blue tones with wave decorations
- **Forest** 🌿 - Natural green palette with vine decorations
- **Sunset** 🌅 - Warm orange hues with sunset graphics
- **Midnight** 🌙 - Deep purple tones with night sky elements

### 📱 Additional Features
- **Dark Mode** - Easy on the eyes for night studying
- **Card Decorations** - Theme-specific visual enhancements (can be toggled)
- **Sound Effects** - Audio feedback for actions
- **Text-to-Speech** - Hear word pronunciations
- **Favorites** - Save words for later review
- **Error Review** - Focus on words you've gotten wrong
- **Dictionary** - Browse and search all available words
- **Time Tracking** - Monitor your daily study time
- **PWA Support** - Install as a standalone app

## 🚀 Getting Started

### Prerequisites
- A modern web browser (Chrome, Safari, Firefox, Edge)
- No server required - runs completely in the browser

### Installation

1. Clone the repository:
```bash
git clone https://github.com/alpaydinmuammer/morevocab.git
cd morevocab
```

2. Open `index.html` in your browser, or serve with a local server:
```bash
# Using Python
python -m http.server 8000

# Using Node.js
npx serve
```

3. Visit `http://localhost:8000` in your browser

### PWA Installation
1. Open the app in Chrome/Safari
2. Click "Add to Home Screen" or the install button
3. Enjoy the app as a standalone application

## 📁 Project Structure

```
morevocab+/
├── index.html          # Main HTML structure
├── style.css           # All styles and themes
├── app.js              # Main application logic
├── config.js           # Configuration and constants
├── levels.js           # Word database (A1-C2, YKS, YDS)
├── manifest.json       # PWA manifest
├── sw.js               # Service worker for offline support
├── app_icon.jpg        # Application icon
├── themes/             # Theme-specific assets
│   ├── ocean/
│   ├── forest/
│   ├── sunset/
│   └── midnight/
└── voices/             # Sound effect files
```

## 🎯 Word Levels

- **A1-A2** - Beginner vocabulary
- **B1-B2** - Intermediate vocabulary  
- **C1-C2** - Advanced vocabulary
- **YKS DİL** - Turkish university entrance exam prep
- **YDS** - Academic English exam prep

## 💾 Data Storage

All user progress is stored locally using `localStorage`:
- Learned words
- Favorite words
- Error cards
- XP and level
- Daily goals
- Theme preferences
- Time statistics

## 🛠️ Technologies

- **HTML5** - Semantic markup
- **CSS3** - Modern styling with CSS variables, flexbox, and grid
- **Vanilla JavaScript** - No frameworks, pure JS
- **Web Audio API** - Sound effects
- **Web Speech API** - Text-to-speech
- **LocalStorage** - Data persistence
- **Service Workers** - Offline support

## 📝 License

This project is licensed under the MIT License.

## 👤 Author

**Muammer Alpaydın**
- Email: alpaydinmuammer@gmail.com

---

*Stop Guessing, Start Knowing.* 🎯
