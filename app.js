// --- GLOBAL DEĞİŞKENLER ---
window.splashStartTime = Date.now();

// --- SMART SPLASH SCREEN SKIP ---
// Skip splash if: same day OR visited within last 4 hours
(function checkSplashSkip() {
    const SPLASH_SKIP_HOURS = 4; // Skip splash if visited within X hours
    const lastVisit = localStorage.getItem('lastVisitTimestamp');
    const now = Date.now();

    if (lastVisit) {
        const lastVisitTime = parseInt(lastVisit, 10);
        const hoursSinceVisit = (now - lastVisitTime) / (1000 * 60 * 60);
        const lastVisitDate = new Date(lastVisitTime).toDateString();
        const todayDate = new Date(now).toDateString();

        // Skip splash if same day OR visited within SPLASH_SKIP_HOURS
        if (lastVisitDate === todayDate || hoursSinceVisit < SPLASH_SKIP_HOURS) {
            window.skipSplashScreen = true;
            // Immediately hide splash via CSS
            const splash = document.getElementById('splashScreen');
            if (splash) {
                splash.style.display = 'none';
                splash.remove();
            }
        }
    }

    // Save current visit timestamp
    localStorage.setItem('lastVisitTimestamp', now.toString());
})();
let currentCard = null;
let nextCard = null;
let learnedCards = [];
let learnedCardsByLevel = {}; // Seviye bazlı öğrenilen kelimeler
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
// swipeThreshold now uses SWIPE_CONFIG.threshold from config.js

// GLOBAL ANIMATION LOCK - prevents any new card action while animating
let isCardAnimating = false;
// CARD_ANIMATION_DURATION now uses ANIMATION_TIMING.cardSwipe from config.js

// GEÇMİŞ YÖNETİMİ (Quiz ve Sentence için)
let cardHistory = [];
let historyIndex = -1;
// maxHistorySize now uses HISTORY_CONFIG.maxSize from config.js

// STREAK & SES & DİĞERLERİ
let streakCount = 0;
let lastStreakDate = "";
let availableVoices = [];

// SPEED RUN DEĞİŞKENLERİ
let speedScore = 0;
let speedTime = 60;
let speedInterval = null;
let speedHighScore = 0;
let speedHighScoresByLevel = {}; // Scores per word level
let totalSpeedScore = 0;

// MODE STATS (for badges)
let totalQuizCorrect = 0;
let totalSentenceCorrect = 0;

// TIME TRACKING
let totalTimeSpent = 0; // Total seconds spent in app
let dailyTimeRecord = {}; // { "YYYY-MM-DD": seconds }
let sessionStartTime = null; // Current session start timestamp

// --- LEVEL SELECTION DATA ---
let currentWordData = []; // Dinamik olarak yüklenecek kelimeler


// --- LEVEL SYSTEM ---
let userXP = 0;
let userLevel = 1;
const MAX_LEVEL = 50;

// Belirli bir level için gereken XP'yi hesapla (dinamik artış)
// Level 2: 200, Level 5: 500, Level 10: 1000, Level 14: 1400, Level 50: 5000
function getXPForLevel(level) {
    return level * 100;
}

// XP_REWARDS moved to config.js

// LEVEL_TITLES moved to config.js

// --- DAILY GOALS ---
let dailyGoals = {
    wordsLearned: 0,
    quizCompleted: 0,
    correctAnswers: 0
};
// DAILY_TARGETS moved to config.js
let lastGoalDate = "";

// --- SOUND SYSTEM (Web Audio API) ---
let soundEnabled = true;
let audioContext = null;

// --- THEME SYSTEM ---
let currentTheme = "default";
let userName = "Scholar";
let userAvatar = "👤";

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

// ROZET LİSTESİ - Modern Achievements
// BADGES moved to config.js

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

    // Word ID (Required for setupFlashcard)
    id: document.getElementById('wordId'),

    // Profile Elements
    userNameDisplay: document.getElementById('userNameDisplay'),
    userAvatarDisplay: document.getElementById('userAvatarDisplay'),

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
    errorCount: document.getElementById('errorCount'),
    errorModeBtn: document.getElementById('errorModeBtn'),

    // Bildirim
    toast: document.getElementById('toast'),
    toastMessage: document.getElementById('toastMessage'),

    // Level System
    levelDisplay: document.getElementById('levelDisplay'),
    levelNumber: document.getElementById('levelNumber'),
    levelTitle: document.getElementById('levelTitle'),
    xpBar: document.getElementById('xpBar'),
    xpText: document.getElementById('xpText'),

    // Profile
    userNameDisplay: document.getElementById('userNameDisplay'),
    userAvatarDisplay: document.getElementById('userAvatarDisplay'),
    profileModal: document.getElementById('profileModal'),
    closeProfile: document.getElementById('closeProfile'),

    // Daily Goals
    goalsToggle: document.getElementById('goalsToggle'),
    goalsModal: document.getElementById('goalsModal'),
    closeGoals: document.getElementById('closeGoals'),
    goalRing: document.getElementById('goalRing'),

    // Theme Selector
    themeSelector: document.getElementById('themeSelector'),

    // Sound Toggle
    menuSoundToggle: document.getElementById('menuSoundToggle'),

    // Time Stats
    btnTimeStats: document.getElementById('btnTimeStats'),
    timeStatsModal: document.getElementById('timeStatsModal'),
    closeTimeStats: document.getElementById('closeTimeStats'),
    statsTodayTime: document.getElementById('statsTodayTime'),
    statsTotalTime: document.getElementById('statsTotalTime'),
    statsTrend: document.getElementById('statsTrend'), // NEW
    timeBarChart: document.getElementById('timeBarChart'),
    timeChartDates: document.getElementById('timeChartDates')
};

let nextCardEl = null;

// --- TIME TRACKING FUNCTIONS ---
let timeTrackingInterval = null;

function startTimeTracking() {
    sessionStartTime = Date.now();

    // Update time every 30 seconds
    timeTrackingInterval = setInterval(() => {
        if (sessionStartTime) {
            const sessionSeconds = Math.floor((Date.now() - sessionStartTime) / 1000);
            totalTimeSpent += sessionSeconds;

            // Update Daily Record
            const today = new Date().toISOString().split('T')[0];
            if (!dailyTimeRecord[today]) dailyTimeRecord[today] = 0;
            dailyTimeRecord[today] += sessionSeconds;

            sessionStartTime = Date.now();
            saveTimeData();
        }
    }, 1000); // Live Update every second for smoother UI

    // Handle visibility change (pause when app is hidden)
    document.addEventListener('visibilitychange', handleVisibilityChange);
}

function handleVisibilityChange() {
    if (document.hidden) {
        // Save time when app goes to background
        if (sessionStartTime) {
            const sessionSeconds = Math.floor((Date.now() - sessionStartTime) / 1000);
            totalTimeSpent += sessionSeconds;
            sessionStartTime = null;
            saveTimeData();
        }
    } else {
        // Resume tracking when app becomes visible
        sessionStartTime = Date.now();
    }
}

function saveTimeData() {
    localStorage.setItem('ydspro_time_spent', totalTimeSpent.toString());

    // Save Daily Record
    const today = new Date().toISOString().split('T')[0];
    localStorage.setItem('ydspro_daily_time', JSON.stringify(dailyTimeRecord));

    updateTimeDisplay();
    // If stats modal is open, update it live
    if (!els.timeStatsModal.classList.contains('hidden')) {
        updateTimeStatsUI();
    }
}

function updateTimeDisplay() {
    const display = document.getElementById('timeSpentDisplay');
    if (!display) return;

    const hours = Math.floor(totalTimeSpent / 3600);
    const minutes = Math.floor((totalTimeSpent % 3600) / 60);
    display.textContent = `${hours}h ${minutes}m`;
}

function formatTimeSpent() {
    const hours = Math.floor(totalTimeSpent / 3600);
    const minutes = Math.floor((totalTimeSpent % 3600) / 60);
    return `${hours}h ${minutes}m`;
}

// --- TIME STATS UI ---
function updateTimeStatsUI() {
    const today = new Date().toISOString().split('T')[0];
    const todaySeconds = dailyTimeRecord[today] || 0;

    // Overview Cards
    if (els.statsTodayTime) els.statsTodayTime.textContent = formatTimeDetail(todaySeconds);
    if (els.statsTotalTime) els.statsTotalTime.textContent = formatTimeDetail(totalTimeSpent);

    // Generate Chart Data (Last 7 Days)
    const dates = [];
    const values = [];
    let thisWeekTotal = 0;

    for (let i = 6; i >= 0; i--) {
        const d = new Date();
        d.setDate(d.getDate() - i);
        const dateStr = d.toISOString().split('T')[0];
        dates.push(d.toLocaleDateString('en-US', { weekday: 'short' }));
        const val = dailyTimeRecord[dateStr] || 0;
        values.push(val);
        thisWeekTotal += val;
    }

    // Calculate Previous Week Total (Days 8-14 ago)
    let prevWeekTotal = 0;
    for (let i = 13; i >= 7; i--) {
        const d = new Date();
        d.setDate(d.getDate() - i);
        const dateStr = d.toISOString().split('T')[0];
        prevWeekTotal += (dailyTimeRecord[dateStr] || 0);
    }

    // Update Trend Text
    if (els.statsTrend) {
        if (prevWeekTotal === 0) {
            els.statsTrend.innerHTML = '<span style="color:var(--success)">🌟 Starting strong! Keep it up!</span>';
        } else {
            const diff = thisWeekTotal - prevWeekTotal;
            const pct = Math.round((diff / prevWeekTotal) * 100);
            if (pct > 0) {
                els.statsTrend.innerHTML = `<span style="color:var(--success)">📈 Trending Up! <strong>+${pct}%</strong> vs last week</span>`;
            } else if (pct < 0) {
                els.statsTrend.innerHTML = `<span style="color:var(--text-sub)">📉 Cooling Down. <strong>${pct}%</strong> vs last week</span>`;
            } else {
                els.statsTrend.innerHTML = `<span style="color:var(--primary)">⚖️ Consistent Pace. Same as last week.</span>`;
            }
        }
    }

    // Render Chart
    const maxVal = Math.max(...values, 60); // Min scale 60s
    if (els.timeBarChart) {
        els.timeBarChart.innerHTML = values.map((val, index) => {
            const heightPct = (val / maxVal) * 100;
            const timeLabel = val > 60 ? Math.round(val / 60) + 'm' : val + 's';
            return `
                <div class="chart-col">
                    <div class="bar" style="height: ${heightPct}%; transition-delay: ${index * 0.1}s;">
                        <span class="bar-tooltip">${formatTimeDetail(val)}</span>
                    </div>
                </div>
            `;
        }).join('');
    }

    if (els.timeChartDates) {
        els.timeChartDates.innerHTML = dates.map(d => `<span>${d}</span>`).join('');
    }
}

function formatTimeDetail(seconds) {
    if (seconds < 60) return `${seconds}s`;
    const m = Math.floor(seconds / 60);
    if (m < 60) return `${m}m`;
    const h = Math.floor(m / 60);
    const remM = m % 60;
    return `${h}h ${remM}m`;
}

// --- MODAL HELPERS ---
function openModal(modal) {
    if (!modal) return;
    modal.classList.remove('hidden');
    playSound('pop'); // Modal open sound

    // Overlay Animation (Fade)
    modal.classList.remove('overlay-animate-out');
    modal.classList.add('overlay-animate-in');

    // Content Animation (Scale)
    const content = modal.querySelector('.modal-content');
    if (content) {
        content.classList.remove('content-animate-out');
        content.classList.add('content-animate-in');
    }
}

function closeModal(modal) {
    if (!modal) return;
    playSound('whoosh'); // Modal close sound

    // Overlay Animation (Fade Out)
    modal.classList.remove('overlay-animate-in');
    modal.classList.add('overlay-animate-out');

    // Content Animation (Scale Out)
    const content = modal.querySelector('.modal-content');
    if (content) {
        content.classList.remove('content-animate-in');
        content.classList.add('content-animate-out');
    }

    setTimeout(() => {
        modal.classList.add('hidden');
        modal.classList.remove('overlay-animate-out');
        if (content) {
            content.classList.remove('content-animate-out');
        }
    }, 200);
}

// --- BAŞLANGIÇ (INIT) ---
async function init() {
    try {
        loadData();
        updateLevelUI();
        initLevelSelection(); // Level seçim butonlarını dinle
        initProfileCustomization();
        preloadVoices();

        // Hide splash after load
        hideSplashScreen();

        // 1. Ana Menü Butonları
        els.btnStartGame.addEventListener('click', startGame);

        // Options Modal (Ana Menüden)
        els.btnOpenOptions.addEventListener('click', () => {
            openModal(els.menuOptionsModal);
        });

        // Options Modal (Header'dan - Oyun içinden)
        if (els.btnHeaderOptions) {
            els.btnHeaderOptions.addEventListener('click', () => {
                openModal(els.menuOptionsModal);
            });
        }

        // Mobile Options Button
        const btnHeaderOptionsMobile = document.getElementById('btnHeaderOptionsMobile');
        if (btnHeaderOptionsMobile) {
            btnHeaderOptionsMobile.addEventListener('click', () => {
                openModal(els.menuOptionsModal);
            });
        }

        // Mobile Badges Button
        const badgeToggleMobile = document.getElementById('badgeToggleMobile');
        if (badgeToggleMobile) {
            badgeToggleMobile.addEventListener('click', () => {
                openModal(els.badgeModal);
                renderBadges();
            });
        }

        // Mobile Dictionary Button  
        const dictToggleMobile = document.getElementById('dictToggleMobile');
        if (dictToggleMobile) {
            dictToggleMobile.addEventListener('click', () => openDict());
        }

        // Modalı Kapatma
        if (els.closeMenuOptions) {
            els.closeMenuOptions.addEventListener('click', () => {
                closeModal(els.menuOptionsModal);
            });
        }

        // Credits Modal
        if (els.btnOpenCredits) els.btnOpenCredits.addEventListener('click', () => openModal(els.creditsModal));
        if (els.closeCredits) els.closeCredits.addEventListener('click', () => closeModal(els.creditsModal));

        // 2. Ayarlar (Options) İçindeki İşlevler
        // Dark Mode Toggle
        if (els.menuThemeToggleCheckbox) {
            els.menuThemeToggleCheckbox.addEventListener('change', toggleTheme);
        }

        // Reset Butonu
        if (els.menuResetBtn) els.menuResetBtn.addEventListener('click', resetAll);

        // Ana Menüye Dön Butonu
        if (els.menuReturnHome) {
            els.menuReturnHome.addEventListener('click', () => {
                closeModal(els.menuOptionsModal);
                returnToMenu();
            });
        }

        // Change Level Butonu
        const menuChangeLevelBtn = document.getElementById('menuChangeLevelBtn');
        if (menuChangeLevelBtn) {
            menuChangeLevelBtn.addEventListener('click', () => {
                localStorage.removeItem('ydspro_user_level_group');
                closeModal(els.menuOptionsModal); // Close options

                // Show level selection modal with animation
                const levelModal = document.getElementById('levelSelectionModal');
                if (levelModal) {
                    openModal(levelModal);
                    levelModal.style.zIndex = "10000";
                }

                // Return to menu meanwhile
                returnToMenu();
            });
        }

        if (els.btnTimeStats) {
            els.btnTimeStats.addEventListener('click', () => {
                updateTimeStatsUI();
                openModal(els.timeStatsModal);
            });
        }
        if (els.closeTimeStats) {
            els.closeTimeStats.addEventListener('click', () => {
                closeModal(els.timeStatsModal);
            });
        }

        // 3. Modal Dışına Tıklayınca Kapatma
        window.addEventListener('click', (e) => {
            if (e.target === els.menuOptionsModal) closeModal(els.menuOptionsModal);
            if (e.target === els.creditsModal) closeModal(els.creditsModal);
            if (e.target === els.badgeModal) closeModal(els.badgeModal);
            if (e.target === els.dictModal) closeModal(els.dictModal);
            if (e.target === els.goalsModal) closeModal(els.goalsModal);

            // New modals for outside click
            const levelModal = document.getElementById('levelSelectionModal');
            const progressModal = document.getElementById('progressModal');
            if (e.target === levelModal) closeModal(levelModal);
            if (e.target === progressModal) closeModal(progressModal);
        });

        // 4. Goals Modal
        if (els.goalsToggle) {
            els.goalsToggle.addEventListener('click', openGoalsModal);
        }
        if (els.closeGoals) {
            els.closeGoals.addEventListener('click', () => closeModal(els.goalsModal));
        }

        // 5. Theme Selector
        if (els.themeSelector) {
            els.themeSelector.addEventListener('change', (e) => setColorTheme(e.target.value));
        }

        // 6. Sound Toggle
        if (els.menuSoundToggle) {
            els.menuSoundToggle.addEventListener('change', toggleSound);
        }

        // 7. Word Level Badge - Opens Level Selection
        const wordLevelBadge = document.getElementById('wordLevelBadge');
        if (wordLevelBadge) {
            wordLevelBadge.addEventListener('click', () => {
                const levelModal = document.getElementById('levelSelectionModal');
                if (levelModal) {
                    openModal(levelModal);
                    levelModal.style.zIndex = "10000";
                }
            });
        }

        // 8. Level Selection Close Button
        const closeLevelSelection = document.getElementById('closeLevelSelection');
        if (closeLevelSelection) {
            closeLevelSelection.addEventListener('click', () => {
                const levelModal = document.getElementById('levelSelectionModal');
                if (levelModal) {
                    closeModal(levelModal);
                }
            });
        }

        // 9. Progress Modal (Combined Badges + Goals)
        const progressToggle = document.getElementById('progressToggle');
        const progressModal = document.getElementById('progressModal');
        const closeProgress = document.getElementById('closeProgress');

        if (progressToggle && progressModal) {
            progressToggle.addEventListener('click', () => {
                openModal(progressModal);
                renderBadges();
                updateGoalsDisplay();
            });
        }

        if (closeProgress && progressModal) {
            closeProgress.addEventListener('click', () => closeModal(progressModal));
        }

        // Tab switching
        const progressTabs = document.querySelectorAll('.progress-tab');
        progressTabs.forEach(tab => {
            tab.addEventListener('click', () => {
                // Remove active from all tabs
                progressTabs.forEach(t => t.classList.remove('active'));
                tab.classList.add('active');

                // Show corresponding pane
                const tabName = tab.dataset.tab;
                document.querySelectorAll('.tab-pane').forEach(pane => pane.classList.remove('active'));
                document.getElementById(tabName === 'badges' ? 'badgesPane' : 'goalsPane').classList.add('active');
            });
        });

        // 10. Homepage Enhancements - Particles, Quotes & Stats
        initHomepageEnhancements();

        // 11. Start Time Tracking
        startTimeTracking();
        updateTimeDisplay();
    } catch (err) {
        console.error("Initialization Failed:", err);
        hideSplashScreen();
    }
}

// --- HOMEPAGE ENHANCEMENTS ---
// MOTIVATION_QUOTES moved to config.js

function initHomepageEnhancements() {
    createFloatingParticles();
    setRandomQuote();
    updateMenuStats();
}

// Create floating particles effect - DISABLED for performance
function createFloatingParticles() {
    // Particles disabled for better performance
    return;

    for (let i = 0; i < particleCount; i++) {
        const particle = document.createElement('div');
        particle.className = 'particle';

        // Random position and animation delay
        particle.style.left = Math.random() * 100 + '%';
        particle.style.animationDelay = Math.random() * 15 + 's';
        particle.style.animationDuration = (12 + Math.random() * 8) + 's';

        // Random size
        const size = 4 + Math.random() * 6;
        particle.style.width = size + 'px';
        particle.style.height = size + 'px';

        container.appendChild(particle);
    }
}

// Set random motivation quote
function setRandomQuote() {
    const quoteText = document.getElementById('quoteText');
    if (!quoteText) return;

    const randomIndex = Math.floor(Math.random() * MOTIVATION_QUOTES.length);
    quoteText.textContent = MOTIVATION_QUOTES[randomIndex];
}

// Update menu stats display with counter animation
function updateMenuStats() {
    const menuStreakCount = document.getElementById('menuStreakCount');
    const menuXPCount = document.getElementById('menuXPCount');
    const menuWordsCount = document.getElementById('menuWordsCount');

    // Animate counters (slower for premium feel)
    animateCounter(menuStreakCount, streakCount || 0, 2500);
    animateCounter(menuXPCount, userXP || 0, 3500);
    animateCounter(menuWordsCount, learnedCards.length || 0, 3000);
}

// Smooth counter animation
function animateCounter(element, target, duration) {
    if (!element) return;

    const start = 0;
    const startTime = performance.now();

    function update(currentTime) {
        const elapsed = currentTime - startTime;
        const progress = Math.min(elapsed / duration, 1);

        // Ease out cubic for smooth deceleration
        const eased = 1 - Math.pow(1 - progress, 3);
        const current = Math.round(start + (target - start) * eased);

        element.textContent = current.toLocaleString();

        if (progress < 1) {
            requestAnimationFrame(update);
        }
    }

    requestAnimationFrame(update);
}

function startGame(instant = false) {
    // 0. Level Seçimi Yapılmış mı Kontrol Et
    if (!localStorage.getItem('ydspro_user_level_group')) {
        const levelModal = document.getElementById('levelSelectionModal');
        if (levelModal) {
            openModal(levelModal);
            levelModal.style.zIndex = "10000";
        }
        return; // Oyunu başlatma, modalı göster
    }

    if (instant) {
        // İsimsiz geçiş (Level seçiminden sonra)
        els.mainMenu.classList.add('hidden');
        els.mainMenu.classList.remove('fade-out');
        els.gameInterface.classList.remove('hidden');

        // Eğer oyun ilk kez başlıyorsa veya kart yoksa başlat
        if (!currentCard) {
            createNextCardPreview();
            setupGameEventListeners();
            pickNewCard();
        }
        return;
    }

    // Add fade-out animation to menu
    els.mainMenu.classList.add('fade-out');

    // Wait for animation to complete, then switch screens
    setTimeout(() => {
        els.mainMenu.classList.add('hidden');
        els.mainMenu.classList.remove('fade-out');

        // Show game interface with fade-in
        els.gameInterface.classList.remove('hidden');
        els.gameInterface.classList.add('fade-in');

        // Remove fade-in class after animation
        setTimeout(() => {
            els.gameInterface.classList.remove('fade-in');
        }, 400);

        // Eğer oyun ilk kez başlıyorsa veya kart yoksa başlat
        if (!currentCard) {
            createNextCardPreview();
            setupGameEventListeners();
            pickNewCard();
        }
    }, 300);
}

function returnToMenu() {
    els.gameInterface.classList.add('hidden');
    els.mainMenu.classList.remove('hidden');

    // Update menu stats when returning
    updateMenuStats();
    setRandomQuote();
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
        <button class="speak-btn neon-icon-container neon-blue"><i class="fas fa-volume-up"></i></button>
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

    // Flashcard Butonları - Use global animation lock
    const safeHandleAnswer = (isCorrect) => {
        if (isCardAnimating) return; // Global lock check

        // Visual feedback - disable buttons during animation
        els.btnFail.style.opacity = '0.5';
        els.btnPass.style.opacity = '0.5';
        els.btnFail.style.pointerEvents = 'none';
        els.btnPass.style.pointerEvents = 'none';

        handleAnswer(isCorrect);

        // Re-enable buttons after animation (synced with global lock release)
        setTimeout(() => {
            els.btnFail.style.opacity = '1';
            els.btnPass.style.opacity = '1';
            els.btnFail.style.pointerEvents = 'auto';
            els.btnPass.style.pointerEvents = 'auto';
        }, ANIMATION_TIMING.cardSwipe);
    };

    els.btnFail.addEventListener('click', () => safeHandleAnswer(false));
    els.btnPass.addEventListener('click', () => safeHandleAnswer(true));
    els.card.addEventListener('click', (e) => {
        if (!e.target.closest('button')) els.card.classList.toggle('flipped');
    });

    // Ses ve Favori Butonları
    els.btnSpeak.addEventListener('click', (e) => { e.stopPropagation(); speak(currentCard.word); });
    els.quizSpeak.addEventListener('click', () => speak(currentCard.word));
    els.favBtn.addEventListener('click', (e) => { e.stopPropagation(); toggleFav(); });
    els.quizFavBtn.addEventListener('click', toggleFav);
    els.sentFavBtn.addEventListener('click', toggleFav);

    // Mod Değiştirme - Dropdown Menu
    els.modeToggle.addEventListener('click', (e) => {
        e.stopPropagation();
        const dropdown = els.modeToggle.closest('.mode-dropdown');
        dropdown.classList.toggle('active');
    });

    // Mode seçeneklerine tıklama
    document.querySelectorAll('.mode-option').forEach(option => {
        option.addEventListener('click', (e) => {
            const selectedMode = e.currentTarget.dataset.mode;
            switchToMode(selectedMode);
            // Dropdown'u kapat
            els.modeToggle.closest('.mode-dropdown').classList.remove('active');
        });
    });

    // Dropdown dışına tıklayınca kapat
    document.addEventListener('click', (e) => {
        if (!e.target.closest('.mode-dropdown')) {
            document.querySelector('.mode-dropdown')?.classList.remove('active');
        }
    });

    // Modal Açma Butonları (Oyun İçi)
    if (els.dictToggle) els.dictToggle.addEventListener('click', openDict);
    if (els.badgeToggle) els.badgeToggle.addEventListener('click', openBadges);
    if (els.errorModeBtn) els.errorModeBtn.addEventListener('click', () => toggleErrorReviewMode(false));

    // Modal Kapatma Butonları
    if (els.closeDict) els.closeDict.addEventListener('click', () => els.dictModal.classList.add('hidden'));
    if (els.closeBadge && els.badgeModal) els.closeBadge.addEventListener('click', () => els.badgeModal.classList.add('hidden'));

    // Sözlük Arama ve Filtreleme (Debounced)
    const debouncedRenderDict = debounce(renderDict, 150);
    if (els.searchInput) els.searchInput.addEventListener('input', debouncedRenderDict);
    if (els.filterFavs) els.filterFavs.addEventListener('click', () => {
        isFilterFav = !isFilterFav;
        els.filterFavs.classList.toggle('active-fav', isFilterFav);
        renderDict();
    });
    if (els.filterErrors) els.filterErrors.addEventListener('click', () => {
        isFilterError = !isFilterError;
        els.filterErrors.classList.toggle('active-error', isFilterError);
        renderDict();
    });

    // Speed Run Kontrolleri
    if (els.startSpeedBtn) els.startSpeedBtn.addEventListener('click', startSpeedRun);
    if (els.exitSpeedMode) els.exitSpeedMode.addEventListener('click', exitSpeedGame);

    // Navigasyon Kontrolleri (Quiz & Sentence)
    if (els.prevBtnQuiz) els.prevBtnQuiz.addEventListener('click', () => navigateHistory('prev'));
    if (els.nextBtnQuiz) els.nextBtnQuiz.addEventListener('click', () => navigateHistory('next'));
    if (els.prevBtnSent) els.prevBtnSent.addEventListener('click', () => navigateHistory('prev'));
    if (els.nextBtnSent) els.nextBtnSent.addEventListener('click', () => navigateHistory('next'));

    // Swipe (Dokunmatik) Kontrolleri - Passive listeners for better performance
    if ('ontouchstart' in window && els.card) {
        els.card.addEventListener('touchstart', touchStart, { passive: true });
        els.card.addEventListener('touchmove', touchMove, { passive: false });
        els.card.addEventListener('touchend', touchEnd, { passive: true });
    }

    // Klavye Kısayolları
    document.addEventListener('keydown', (e) => {
        // Menüdeyken veya modal açıkken tuşları dinleme
        if (!els.mainMenu.classList.contains('hidden')) return;
        if (!els.menuOptionsModal.classList.contains('hidden')) return;

        // Profile Modal açıkken kısayolları iptal et
        const profileModal = document.getElementById('profileModal');
        if (profileModal && !profileModal.classList.contains('hidden')) return;

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
            if (activeMode === 'flashcard') {
                // Spam koruması - buton tıklamasını simüle et
                if (!els.btnPass.style.pointerEvents || els.btnPass.style.pointerEvents !== 'none') {
                    els.btnPass.click();
                }
            }
            else if (activeMode === 'quiz' || activeMode === 'sentence') navigateHistory('next');
        }
        else if (e.key === 'ArrowLeft') {
            if (activeMode === 'flashcard') {
                // Spam koruması - buton tıklamasını simüle et
                if (!els.btnFail.style.pointerEvents || els.btnFail.style.pointerEvents !== 'none') {
                    els.btnFail.click();
                }
            }
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



// --- LEVEL SELECTION LOGIC ---
function initLevelSelection() {
    const levelBtns = document.querySelectorAll('.level-btn');
    levelBtns.forEach(btn => {
        const levelKey = btn.dataset.level;
        if (LEVEL_DATA[levelKey]) {
            const count = LEVEL_DATA[levelKey].length;
            const descSpan = btn.querySelector('.lvl-desc');
            if (descSpan) {
                descSpan.textContent += ` (${count.toLocaleString()} words)`;
            }
        }

        btn.addEventListener('click', (e) => {
            const selectedLevel = e.currentTarget.dataset.level;

            // BUG PREVENTION: Save current status before switch
            saveData();

            // Seçimi kaydet
            localStorage.setItem('ydspro_user_level_group', selectedLevel);

            // Update current highscore for the selected level
            speedHighScore = speedHighScoresByLevel[selectedLevel] || 0;
            if (els.highScoreDisplay) els.highScoreDisplay.textContent = speedHighScore;

            // Modalı kapat with animation
            const modal = document.getElementById('levelSelectionModal');
            closeModal(modal);

            // Level değiştirirken eski kartları temizle
            currentCard = null;
            nextCard = null;
            cardHistory = [];
            historyIndex = -1;

            // Sayfayı yenilemek yerine veriyi yükle ve oyunu başlat
            loadData();
            startGame(true); // Instant start
        });
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
    learnedCardsByLevel = JSON.parse(localStorage.getItem('ydspro_learned_by_level') || '{}');
    learnedCards = JSON.parse(localStorage.getItem('ydspro_learned') || '[]');
    favCards = JSON.parse(localStorage.getItem('ydspro_favs') || '[]');
    earnedBadges = JSON.parse(localStorage.getItem('ydspro_badges') || '[]');
    errorCards = JSON.parse(localStorage.getItem('ydspro_errors') || '[]');
    streakCount = parseInt(localStorage.getItem('ydspro_streak_count') || '0');
    lastStreakDate = localStorage.getItem('ydspro_streak_date') || '';

    // Level Group Loading Logic
    const currentLevelGroup = localStorage.getItem('ydspro_user_level_group') || 'A1-A2';

    // Migration logic for learnedCards
    if (learnedCards.length > 0 && Object.keys(learnedCardsByLevel).length === 0) {
        learnedCardsByLevel[currentLevelGroup] = learnedCards;
    }
    learnedCards = learnedCardsByLevel[currentLevelGroup] || [];

    // Low High Scores (Combined for legacy, but prioritized per level)
    const savedLevelScores = localStorage.getItem('ydspro_speed_highscores_by_level');
    if (savedLevelScores) {
        speedHighScoresByLevel = JSON.parse(savedLevelScores);
    }

    const legacyHighScore = parseInt(localStorage.getItem('ydspro_speed_highscore') || '0');

    // Migration logic
    if (Object.keys(speedHighScoresByLevel).length === 0 && legacyHighScore > 0) {
        speedHighScoresByLevel[currentLevelGroup] = legacyHighScore;
    }

    speedHighScore = speedHighScoresByLevel[currentLevelGroup] || 0;
    totalSpeedScore = parseInt(localStorage.getItem('ydspro_total_speed_score') || '0');

    // Mode Stats (for badges)
    totalQuizCorrect = parseInt(localStorage.getItem('ydspro_quiz_correct') || '0');
    totalSentenceCorrect = parseInt(localStorage.getItem('ydspro_sentence_correct') || '0');

    // Time Tracking
    totalTimeSpent = parseInt(localStorage.getItem('ydspro_time_spent') || '0');
    dailyTimeRecord = JSON.parse(localStorage.getItem('ydspro_daily_time') || '{}');

    // Level System & Profile
    userXP = parseInt(localStorage.getItem('ydspro_xp') || '0');
    userLevel = parseInt(localStorage.getItem('ydspro_level') || '1');
    userName = localStorage.getItem('ydspro_username') || 'Scholar';
    userAvatar = localStorage.getItem('ydspro_avatar') || '👤';

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

    // Level Group Loading Logic
    const savedLevelGroup = localStorage.getItem('ydspro_user_level_group');

    // Eğer veritabanında (levels.js) bu grup varsa onu yükle
    if (savedLevelGroup && typeof LEVEL_DATA !== 'undefined' && LEVEL_DATA[savedLevelGroup]) {
        currentWordData = LEVEL_DATA[savedLevelGroup];

        // Başlık güncellemeleri veya UI bildirimleri eklenebilir
        console.log("Loaded Level Group:", savedLevelGroup);
    } else {
        // Kayıtlı level yoksa fallback: LEVEL_DATA'dan ilk mevcut level
        const levelKeys = Object.keys(LEVEL_DATA);
        if (levelKeys.length > 0) {
            currentWordData = LEVEL_DATA[levelKeys[0]];
            console.log("Fallback to first level:", levelKeys[0]);
        } else {
            currentWordData = [];
            console.warn("No level data available!");
        }
    }

    if (els.highScoreDisplay) els.highScoreDisplay.textContent = speedHighScore;
    cardPool = currentWordData.filter(w => !learnedCards.includes(w.id));

    // Update word level badge in dashboard
    const wordLevelText = document.getElementById('wordLevelText');
    if (wordLevelText && savedLevelGroup) {
        wordLevelText.textContent = savedLevelGroup;
    }

    updateStats();
    checkStreak();
    checkDailyGoals();
    updateLevelUI();
}

function saveData() {
    const currentLevelGroup = localStorage.getItem('ydspro_user_level_group') || 'A1-A2';
    learnedCardsByLevel[currentLevelGroup] = learnedCards;

    localStorage.setItem('ydspro_learned_by_level', JSON.stringify(learnedCardsByLevel));
    localStorage.setItem('ydspro_learned', JSON.stringify(learnedCards)); // Keep legacy for safety
    localStorage.setItem('ydspro_favs', JSON.stringify(favCards));
    localStorage.setItem('ydspro_badges', JSON.stringify(earnedBadges));
    localStorage.setItem('ydspro_errors', JSON.stringify(errorCards));
    localStorage.setItem('ydspro_streak_count', streakCount.toString());
    localStorage.setItem('ydspro_streak_date', lastStreakDate);

    // Save per-level highscores
    speedHighScoresByLevel[currentLevelGroup] = speedHighScore;
    localStorage.setItem('ydspro_speed_highscores_by_level', JSON.stringify(speedHighScoresByLevel));

    localStorage.setItem('ydspro_speed_highscore', speedHighScore.toString()); // Keep legacy for safety
    localStorage.setItem('ydspro_total_speed_score', totalSpeedScore.toString());

    // Mode Stats (for badges)
    localStorage.setItem('ydspro_quiz_correct', totalQuizCorrect.toString());
    localStorage.setItem('ydspro_sentence_correct', totalSentenceCorrect.toString());

    // Time Tracking
    localStorage.setItem('ydspro_time_spent', totalTimeSpent.toString());

    // Level System & Profile
    localStorage.setItem('ydspro_xp', userXP.toString());
    localStorage.setItem('ydspro_level', userLevel.toString());
    localStorage.setItem('ydspro_username', userName);
    localStorage.setItem('ydspro_avatar', userAvatar);

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
        if (speedTime <= 10) {
            els.speedTimer.style.color = "#e74c3c";
            playSound('tick'); // Tick-tock for last 10 seconds
        }
        else els.speedTimer.style.color = "#e67e22";
        if (speedTime <= 0) endSpeedGame();
    }, 1000);
}

function nextSpeedQuestion() {
    const randomPool = currentWordData;
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

// --- PROFILE CUSTOMIZATION LOGIC ---
function initProfileCustomization() {
    // Open Modal Triggers
    const openProfile = () => {
        // Populate current values
        document.getElementById('profileNameInput').value = userName;
        document.querySelectorAll('.avatar-opt').forEach(btn => {
            btn.classList.toggle('selected', btn.dataset.avatar === userAvatar);
        });
        document.getElementById('profileModal').classList.remove('hidden');
    };

    if (els.userNameDisplay) els.userNameDisplay.parentElement.addEventListener('click', openProfile);
    if (els.userAvatarDisplay) els.userAvatarDisplay.parentElement.addEventListener('click', openProfile);

    // Close Modal
    const closeProfile = () => document.getElementById('profileModal').classList.add('hidden');
    document.getElementById('closeProfileModal').addEventListener('click', closeProfile);

    // Close on outside click
    document.getElementById('profileModal').addEventListener('click', (e) => {
        if (e.target === document.getElementById('profileModal')) closeProfile();
    });

    // Avatar Selection
    document.querySelectorAll('.avatar-opt').forEach(btn => {
        btn.addEventListener('click', (e) => {
            document.querySelectorAll('.avatar-opt').forEach(b => b.classList.remove('selected'));
            e.currentTarget.classList.add('selected');
        });
    });

    // Save Changes
    document.getElementById('saveProfileBtn').addEventListener('click', () => {
        const newName = document.getElementById('profileNameInput').value.trim();
        const selectedAvatarBtn = document.querySelector('.avatar-opt.selected');
        const newAvatar = selectedAvatarBtn ? selectedAvatarBtn.dataset.avatar : userAvatar;

        if (newName) {
            userName = newName;
            userAvatar = newAvatar;

            // Save to LocalStorage
            saveData();

            // Update UI
            updateLevelUI();

            // Show Success Notification
            showToast("Profile updated successfully!", "SAVED");

            // Close Modal
            closeProfile();
        } else {
            alert("Please enter a valid name!");
        }
    });
}

// Ensure this is initialized!
document.addEventListener('DOMContentLoaded', () => {
    initProfileCustomization();
});

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
    if (els.total) els.total.textContent = currentWordData.length;
    if (els.learned) els.learned.textContent = learnedCards.length;
    if (els.progressBar) els.progressBar.style.width = `${(learnedCards.length / currentWordData.length) * 100}%`;
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
        els.errorModeBtn.innerHTML = '<i class="fas fa-times" style="font-size:1.2rem;"></i>';
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
    let newBadge = false;
    BADGES.forEach(badge => {
        let currentProgress = 0;

        switch (badge.type) {
            case 'words': currentProgress = learnedCards.length; break;
            case 'score': currentProgress = totalSpeedScore; break;
            case 'level': currentProgress = userLevel; break;
            case 'quiz': currentProgress = totalQuizCorrect; break;
            case 'sentence': currentProgress = totalSentenceCorrect; break;
            case 'streak': currentProgress = streakCount; break;
        }

        if (currentProgress >= badge.count && !earnedBadges.includes(badge.id)) {
            earnedBadges.push(badge.id);
            showToast(`${badge.icon} ${badge.name} Badge Unlocked!`, "NEW ACHIEVEMENT!");
            newBadge = true;
        }
    });
    if (newBadge) localStorage.setItem('ydspro_badges', JSON.stringify(earnedBadges));
}

function showToast(message, title = "Notification") {
    // Create toast dynamically if it doesn't exist
    let toast = document.querySelector('.achievement-toast');
    if (!toast) {
        toast = document.createElement('div');
        toast.className = 'achievement-toast';
        document.body.appendChild(toast);
    }

    // Determine if it's an achievement notification
    const isAchievement = title.includes('ACHIEVEMENT');
    const icon = isAchievement ? '🏆' : '🔔';

    toast.innerHTML = `
        <div class="toast-icon">${icon}</div>
        <div class="toast-body">
            <span class="toast-title">${title}</span>
            <span class="toast-message">${message}</span>
        </div>
    `;

    // Add styles if not present
    if (!document.querySelector('#toast-styles')) {
        const style = document.createElement('style');
        style.id = 'toast-styles';
        style.textContent = `
            .achievement-toast {
                position: fixed;
                top: 20px;
                left: 50%;
                transform: translateX(-50%) translateY(-120px) scale(0.9);
                background: rgba(255, 255, 255, 0.95);
                backdrop-filter: blur(10px);
                -webkit-backdrop-filter: blur(10px);
                color: #1f2937;
                padding: 14px 20px;
                border-radius: 16px;
                box-shadow: 
                    0 20px 50px rgba(0, 0, 0, 0.15),
                    0 0 0 1px rgba(255, 255, 255, 0.5) inset,
                    0 0 30px rgba(245, 158, 11, 0.2);
                border: 2px solid rgba(245, 158, 11, 0.3);
                z-index: 99999;
                opacity: 0;
                transition: all 0.5s cubic-bezier(0.68, -0.55, 0.265, 1.55);
                display: flex;
                align-items: center;
                gap: 14px;
                min-width: 280px;
                max-width: 90%;
            }
            .achievement-toast.show {
                opacity: 1;
                transform: translateX(-50%) translateY(0) scale(1);
            }
            .toast-icon {
                font-size: 2em;
                filter: drop-shadow(0 2px 4px rgba(0,0,0,0.1));
                animation: bounce 0.6s ease;
            }
            @keyframes bounce {
                0%, 100% { transform: scale(1); }
                50% { transform: scale(1.2); }
            }
            .toast-body {
                display: flex;
                flex-direction: column;
                gap: 2px;
            }
            .toast-title {
                font-size: 0.7em;
                font-weight: 800;
                text-transform: uppercase;
                letter-spacing: 1.5px;
                color: #f59e0b;
            }
            .toast-message {
                font-size: 0.95em;
                font-weight: 600;
                color: #374151;
            }
            /* Dark Mode */
            body.dark-mode .achievement-toast {
                background: rgba(30, 30, 50, 0.95);
                border: 2px solid rgba(245, 158, 11, 0.4);
                box-shadow: 
                    0 20px 50px rgba(0, 0, 0, 0.4),
                    0 0 0 1px rgba(255, 255, 255, 0.1) inset,
                    0 0 30px rgba(245, 158, 11, 0.3);
            }
            body.dark-mode .toast-message {
                color: #e5e7eb;
            }
        `;
        document.head.appendChild(style);
    }

    // Play achievement sound if applicable
    if (isAchievement) {
        playSound('levelup');
    }

    // Trigger animation
    setTimeout(() => toast.classList.add('show'), 50);

    // Hide after 3.5 seconds
    setTimeout(() => {
        toast.classList.remove('show');
    }, 3500);
}

function openBadges() {
    els.badgeList.innerHTML = '';
    BADGES.forEach(badge => {
        const isUnlocked = earnedBadges.includes(badge.id);

        // Get progress based on badge type
        let progress = 0;
        let goalLabel = '';
        switch (badge.type) {
            case 'words':
                progress = learnedCards.length;
                goalLabel = 'words';
                break;
            case 'score':
                progress = totalSpeedScore;
                goalLabel = 'Speed pts';
                break;
            case 'level':
                progress = userLevel;
                goalLabel = 'Level';
                break;
            case 'quiz':
                progress = totalQuizCorrect;
                goalLabel = 'Quiz ✓';
                break;
            case 'sentence':
                progress = totalSentenceCorrect;
                goalLabel = 'Context ✓';
                break;
            case 'streak':
                progress = streakCount;
                goalLabel = 'days';
                break;
        }

        const div = document.createElement('div');
        div.className = `badge-item ${isUnlocked ? 'unlocked' : ''}`;
        let progressText = isUnlocked ? '✓ Unlocked!' : `${progress}/${badge.count} ${goalLabel}`;
        div.innerHTML = `
            <span class="badge-icon">${badge.icon}</span>
            <span class="badge-name">${badge.name}</span>
            <span style="font-size:0.65em; color:var(--text-sub)">${progressText}</span>
        `;
        els.badgeList.appendChild(div);
    });
    openModal(els.badgeModal);
}

// Render badges for Progress Modal (without opening old modal)
function renderBadges() {
    console.log('renderBadges called');
    const badgeList = document.getElementById('badgeList');
    console.log('badgeList element:', badgeList);
    console.log('BADGES array:', BADGES, 'length:', BADGES?.length);

    if (!badgeList) {
        console.error('badgeList element not found!');
        return;
    }

    badgeList.innerHTML = '';
    BADGES.forEach(badge => {
        const isUnlocked = earnedBadges.includes(badge.id);

        let progress = 0;
        let goalLabel = '';
        switch (badge.type) {
            case 'words': progress = learnedCards.length; goalLabel = 'words'; break;
            case 'score': progress = totalSpeedScore; goalLabel = 'pts'; break;
            case 'level': progress = userLevel; goalLabel = 'lvl'; break;
            case 'quiz': progress = totalQuizCorrect; goalLabel = '✓'; break;
            case 'sentence': progress = totalSentenceCorrect; goalLabel = '✓'; break;
            case 'streak': progress = streakCount; goalLabel = 'days'; break;
        }

        const div = document.createElement('div');
        div.className = `badge-item ${isUnlocked ? 'unlocked' : 'locked'}`;
        const progressText = isUnlocked ? '✓' : `${progress}/${badge.count}`;
        div.innerHTML = `
            <span class="badge-icon">${badge.icon}</span>
            <span class="badge-name">${badge.name}</span>
            <span class="badge-desc">${badge.desc}</span>
            <span class="badge-progress">${progressText}</span>
        `;
        badgeList.appendChild(div);
    });
}

// Update goals display in Progress Modal
function updateGoalsDisplay() {
    const wordsProgress = document.getElementById('wordsGoalProgress');
    const quizProgress = document.getElementById('quizGoalProgress');
    const correctProgress = document.getElementById('correctGoalProgress');

    const wordsStudied = document.getElementById('wordsStudied');
    const quizCompleted = document.getElementById('quizCompleted');
    const correctAnswers = document.getElementById('correctAnswers');

    if (!wordsProgress || !dailyGoals) return;

    const wordsPercent = Math.min((dailyGoals.wordsLearned / DAILY_TARGETS.words) * 100, 100);
    const quizPercent = Math.min((dailyGoals.quizCompleted / DAILY_TARGETS.quiz) * 100, 100);
    const correctPercent = Math.min((dailyGoals.correctAnswers / DAILY_TARGETS.correct) * 100, 100);

    wordsProgress.style.width = wordsPercent + '%';
    quizProgress.style.width = quizPercent + '%';
    correctProgress.style.width = correctPercent + '%';

    if (wordsStudied) wordsStudied.textContent = dailyGoals.wordsLearned;
    if (quizCompleted) quizCompleted.textContent = dailyGoals.quizCompleted;
    if (correctAnswers) correctAnswers.textContent = dailyGoals.correctAnswers;
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

// Doğrudan mod seçimi için yeni fonksiyon
function switchToMode(mode) {
    if (activeMode === mode) return; // Zaten bu moddaysa bir şey yapma

    clearInterval(speedInterval);
    activeMode = mode;

    // Tüm modları gizle
    els.flashcardMode.classList.add('hidden');
    els.quizMode.classList.add('hidden');
    els.sentenceMode.classList.add('hidden');
    els.speedMode.classList.add('hidden');

    cardHistory = [];
    historyIndex = -1;
    nextCard = null;

    if (nextCardEl) nextCardEl.style.display = (activeMode === 'flashcard') ? 'flex' : 'none';

    // Dropdown menüdeki aktif öğeyi güncelle
    document.querySelectorAll('.mode-option').forEach(opt => {
        opt.classList.remove('active');
        if (opt.dataset.mode === mode) {
            opt.classList.add('active');
        }
    });

    // Modu aktif et ve ikonu güncelle
    if (activeMode === 'flashcard') {
        els.modeToggle.innerHTML = '<i class="fas fa-clone"></i>';
        els.flashcardMode.classList.remove('hidden');
    } else if (activeMode === 'quiz') {
        els.modeToggle.innerHTML = '<i class="fas fa-question-circle"></i>';
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
    // Reset main card state immediately for next round
    els.card.style.transition = 'none';
    els.card.style.transform = '';
    els.card.classList.remove('swipe-right', 'swipe-left', 'flipped');

    // Force a small layout update before reenabling transitions
    void els.card.offsetWidth;

    if (nextCardEl) {
        nextCardEl.style.transition = 'none';
        nextCardEl.classList.remove('promote-card');
        void nextCardEl.offsetWidth;
        nextCardEl.style.transition = ''; // Restore CSS-defined transitions
    }

    els.card.style.transition = '';

    let activePool = [];
    if (isErrorReviewMode) {
        activePool = currentWordData.filter(w => errorCards.includes(w.id));
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
        currentCard = currentWordData.find(w => w.id === cardHistory[historyIndex]);
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
        if (cardHistory.length > HISTORY_CONFIG.maxSize) {
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

    // GLOBAL ANIMATION LOCK - Block if animation in progress
    if (isCardAnimating) return;
    isCardAnimating = true;

    // Play swipe sound for card transition (both directions)
    playSound('swipe');

    if (known) {
        updateStreak(true);
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

        // Release global animation lock
        isCardAnimating = false;
    }, ANIMATION_TIMING.cardSwipe); // Uses config constant
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
            currentCard = currentWordData.find(w => w.id === cardHistory[historyIndex]);
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
            currentCard = currentWordData.find(w => w.id === cardHistory[historyIndex]);
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
    if (isCardAnimating) return; // Block touch if animation in progress
    isDragging = true;
    startX = e.touches[0].clientX;
    startTime = Date.now();
    els.card.style.transition = 'none';
    els.card.querySelector('.flip-card-inner').style.transition = 'none';
}

function touchMove(e) {
    if (!isDragging) return;
    const currentX = e.touches[0].clientX;
    const diffX = currentX - startX;
    e.preventDefault();

    // Smoother rotation calculation with easing and translate3d
    const rotation = diffX / 15; // More sensitive
    const scale = 1 - Math.abs(diffX) / 1500;

    els.card.style.transform = `translate3d(${diffX}px, 0, 0) rotateZ(${rotation}deg) scale(${scale})`;

    // Smoother opacity feedback
    const progress = Math.min(Math.abs(diffX) / SWIPE_CONFIG.threshold, 1);
    const easeProgress = 1 - Math.pow(1 - progress, 3); // Cubic ease out

    if (diffX > 0) {
        els.btnPass.style.opacity = 0.5 + easeProgress * 0.5;
        els.btnPass.style.transform = `scale(${1 + easeProgress * 0.1})`;
        els.btnFail.style.opacity = 0.3;
        els.btnFail.style.transform = 'scale(1)';
    } else {
        els.btnFail.style.opacity = 0.5 + easeProgress * 0.5;
        els.btnFail.style.transform = `scale(${1 + easeProgress * 0.1})`;
        els.btnPass.style.opacity = 0.3;
        els.btnPass.style.transform = 'scale(1)';
    }
}

let startTime = 0;

function touchEnd(e) {
    if (!isDragging) return;
    if (isCardAnimating) { isDragging = false; return; } // Block if animating
    isDragging = false;

    const endX = e.changedTouches[0].clientX;
    const diffX = endX - startX;
    const duration = Date.now() - startTime;

    // Calculate velocity for momentum
    const velocity = Math.abs(diffX) / duration;
    const isSwipe = velocity > SWIPE_CONFIG.velocityThreshold || Math.abs(diffX) > SWIPE_CONFIG.threshold;

    // Reset button styles smoothly
    els.btnPass.style.transition = 'all 0.3s ease';
    els.btnFail.style.transition = 'all 0.3s ease';
    els.btnPass.style.opacity = 1;
    els.btnFail.style.opacity = 1;
    els.btnPass.style.transform = 'scale(1)';
    els.btnFail.style.transform = 'scale(1)';

    // Smooth card transition
    els.card.querySelector('.flip-card-inner').style.transition = 'transform 0.6s cubic-bezier(0.4, 0, 0.2, 1)';

    let answer = null;
    if (diffX > 0 && isSwipe) answer = true;
    else if (diffX < 0 && isSwipe) answer = false;

    if (answer !== null) {
        // Momentum-based fly out animation
        const flyDistance = diffX > 0 ? 400 : -400;
        const rotation = diffX > 0 ? 15 : -15;

        els.card.style.transition = 'transform 0.5s cubic-bezier(0.32, 0, 0.67, 0)';
        els.card.style.transform = `translateX(${flyDistance}px) rotateZ(${rotation}deg) scale(0.9)`;
        handleAnswer(answer);
    } else {
        // Elastic bounce back animation
        els.card.style.transition = 'transform 0.5s cubic-bezier(0.34, 1.56, 0.64, 1)';
        els.card.style.transform = 'translateX(0) rotateZ(0) scale(1)';
    }

    // Reset button transitions after animation
    setTimeout(() => {
        els.btnPass.style.transition = '';
        els.btnFail.style.transition = '';
    }, 300);
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
        let randomW = currentWordData[Math.floor(Math.random() * currentWordData.length)];
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

        // Increment mode-specific counters for badges
        if (activeMode === 'quiz') totalQuizCorrect++;
        else if (activeMode === 'sentence') totalSentenceCorrect++;

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
    else {
        favCards.push(currentCard.id);
        playSound('sparkle'); // Favorite added sound
    }
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
    openModal(els.dictModal);
    renderDict();
}

function renderDict() {
    const term = els.searchInput.value.toLowerCase();
    els.wordList.innerHTML = '';
    const filtered = currentWordData.filter(w => {
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
    // Mobilde performansı artırmak için XP animasyonunu atla
    if (window.innerWidth <= 768) return;

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

    // Profile Updates
    if (els.userNameDisplay) els.userNameDisplay.textContent = userName;
    if (els.userAvatarDisplay) {
        if (userAvatar && userAvatar.startsWith('data:image')) {
            els.userAvatarDisplay.innerHTML = `<img src="${userAvatar}" alt="User Avatar" style="width: 100%; height: 100%; border-radius: 50%; object-fit: cover; display: block;">`;
            // Remove any default background char styling if needed, though img covers it
            els.userAvatarDisplay.style.fontSize = '0'; // Hide any leakage
        } else {
            els.userAvatarDisplay.textContent = userAvatar;
            els.userAvatarDisplay.style.fontSize = ''; // Reset
            els.userAvatarDisplay.innerHTML = userAvatar; // Ensure no stale img
        }
    }

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

    openModal(els.goalsModal);
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

            case 'swipe':
                // Play actual MP3 file for paper sound
                const swipeAudio = new Audio('voices/swipe.mp3');
                swipeAudio.volume = 0.5;
                swipeAudio.play().catch(e => console.log('Swipe audio error:', e));
                return;

            case 'tick':
                // Tick-tock for speed mode countdown
                oscillator.frequency.setValueAtTime(1200, ctx.currentTime);
                oscillator.type = 'sine';
                gainNode.gain.setValueAtTime(0.15, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.08);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.08);
                break;

            case 'pop':
                // Modal open sound - soft pop
                oscillator.frequency.setValueAtTime(400, ctx.currentTime);
                oscillator.frequency.exponentialRampToValueAtTime(600, ctx.currentTime + 0.05);
                oscillator.type = 'sine';
                gainNode.gain.setValueAtTime(0.12, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.1);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.1);
                break;

            case 'whoosh':
                // Modal close sound - soft whoosh down
                oscillator.frequency.setValueAtTime(500, ctx.currentTime);
                oscillator.frequency.exponentialRampToValueAtTime(200, ctx.currentTime + 0.12);
                oscillator.type = 'sine';
                gainNode.gain.setValueAtTime(0.1, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.12);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.12);
                break;

            case 'sparkle':
                // Favorite/star sound - twinkle
                oscillator.frequency.setValueAtTime(1047, ctx.currentTime); // C6
                oscillator.frequency.setValueAtTime(1319, ctx.currentTime + 0.08); // E6
                oscillator.type = 'sine';
                gainNode.gain.setValueAtTime(0.15, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.2);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.2);
                break;

            case 'flip':
                // Card flip sound
                oscillator.frequency.setValueAtTime(300, ctx.currentTime);
                oscillator.frequency.exponentialRampToValueAtTime(450, ctx.currentTime + 0.08);
                oscillator.type = 'triangle';
                gainNode.gain.setValueAtTime(0.08, ctx.currentTime);
                gainNode.gain.exponentialRampToValueAtTime(0.01, ctx.currentTime + 0.1);
                oscillator.start(ctx.currentTime);
                oscillator.stop(ctx.currentTime + 0.1);
                break;
        }
    } catch (e) {
        console.log('Audio error:', e);
    }
}

// --- SPLASH SCREEN LOGIC ---
function hideSplashScreen() {
    const splash = document.getElementById('splashScreen');
    const statusText = splash?.querySelector('.splash-status');
    const progressBar = splash?.querySelector('.progress-bar');

    if (!splash) return;

    // Minimum delay for premium theatrical feel (uses config)
    const startTime = window.splashStartTime || Date.now();
    const elapsedTime = Date.now() - startTime;
    const minDelay = ANIMATION_TIMING.splashMinimum;

    // SMART PROGRESS BAR LOGIC - Milestones and Speed variations
    if (progressBar && statusText) {
        // Step 1: Initialization
        setTimeout(() => {
            progressBar.style.transition = 'width 1.5s ease-out';
            progressBar.style.width = '25%';
            statusText.textContent = "Initializing cognitive engines...";
        }, 100);

        // Step 2: Database Scan (Slower)
        setTimeout(() => {
            progressBar.style.transition = 'width 2.5s ease-in-out';
            progressBar.style.width = '55%';
            statusText.textContent = "Scanning word database...";
        }, 2000);

        // Step 3: Synch (Variable speed)
        setTimeout(() => {
            progressBar.style.transition = 'width 2s cubic-bezier(0.4, 0, 0.2, 1)';
            progressBar.style.width = '85%';
            statusText.textContent = "Synchronizing progress data...";
        }, 5000);

        // Step 4: Ready
        setTimeout(() => {
            progressBar.style.transition = 'width 1s ease-out';
            progressBar.style.width = '100%';
            statusText.textContent = "Boarding complete. Ready!";
        }, 7500);
    }

    const delay = Math.max(0, minDelay - elapsedTime);

    setTimeout(() => {
        splash.classList.add('fade-out');
        // Clean up DOM after transition
        setTimeout(() => splash.remove(), 1000);
    }, delay);
}

// SplashScreen logic definitions...

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

// --- PROFILE CUSTOMIZATION & AVATAR UPLOAD ---
function initProfileCustomization() {
    const avatarGrid = document.getElementById('avatarGrid');
    const uploadBtn = document.getElementById('uploadAvatarBtn');
    const fileInput = document.getElementById('avatarUpload');
    const nameInput = document.getElementById('profileNameInput');
    const saveBtn = document.getElementById('saveProfileBtn');
    const modal = document.getElementById('profileModal');

    if (!avatarGrid || !modal) return;

    // Hotfix: Refresh input value whenever initialization runs
    if (nameInput) {
        nameInput.value = userName || '';
        // Ensure input is interactive
        nameInput.onmousedown = (e) => e.stopPropagation();
    }

    // Header Interaction (Open Modal) - Click anywhere on the level card
    if (els.levelDisplay) {
        els.levelDisplay.style.cursor = 'pointer';
        els.levelDisplay.title = "Click to Edit Profile";
        els.levelDisplay.onclick = () => openModal(modal);
    }

    // Explicit Close Button Listener
    if (els.closeProfile) {
        els.closeProfile.onclick = () => closeModal(modal);
    }

    // Close on outside click
    modal.onclick = (e) => {
        if (e.target === modal) closeModal(modal);
    };

    // Render Avatars from Config
    avatarGrid.innerHTML = '';
    AVATAR_COLLECTION.forEach(av => {
        const isLocked = userLevel < av.level;
        const div = document.createElement('div');
        div.className = `avatar-opt ${userAvatar === av.char ? 'selected' : ''} ${isLocked ? 'locked' : ''}`;
        div.textContent = av.char;
        div.title = isLocked ? `Unlocks at Level ${av.level}` : av.name;

        div.onclick = () => {
            if (isLocked) {
                showToast(`🔒 Reach Level ${av.level} to unlock!`, "Avatar Locked");
                playSound('wrong');
                return;
            }
            // Deselect all
            document.querySelectorAll('.avatar-opt').forEach(el => el.classList.remove('selected'));
            div.classList.add('selected');

            // Remember selection
            avatarGrid.dataset.selected = av.char;
        };
        avatarGrid.appendChild(div);
    });

    // Custom Avatar Handling
    if (uploadBtn && fileInput) {
        uploadBtn.onclick = () => fileInput.click();
        fileInput.onchange = (e) => handleAvatarUpload(e);
    }

    if (saveBtn) {
        saveBtn.onclick = () => {
            const newName = nameInput.value.trim().substring(0, 15);
            const selectedEl = avatarGrid.querySelector('.selected');
            const newAvatar = avatarGrid.dataset.selected || (selectedEl ? selectedEl.textContent : userAvatar);

            if (newName || userAvatar !== newAvatar) {
                if (newName) userName = newName;
                userAvatar = newAvatar;
                saveData();
                updateLevelUI();
                closeModal(modal);
                showToast("Profile Updated!", "Success");
                playSound('correct');
            } else {
                closeModal(modal);
            }
        };
    }
}

function handleAvatarUpload(e) {
    const file = e.target.files[0];
    if (!file) return;

    if (file.size > 2 * 1024 * 1024) { // 2MB limit check
        showToast("Image too large. Max 2MB.", "Upload Failed");
        return;
    }

    const reader = new FileReader();
    reader.onload = function (event) {
        const img = new Image();
        img.onload = function () {
            const canvas = document.createElement('canvas');
            const ctx = canvas.getContext('2d');
            const MAX_SIZE = 150;
            let width = img.width;
            let height = img.height;

            if (width > height) {
                if (width > MAX_SIZE) {
                    height *= MAX_SIZE / width;
                    width = MAX_SIZE;
                }
            } else {
                if (height > MAX_SIZE) {
                    width *= MAX_SIZE / height;
                    height = MAX_SIZE;
                }
            }

            canvas.width = width;
            canvas.height = height;
            ctx.drawImage(img, 0, 0, width, height);

            const dataUrl = canvas.toDataURL('image/jpeg', 0.8);

            // Set as selected in UI
            const avatarGrid = document.getElementById('avatarGrid');
            if (avatarGrid) avatarGrid.dataset.selected = dataUrl;

            showToast("Photo processed! Click 'Save' to apply.", "Upload Success");
        };
        img.src = event.target.result;
    };
    reader.readAsDataURL(file);
}

init();
