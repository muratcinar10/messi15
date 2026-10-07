import '../models/entities.dart';

class MockData {
  static const date = '7 Ekim Çarşamba';
  static const students = [
    Student('ahmet', 'Ahmet Yılmaz', '4-A'),
    Student('zeynep', 'Zeynep Yılmaz', '3-B'),
    Student('deniz', 'Deniz Arslan', '4-A'),
    Student('ece', 'Ece Aydın', '3-B'),
  ];
  static const users = ['Mehmet Kaya', 'Elif Demir', 'Ayşe Yılmaz'];
  static const programs = [
    Entry(
      'Matematik',
      '09.00 – 09.45 • Elif Demir • 4-A',
      studentId: 'ahmet',
      tag: 'Ders',
    ),
    Entry(
      'Türkçe',
      '10.00 – 10.45 • Selin Aksoy • 4-A',
      studentId: 'ahmet',
      tag: 'Ders',
    ),
    Entry(
      'Matematik etüdü',
      '14.00 – 14.45 • Elif Demir • 4-A',
      studentId: 'ahmet',
      tag: 'Etüt',
    ),
    Entry(
      'Hayat Bilgisi',
      '09.30 – 10.15 • Selin Aksoy • 3-B',
      studentId: 'zeynep',
      tag: 'Ders',
    ),
    Entry(
      'Robotik atölyesi',
      '13.00 – 14.00 • Can Eren • 3-B',
      studentId: 'zeynep',
      tag: 'Etkinlik',
    ),
  ];
  static const attendance = [
    Entry(
      'Matematik • Katılmadı',
      '7 Ekim • 4-A • Veliye bilgi verildi',
      studentId: 'ahmet',
      tag: 'Devamsız',
    ),
    Entry(
      'Hayat Bilgisi • Katıldı',
      '7 Ekim • 3-B • Yoklama tamamlandı',
      studentId: 'zeynep',
      tag: 'Katıldı',
    ),
    Entry(
      'Türkçe • Katıldı',
      '6 Ekim • 4-A',
      studentId: 'ahmet',
      tag: 'Katıldı',
    ),
  ];
  static const opinions = [
    Entry(
      'Problem çözmede ilerleme',
      'Elif Demir • 6 Ekim\nAhmet çok adımlı problemleri artık daha bağımsız çözüyor.',
      studentId: 'ahmet',
    ),
    Entry(
      'Grup çalışmalarına aktif katılım',
      'Selin Aksoy • 6 Ekim\nZeynep arkadaşlarıyla iş birliği kurmakta başarılı.',
      studentId: 'zeynep',
    ),
  ];
  static const materials = [
    Entry(
      'Kesirler çalışma kâğıdı',
      'Matematik • 12 soru • 7 Ekim',
      studentId: 'ahmet',
    ),
    Entry(
      'Doğayı keşfediyorum',
      'Hayat Bilgisi • Okuma ve etkinlik • 7 Ekim',
      studentId: 'zeynep',
    ),
  ];
  static const meetings = [
    Entry(
      'Ahmet için gelişim görüşmesi',
      '9 Ekim Cuma • 16.00 • Elif Demir',
      studentId: 'ahmet',
    ),
    Entry(
      'Zeynep için dönem görüşmesi',
      '12 Ekim Pazartesi • 15.30 • Selin Aksoy',
      studentId: 'zeynep',
    ),
  ];
  static const payments = [
    Entry(
      'Ekim • Ahmet Yılmaz',
      'Aylık eğitim ücreti • Son tarih: 10 Ekim',
      studentId: 'ahmet',
      tag: 'Bekliyor',
      amount: 2000,
    ),
    Entry(
      'Ekim • Zeynep Yılmaz',
      'Aylık eğitim ücreti • Son tarih: 10 Ekim',
      studentId: 'zeynep',
      tag: 'Kısmi',
      amount: 3000,
    ),
    Entry(
      'Eylül • Ahmet Yılmaz',
      '5 Eylül tarihinde tahsil edildi',
      studentId: 'ahmet',
      tag: 'Ödendi',
      amount: 2000,
    ),
    Entry(
      'Eylül • Zeynep Yılmaz',
      '6 Eylül tarihinde tahsil edildi',
      studentId: 'zeynep',
      tag: 'Ödendi',
      amount: 3000,
    ),
    Entry(
      'Ekim • Deniz Arslan',
      'Son tarih: 5 Ekim',
      studentId: 'deniz',
      tag: 'Gecikti',
      amount: 2500,
    ),
  ];
  static const messages = [
    Entry(
      'Yoklama bilgilendirmesi',
      'Ahmet • 4-A\nMatematik dersine katılmadı.',
      studentId: 'ahmet',
      tag: 'Yoklama',
    ),
    Entry(
      'Yarın robotik etkinliği',
      'Zeynep • 3-B\nEtkinlik için malzeme getirmeniz gerekmiyor.',
      studentId: 'zeynep',
      tag: 'Duyuru',
    ),
    Entry(
      'Yeni eğitim materyali',
      'Zeynep • 3-B\nDoğayı keşfediyorum etkinliği paylaşıldı.',
      studentId: 'zeynep',
      tag: 'Bildirim',
    ),
    Entry(
      'Ekim ayı veli buluşması',
      'Tüm veliler • 15 Ekim saat 18.00\nMerkezimizde sizleri bekliyoruz.',
      tag: 'Duyuru',
    ),
  ];
  static const menu = [
    Entry(
      'Bugünün menüsü',
      'Mercimek çorbası • Fırında tavuk • Bulgur pilavı • Ayran',
      tag: '7 Ekim',
    ),
    Entry(
      'Perşembe',
      'Sebze çorbası • Köfte • Makarna • Yoğurt',
      tag: '8 Ekim',
    ),
  ];
  static const center = [
    Entry(
      'Pusula Eğitim Merkezi',
      'Atatürk Mah. Eğitim Sok. No: 12\nHafta içi 08.00 – 18.00 • 0212 555 01 28',
    ),
    Entry(
      'Sınıflar',
      '4-A • 2 öğrenci • Elif Demir\n3-B • 2 öğrenci • Selin Aksoy',
    ),
  ];
  static const adminDashboard = [
    Entry(
      'Merkezde yeni bir gün',
      '2 aktif sınıf • Bugün 3 ders, 1 etüt ve 1 etkinlik\n2 yeni kayıt değerlendirme bekliyor',
      tag: 'GÜNLÜK GENEL DURUM',
    ),
    Entry(
      '4 öğrenci · 3 öğretmen',
      'Ön kayıtlar ve kişi listelerini inceleyin',
      tag: 'Kişiler',
    ),
    Entry(
      '09.00 · Matematik',
      '4-A • Elif Demir • Günün ilk programı',
      tag: 'Eğitim',
    ),
    Entry(
      '7.500 TL beklenen',
      '1.000 TL tahsil edildi\n6.500 TL bakiye • 2.500 TL geciken',
      tag: 'Finans · Ekim',
    ),
    Entry(
      '2 sınıf eğitimde',
      '2 öğrenci giriş yaptı\nBugün: mercimek çorbası ve fırında tavuk',
      tag: 'Merkez',
    ),
    Entry(
      '3 yeni bildirim',
      '1 okunmamış mesaj • Son duyuru: Veli buluşması',
      tag: 'İletişim',
    ),
    Entry(
      'Demo çalışma alanı',
      'Kullanıcı rolleri ve hesap bilgileri',
      tag: 'Yönetim',
    ),
  ];
  static const teacherDashboard = [
    Entry(
      '09.00 · Matematik',
      '4-A • 2 öğrenci • Derslik 2\nBugün 1 ders ve 1 etüt',
      tag: 'SIRADAKİ DERSİNİZ',
    ),
    Entry(
      '1 yoklama bekliyor',
      '1 yoklama tamamlandı • 1 öğrenci devamsız',
      tag: 'Yoklama',
    ),
    Entry(
      '4-A · 2 öğrenci',
      'Sorumlu olduğunuz sınıf ve öğrenci listesi',
      tag: 'Sınıflarım',
    ),
    Entry(
      'Ahmet için gelişim görüşmesi',
      '9 Ekim • 16.00\nSon görüş: Problem çözmede ilerleme',
      tag: 'Öğrenciler',
    ),
    Entry(
      '1 okunmamış mesaj',
      '3 yeni bildirim • Ekim veli buluşması duyuruldu',
      tag: 'İletişim',
    ),
    Entry(
      'Fırında tavuk',
      'Mercimek çorbası • Bulgur pilavı • Ayran',
      tag: 'Bugünün menüsü',
    ),
  ];
  static const parentDashboard = [
    Entry(
      'Ekim toplamı: 5.000 TL',
      'Ahmet: 2.000 TL • Zeynep: 3.000 TL\nÖdenen: 1.000 TL • Kalan: 4.000 TL',
      tag: 'Ödemeler · Tüm çocuklar',
    ),
    Entry(
      '3 yeni bildirim',
      'Ahmet: 1 • Zeynep: 2',
      tag: 'İletişim · Tüm çocuklar',
    ),
    Entry(
      'Fırında tavuk',
      'Mercimek çorbası • Bulgur pilavı • Ayran',
      tag: 'Bugünün menüsü',
    ),
  ];
  static const classes = [
    Entry('4-A', 'Elif Demir • Derslik 2 • 2 öğrenci'),
    Entry('3-B', 'Selin Aksoy • Derslik 3 • 2 öğrenci'),
  ];
}
