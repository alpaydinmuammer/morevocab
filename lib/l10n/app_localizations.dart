import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fr.dart';
import 'app_localizations_it.dart';
import 'app_localizations_tr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fr'),
    Locale('it'),
    Locale('tr'),
  ];

  /// Greeting
  ///
  /// In tr, this message translates to:
  /// **'Merhaba'**
  String get hello;

  /// No description provided for @goodMorning.
  ///
  /// In tr, this message translates to:
  /// **'Günaydın'**
  String get goodMorning;

  /// No description provided for @goodAfternoon.
  ///
  /// In tr, this message translates to:
  /// **'İyi Günler'**
  String get goodAfternoon;

  /// No description provided for @goodEvening.
  ///
  /// In tr, this message translates to:
  /// **'İyi Akşamlar'**
  String get goodEvening;

  /// No description provided for @goodNight.
  ///
  /// In tr, this message translates to:
  /// **'İyi Geceler'**
  String get goodNight;

  /// No description provided for @motiveLateNight.
  ///
  /// In tr, this message translates to:
  /// **'Unutma; kelimeler önemli, uyku düzeni daha önemli.'**
  String get motiveLateNight;

  /// No description provided for @motive2am.
  ///
  /// In tr, this message translates to:
  /// **'O geri dönmeyecek ama kelimeler seni terketmez.'**
  String get motive2am;

  /// No description provided for @motiveMon.
  ///
  /// In tr, this message translates to:
  /// **'Haftaya yeni kelimelerle başlamak gibisi yok!'**
  String get motiveMon;

  /// No description provided for @motiveTue.
  ///
  /// In tr, this message translates to:
  /// **'Kelime öğren, kahve iç, tekrarla!'**
  String get motiveTue;

  /// No description provided for @motiveWed.
  ///
  /// In tr, this message translates to:
  /// **'Hava Durumu: Kelime öğrenmeye müsait.'**
  String get motiveWed;

  /// No description provided for @motiveThu.
  ///
  /// In tr, this message translates to:
  /// **'Kelimelerin biterse, susmak zorunda kalırsın.'**
  String get motiveThu;

  /// No description provided for @motiveFri.
  ///
  /// In tr, this message translates to:
  /// **'Tartışmada \'şey\' dememek için yeni kelimeler öğren.'**
  String get motiveFri;

  /// No description provided for @motiveSat.
  ///
  /// In tr, this message translates to:
  /// **'Kelimelere yatırım yap, enflasyondan etkilenmez.'**
  String get motiveSat;

  /// No description provided for @motiveSun.
  ///
  /// In tr, this message translates to:
  /// **'Bugün dünyayı kurtaramazsın ama birkaç kelime öğrenebilirsin.'**
  String get motiveSun;

  /// No description provided for @letsLearn.
  ///
  /// In tr, this message translates to:
  /// **'Hadi biraz kelime öğrenelim'**
  String get letsLearn;

  /// No description provided for @progressStatus.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme Durumu'**
  String get progressStatus;

  /// No description provided for @learned.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenildi'**
  String get learned;

  /// No description provided for @newWord.
  ///
  /// In tr, this message translates to:
  /// **'Yeni'**
  String get newWord;

  /// No description provided for @review.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar'**
  String get review;

  /// No description provided for @start.
  ///
  /// In tr, this message translates to:
  /// **'BAŞLA'**
  String get start;

  /// No description provided for @settings.
  ///
  /// In tr, this message translates to:
  /// **'Ayarlar'**
  String get settings;

  /// No description provided for @credits.
  ///
  /// In tr, this message translates to:
  /// **'Emeği Geçenler'**
  String get credits;

  /// No description provided for @idontknow.
  ///
  /// In tr, this message translates to:
  /// **'Bilmiyorum'**
  String get idontknow;

  /// No description provided for @flip.
  ///
  /// In tr, this message translates to:
  /// **'Çevir'**
  String get flip;

  /// No description provided for @iknow.
  ///
  /// In tr, this message translates to:
  /// **'Biliyorum'**
  String get iknow;

  /// No description provided for @theme.
  ///
  /// In tr, this message translates to:
  /// **'Tema'**
  String get theme;

  /// No description provided for @system.
  ///
  /// In tr, this message translates to:
  /// **'Sistem'**
  String get system;

  /// No description provided for @light.
  ///
  /// In tr, this message translates to:
  /// **'Açık'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In tr, this message translates to:
  /// **'Koyu'**
  String get dark;

  /// No description provided for @language.
  ///
  /// In tr, this message translates to:
  /// **'Dil'**
  String get language;

  /// No description provided for @turkish.
  ///
  /// In tr, this message translates to:
  /// **'Türkçe'**
  String get turkish;

  /// No description provided for @english.
  ///
  /// In tr, this message translates to:
  /// **'İngilizce'**
  String get english;

  /// No description provided for @spanish.
  ///
  /// In tr, this message translates to:
  /// **'İspanyolca'**
  String get spanish;

  /// No description provided for @french.
  ///
  /// In tr, this message translates to:
  /// **'Fransızca'**
  String get french;

  /// No description provided for @german.
  ///
  /// In tr, this message translates to:
  /// **'Almanca'**
  String get german;

  /// No description provided for @italian.
  ///
  /// In tr, this message translates to:
  /// **'İtalyanca'**
  String get italian;

  /// No description provided for @soundSettings.
  ///
  /// In tr, this message translates to:
  /// **'Ses Ayarları'**
  String get soundSettings;

  /// No description provided for @speed.
  ///
  /// In tr, this message translates to:
  /// **'Hız'**
  String get speed;

  /// No description provided for @volume.
  ///
  /// In tr, this message translates to:
  /// **'Ses Seviyesi'**
  String get volume;

  /// No description provided for @pitch.
  ///
  /// In tr, this message translates to:
  /// **'Perde'**
  String get pitch;

  /// No description provided for @testSound.
  ///
  /// In tr, this message translates to:
  /// **'Sesi Test Et'**
  String get testSound;

  /// No description provided for @resetProgress.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemeyi Sıfırla'**
  String get resetProgress;

  /// No description provided for @resetConfirmMessage.
  ///
  /// In tr, this message translates to:
  /// **'İlerlemeyi sıfırlamak istediğinize emin misiniz?'**
  String get resetConfirmMessage;

  /// No description provided for @resetSuccess.
  ///
  /// In tr, this message translates to:
  /// **'İlerleme sıfırlandı'**
  String get resetSuccess;

  /// No description provided for @dailyGoalCompleted.
  ///
  /// In tr, this message translates to:
  /// **'Günlük hedefini tamamladın.'**
  String get dailyGoalCompleted;

  /// No description provided for @congratulations.
  ///
  /// In tr, this message translates to:
  /// **'Tebrikler!'**
  String get congratulations;

  /// No description provided for @continueText.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get continueText;

  /// No description provided for @returnHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfaya Dön'**
  String get returnHome;

  /// No description provided for @conceptVision.
  ///
  /// In tr, this message translates to:
  /// **'KONSEPT VE VİZYON'**
  String get conceptVision;

  /// No description provided for @developmentCode.
  ///
  /// In tr, this message translates to:
  /// **'GELİŞTİRME VE KOD'**
  String get developmentCode;

  /// No description provided for @design.
  ///
  /// In tr, this message translates to:
  /// **'Tasarım (UI/UX)'**
  String get design;

  /// No description provided for @aiArchitecture.
  ///
  /// In tr, this message translates to:
  /// **'YAPAY ZEKA MİMARİSİ'**
  String get aiArchitecture;

  /// No description provided for @feedbackContact.
  ///
  /// In tr, this message translates to:
  /// **'FEEDBACK & CONTACT'**
  String get feedbackContact;

  /// No description provided for @emailJobOffers.
  ///
  /// In tr, this message translates to:
  /// **'E-Posta / İş Teklifleri'**
  String get emailJobOffers;

  /// No description provided for @cancel.
  ///
  /// In tr, this message translates to:
  /// **'İptal'**
  String get cancel;

  /// No description provided for @reset.
  ///
  /// In tr, this message translates to:
  /// **'Sıfırla'**
  String get reset;

  /// No description provided for @close.
  ///
  /// In tr, this message translates to:
  /// **'Kapat'**
  String get close;

  /// No description provided for @tapToSeeMeaning.
  ///
  /// In tr, this message translates to:
  /// **'Anlamı görmek için dokun'**
  String get tapToSeeMeaning;

  /// No description provided for @tapToReturn.
  ///
  /// In tr, this message translates to:
  /// **'Geri dönmek için dokun'**
  String get tapToReturn;

  /// No description provided for @data.
  ///
  /// In tr, this message translates to:
  /// **'Veri'**
  String get data;

  /// No description provided for @resetDescription.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenilen kelimeler sıfırlanır.'**
  String get resetDescription;

  /// No description provided for @loadingWords.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeler yükleniyor...'**
  String get loadingWords;

  /// No description provided for @retry.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Dene'**
  String get retry;

  /// No description provided for @wordsRemaining.
  ///
  /// In tr, this message translates to:
  /// **'{count} kelime kaldı'**
  String wordsRemaining(int count);

  /// No description provided for @iKnow.
  ///
  /// In tr, this message translates to:
  /// **'Biliyorum'**
  String get iKnow;

  /// No description provided for @iDontKnow.
  ///
  /// In tr, this message translates to:
  /// **'Bilmiyorum'**
  String get iDontKnow;

  /// No description provided for @sessionCompleted.
  ///
  /// In tr, this message translates to:
  /// **'Bu oturumu tamamladınız'**
  String get sessionCompleted;

  /// No description provided for @known.
  ///
  /// In tr, this message translates to:
  /// **'Bilinen'**
  String get known;

  /// No description provided for @studyAgain.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Çalış'**
  String get studyAgain;

  /// No description provided for @backToHome.
  ///
  /// In tr, this message translates to:
  /// **'Ana Sayfaya Dön'**
  String get backToHome;

  /// No description provided for @conceptAndVision.
  ///
  /// In tr, this message translates to:
  /// **'Konsept ve Vizyon'**
  String get conceptAndVision;

  /// No description provided for @developmentAndCode.
  ///
  /// In tr, this message translates to:
  /// **'Geliştirme ve Kod'**
  String get developmentAndCode;

  /// No description provided for @feedbackAndContact.
  ///
  /// In tr, this message translates to:
  /// **'Geri Bildirim & İletişim'**
  String get feedbackAndContact;

  /// No description provided for @selectDeck.
  ///
  /// In tr, this message translates to:
  /// **'Deste Seç'**
  String get selectDeck;

  /// No description provided for @whichDeckIntro.
  ///
  /// In tr, this message translates to:
  /// **'Hangi desteyle çalışmak istersin?'**
  String get whichDeckIntro;

  /// No description provided for @newLabel.
  ///
  /// In tr, this message translates to:
  /// **'YENİ'**
  String get newLabel;

  /// No description provided for @comingSoon.
  ///
  /// In tr, this message translates to:
  /// **'Çok Yakında...'**
  String get comingSoon;

  /// No description provided for @strategiesCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} strateji'**
  String strategiesCount(int count);

  /// No description provided for @deckWordCount.
  ///
  /// In tr, this message translates to:
  /// **'{count} kelime'**
  String deckWordCount(int count);

  /// No description provided for @total.
  ///
  /// In tr, this message translates to:
  /// **'Toplam'**
  String get total;

  /// No description provided for @unknown.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen'**
  String get unknown;

  /// No description provided for @learning.
  ///
  /// In tr, this message translates to:
  /// **'Öğreniliyor'**
  String get learning;

  /// No description provided for @mastered.
  ///
  /// In tr, this message translates to:
  /// **'Uzmanlaşıldı'**
  String get mastered;

  /// No description provided for @deckMixed.
  ///
  /// In tr, this message translates to:
  /// **'Karışık'**
  String get deckMixed;

  /// No description provided for @deckYdsYdt.
  ///
  /// In tr, this message translates to:
  /// **'YDS/YDT Kelimeler'**
  String get deckYdsYdt;

  /// No description provided for @deckBeginner.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç Seviyesi'**
  String get deckBeginner;

  /// No description provided for @deckSurvival.
  ///
  /// In tr, this message translates to:
  /// **'Survival English'**
  String get deckSurvival;

  /// No description provided for @deckPhrasalVerbs.
  ///
  /// In tr, this message translates to:
  /// **'Phrasal Verbs'**
  String get deckPhrasalVerbs;

  /// No description provided for @deckIdioms.
  ///
  /// In tr, this message translates to:
  /// **'Deyimler ve Argo'**
  String get deckIdioms;

  /// No description provided for @deckExamStrategies.
  ///
  /// In tr, this message translates to:
  /// **'Sınav Stratejileri'**
  String get deckExamStrategies;

  /// No description provided for @wordsRemainingLabel.
  ///
  /// In tr, this message translates to:
  /// **'kelime kaldı'**
  String get wordsRemainingLabel;

  /// No description provided for @deckMixedDesc.
  ///
  /// In tr, this message translates to:
  /// **'Tüm kelimelerden karışık'**
  String get deckMixedDesc;

  /// No description provided for @deckYdsYdtDesc.
  ///
  /// In tr, this message translates to:
  /// **'Akademik sınav kelimeleri'**
  String get deckYdsYdtDesc;

  /// No description provided for @deckBeginnerDesc.
  ///
  /// In tr, this message translates to:
  /// **'Başlangıç seviyesi'**
  String get deckBeginnerDesc;

  /// No description provided for @deckSurvivalDesc.
  ///
  /// In tr, this message translates to:
  /// **'Günlük hayat ve seyahat'**
  String get deckSurvivalDesc;

  /// No description provided for @deckPhrasalVerbsDesc.
  ///
  /// In tr, this message translates to:
  /// **'Yaygın phrasal verb\'ler'**
  String get deckPhrasalVerbsDesc;

  /// No description provided for @deckIdiomsDesc.
  ///
  /// In tr, this message translates to:
  /// **'Deyimler ve argo ifadeler'**
  String get deckIdiomsDesc;

  /// No description provided for @deckExamStrategiesDesc.
  ///
  /// In tr, this message translates to:
  /// **'Sınav taktikleri ve ipuçları'**
  String get deckExamStrategiesDesc;

  /// No description provided for @allWords.
  ///
  /// In tr, this message translates to:
  /// **'Tüm Kelimeler'**
  String get allWords;

  /// No description provided for @unknownWords.
  ///
  /// In tr, this message translates to:
  /// **'Bilinmeyen Kelimeler'**
  String get unknownWords;

  /// No description provided for @learningWords.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenilen Kelimeler'**
  String get learningWords;

  /// No description provided for @masteredWords.
  ///
  /// In tr, this message translates to:
  /// **'Uzmanlaşılan Kelimeler'**
  String get masteredWords;

  /// No description provided for @addNewWord.
  ///
  /// In tr, this message translates to:
  /// **'Yeni Kelime Ekle'**
  String get addNewWord;

  /// No description provided for @enterWordPrompt.
  ///
  /// In tr, this message translates to:
  /// **'İngilizce bir kelime gir. Yapay zeka gerisini oluşturacak!'**
  String get enterWordPrompt;

  /// No description provided for @wordExample.
  ///
  /// In tr, this message translates to:
  /// **'örn., Serendipity'**
  String get wordExample;

  /// No description provided for @generateAndAdd.
  ///
  /// In tr, this message translates to:
  /// **'Oluştur ve Ekle'**
  String get generateAndAdd;

  /// No description provided for @noWordsYet.
  ///
  /// In tr, this message translates to:
  /// **'Henüz kelime yok!'**
  String get noWordsYet;

  /// No description provided for @tapToAddWords.
  ///
  /// In tr, this message translates to:
  /// **'Yapay zeka ile kelime eklemek için + işaretine dokun.'**
  String get tapToAddWords;

  /// No description provided for @addWord.
  ///
  /// In tr, this message translates to:
  /// **'Kelime Ekle'**
  String get addWord;

  /// No description provided for @failedToGenerate.
  ///
  /// In tr, this message translates to:
  /// **'İçerik oluşturulamadı. İnternet bağlantısını/API anahtarını kontrol edin.'**
  String get failedToGenerate;

  /// No description provided for @wordAdded.
  ///
  /// In tr, this message translates to:
  /// **'{word} kelimesi {deck} destesine eklendi!'**
  String wordAdded(String word, String deck);

  /// No description provided for @errorOccurred.
  ///
  /// In tr, this message translates to:
  /// **'Hata: {error}'**
  String errorOccurred(String error);

  /// No description provided for @createDeck.
  ///
  /// In tr, this message translates to:
  /// **'Deste Oluştur'**
  String get createDeck;

  /// No description provided for @nameYourDeck.
  ///
  /// In tr, this message translates to:
  /// **'Destene bir isim ver'**
  String get nameYourDeck;

  /// No description provided for @deckNameHint.
  ///
  /// In tr, this message translates to:
  /// **'örn., Favoriler, Zor Kelimeler'**
  String get deckNameHint;

  /// No description provided for @create.
  ///
  /// In tr, this message translates to:
  /// **'Oluştur'**
  String get create;

  /// No description provided for @examples.
  ///
  /// In tr, this message translates to:
  /// **'Örnekler'**
  String get examples;

  /// No description provided for @moreVocab.
  ///
  /// In tr, this message translates to:
  /// **'More Vocab'**
  String get moreVocab;

  /// No description provided for @loadingError.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeler yüklenemedi'**
  String get loadingError;

  /// No description provided for @noWordsInDeck.
  ///
  /// In tr, this message translates to:
  /// **'Bu destede kelime yok'**
  String get noWordsInDeck;

  /// No description provided for @motivationalExcellent.
  ///
  /// In tr, this message translates to:
  /// **'Mükemmel! Harikasın!'**
  String get motivationalExcellent;

  /// No description provided for @motivationalGreat.
  ///
  /// In tr, this message translates to:
  /// **'Harika iş! Böyle devam!'**
  String get motivationalGreat;

  /// No description provided for @motivationalGood.
  ///
  /// In tr, this message translates to:
  /// **'İyi gidiyorsun! Öğreniyorsun!'**
  String get motivationalGood;

  /// No description provided for @motivationalKeepPracticing.
  ///
  /// In tr, this message translates to:
  /// **'Pratik yapmaya devam et, başaracaksın!'**
  String get motivationalKeepPracticing;

  /// No description provided for @petSelectTitle.
  ///
  /// In tr, this message translates to:
  /// **'Evcil Hayvanını Seç'**
  String get petSelectTitle;

  /// No description provided for @petSelectSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenme yolculuğunda sana eşlik edecek'**
  String get petSelectSubtitle;

  /// No description provided for @petNameTitle.
  ///
  /// In tr, this message translates to:
  /// **'Petine İsim Ver'**
  String get petNameTitle;

  /// No description provided for @petNameHint.
  ///
  /// In tr, this message translates to:
  /// **'İsim gir...'**
  String get petNameHint;

  /// No description provided for @petDragon.
  ///
  /// In tr, this message translates to:
  /// **'Ejderha'**
  String get petDragon;

  /// No description provided for @petDragonDesc.
  ///
  /// In tr, this message translates to:
  /// **'Ateşli ve güçlü'**
  String get petDragonDesc;

  /// No description provided for @petEagle.
  ///
  /// In tr, this message translates to:
  /// **'Kartal'**
  String get petEagle;

  /// No description provided for @petEagleDesc.
  ///
  /// In tr, this message translates to:
  /// **'Özgür ve keskin'**
  String get petEagleDesc;

  /// No description provided for @petWolf.
  ///
  /// In tr, this message translates to:
  /// **'Kurt'**
  String get petWolf;

  /// No description provided for @petWolfDesc.
  ///
  /// In tr, this message translates to:
  /// **'Yediği ayazı unutmaz'**
  String get petWolfDesc;

  /// No description provided for @petFox.
  ///
  /// In tr, this message translates to:
  /// **'Tilki'**
  String get petFox;

  /// No description provided for @petFoxDesc.
  ///
  /// In tr, this message translates to:
  /// **'Zeki ve çevik'**
  String get petFoxDesc;

  /// No description provided for @petLevelUp.
  ///
  /// In tr, this message translates to:
  /// **'Level Atladın!'**
  String get petLevelUp;

  /// No description provided for @petEvolved.
  ///
  /// In tr, this message translates to:
  /// **'{name} evrimleşti!'**
  String petEvolved(String name);

  /// No description provided for @petXpGained.
  ///
  /// In tr, this message translates to:
  /// **'+{xp} XP'**
  String petXpGained(int xp);

  /// No description provided for @petLevel.
  ///
  /// In tr, this message translates to:
  /// **'Level {level}'**
  String petLevel(int level);

  /// No description provided for @petStageBaby.
  ///
  /// In tr, this message translates to:
  /// **'Yavru'**
  String get petStageBaby;

  /// No description provided for @petStageYoung.
  ///
  /// In tr, this message translates to:
  /// **'Genç'**
  String get petStageYoung;

  /// No description provided for @petStageAdult.
  ///
  /// In tr, this message translates to:
  /// **'Yetişkin'**
  String get petStageAdult;

  /// No description provided for @petStageLegendary.
  ///
  /// In tr, this message translates to:
  /// **'Efsanevi'**
  String get petStageLegendary;

  /// No description provided for @petTapToHatch.
  ///
  /// In tr, this message translates to:
  /// **'Dokun'**
  String get petTapToHatch;

  /// No description provided for @petContinue.
  ///
  /// In tr, this message translates to:
  /// **'Devam Et'**
  String get petContinue;

  /// No description provided for @petLetsStart.
  ///
  /// In tr, this message translates to:
  /// **'Başlayalım!'**
  String get petLetsStart;

  /// No description provided for @petEvolution.
  ///
  /// In tr, this message translates to:
  /// **'EVRİM!'**
  String get petEvolution;

  /// No description provided for @petNextEvolution.
  ///
  /// In tr, this message translates to:
  /// **'Level {level} evrim'**
  String petNextEvolution(int level);

  /// No description provided for @editName.
  ///
  /// In tr, this message translates to:
  /// **'İsmini Düzenle'**
  String get editName;

  /// No description provided for @save.
  ///
  /// In tr, this message translates to:
  /// **'Kaydet'**
  String get save;

  /// No description provided for @enterYourName.
  ///
  /// In tr, this message translates to:
  /// **'Adınızı girin'**
  String get enterYourName;

  /// No description provided for @totalXp.
  ///
  /// In tr, this message translates to:
  /// **'Toplam XP'**
  String get totalXp;

  /// No description provided for @nextEvolution.
  ///
  /// In tr, this message translates to:
  /// **'Sonraki Evrim'**
  String get nextEvolution;

  /// No description provided for @status.
  ///
  /// In tr, this message translates to:
  /// **'Durum'**
  String get status;

  /// No description provided for @maximum.
  ///
  /// In tr, this message translates to:
  /// **'Maksimum!'**
  String get maximum;

  /// No description provided for @ok.
  ///
  /// In tr, this message translates to:
  /// **'Tamam'**
  String get ok;

  /// No description provided for @becameStage.
  ///
  /// In tr, this message translates to:
  /// **'{stage} oldu!'**
  String becameStage(String stage);

  /// No description provided for @authTagline.
  ///
  /// In tr, this message translates to:
  /// **'Akıllı kelime öğrenme'**
  String get authTagline;

  /// No description provided for @authTermsNotice.
  ///
  /// In tr, this message translates to:
  /// **'Giriş yaparak Kullanım Koşullarını kabul etmiş olursunuz'**
  String get authTermsNotice;

  /// No description provided for @continueWithGoogle.
  ///
  /// In tr, this message translates to:
  /// **'Google ile Devam Et'**
  String get continueWithGoogle;

  /// No description provided for @continueWithApple.
  ///
  /// In tr, this message translates to:
  /// **'Apple ile Devam Et'**
  String get continueWithApple;

  /// No description provided for @signOut.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış Yap'**
  String get signOut;

  /// No description provided for @signOutConfirm.
  ///
  /// In tr, this message translates to:
  /// **'Çıkış yapmak istediğinize emin misiniz?'**
  String get signOutConfirm;

  /// No description provided for @authErrorNetwork.
  ///
  /// In tr, this message translates to:
  /// **'Bağlantı hatası. İnternet bağlantınızı kontrol edin.'**
  String get authErrorNetwork;

  /// No description provided for @authErrorCancelled.
  ///
  /// In tr, this message translates to:
  /// **'Giriş iptal edildi.'**
  String get authErrorCancelled;

  /// No description provided for @authErrorGeneric.
  ///
  /// In tr, this message translates to:
  /// **'Giriş başarısız. Lütfen tekrar deneyin.'**
  String get authErrorGeneric;

  /// No description provided for @continueAsGuest.
  ///
  /// In tr, this message translates to:
  /// **'Misafir Olarak Devam Et'**
  String get continueAsGuest;

  /// No description provided for @signIn.
  ///
  /// In tr, this message translates to:
  /// **'Giriş Yap'**
  String get signIn;

  /// No description provided for @orText.
  ///
  /// In tr, this message translates to:
  /// **'veya'**
  String get orText;

  /// No description provided for @onboardingSkip.
  ///
  /// In tr, this message translates to:
  /// **'Atla'**
  String get onboardingSkip;

  /// No description provided for @onboardingNext.
  ///
  /// In tr, this message translates to:
  /// **'İleri'**
  String get onboardingNext;

  /// No description provided for @onboardingStart.
  ///
  /// In tr, this message translates to:
  /// **'Başlayalım!'**
  String get onboardingStart;

  /// No description provided for @onboardingWelcomeTitle.
  ///
  /// In tr, this message translates to:
  /// **'More Vocab'**
  String get onboardingWelcomeTitle;

  /// No description provided for @onboardingWelcomeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kelimeleri kaydırarak öğren.'**
  String get onboardingWelcomeSubtitle;

  /// No description provided for @onboardingSwipeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kaydır ve Öğren'**
  String get onboardingSwipeTitle;

  /// No description provided for @onboardingSwipeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Biliyorsan sağa, bilmiyorsan sola kaydır. Bu kadar basit!'**
  String get onboardingSwipeSubtitle;

  /// No description provided for @onboardingSrsTitle.
  ///
  /// In tr, this message translates to:
  /// **'Akıllı Tekrar'**
  String get onboardingSrsTitle;

  /// No description provided for @onboardingSrsSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Algoritmamız kelimeleri akıllı aralıklarla tekrar göstererek öğrendiğinizden emin olur.'**
  String get onboardingSrsSubtitle;

  /// No description provided for @onboardingPetTitle.
  ///
  /// In tr, this message translates to:
  /// **'Pet Arkadaşın'**
  String get onboardingPetTitle;

  /// No description provided for @onboardingPetSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Öğrenme yolculuğunda sana yoldaş olacak bir evcil hayvan seç. Sen yeni kelimeler öğren. O da büyüyüp evrimleşsin.'**
  String get onboardingPetSubtitle;

  /// No description provided for @onboardingDecksTitle.
  ///
  /// In tr, this message translates to:
  /// **'Kelime Desteleri'**
  String get onboardingDecksTitle;

  /// No description provided for @onboardingDecksSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Senin için özel oluşturulmuş destelerden istediğini seç.'**
  String get onboardingDecksSubtitle;

  /// No description provided for @onboardingReadyTitle.
  ///
  /// In tr, this message translates to:
  /// **'Hazırsın!'**
  String get onboardingReadyTitle;

  /// No description provided for @onboardingReadySubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Her gün 10 dakika, büyük fark yaratır. Yolculuğuna başla!'**
  String get onboardingReadySubtitle;

  /// No description provided for @creditsDevelopment.
  ///
  /// In tr, this message translates to:
  /// **'Geliştirme'**
  String get creditsDevelopment;

  /// No description provided for @creditsDesign.
  ///
  /// In tr, this message translates to:
  /// **'UI / UX Tasarım'**
  String get creditsDesign;

  /// No description provided for @creditsTechnology.
  ///
  /// In tr, this message translates to:
  /// **'Temel Teknoloji'**
  String get creditsTechnology;

  /// No description provided for @creditsVersion.
  ///
  /// In tr, this message translates to:
  /// **'Sürüm'**
  String get creditsVersion;

  /// No description provided for @contactUs.
  ///
  /// In tr, this message translates to:
  /// **'Bana Ulaşın'**
  String get contactUs;

  /// No description provided for @arcadeMode.
  ///
  /// In tr, this message translates to:
  /// **'Arcade'**
  String get arcadeMode;

  /// No description provided for @arcadeTitle.
  ///
  /// In tr, this message translates to:
  /// **'Oyunlar'**
  String get arcadeTitle;

  /// No description provided for @arcadeSubtitle.
  ///
  /// In tr, this message translates to:
  /// **'Kelime öğrenmenin eğlenceli yolları'**
  String get arcadeSubtitle;

  /// No description provided for @gameWordChain.
  ///
  /// In tr, this message translates to:
  /// **'Kelime Zinciri'**
  String get gameWordChain;

  /// No description provided for @gameWordChainDesc.
  ///
  /// In tr, this message translates to:
  /// **'Son harfle başlayan kelimeler yaz'**
  String get gameWordChainDesc;

  /// No description provided for @gameAnagram.
  ///
  /// In tr, this message translates to:
  /// **'Anagram'**
  String get gameAnagram;

  /// No description provided for @gameAnagramDesc.
  ///
  /// In tr, this message translates to:
  /// **'Karışık harflerden kelime bul'**
  String get gameAnagramDesc;

  /// No description provided for @gameWordBuilder.
  ///
  /// In tr, this message translates to:
  /// **'Kelime İnşaatı'**
  String get gameWordBuilder;

  /// No description provided for @gameWordBuilderDesc.
  ///
  /// In tr, this message translates to:
  /// **'Heceleri sıralayarak kelime oluştur'**
  String get gameWordBuilderDesc;

  /// No description provided for @gameEmojiPuzzle.
  ///
  /// In tr, this message translates to:
  /// **'Emoji Bulmaca'**
  String get gameEmojiPuzzle;

  /// No description provided for @gameEmojiPuzzleDesc.
  ///
  /// In tr, this message translates to:
  /// **'Emojilerden kelime tahmin et'**
  String get gameEmojiPuzzleDesc;

  /// No description provided for @gameOddOneOut.
  ///
  /// In tr, this message translates to:
  /// **'Farklı Olanı Bul'**
  String get gameOddOneOut;

  /// No description provided for @gameOddOneOutDesc.
  ///
  /// In tr, this message translates to:
  /// **'Alakasız kelimeyi bul'**
  String get gameOddOneOutDesc;

  /// No description provided for @score.
  ///
  /// In tr, this message translates to:
  /// **'Puan'**
  String get score;

  /// No description provided for @timeLeft.
  ///
  /// In tr, this message translates to:
  /// **'Kalan Süre'**
  String get timeLeft;

  /// No description provided for @yourTurn.
  ///
  /// In tr, this message translates to:
  /// **'Senin Sıran'**
  String get yourTurn;

  /// No description provided for @correct.
  ///
  /// In tr, this message translates to:
  /// **'Doğru!'**
  String get correct;

  /// No description provided for @incorrect.
  ///
  /// In tr, this message translates to:
  /// **'Yanlış!'**
  String get incorrect;

  /// No description provided for @gameOver.
  ///
  /// In tr, this message translates to:
  /// **'Oyun Bitti'**
  String get gameOver;

  /// No description provided for @playAgain.
  ///
  /// In tr, this message translates to:
  /// **'Tekrar Oyna'**
  String get playAgain;

  /// No description provided for @comingSoonGame.
  ///
  /// In tr, this message translates to:
  /// **'Çok Yakında'**
  String get comingSoonGame;

  /// No description provided for @offlineWarning.
  ///
  /// In tr, this message translates to:
  /// **'İnternet bağlantınız yok. Kelime doğrulama düzgün çalışmayabilir. Yine de devam etmek ister misiniz?'**
  String get offlineWarning;

  /// No description provided for @continueOffline.
  ///
  /// In tr, this message translates to:
  /// **'Çevrimdışı Devam Et'**
  String get continueOffline;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'de',
    'en',
    'es',
    'fr',
    'it',
    'tr',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fr':
      return AppLocalizationsFr();
    case 'it':
      return AppLocalizationsIt();
    case 'tr':
      return AppLocalizationsTr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
