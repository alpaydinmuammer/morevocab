// --- GLOBAL DEĞİŞKENLER ---
let currentCard = null;
let nextCard = null;
let learnedCards = [];
let favCards = [];
let errorCards = [];
let earnedBadges = [];
let cardPool = [];
let isDarkMode = false;
let activeMode = 'flashcard';
let isFilterFav = false;
let isFilterError = false;
let isErrorReviewMode = false;

// SWIPE (KAYDIRMA) DEĞİŞKENLERİ
let startX = 0;
let isDragging = false;
const swipeThreshold = 100;

// GEÇMİŞ YÖNETİMİ (Quiz ve Sentence için)
let cardHistory = [];
let historyIndex = -1;
let maxHistorySize = 50;

// STREAK & SES & DİĞERLERİ
let streakCount = 0;
let lastStreakDate = "";
let availableVoices = [];

// SPEED RUN DEĞİŞKENLERİ
let speedScore = 0;
let speedTime = 60;
let speedInterval = null;
let speedHighScore = 0;
let totalSpeedScore = 0;

// --- LEVEL SYSTEM ---
let userXP = 0;
let userLevel = 1;
const MAX_LEVEL = 50;

// Belirli bir level için gereken XP'yi hesapla (dinamik artış)
// Level 2: 200, Level 5: 500, Level 10: 1000, Level 14: 1400, Level 50: 5000
function getXPForLevel(level) {
    return level * 100;
}

const XP_REWARDS = {
    correctAnswer: 10,
    wordMastered: 25,
    quizComplete: 15,
    speedRunBonus: 5,
    streakBonus: 20,
    goalComplete: 100
};

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

// --- DAILY GOALS ---
let dailyGoals = {
    wordsLearned: 0,
    quizCompleted: 0,
    correctAnswers: 0
};
const DAILY_TARGETS = {
    words: 10,
    quiz: 5,
    correct: 20
};
let lastGoalDate = "";

// --- SOUND SYSTEM (Web Audio API) ---
let soundEnabled = true;
let audioContext = null;

// --- THEME SYSTEM ---
let currentTheme = "default";

// PERFORMANS OPTİMİZASYONU - Debounce fonksiyonu
function debounce(func, wait) {
    let timeout;
    return function executedFunction(...args) {
        const later = () => {
            clearTimeout(timeout);
            func(...args);
        };
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
    };
}

// ROZET LİSTESİ
const BADGES = [
    { id: 'b1', name: 'Newbie', type: 'words', count: 10, icon: '👶' },
    { id: 'b2', name: 'Student', type: 'words', count: 50, icon: '🤓' },
    { id: 'b3', name: 'Scholar', type: 'words', count: 100, icon: '🎓' },
    { id: 'b4', name: 'Wizard', type: 'words', count: 250, icon: '🧙‍♂️' },
    { id: 'b5', name: 'King of YDS', type: 'words', count: 500, icon: '👑' },
    { id: 'b6', name: 'Legend', type: 'words', count: 1000, icon: '🚀' },
    { id: 's1', name: 'Quick Starter', type: 'score', count: 100, icon: '🥉' },
    { id: 's2', name: 'Speed Racer', type: 'score', count: 200, icon: '🥈' },
    { id: 's3', name: 'Velocity Guru', type: 'score', count: 300, icon: '🥇' },
    { id: 's4', name: 'Time Lord', type: 'score', count: 500, icon: '⏱️' }
];

// DOM ELEMENTLERİ
const els = {
    // Menü
    mainMenu: document.getElementById('mainMenu'),
    gameInterface: document.getElementById('gameInterface'),
    btnStartGame: document.getElementById('btnStartGame'),
    btnOpenOptions: document.getElementById('btnOpenOptions'),
    btnOpenCredits: document.getElementById('btnOpenCredits'),

    // Header Butonları
    btnHeaderOptions: document.getElementById('btnHeaderOptions'),

    // Modallar
    menuOptionsModal: document.getElementById('menuOptionsModal'),
    creditsModal: document.getElementById('creditsModal'),
    closeMenuOptions: document.getElementById('closeMenuOptions'),
    closeCredits: document.getElementById('closeCredits'),

    // Ayarlar İçeriği
    menuReturnHome: document.getElementById('menuReturnHome'),
    menuThemeToggleCheckbox: document.getElementById('menuThemeToggleCheckbox'),
    menuResetBtn: document.getElementById('menuResetBtn'),

    // Oyun Modu Konteynerleri
    flashcardMode: document.getElementById('flashcardMode'),
    quizMode: document.getElementById('quizMode'),
    sentenceMode: document.getElementById('sentenceMode'),
    speedMode: document.getElementById('speedMode'),

    // Flashcard Elementleri
    card: document.getElementById('cardElement'),
    en: document.getElementById('wordEnglish'),
    def: document.getElementById('wordDefinition'),
    syn: document.getElementById('wordSynonym'),
    ex: document.getElementById('wordExample'),
    id: document.getElementById('wordId'),

    // İstatistikler
    total: document.getElementById('totalWords'),
    learned: document.getElementById('learnedWords'),
    progressBar: document.getElementById('progressBar'),
    streakBox: document.getElementById('streakBox'),
    streakCount: document.getElementById('streakCount'),

    // Kontrol Butonları
    btnFail: document.getElementById('btnFail'),
    btnPass: document.getElementById('btnPass'),
    btnSpeak: document.getElementById('btnSpeak'),
    favBtn: document.getElementById('favBtn'),
    modeToggle: document.getElementById('modeToggle'),
    badgeToggle: document.getElementById('badgeToggle'),
    errorModeBtn: document.getElementById('errorModeBtn'),
    errorCount: document.getElementById('errorCount'),

    // Quiz Modu Elementleri
    quizWord: document.getElementById('quizWord'),
    quizDef: document.getElementById('quizDefinition'),
    quizOptions: document.getElementById('quizOptions'),
    quizSpeak: document.getElementById('quizSpeak'),
    quizFavBtn: document.getElementById('quizFavBtn'),

    // Sentence Modu Elementleri
    sentenceText: document.getElementById('sentenceText'),
    sentenceOptions: document.getElementById('sentenceOptions'),
    sentFavBtn: document.getElementById('sentFavBtn'),

    // Navigasyon
    quizNavControls: document.getElementById('quizNavControls'),
    prevBtnQuiz: document.getElementById('prevBtnQuiz'),
    nextBtnQuiz: document.getElementById('nextBtnQuiz'),
    sentNavControls: document.getElementById('sentNavControls'),
    prevBtnSent: document.getElementById('prevBtnSent'),
    nextBtnSent: document.getElementById('nextBtnSent'),

    // Speed Run Elementleri
    speedStartScreen: document.getElementById('speedStartScreen'),
    startSpeedBtn: document.getElementById('startSpeedBtn'),
    speedTimer: document.getElementById('speedTimer'),
    speedScore: document.getElementById('speedScore'),
    highScoreDisplay: document.getElementById('highScoreDisplay'),
    speedWord: document.getElementById('speedWord'),
    speedOptions: document.getElementById('speedOptions'),
    exitSpeedMode: document.getElementById('exitSpeedMode'),

    // Sözlük ve Rozetler
    dictToggle: document.getElementById('dictToggle'),
    dictModal: document.getElementById('dictionaryModal'),
    badgeModal: document.getElementById('badgeModal'),
    closeDict: document.getElementById('closeDict'),
    closeBadge: document.getElementById('closeBadge'),
    searchInput: document.getElementById('searchInput'),
    wordList: document.getElementById('wordList'),
    badgeList: document.getElementById('badgeList'),
    filterFavs: document.getElementById('filterFavs'),
    filterErrors: document.getElementById('filterErrors'),

    // Bildirim
    toast: document.getElementById('toast'),
    toastMessage: document.getElementById('toastMessage'),

    // Level System
    levelDisplay: document.getElementById('levelDisplay'),
    levelNumber: document.getElementById('levelNumber'),
    levelTitle: document.getElementById('levelTitle'),
    xpBar: document.getElementById('xpBar'),
    xpText: document.getElementById('xpText'),

    // Daily Goals
    goalsToggle: document.getElementById('goalsToggle'),
    goalsModal: document.getElementById('goalsModal'),
    closeGoals: document.getElementById('closeGoals'),
    goalRing: document.getElementById('goalRing'),

    // Theme Selector
    themeSelector: document.getElementById('themeSelector'),

    // Sound Toggle
    menuSoundToggle: document.getElementById('menuSoundToggle')
};

let nextCardEl = null;

// --- BAŞLANGIÇ (INIT) ---
function init() {
    loadData();
    preloadVoices();

    // 1. Ana Menü Butonları
    els.btnStartGame.addEventListener('click', startGame);

    // Options Modal (Ana Menüden)
    els.btnOpenOptions.addEventListener('click', () => {
        els.menuOptionsModal.classList.remove('hidden');
    });

    // Options Modal (Header'dan - Oyun içinden)
    if (els.btnHeaderOptions) {
        els.btnHeaderOptions.addEventListener('click', () => {
            els.menuOptionsModal.classList.remove('hidden');
        });
    }

    // Mobile Options Button
    const btnHeaderOptionsMobile = document.getElementById('btnHeaderOptionsMobile');
    if (btnHeaderOptionsMobile) {
        btnHeaderOptionsMobile.addEventListener('click', () => {
            els.menuOptionsModal.classList.remove('hidden');
        });
    }

    // Mobile Badges Button
    const badgeToggleMobile = document.getElementById('badgeToggleMobile');
    if (badgeToggleMobile) {
        badgeToggleMobile.addEventListener('click', () => {
            els.badgeModal.classList.remove('hidden');
            renderBadges();
        });
    }

    // Mobile Dictionary Button  
    const dictToggleMobile = document.getElementById('dictToggleMobile');
    if (dictToggleMobile) {
        dictToggleMobile.addEventListener('click', () => openDict());
    }

    // Modalı Kapatma
    els.closeMenuOptions.addEventListener('click', () => {
        els.menuOptionsModal.classList.add('hidden');
    });

    // Credits Modal
    els.btnOpenCredits.addEventListener('click', () => els.creditsModal.classList.remove('hidden'));
    els.closeCredits.addEventListener('click', () => els.creditsModal.classList.add('hidden'));

    // 2. Ayarlar (Options) İçindeki İşlevler
    // Dark Mode Toggle
    if (els.menuThemeToggleCheckbox) {
        els.menuThemeToggleCheckbox.addEventListener('change', toggleTheme);
    }

    // Reset Butonu
    els.menuResetBtn.addEventListener('click', resetAll);

    // Ana Menüye Dön Butonu
    if (els.menuReturnHome) {
        els.menuReturnHome.addEventListener('click', () => {
            els.menuOptionsModal.classList.add('hidden');
            returnToMenu();
        });
    }

    // 3. Modal Dışına Tıklayınca Kapatma
    window.addEventListener('click', (e) => {
        if (e.target === els.menuOptionsModal) els.menuOptionsModal.classList.add('hidden');
        if (e.target === els.creditsModal) els.creditsModal.classList.add('hidden');
        if (e.target === els.badgeModal) els.badgeModal.classList.add('hidden');
        if (e.target === els.dictModal) els.dictModal.classList.add('hidden');
        if (e.target === els.goalsModal) els.goalsModal.classList.add('hidden');
    });

    // 4. Goals Modal
    if (els.goalsToggle) {
        els.goalsToggle.addEventListener('click', openGoalsModal);
    }
    if (els.closeGoals) {
        els.closeGoals.addEventListener('click', () => els.goalsModal.classList.add('hidden'));
    }

    // 5. Theme Selector
    if (els.themeSelector) {
        els.themeSelector.addEventListener('change', (e) => setColorTheme(e.target.value));
    }

    // 6. Sound Toggle
    if (els.menuSoundToggle) {
        els.menuSoundToggle.addEventListener('change', toggleSound);
    }
}

function startGame() {
    els.mainMenu.classList.add('hidden');
    els.gameInterface.classList.remove('hidden');

    // Eğer oyun ilk kez başlıyorsa veya kart yoksa başlat
    if (!currentCard) {
        createNextCardPreview();
        setupGameEventListeners(); // Oyun içi eventleri sadece oyun başlayınca ekle
        pickNewCard();
    }
}

function returnToMenu() {
    els.gameInterface.classList.add('hidden');
    els.mainMenu.classList.remove('hidden');
}

function createNextCardPreview() {
    if (nextCardEl) return;

    nextCardEl = document.createElement('div');
    nextCardEl.className = 'next-card-preview';
    nextCardEl.innerHTML = `
        <div class="card-header">
            <span class="word-id" id="nextWordId">#--</span>
            <button class="fav-btn"><i class="far fa-star"></i></button>
        </div>
        <h1 id="nextWordEnglish">Loading...</h1>
        <button class="speak-btn"><i class="fas fa-volume-up"></i></button>
        <p class="tap-hint">TAP TO FLIP</p>
    `;

    // YENİ KART YAPISI İÇİN DÜZELTME
    // Kartı sarmalayan wrapper içine ekliyoruz ki üst üste binsinler
    const cardStackWrapper = document.querySelector('.card-stack-wrapper');
    if (cardStackWrapper) {
        cardStackWrapper.insertBefore(nextCardEl, els.card);
    } else {
        // Eski yapı için güvenlik önlemi
        els.card.parentElement.insertBefore(nextCardEl, els.card);
    }

    // Ana kartın ipucunu güncelle
    const mainCardHint = els.card.querySelector('.tap-hint');
    if (mainCardHint) mainCardHint.textContent = "TAP TO FLIP";
}

function setupGameEventListeners() {
    // Sadece bir kere listener eklemek için kontrol
    if (els.card.getAttribute('data-listeners-added')) return;
    els.card.setAttribute('data-listeners-added', 'true');

    // Flashcard Butonları
    els.btnFail.addEventListener('click', () => handleAnswer(false));
    els.btnPass.addEventListener('click', () => handleAnswer(true));
    els.card.addEventListener('click', (e) => {
        if (!e.target.closest('button')) els.card.classList.toggle('flipped');
    });

    // Ses ve Favori Butonları
    els.btnSpeak.addEventListener('click', (e) => { e.stopPropagation(); speak(currentCard.word); });
    els.quizSpeak.addEventListener('click', () => speak(currentCard.word));
    els.favBtn.addEventListener('click', (e) => { e.stopPropagation(); toggleFav(); });
    els.quizFavBtn.addEventListener('click', toggleFav);
    els.sentFavBtn.addEventListener('click', toggleFav);

    // Mod Değiştirme
    els.modeToggle.addEventListener('click', toggleMode);

    // Modal Açma Butonları (Oyun İçi)
    els.dictToggle.addEventListener('click', openDict);
    els.badgeToggle.addEventListener('click', openBadges);
    els.errorModeBtn.addEventListener('click', () => toggleErrorReviewMode(false));

    // Modal Kapatma Butonları
    els.closeDict.addEventListener('click', () => els.dictModal.classList.add('hidden'));
    els.closeBadge.addEventListener('click', () => els.badgeModal.classList.add('hidden'));

    // Sözlük Arama ve Filtreleme (Debounced)
    const debouncedRenderDict = debounce(renderDict, 150);
    els.searchInput.addEventListener('input', debouncedRenderDict);
    els.filterFavs.addEventListener('click', () => {
        isFilterFav = !isFilterFav;
        els.filterFavs.classList.toggle('active-fav', isFilterFav);
        renderDict();
    });
    els.filterErrors.addEventListener('click', () => {
        isFilterError = !isFilterError;
        els.filterErrors.classList.toggle('active-error', isFilterError);
        renderDict();
    });

    // Speed Run Kontrolleri
    els.startSpeedBtn.addEventListener('click', startSpeedRun);
    els.exitSpeedMode.addEventListener('click', exitSpeedGame);

    // Navigasyon Kontrolleri (Quiz & Sentence)
    els.prevBtnQuiz.addEventListener('click', () => navigateHistory('prev'));
    els.nextBtnQuiz.addEventListener('click', () => navigateHistory('next'));
    els.prevBtnSent.addEventListener('click', () => navigateHistory('prev'));
    els.nextBtnSent.addEventListener('click', () => navigateHistory('next'));

    // Swipe (Dokunmatik) Kontrolleri - Passive listeners for better performance
    if ('ontouchstart' in window) {
        els.card.addEventListener('touchstart', touchStart, { passive: true });
        els.card.addEventListener('touchmove', touchMove, { passive: false });
        els.card.addEventListener('touchend', touchEnd, { passive: true });
    }

    // Klavye Kısayolları
    document.addEventListener('keydown', (e) => {
        // Menüdeyken veya modal açıkken tuşları dinleme
        if (!els.mainMenu.classList.contains('hidden')) return;
        if (!els.menuOptionsModal.classList.contains('hidden')) return;

        // Arama kutusundaysan kısayolları iptal et
        if (document.activeElement === els.searchInput) {
            if (e.key === 'Escape') els.dictModal.classList.add('hidden');
            return;
        }

        if (e.code === 'Space' && activeMode === 'flashcard') {
            e.preventDefault();
            els.card.classList.toggle('flipped');
        }
        else if (e.key === 'ArrowRight') {
            if (activeMode === 'flashcard') handleAnswer(true);
            else if (activeMode === 'quiz' || activeMode === 'sentence') navigateHistory('next');
        }
        else if (e.key === 'ArrowLeft') {
            if (activeMode === 'flashcard') handleAnswer(false);
            else if (activeMode === 'quiz' || activeMode === 'sentence') navigateHistory('prev');
        }
        else if (e.key === 'ArrowDown') {
            e.preventDefault();
            speak(currentCard.word);
        }
        else if (e.key.toLowerCase() === 'f') toggleFav();
        else if (e.key.toLowerCase() === 'm') toggleMode();
        else if (e.key.toLowerCase() === 'd') openDict();
        else if (e.key === 'Escape') {
            els.dictModal.classList.add('hidden');
            els.badgeModal.classList.add('hidden');
            if (activeMode === 'speed' && !els.speedStartScreen.classList.contains('hidden')) {
                exitSpeedGame();
            }
        }
        else if (['1', '2', '3', '4'].includes(e.key)) {
            if (activeMode === 'quiz' || activeMode === 'sentence' || activeMode === 'speed') {
                const index = parseInt(e.key) - 1;
                const container = activeMode === 'quiz' ? els.quizOptions : (activeMode === 'sentence' ? els.sentenceOptions : els.speedOptions);
                const buttons = container.querySelectorAll('.quiz-opt');
                if (buttons[index] && !buttons[index].disabled) {
                    buttons[index].click();
                }
            }
        }
    });
}

// --- VERİ YÖNETİMİ ---
function loadData() {
    if (localStorage.getItem('ydspro_theme') === 'dark') {
        isDarkMode = true;
        document.body.classList.add('dark-mode');
        // Checkbox'ı da güncelle
        if (els.menuThemeToggleCheckbox) els.menuThemeToggleCheckbox.checked = true;
    }
    learnedCards = JSON.parse(localStorage.getItem('ydspro_learned') || '[]');
    favCards = JSON.parse(localStorage.getItem('ydspro_favs') || '[]');
    earnedBadges = JSON.parse(localStorage.getItem('ydspro_badges') || '[]');
    errorCards = JSON.parse(localStorage.getItem('ydspro_errors') || '[]');
    streakCount = parseInt(localStorage.getItem('ydspro_streak_count') || '0');
    lastStreakDate = localStorage.getItem('ydspro_streak_date') || '';
    speedHighScore = parseInt(localStorage.getItem('ydspro_speed_highscore') || '0');
    totalSpeedScore = parseInt(localStorage.getItem('ydspro_total_speed_score') || '0');

    // Level System
    userXP = parseInt(localStorage.getItem('ydspro_xp') || '0');
    userLevel = parseInt(localStorage.getItem('ydspro_level') || '1');

    // Daily Goals
    lastGoalDate = localStorage.getItem('ydspro_goal_date') || '';
    const savedGoals = localStorage.getItem('ydspro_daily_goals');
    if (savedGoals) dailyGoals = JSON.parse(savedGoals);

    // Theme
    currentTheme = localStorage.getItem('ydspro_color_theme') || 'default';
    if (currentTheme !== 'default') {
        document.body.classList.add(`theme-${currentTheme}`);
    }
    if (els.themeSelector) els.themeSelector.value = currentTheme;

    // Sound
    soundEnabled = localStorage.getItem('ydspro_sound') !== 'false';
    if (els.menuSoundToggle) els.menuSoundToggle.checked = soundEnabled;

    if (els.highScoreDisplay) els.highScoreDisplay.textContent = speedHighScore;
    cardPool = wordData.filter(w => !learnedCards.includes(w.id));

    updateStats();
    checkStreak();
    checkDailyGoals();
    updateLevelUI();
}

function saveData() {
    localStorage.setItem('ydspro_learned', JSON.stringify(learnedCards));
    localStorage.setItem('ydspro_favs', JSON.stringify(favCards));
    localStorage.setItem('ydspro_badges', JSON.stringify(earnedBadges));
    localStorage.setItem('ydspro_errors', JSON.stringify(errorCards));
    localStorage.setItem('ydspro_streak_count', streakCount.toString());
    localStorage.setItem('ydspro_streak_date', lastStreakDate);
    localStorage.setItem('ydspro_speed_highscore', speedHighScore.toString());
    localStorage.setItem('ydspro_total_speed_score', totalSpeedScore.toString());

    // Level System
    localStorage.setItem('ydspro_xp', userXP.toString());
    localStorage.setItem('ydspro_level', userLevel.toString());

    // Daily Goals
    localStorage.setItem('ydspro_daily_goals', JSON.stringify(dailyGoals));
    localStorage.setItem('ydspro_goal_date', lastGoalDate);

    // Theme & Sound
    localStorage.setItem('ydspro_color_theme', currentTheme);
    localStorage.setItem('ydspro_sound', soundEnabled.toString());

    updateStats();
    checkBadges();
    updateGoalsUI();
}

// --- SPEED RUN MANTIĞI ---
function startSpeedRun() {
    speedScore = 0;
    speedTime = 60;
    els.speedScore.textContent = 0;
    els.speedTimer.textContent = 60;
    els.speedStartScreen.classList.add('hidden');
    nextSpeedQuestion();
    speedInterval = setInterval(() => {
        speedTime--;
        els.speedTimer.textContent = speedTime;
        if (speedTime <= 10) els.speedTimer.style.color = "#e74c3c";
        else els.speedTimer.style.color = "#e67e22";
        if (speedTime <= 0) endSpeedGame();
    }, 1000);
}

function nextSpeedQuestion() {
    const randomPool = wordData;
    currentCard = randomPool[Math.floor(Math.random() * randomPool.length)];
    els.speedWord.textContent = currentCard.word;
    generateOptions(els.speedOptions, 'definition', currentCard.definition);
}

function checkSpeedAnswer(btn, isCorrect, container) {
    const allBtns = container.querySelectorAll('.quiz-opt');
    allBtns.forEach(b => b.disabled = true);
    const speedCard = document.querySelector('.speed-content');
    if (isCorrect) {
        btn.classList.add('correct');
        playSound('correct');
        speedScore += 10;
        totalSpeedScore += 10;
        speedTime += 2;
        addXP(XP_REWARDS.speedRunBonus, '');
        updateGoalProgress('correct');
        if (speedCard) {
            speedCard.classList.add('correct-pulse');
            setTimeout(() => speedCard.classList.remove('correct-pulse'), 500);
        }
        if (errorCards.includes(currentCard.id)) errorCards = errorCards.filter(id => id !== currentCard.id);
    } else {
        btn.classList.add('wrong');
        playSound('wrong');
        allBtns.forEach(b => { if (b.innerText.includes(currentCard.definition)) b.classList.add('correct'); });
        speedTime -= 5;
        if (speedCard) {
            speedCard.classList.add('wrong-pulse');
            setTimeout(() => speedCard.classList.remove('wrong-pulse'), 500);
        }
        if (!errorCards.includes(currentCard.id)) errorCards.push(currentCard.id);
    }
    els.speedScore.textContent = speedScore;
    els.speedTimer.textContent = speedTime;
    saveData();
    setTimeout(() => { nextSpeedQuestion(); }, 800);
}

function endSpeedGame() {
    clearInterval(speedInterval);
    els.speedStartScreen.classList.remove('hidden');
    if (speedScore > speedHighScore) {
        speedHighScore = speedScore;
        saveData();
        els.highScoreDisplay.textContent = speedHighScore;
        confetti({ particleCount: 150, spread: 70, origin: { y: 0.6 } });
        alert(`NEW HIGH SCORE: ${speedScore}! 🏆`);
    } else {
        alert(`Game Over! Score: ${speedScore}`);
    }
    checkBadges();
}

function exitSpeedGame() {
    clearInterval(speedInterval);
    els.speedMode.classList.add('hidden');
    els.speedStartScreen.classList.remove('hidden');
    activeMode = 'flashcard';
    els.flashcardMode.classList.remove('hidden');
    els.modeToggle.innerHTML = '<i class="fas fa-layer-group"></i>';
    pickNewCard();
}

// --- SES VE STREAK ---
function preloadVoices() {
    availableVoices = window.speechSynthesis.getVoices();
    if (availableVoices.length === 0) {
        window.speechSynthesis.onvoiceschanged = () => {
            availableVoices = window.speechSynthesis.getVoices();
        };
    }
}

function speak(text) {
    if (!('speechSynthesis' in window)) return;
    window.speechSynthesis.cancel();
    const utterance = new SpeechSynthesisUtterance(text);
    utterance.rate = 0.9;
    if (availableVoices.length === 0) availableVoices = window.speechSynthesis.getVoices();
    const preferredVoice = availableVoices.find(v => v.name.includes("Google US English")) || availableVoices.find(v => v.lang === "en-US");
    if (preferredVoice) utterance.voice = preferredVoice;
    window.speechSynthesis.speak(utterance);
}

function checkStreak() {
    const today = new Date().toDateString();
    const yesterday = new Date(Date.now() - 86400000).toDateString();
    if (lastStreakDate !== today && lastStreakDate !== yesterday && lastStreakDate !== "") streakCount = 0;
    updateStreakUI();
}

function updateStreak(isCorrect) {
    if (!isCorrect) return;
    const today = new Date().toDateString();
    if (lastStreakDate === today) return;
    const yesterday = new Date(Date.now() - 86400000).toDateString();
    if (lastStreakDate === yesterday) streakCount++;
    else streakCount = 1;
    lastStreakDate = today;
    saveData();
    updateStreakUI();
}

function updateStreakUI() {
    if (els.streakCount) els.streakCount.textContent = streakCount;
    if (els.streakBox) {
        if (streakCount > 0) els.streakBox.classList.add('active');
        else els.streakBox.classList.remove('active');
    }
}

function updateStats() {
    if (els.total) els.total.textContent = wordData.length;
    if (els.learned) els.learned.textContent = learnedCards.length;
    if (els.progressBar) els.progressBar.style.width = `${(learnedCards.length / wordData.length) * 100}%`;
    if (els.errorCount) els.errorCount.textContent = errorCards.length;
    if (els.errorModeBtn) els.errorModeBtn.style.opacity = errorCards.length > 0 ? '1' : '0.5';
}

// --- KART SEÇİM VE MOD YÖNETİMİ ---
function toggleErrorReviewMode(forceExit = false) {
    if (!forceExit && !isErrorReviewMode && errorCards.length === 0) {
        alert("Good job! You have no errors to review.");
        return;
    }
    if (forceExit) isErrorReviewMode = false;
    else isErrorReviewMode = !isErrorReviewMode;
    document.body.classList.toggle('error-mode-active', isErrorReviewMode);
    if (isErrorReviewMode) {
        els.errorModeBtn.classList.add('active-mode');
        els.errorModeBtn.innerHTML = '<i class="fas fa-times"></i> EXIT';
    } else {
        els.errorModeBtn.classList.remove('active-mode');
        els.errorModeBtn.innerHTML = '<i class="fas fa-exclamation-triangle"></i> <span class="badge-count" id="errorCount">' + errorCards.length + '</span>';
        els.errorCount = document.getElementById('errorCount');
    }
    cardHistory = [];
    historyIndex = -1;
    nextCard = null;
    pickNewCard();
}

function checkBadges() {
    const wordCount = learnedCards.length;
    const score = totalSpeedScore;
    let newBadge = false;
    BADGES.forEach(badge => {
        let currentProgress = badge.type === 'words' ? wordCount : score;
        if (currentProgress >= badge.count && !earnedBadges.includes(badge.id)) {
            earnedBadges.push(badge.id);
            showToast(`${badge.icon} ${badge.name} Badge Unlocked!`, "NEW ACHIEVEMENT!");
            newBadge = true;
        }
    });
    if (newBadge) localStorage.setItem('ydspro_badges', JSON.stringify(earnedBadges));
}

function showToast(message, title = "Notification") {
    const titleEl = els.toast.querySelector('h4');
    if (titleEl) titleEl.textContent = title;
    els.toastMessage.textContent = message;
    els.toast.classList.remove('hidden');
    setTimeout(() => els.toast.classList.add('hidden'), 3000);
}

function openBadges() {
    els.badgeList.innerHTML = '';
    BADGES.forEach(badge => {
        const isUnlocked = earnedBadges.includes(badge.id);
        const progress = badge.type === 'words' ? learnedCards.length : totalSpeedScore;
        const div = document.createElement('div');
        div.className = `badge-item ${isUnlocked ? 'unlocked' : ''}`;
        let progressText = isUnlocked ? 'Unlocked!' : `Goal: ${badge.count}`;
        div.innerHTML = `
            <span class="badge-icon">${badge.icon}</span>
            <span class="badge-name">${badge.name}</span>
            <span style="font-size:0.7em; color:var(--text-sub)">${progressText}</span>
        `;
        els.badgeList.appendChild(div);
    });
    els.badgeModal.classList.remove('hidden');
}

function toggleMode() {
    clearInterval(speedInterval);

    if (activeMode === 'flashcard') activeMode = 'quiz';
    else if (activeMode === 'quiz') activeMode = 'sentence';
    else if (activeMode === 'sentence') activeMode = 'speed';
    else activeMode = 'flashcard';

    els.flashcardMode.classList.add('hidden');
    els.quizMode.classList.add('hidden');
    els.sentenceMode.classList.add('hidden');
    els.speedMode.classList.add('hidden');

    cardHistory = [];
    historyIndex = -1;
    nextCard = null;

    if (nextCardEl) nextCardEl.style.display = (activeMode === 'flashcard') ? 'flex' : 'none';

    if (activeMode === 'flashcard') {
        els.modeToggle.innerHTML = '<i class="fas fa-layer-group"></i>';
        els.flashcardMode.classList.remove('hidden');
    } else if (activeMode === 'quiz') {
        els.modeToggle.innerHTML = '<i class="fas fa-gamepad"></i>';
        els.quizMode.classList.remove('hidden');
    } else if (activeMode === 'sentence') {
        els.modeToggle.innerHTML = '<i class="fas fa-align-left"></i>';
        els.sentenceMode.classList.remove('hidden');
    } else if (activeMode === 'speed') {
        els.modeToggle.innerHTML = '<i class="fas fa-stopwatch"></i>';
        els.speedMode.classList.remove('hidden');
        els.speedStartScreen.classList.remove('hidden');
        return;
    }
    pickNewCard();
}

function pickNewCard() {
    // Use requestAnimationFrame for smoother DOM updates
    requestAnimationFrame(() => {
        els.card.style.transform = '';
        els.card.style.transition = '';
        els.card.classList.remove('swipe-right', 'swipe-left', 'flipped');

        if (nextCardEl) {
            nextCardEl.style.transition = 'none';
            nextCardEl.classList.remove('promote-card');
            void nextCardEl.offsetWidth;
            nextCardEl.style.transition = 'all 0.25s ease';
        }
    });

    let activePool = [];
    if (isErrorReviewMode) {
        activePool = wordData.filter(w => errorCards.includes(w.id));
        if (activePool.length === 0) {
            toggleErrorReviewMode(true);
            showToast("All errors cleared! Returning to normal mode.", "Great Job!");
            return;
        }
    } else {
        activePool = cardPool;
        if (activePool.length === 0) {
            alert("🎉 Congratulations! You mastered all words!");
            return;
        }
    }

    if (historyIndex < cardHistory.length - 1) {
        historyIndex++;
        currentCard = wordData.find(w => w.id === cardHistory[historyIndex]);
        nextCard = activePool[Math.floor(Math.random() * activePool.length)];
    } else {
        if (nextCard && !isErrorReviewMode) {
            currentCard = nextCard;
        } else {
            currentCard = activePool[Math.floor(Math.random() * activePool.length)];
        }

        let potentialNext;
        do {
            potentialNext = activePool[Math.floor(Math.random() * activePool.length)];
        } while (potentialNext.id === currentCard.id && activePool.length > 1);
        nextCard = potentialNext;

        historyIndex++;
        cardHistory = cardHistory.slice(0, historyIndex);
        cardHistory.push(currentCard.id);
        if (cardHistory.length > maxHistorySize) {
            cardHistory.shift();
            historyIndex--;
        }
    }

    const isFav = favCards.includes(currentCard.id);

    if (activeMode === 'quiz') setupQuiz(isFav);
    else if (activeMode === 'sentence') setupSentence(isFav);
    else {
        setupFlashcard(isFav);
        if (nextCard && nextCardEl) {
            document.getElementById('nextWordId').textContent = `#${nextCard.id}`;
            document.getElementById('nextWordEnglish').textContent = nextCard.word;
        }
    }
    updateNavigationControls();
}

function handleAnswer(known) {
    if (activeMode !== 'flashcard') return;
    if (known) {
        updateStreak(true);
        playSound('correct');
    } else {
        playSound('wrong');
    }
    els.card.classList.add(known ? 'swipe-right' : 'swipe-left');

    if (nextCardEl) {
        // Use requestAnimationFrame for smoother animation
        requestAnimationFrame(() => {
            nextCardEl.classList.add('promote-card');
        });
    }

    setTimeout(() => {
        if (known) {
            if (isErrorReviewMode) {
                errorCards = errorCards.filter(id => id !== currentCard.id);
                addXP(XP_REWARDS.correctAnswer, 'Review Complete');
            } else {
                learnedCards.push(currentCard.id);
                cardPool = cardPool.filter(w => w.id !== currentCard.id);
                if (errorCards.includes(currentCard.id)) errorCards = errorCards.filter(id => id !== currentCard.id);
                addXP(XP_REWARDS.wordMastered, 'Word Mastered!');
                updateGoalProgress('word');
            }
            updateGoalProgress('correct');
        } else {
            if (!errorCards.includes(currentCard.id)) errorCards.push(currentCard.id);
        }
        saveData();
        pickNewCard();
    }, 700);
}

function updateNavigationControls() {
    if (activeMode === 'flashcard' || activeMode === 'speed') return;
    const navControls = activeMode === 'quiz' ? els.quizNavControls : els.sentNavControls;
    const prevBtn = activeMode === 'quiz' ? els.prevBtnQuiz : els.prevBtnSent;
    const nextBtn = activeMode === 'quiz' ? els.nextBtnQuiz : els.nextBtnSent;
    navControls.classList.remove('hidden');
    prevBtn.disabled = historyIndex <= 0;
    nextBtn.disabled = false;
}

function navigateHistory(direction) {
    if (activeMode === 'flashcard' || activeMode === 'speed') return;
    const container = activeMode === 'quiz' ? els.quizOptions : els.sentenceOptions;
    const allBtns = container.querySelectorAll('.quiz-opt');
    allBtns.forEach(b => { b.disabled = false; b.classList.remove('correct', 'wrong'); });

    if (direction === 'prev') {
        if (historyIndex > 0) {
            historyIndex--;
            currentCard = wordData.find(w => w.id === cardHistory[historyIndex]);
            const isFav = favCards.includes(currentCard.id);
            if (activeMode === 'quiz') setupQuiz(isFav);
            else if (activeMode === 'sentence') setupSentence(isFav);
            updateNavigationControls();
        } else {
            showToast("You are at the start of your history.", "Hint");
        }
    } else if (direction === 'next') {
        if (historyIndex < cardHistory.length - 1) {
            historyIndex++;
            currentCard = wordData.find(w => w.id === cardHistory[historyIndex]);
            const isFav = favCards.includes(currentCard.id);
            if (activeMode === 'quiz') setupQuiz(isFav);
            else if (activeMode === 'sentence') setupSentence(isFav);
            updateNavigationControls();
        } else {
            pickNewCard();
        }
    }
}

function touchStart(e) {
    if (activeMode !== 'flashcard' || els.card.classList.contains('flipped')) return;
    isDragging = true;
    startX = e.touches[0].clientX;
    els.card.style.transition = 'none';
    els.card.querySelector('.flip-card-inner').style.transition = 'none';
}

function touchMove(e) {
    if (!isDragging) return;
    const currentX = e.touches[0].clientX;
    const diffX = currentX - startX;
    e.preventDefault();
    els.card.style.transform = `translateX(${diffX}px) rotateY(0deg) rotateZ(${diffX / 20}deg)`;
    const opacity = Math.min(Math.abs(diffX) / swipeThreshold, 1);
    if (diffX > 0) {
        els.btnPass.style.opacity = opacity;
        els.btnFail.style.opacity = 0.5;
    } else {
        els.btnFail.style.opacity = opacity;
        els.btnPass.style.opacity = 0.5;
    }
}

function touchEnd(e) {
    if (!isDragging) return;
    isDragging = false;
    const endX = e.changedTouches[0].clientX;
    const diffX = endX - startX;
    els.card.style.transition = 'transform 1.2s cubic-bezier(0.25, 0.46, 0.45, 0.94)';
    els.card.querySelector('.flip-card-inner').style.transition = 'transform 0.6s';
    els.btnPass.style.opacity = 1;
    els.btnFail.style.opacity = 1;
    let answer = null;
    if (diffX > swipeThreshold) answer = true;
    else if (diffX < -swipeThreshold) answer = false;

    if (answer !== null) {
        els.card.style.transform = `translateX(${diffX > 0 ? 300 : -300}px) rotateZ(${diffX / 10}deg)`;
        handleAnswer(answer);
    } else {
        els.card.style.transform = 'translateX(0) rotateZ(0)';
    }
}

function setupFlashcard(isFav) {
    els.en.textContent = currentCard.word;
    els.def.textContent = currentCard.definition || "";
    els.syn.textContent = currentCard.synonyms || "-";
    els.ex.textContent = currentCard.example || "-";
    els.id.textContent = `#${currentCard.id}`;
    updateFavIcon(els.favBtn, isFav);
}

function setupQuiz(isFav) {
    els.quizWord.textContent = currentCard.word;
    els.quizDef.textContent = "";
    updateFavIcon(els.quizFavBtn, isFav);
    generateOptions(els.quizOptions, 'definition', currentCard.definition);
}

function setupSentence(isFav) {
    const hiddenSentence = currentCard.example.replace(new RegExp(currentCard.word, "gi"), "<span class='blank-space'>_____</span>");
    els.sentenceText.innerHTML = hiddenSentence;
    updateFavIcon(els.sentFavBtn, isFav);
    generateOptions(els.sentenceOptions, 'word', currentCard.word);
}

function generateOptions(container, type, correctAnswer) {
    let options = [currentCard];
    while (options.length < 4) {
        let randomW = wordData[Math.floor(Math.random() * wordData.length)];
        if (!options.includes(randomW)) options.push(randomW);
    }
    options.sort(() => Math.random() - 0.5);
    container.innerHTML = '';
    options.forEach((opt, index) => {
        const btn = document.createElement('button');
        btn.className = 'quiz-opt';
        const numberPrefix = `<span class="key-shortcut" style="opacity:0.5; margin-right:8px; font-size:0.8em;">[${index + 1}]</span>`;
        btn.innerHTML = numberPrefix + opt[type];
        if (activeMode === 'speed') {
            btn.onclick = () => checkSpeedAnswer(btn, opt.id === currentCard.id, container);
        } else {
            btn.onclick = () => checkAnswer(btn, opt.id === currentCard.id, container);
        }
        container.appendChild(btn);
    });
}

function checkAnswer(btn, isCorrect, container) {
    const allBtns = container.querySelectorAll('.quiz-opt');
    allBtns.forEach(b => b.disabled = true);
    if (isCorrect) {
        btn.classList.add('correct');
        playSound('correct');
        addXP(XP_REWARDS.correctAnswer, 'Correct!');
        updateGoalProgress('correct');
        updateGoalProgress('quiz');
        if (isErrorReviewMode) errorCards = errorCards.filter(id => id !== currentCard.id);
        if (errorCards.includes(currentCard.id)) errorCards = errorCards.filter(id => id !== currentCard.id);
        saveData();
        if (historyIndex === cardHistory.length - 1) setTimeout(() => pickNewCard(), 1500);
    } else {
        btn.classList.add('wrong');
        playSound('wrong');
        let correctText = activeMode === 'sentence' ? currentCard.word : currentCard.definition;
        allBtns.forEach(b => { if (b.innerText.includes(correctText)) b.classList.add('correct'); });
        if (!errorCards.includes(currentCard.id)) errorCards.push(currentCard.id);
        saveData();
        if (historyIndex === cardHistory.length - 1) setTimeout(() => pickNewCard(), 2000);
    }
}

function toggleFav() {
    if (favCards.includes(currentCard.id)) favCards = favCards.filter(id => id !== currentCard.id);
    else favCards.push(currentCard.id);
    saveData();
    const isFav = favCards.includes(currentCard.id);
    updateFavIcon(els.favBtn, isFav);
    updateFavIcon(els.quizFavBtn, isFav);
    updateFavIcon(els.sentFavBtn, isFav);
}

function updateFavIcon(btn, isFav) {
    btn.innerHTML = isFav ? '<i class="fas fa-star"></i>' : '<i class="far fa-star"></i>';
}

function openDict() {
    els.dictModal.classList.remove('hidden');
    renderDict();
}

function renderDict() {
    const term = els.searchInput.value.toLowerCase();
    els.wordList.innerHTML = '';
    const filtered = wordData.filter(w => {
        const matchesSearch = w.word.toLowerCase().includes(term) || w.definition.toLowerCase().includes(term);
        const matchesFav = isFilterFav ? favCards.includes(w.id) : true;
        const matchesError = isFilterError ? errorCards.includes(w.id) : true;
        return matchesSearch && matchesFav && matchesError;
    });

    // TÜM KELİMELERİ GÖSTER (SAYI SINIRI YOK)
    const displayList = filtered;

    if (displayList.length === 0) {
        els.wordList.innerHTML = '<div style="padding:20px; text-align:center; color:var(--text-sub);">No words found.</div>';
        return;
    }
    displayList.forEach(w => {
        const div = document.createElement('div');
        div.className = 'dict-item';

        const isLearned = learnedCards.includes(w.id);
        const isFav = favCards.includes(w.id);
        const isErr = errorCards.includes(w.id);

        let statusIcon = '';
        if (isErr) {
            div.classList.add('error-word');
            statusIcon = '<i class="fas fa-exclamation-circle" style="color:var(--danger);" title="Review Needed"></i>';
        } else if (isLearned) {
            div.classList.add('learned');
            statusIcon = '<i class="fas fa-check-circle" style="color:var(--success);" title="Mastered"></i>';
        }

        div.innerHTML = `
            <div style="text-align:left; max-width:85%;">
                <strong>${w.word}</strong>
                <br>
                <small class="dict-def">${w.definition}</small>
            </div>
            <div class="dict-icons">
                ${statusIcon}
                ${isFav ? '<i class="fas fa-star" style="color:var(--gold);"></i>' : ''}
            </div>
        `;
        els.wordList.appendChild(div);
    });
}

function toggleTheme() {
    isDarkMode = !isDarkMode;
    document.body.classList.toggle('dark-mode', isDarkMode);
    localStorage.setItem('ydspro_theme', isDarkMode ? 'dark' : 'light');
}

function resetAll() {
    if (confirm('Reset ALL progress and badges? This cannot be undone.')) {
        localStorage.clear();
        location.reload();
    }
}

// --- LEVEL SYSTEM FUNCTIONS ---
function addXP(amount, reason = '') {
    if (userLevel >= MAX_LEVEL) return;

    userXP += amount;
    showXPGain(amount, reason);

    // Check level up with progressive XP
    let xpNeeded = getXPForLevel(userLevel + 1);
    while (userXP >= xpNeeded && userLevel < MAX_LEVEL) {
        userXP -= xpNeeded;
        userLevel++;
        showLevelUpAnimation();
        playSound('levelup');
        xpNeeded = getXPForLevel(userLevel + 1);
    }

    updateLevelUI();
    saveData();
}

function showXPGain(amount, reason) {
    const xpFloat = document.createElement('div');
    xpFloat.className = 'xp-float';
    xpFloat.innerHTML = `+${amount} XP`;
    if (reason) xpFloat.innerHTML += ` <small>${reason}</small>`;
    document.body.appendChild(xpFloat);

    setTimeout(() => xpFloat.remove(), 1500);
}

function showLevelUpAnimation() {
    const overlay = document.createElement('div');
    overlay.className = 'level-up-overlay';
    overlay.innerHTML = `
        <div class="level-up-content">
            <div class="level-up-icon">🎉</div>
            <h2>LEVEL UP!</h2>
            <div class="new-level">${userLevel}</div>
            <p class="level-title">${getLevelTitle()}</p>
        </div>
    `;
    document.body.appendChild(overlay);

    confetti({ particleCount: 100, spread: 70, origin: { y: 0.6 } });

    setTimeout(() => {
        overlay.classList.add('fade-out');
        setTimeout(() => overlay.remove(), 500);
    }, 2500);
}

function getLevelTitle() {
    return LEVEL_TITLES[Math.min(userLevel - 1, LEVEL_TITLES.length - 1)];
}

function updateLevelUI() {
    const xpNeeded = getXPForLevel(userLevel + 1);
    if (els.levelNumber) els.levelNumber.textContent = userLevel;
    if (els.levelTitle) els.levelTitle.textContent = getLevelTitle();
    if (els.xpBar) {
        const progress = (userXP / xpNeeded) * 100;
        els.xpBar.style.width = `${progress}%`;
    }
    if (els.xpText) els.xpText.textContent = `${userXP}/${xpNeeded} XP`;
}

// --- DAILY GOALS FUNCTIONS ---
function checkDailyGoals() {
    const today = new Date().toDateString();
    if (lastGoalDate !== today) {
        // Reset daily goals for new day
        dailyGoals = { wordsLearned: 0, quizCompleted: 0, correctAnswers: 0 };
        lastGoalDate = today;
        saveData();
    }
    updateGoalsUI();
}

function updateGoalProgress(type) {
    const today = new Date().toDateString();
    if (lastGoalDate !== today) checkDailyGoals();

    let previouslyComplete = isGoalComplete(type);

    if (type === 'word') dailyGoals.wordsLearned++;
    else if (type === 'quiz') dailyGoals.quizCompleted++;
    else if (type === 'correct') dailyGoals.correctAnswers++;

    // Check if this goal was just completed
    if (!previouslyComplete && isGoalComplete(type)) {
        celebrateGoalComplete(type);
        addXP(XP_REWARDS.goalComplete, 'Goal Complete!');
    }

    updateGoalsUI();
    saveData();
}

function isGoalComplete(type) {
    if (type === 'word') return dailyGoals.wordsLearned >= DAILY_TARGETS.words;
    if (type === 'quiz') return dailyGoals.quizCompleted >= DAILY_TARGETS.quiz;
    if (type === 'correct') return dailyGoals.correctAnswers >= DAILY_TARGETS.correct;
    return false;
}

function getAllGoalsComplete() {
    return isGoalComplete('word') && isGoalComplete('quiz') && isGoalComplete('correct');
}

function updateGoalsUI() {
    if (!els.goalRing) return;

    // Calculate overall progress
    const wordProgress = Math.min(dailyGoals.wordsLearned / DAILY_TARGETS.words, 1);
    const quizProgress = Math.min(dailyGoals.quizCompleted / DAILY_TARGETS.quiz, 1);
    const correctProgress = Math.min(dailyGoals.correctAnswers / DAILY_TARGETS.correct, 1);
    const overallProgress = (wordProgress + quizProgress + correctProgress) / 3;

    // Update ring indicator
    const degrees = overallProgress * 360;
    els.goalRing.style.background = `conic-gradient(var(--success) ${degrees}deg, transparent ${degrees}deg)`;

    if (getAllGoalsComplete()) {
        els.goalRing.classList.add('complete');
    } else {
        els.goalRing.classList.remove('complete');
    }
}

function celebrateGoalComplete(type) {
    const goalNames = { word: 'Words Goal', quiz: 'Quiz Goal', correct: 'Accuracy Goal' };
    showToast(`🎯 ${goalNames[type]} Complete!`, "Daily Goal Achieved!");
    playSound('goal');
    confetti({ particleCount: 50, spread: 60, origin: { y: 0.7 } });
}

function openGoalsModal() {
    if (!els.goalsModal) return;

    const goalsBody = els.goalsModal.querySelector('.goals-body');
    if (goalsBody) {
        goalsBody.innerHTML = `
            <div class="goal-item ${isGoalComplete('word') ? 'complete' : ''}">
                <div class="goal-icon">📚</div>
                <div class="goal-info">
                    <h4>Learn Words</h4>
                    <p>${dailyGoals.wordsLearned} / ${DAILY_TARGETS.words}</p>
                </div>
                <div class="goal-progress-bar">
                    <div class="goal-fill" style="width: ${Math.min(dailyGoals.wordsLearned / DAILY_TARGETS.words * 100, 100)}%"></div>
                </div>
            </div>
            <div class="goal-item ${isGoalComplete('quiz') ? 'complete' : ''}">
                <div class="goal-icon">🎯</div>
                <div class="goal-info">
                    <h4>Complete Quizzes</h4>
                    <p>${dailyGoals.quizCompleted} / ${DAILY_TARGETS.quiz}</p>
                </div>
                <div class="goal-progress-bar">
                    <div class="goal-fill" style="width: ${Math.min(dailyGoals.quizCompleted / DAILY_TARGETS.quiz * 100, 100)}%"></div>
                </div>
            </div>
            <div class="goal-item ${isGoalComplete('correct') ? 'complete' : ''}">
                <div class="goal-icon">✅</div>
                <div class="goal-info">
                    <h4>Correct Answers</h4>
                    <p>${dailyGoals.correctAnswers} / ${DAILY_TARGETS.correct}</p>
                </div>
                <div class="goal-progress-bar">
                    <div class="goal-fill" style="width: ${Math.min(dailyGoals.correctAnswers / DAILY_TARGETS.correct * 100, 100)}%"></div>
                </div>
            </div>
            ${getAllGoalsComplete() ? '<div class="all-goals-complete">🏆 All Daily Goals Complete! +100 XP Bonus</div>' : ''}
        `;
    }

    els.goalsModal.classList.remove('hidden');
}

// --- SOUND SYSTEM (Web Audio API) ---
function initAudioContext() {
    if (!audioContext) {
        audioContext = new (window.AudioContext || window.webkitAudioContext)();
    }
    return audioContext;
}

function playSound(type) {
    if (!soundEnabled) return;

    try {
        const ctx = initAudioContext();
        const oscillator = ctx.createOscillator();
        const gainNode = ctx.createGain();

        oscillator.connect(gainNode);
        gainNode.connect(ctx.destination);

        // Different sounds for different events
        switch (type) {
            case 'correct':
                oscillator.frequency.setValueAtTime(523.25, ctx.currentTime); // C5
                oscillator.frequency.setValueAtTime(659.25, ctx.currentTime + 0.1); // E5
                oscillator.frequency.setValueAtTime(783.99, ctx.currentTime + 0.2); // G5
                gainNode.gain.setValueAtTime(0.3, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.4);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.4);
                break;

            case 'wrong':
                oscillator.frequency.setValueAtTime(200, ctx.currentTime);
                oscillator.frequency.setValueAtTime(150, ctx.currentTime + 0.1);
                oscillator.type = 'sawtooth';
                gainNode.gain.setValueAtTime(0.2, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.3);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.3);
                break;

            case 'levelup':
                // Ascending arpeggio
                const notes = [523.25, 659.25, 783.99, 1046.50]; // C5, E5, G5, C6
                notes.forEach((freq, i) => {
                    const osc = ctx.createOscillator();
                    const gain = ctx.createGain();
                    osc.connect(gain);
                    gain.connect(ctx.destination);
                    osc.frequency.setValueAtTime(freq, ctx.currentTime + i * 0.15);
                    gain.gain.setValueAtTime(0.3, ctx.currentTime + i * 0.15);
                    gain.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + i * 0.15 + 0.3);
                    osc.start(ctx.currentTime + i * 0.15);
                    osc.stop(ctx.currentTime + i * 0.15 + 0.3);
                });
                return;

            case 'goal':
                oscillator.frequency.setValueAtTime(880, ctx.currentTime); // A5
                oscillator.frequency.setValueAtTime(1108.73, ctx.currentTime + 0.15); // C#6
                oscillator.frequency.setValueAtTime(1318.51, ctx.currentTime + 0.3); // E6
                gainNode.gain.setValueAtTime(0.25, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.5);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.5);
                break;

            case 'click':
                oscillator.frequency.setValueAtTime(800, ctx.currentTime);
                oscillator.type = 'sine';
                gainNode.gain.setValueAtTime(0.1, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.05);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.05);
                break;
        }
    } catch (e) {
        console.log('Audio error:', e);
    }
}

function toggleSound() {
    soundEnabled = !soundEnabled;
    saveData();
    if (soundEnabled) playSound('click');
}

// --- THEME SYSTEM ---
function setColorTheme(themeName) {
    // Remove all theme classes
    document.body.classList.remove('theme-ocean', 'theme-forest', 'theme-sunset', 'theme-midnight');

    if (themeName !== 'default') {
        document.body.classList.add(`theme-${themeName}`);
    }

    currentTheme = themeName;
    saveData();
}

init();