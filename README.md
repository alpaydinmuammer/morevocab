# 🚀 More Vocab

**More Vocab**, İngilizce kelime öğrenmeyi eğlenceli, interaktif ve modern bir deneyime dönüştüren premium bir Flutter uygulamasıdır. Tinder stili kaydırma mekaniği, gelişmiş mini oyunlar ve evrimleşen evcil hayvan sistemi ile öğrenme sürecini oyunlaştırır.

---

## ✨ Öne Çıkan Özellikler

### cards 1. Tinder Stili Öğrenme
- **Swipe-to-Learn:** Kelimeyi biliyorsan SAĞA, bilmiyorsan SOLA kaydır.
- **Görsel Hafıza:** Her kelime için özenle seçilmiş WebP formatında yüksek kaliteli görseller.
- **Sesli Telaffuz:** Yüksek kaliteli TTS (Text-to-Speech) desteği ile doğru telaffuzu dinle.

### 🕹️ 2. Arcade Modu (Arcade Mode)
Geleneksel öğrenmenin dışına çıkın! 5 farklı mini oyun ile kelime bilginizi test edin:
- **Word Chain:** Önceki kelimenin son harfiyle yeni kelime üret.
- **Anagram:** Karışık harflerden doğru kelimeyi bul.
- **Word Builder:** Eksik harfleri tamamlayarak kelimeyi inşa et.
- **Emoji Puzzle:** Emojilerin anlattığı gizli kelimeyi tahmin et.
- **Odd One Out:** Birbirine uymayan kelimeyi gruptan ayıkla.

### 🥚 3. Evcil Hayvan Sistemi (Pet System)
- **Yumurtadan Başla:** Öğrenmeye başladığında bir yumurta seçersin.
- **Evrimleşme:** Kelime öğrendikçe ve puan topladıkça petin büyür ve evrim geçirir.
- **Kişisel Bağ:** Öğrenme motivasyonunu artıran tatlı dostlar.

### 🔥 4. Seri (Streak) ve Başarılar
- **Günlük Hedef:** Her gün çalışarak "Streak" puanını koru.
- **Premium Rozetler:** Başarılarını sergilemek için özel tasarım rozetler kazan.

---

## 🎨 Tasarım Felsefesi
Uygulama, en modern web ve mobil tasarım trendlerini takip eder:
- **Glassmorphism:** Saydam ve şık panel tasarımları.
- **Mesh Gradients:** Canlı ve dinamik arka planlar.
- **Premium Background:** Özel "Grain" (kumlanma) efekti ile derinlik kazandırılmış arayüz.
- **Lottie Animations:** Akıcı ve etkileyici geçiş animasyonları.

---

## 🛠️ Teknik Stack

- **Framework:** Flutter (Android & iOS)
- **State Management:** Riverpod (Scalable & Robust)
- **Backend:** Firebase (Authentication, Firestore, Analytics)
- **Navigation:** GoRouter
- **Storage:** SharedPreferences & Offline Word DB
- **UI & Animation:** 
  - `flutter_card_swiper` (Core learning engine)
  - `lottie` (Liquid animations)
  - `cached_network_image` (Fast image loading)
  - `google_fonts` (Modern typography)

---

## 🚀 Kurulum ve Derleme (Build)

Uygulamayı yerel cihazınızda çalıştırmak için:

1.  Repoyu klonlayın: `git clone https://github.com/muammer/morevocab.git`
2.  Bağımlılıkları yükleyin: `flutter pub get`
3.  Firebase konfigürasyonlarını eklediğinizden emin olun (`google-services.json`).
4.  Uygulamayı çalıştırın: `flutter run`

### 📦 APK Boyutunu Küçültme (Optimized Build)
Uygulamanın APK boyutunu minimuma düşürmek için şu komutu kullanın:

```bash
flutter build apk --release --split-per-abi --obfuscate --split-debug-info=build/app/outputs/symbols
```
*Bu komut, uygulamanızı yaklaşık **15-20 MB** arasına düşürecek 3 farklı APK üretir.*

---

*Created with ❤️ by **Muammer Alpaydın***
