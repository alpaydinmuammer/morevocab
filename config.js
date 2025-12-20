// --- OYUN KONFIGURASYONU (GAME CONFIG) ---

// 1. XP ve Ödül Sistemi
const XP_REWARDS = {
    correctAnswer: 15,    // Flashcard doğru cevap
    wordMastered: 5,      // Kelime öğrenildiyse ekstra
    quizComplete: 15,     // Bir quiz sorusu (veya quiz bitimi?) -> Kodda soru başına çağrılıyor
    speedRunBonus: 10,    // Speed mode doğru cevap
    streakBonus: 25,      // Günlük streak devamı
    goalComplete: 150     // Günlük hedef tamamlanınca
};

const DAILY_TARGETS = {
    words: 10,     // Öğrenilecek kelime sayısı
    quiz: 5,       // Çözülecek quiz sayısı
    correct: 20    // Toplam doğru cevap sayısı
};

// 2. Seviye Sistemi Unvanları (Level Titles)
const LEVEL_TITLES = [
    "Beginner", "Novice", "Apprentice", "Learner", "Student",
    "Scholar", "Adept", "Expert", "Specialist", "Professional",
    "Veteran", "Master", "Grandmaster", "Champion", "Legend",
    "Mythic", "Divine", "Immortal", "Transcendent", "Ultimate",
    "Sage", "Oracle", "Titan", "Demigod", "Deity",
    "Celestial", "Cosmic", "Ethereal", "Infinite", "Absolute",
    "Supreme", "Omega", "Prime", "Paramount", "Apex",
    "Zenith", "Pinnacle", "Sovereign", "Emperor", "Monarch",
    "Overlord", "Archmage", "Almighty", "Omniscient", "Eternal",
    "Universal", "Galactic", "Stellar", "Astral", "GODLIKE"
];

// 3. Rozet Sistemi (Achievements)
const BADGES = [
    // Word Mastery Achievements
    { id: 'w1', name: 'First Steps', type: 'words', count: 10, icon: '🌱', desc: 'Master 10 words' },
    { id: 'w2', name: 'Word Explorer', type: 'words', count: 25, icon: '🔍', desc: 'Master 25 words' },
    { id: 'w3', name: 'Vocabulary Builder', type: 'words', count: 50, icon: '📚', desc: 'Master 50 words' },
    { id: 'w4', name: 'Word Collector', type: 'words', count: 100, icon: '🎯', desc: 'Master 100 words' },
    { id: 'w5', name: 'Language Enthusiast', type: 'words', count: 200, icon: '🔥', desc: 'Master 200 words' },
    { id: 'w6', name: 'Word Master', type: 'words', count: 350, icon: '🏆', desc: 'Master 350 words' },
    { id: 'w7', name: 'Vocabulary Expert', type: 'words', count: 500, icon: '⭐', desc: 'Master 500 words' },
    { id: 'w8', name: 'Lexicon Legend', type: 'words', count: 750, icon: '👑', desc: 'Master 750 words' },
    { id: 'w9', name: 'Dictionary Master', type: 'words', count: 1000, icon: '🎓', desc: 'Master 1000 words' },

    // Speed Run Achievements
    { id: 's1', name: 'Speed Starter', type: 'score', count: 50, icon: '⚡', desc: 'Reach 50 Speed Score' },
    { id: 's2', name: 'Quick Thinker', type: 'score', count: 150, icon: '🚀', desc: 'Reach 150 Speed Score' },
    { id: 's3', name: 'Speed Demon', type: 'score', count: 300, icon: '💨', desc: 'Reach 300 Speed Score' },
    { id: 's4', name: 'Lightning Fast', type: 'score', count: 500, icon: '⏱️', desc: 'Reach 500 Speed Score' },
    { id: 's5', name: 'Time Lord', type: 'score', count: 1000, icon: '🌟', desc: 'Reach 1000 Speed Score' },

    // Level Achievements
    { id: 'l1', name: 'Rising Star', type: 'level', count: 5, icon: '✨', desc: 'Reach level 5' },
    { id: 'l2', name: 'Dedicated Learner', type: 'level', count: 10, icon: '📖', desc: 'Reach level 10' },
    { id: 'l3', name: 'Knowledge Seeker', type: 'level', count: 20, icon: '🧠', desc: 'Reach level 20' },
    { id: 'l4', name: 'Elite Scholar', type: 'level', count: 30, icon: '💎', desc: 'Reach level 30' },
    { id: 'l5', name: 'Grandmaster', type: 'level', count: 50, icon: '🏅', desc: 'Reach level 50' },

    // Quiz Mode Achievements
    { id: 'q1', name: 'Quiz Rookie', type: 'quiz', count: 10, icon: '❓', desc: '10 correct quiz answers' },
    { id: 'q2', name: 'Quiz Pro', type: 'quiz', count: 50, icon: '🧩', desc: '50 correct quiz answers' },
    { id: 'q3', name: 'Quiz Champion', type: 'quiz', count: 100, icon: '🎮', desc: '100 correct quiz answers' },
    { id: 'q4', name: 'Quiz Master', type: 'quiz', count: 250, icon: '🎪', desc: '250 correct quiz answers' },

    // Sentence Mode Achievements
    { id: 'c1', name: 'Context Beginner', type: 'sentence', count: 10, icon: '📝', desc: '10 correct sentence answers' },
    { id: 'c2', name: 'Context Builder', type: 'sentence', count: 50, icon: '✍️', desc: '50 correct sentence answers' },
    { id: 'c3', name: 'Context Expert', type: 'sentence', count: 100, icon: '📜', desc: '100 correct sentence answers' },
    { id: 'c4', name: 'Context Master', type: 'sentence', count: 250, icon: '🖋️', desc: '250 correct sentence answers' },

    // Streak Achievements
    { id: 'st1', name: '7 Day Warrior', type: 'streak', count: 7, icon: '🔥', desc: 'Maintain a 7-day streak' },
    { id: 'st2', name: 'Monthly Master', type: 'streak', count: 30, icon: '💪', desc: 'Maintain a 30-day streak' },
    { id: 'st3', name: 'Century Champion', type: 'streak', count: 100, icon: '👑', desc: 'Maintain a 100-day streak' }
];

// 4. Motivasyon Sözleri
const MOTIVATION_QUOTES = [
    "Knowledge of languages is the doorway to wisdom.",
    "A different language is a different vision of life.",
    "The limits of my language mean the limits of my world.",
    "To possess another language is to possess a second soul.",
    "Language is the road map of a culture. It tells you where its people come from and where they are going.",
    "Those who know nothing of foreign languages know nothing of their own.",
    "You can never understand one language until you understand at least two."
];

// 5. Avatar Koleksiyonu (Avatar Collection)
const AVATAR_COLLECTION = [
    { char: '🧑‍🎓', level: 1, name: 'Student' },
    { char: '🌱', level: 1, name: 'Novice' },
    { char: '🐛', level: 2, name: 'Larva' },
    { char: '🐥', level: 3, name: 'Hatchling' },
    { char: '🦋', level: 5, name: 'Butterfly' },
    { char: '🦊', level: 7, name: 'Fox' },
    { char: '🦉', level: 10, name: 'Wise Owl' },
    { char: '🦁', level: 12, name: 'Lion' },
    { char: '🐯', level: 15, name: 'Tiger' },
    { char: '🐲', level: 20, name: 'Dragon' },
    { char: '🧙‍♂️', level: 25, name: 'Wizard' },
    { char: '🥷', level: 30, name: 'Ninja' },
    { char: '🤖', level: 35, name: 'Cyborg' },
    { char: '👽', level: 40, name: 'Alien' },
    { char: '🦸', level: 45, name: 'Hero' },
    { char: '👑', level: 50, name: 'King/Queen' }
];

// 6. Animation Timing (ms)
const ANIMATION_TIMING = {
    cardSwipe: 700,          // Card swipe out animation
    cardFlip: 500,           // Card flip animation
    modalTransition: 300,    // Modal open/close
    toastDuration: 3500,     // Toast notification display time
    splashMinimum: 8500,     // Minimum splash screen display time
    buttonCooldown: 700      // Button spam prevention cooldown
};

// 7. Splash Screen Settings
const SPLASH_CONFIG = {
    skipIfWithinHours: 4,    // Skip splash if visited within X hours
    skipIfSameDay: true      // Skip splash on same day visit
};

// 8. Swipe Configuration
const SWIPE_CONFIG = {
    threshold: 100,          // Minimum swipe distance (px)
    velocityThreshold: 0.5   // Minimum velocity (px/ms)
};

// 9. Card History Settings
const HISTORY_CONFIG = {
    maxSize: 50              // Maximum cards to keep in history
};
