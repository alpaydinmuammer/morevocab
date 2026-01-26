# 🚀 More Vocab

**More Vocab**, İngilizce kelime öğrenmeyi eğlenceli, interaktif ve modern bir deneyime dönüştüren premium bir Flutter uygulamasıdır. Tinder stili kaydırma mekaniği, gelişmiş mini oyunlar ve evrimleşen evcil hayvan sistemi ile öğrenme sürecini oyunlaştırır.

---

## ✨ Öne Çıkan Özellikler

### cards 1. Tinder Stili Öğrenme
- **Swipe-to-Learn:** Kelimeyi biliyorsan SAĞA, bilmiyorsan SOLA kaydır.
- **Görsel Hafıza:** Her kelime için özenle seçilmiş WebP formatında yüksek kaliteli görseller.
- **Sesli Telaffuz:** Yüksek kaliteli TTS (Text-to-Speech) desteği ile doğru telaffuzu dinle.

### 📚 2. Geniş İçerik Kütüphanesi (7 Farklı Deste)
Her seviyeye uygun, özenle hazırlanmış kelime setleri:
- **Beginner:** Başlangıç seviyesi için temel kelimeler.
- **Common:** Günlük hayatta en sık kullanılan kelimeler.
- **Exam / TOEFL:** Akademik ve sınav odaklı kelime dağarcığı.
- **Idioms:** İngilizce deyimler ve kültürel ifadeler.
- **Phrasal Verbs:** Öbek fiiller ve kullanımları.
- **Survival:** Seyahat ve acil durumlar için gerekli kelimeler.
- **YDS / YDT:** Türkiye'deki dil sınavlarına özel hazırlık seti.

### 🕹️ 3. Arcade Modu (Arcade Mode)
Geleneksel öğrenmenin dışına çıkın! Seviye bazlı ilerleme sistemi (Level-based Progression) ile 5 farklı mini oyun:
- **Word Chain:** Kelime zinciri kurarak zihnini zorla.
- **Anagram:** Karışık harflerden doğru kelimeyi bul.
- **Word Builder:** Harfleri birleştir, kelimeyi inşa et.
- **Emoji Puzzle:** Emojilerin anlattığı gizli kelimeyi tahmin et.
- **Odd One Out:** Farklı olanı bulma oyunu ile dikkatinizi test edin.

### 🎨 4. AI Destekli Görsel İçerik
- **Yüksek Kalite:** Tüm kelimeler için 500x500 özel optimize edilmiş WebP görseller.
- **AI Generation:** Eksik görseller, yapay zeka ile kelimenin anlamına en uygun şekilde üretilmiştir.

### 🥚 5. Evcil Hayvan Sistemi (Pet System)
- **Yumurtadan Başla:** Öğrenmeye başladığında bir yumurta seçersin.
- **Evrimleşme:** Kelime öğrendikçe ve puan topladıkça petin büyür ve evrim geçirir.
- **Kişisel Bağ:** Öğrenme motivasyonunu artıran tatlı dostlar.

### 🔥 6. Seri (Streak) ve Başarılar
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
