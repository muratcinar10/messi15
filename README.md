# Pusula Eğitim Merkezi

Flutter + Dart ile iOS ve Android için UI/UX prototipi. Web hedefi kolay önizleme için dahildir. Backend, API, veritabanı, gerçek kimlik doğrulama veya ödeme entegrasyonu yoktur.

## Çalıştırma

Flutter stable 3.47.6 / Dart 3.13.5 ile doğrulandı.

```sh
flutter pub get
flutter run
# Tarayıcı önizlemesi:
flutter run -d chrome
```

Bu çalışma klasöründe SDK `../../work/flutter-sdk/bin/flutter` konumunda da bulunur. Android çalıştırma için Android SDK ve araçları; iOS için Xcode ve simülatör gerekir.

## Klasör yapısı

```text
lib/
  main.dart
  core/
    theme/app_theme.dart
    routing/navigation_config.dart
    widgets/content_widgets.dart
    widgets/seven_navigation.dart
  models/entities.dart
  mock/
    mock_data.dart
    mock_repository.dart
  features/
    admin/admin_dashboard.dart
    teacher/teacher_dashboard.dart
    parent/parent_dashboard.dart
  shared/
    education_repository.dart
    demo_state.dart
    demo_app.dart
```

## Ekranlar

Demo rol seçimi; Yönetici, Öğretmen ve Veli için ayrı dashboard; her rolde merkezde büyük Ana Sayfa içeren 7 öğeli navigasyon; tüm kategori landing ekranları; bütün alt menüler için örnek kayıt/detail ekranları. Üstteki rol değiştirme butonu demo seçimine döner. Sistem geri hareketi detay → kategori → ana sayfa → rol seçimi sırasını izler.

Velide Ahmet/Zeynep selector tüm ekranlarda görünür. Eğitim, program, yoklama ve dashboard çocuk bağlamını kullanır. Ödemeler bütün çocukları kapsar. İletişim Tümü/Ahmet/Zeynep filtresiyle bağımsızdır; genel duyurular her filtrede görünür. Veliye giriş/çıkış ekranı sunulmaz. Ödeme özetinde Ekim aile toplamı 5.000 TL, ödenen 1.000 TL, kalan 4.000 TL'dir.

## Mock veri ve mimari

Widget → EducationRepository → MockRepository → MockData. Mock kayıtlar ve dashboard özetleri merkezi kaynaktadır. Öğrenciler sabit kimliklerle program, yoklama, görüş, görüşme, materyal, ödeme ve mesajlara bağlanır. Dört öğrenci, üç öğretmen ve iki sınıf içerir. Yönetici finans özeti Deniz'in geciken ödemesini de kapsar; veli yalnızca kendi iki çocuğunu görür.

Repository constructor ile enjekte edilir. Sonraki aşamada gerçek repository implementasyonu aynı arayüzle değiştirilebilir. `DemoState` rol, sekme, detail, aktif çocuk ve iletişim filtresini tutar. Yeniden başlatınca demo durumu sıfırlanır. Senkron arayüz bu yerel prototip için yeterlidir; ağ aşamasında loading/error durumları ve asenkron repository sözleşmesi eklenmelidir. Dashboard özetleri de gerçek verilerden hesaplanmalıdır.

## Doğrulama

`flutter analyze`: temiz. `flutter test`: 5 test geçti. `flutter build web --no-web-resources-cdn`: başarılı; render kaynakları yerel pakette. `flutter build ios --simulator`: başarılı. `flutter build apk --debug`: başarılı; yüklenebilir paket `pusula-demo.apk` olarak teslim edildi. Gerçek cihaz çalıştırması ve iOS dağıtım imzası doğrulanmadı. Widget testleri 320/375/430 px ekranlarda tüm rol ve alt menüleri açar; overflow, rol geçişi, büyük Ana Sayfa ikonu, ellipsis kullanılmaması, çocuk seçimi, aile ödemeleri ve bağımsız iletişim filtresini doğrular.

## Sonraki waterfall aşaması

Gerçek authentication/yetkiler ve repository entegrasyonu; öğrenci kayıt CRUD; program oluşturma/düzenleme; yoklama işlemleri; görüş/görüşme yönetimi; gerçek mesajlaşma ve bildirimler; materyal/dosya yükleme; ödeme planı/tahsilat süreçleri; tercihler ve dark mode. Bu prototipte işlem butonlarıyla sahte kayıt veya ödeme yapılmaz; detail ekranları okunabilir demo kayıtlardır.

## GitHub Pages

Demo adresi: https://muratcinar10.github.io/messi15/

`.github/workflows/deploy-pages.yml`, main push ile Flutter 3.47.6 kurar, analiz eder, `/messi15/` base path ile release build oluşturur ve GitHub Pages'e yükler. Repository Settings → Pages → Source: GitHub Actions kullanılmalıdır. Render kaynakları da artifact içinde sunulur.

Yerel üretim doğrulaması:

```sh
flutter pub get
flutter analyze
flutter build web --release --base-href "/messi15/" --no-web-resources-cdn
```
