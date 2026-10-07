import '../models/entities.dart';
import '../shared/education_repository.dart';
import 'mock_data.dart';

class MockRepository implements EducationRepository {
  @override
  List<Entry> dashboard(DemoRole role) => switch (role) {
    DemoRole.admin => MockData.adminDashboard,
    DemoRole.teacher => MockData.teacherDashboard,
    DemoRole.parent => MockData.parentDashboard,
  };
  @override
  List<Student> get students => MockData.students;
  @override
  List<Student> get parentChildren =>
      students.where((s) => ['ahmet', 'zeynep'].contains(s.id)).toList();
  @override
  String userName(DemoRole role) => MockData.users[role.index];
  @override
  String get dateLabel => MockData.date;
  @override
  List<Entry> records(String module, DemoRole role, String childId) {
    List<Entry> result;
    if (module.contains('Ödeme')) {
      result = MockData.payments;
    } else if ([
      'Mesajlar',
      'Duyurular',
      'Bildirimler',
      'Yoklama Mesajları',
      'Veli İletişimi',
    ].contains(module)) {
      result = MockData.messages;
      if (module == 'Duyurular') {
        result = result.where((e) => e.tag == 'Duyuru').toList();
      }
    } else if (module.contains('Yoklama') || module.contains('Devamsız')) {
      result = MockData.attendance;
    } else if (module.contains('Görüşme')) {
      result = MockData.meetings;
    } else if (module.contains('Görüş')) {
      result = MockData.opinions;
    } else if (module.contains('Materyal')) {
      result = MockData.materials;
    } else if (module.contains('Program') ||
        module.contains('Etüt') ||
        module.contains('Aktivite') ||
        module.contains('Etkinlik')) {
      result = role == DemoRole.teacher
          ? MockData.programs
                .where((e) => e.subtitle.contains('Elif Demir'))
                .toList()
          : MockData.programs;
      if (module.contains('Etüt')) {
        result = result.where((e) => e.tag == 'Etüt').toList();
      }
      if (module.contains('Aktivite') || module.contains('Etkinlik')) {
        result = result.where((e) => e.tag == 'Etkinlik').toList();
      }
    } else if (module.contains('Yemek')) {
      result = MockData.menu;
    } else if (module.contains('Öğrenci')) {
      result = students
          .map(
            (s) => Entry(
              s.name,
              '${s.className} • Aktif öğrenci',
              studentId: s.id,
            ),
          )
          .toList();
    } else if (module == 'Veliler') {
      result = const [
        Entry('Ayşe Yılmaz', 'Ahmet Yılmaz ve Zeynep Yılmaz'),
        Entry('Emre Arslan', 'Deniz Arslan'),
        Entry('Derya Aydın', 'Ece Aydın'),
      ];
    } else if (module == 'Öğretmenler') {
      result = const [
        Entry('Elif Demir', 'Matematik • 4-A'),
        Entry('Selin Aksoy', 'Sınıf öğretmeni • 3-B'),
        Entry('Can Eren', 'Robotik ve sosyal etkinlikler'),
      ];
    } else if (module == 'Kayıt İşlemleri') {
      result = const [
        Entry(
          'Mert Koç',
          '4. sınıf • Ön görüşme: 9 Ekim',
          tag: 'Bekleyen kayıt',
        ),
        Entry('Ada Çelik', '3. sınıf • Evrak kontrolü', tag: 'Yeni kayıt'),
      ];
    } else if (module == 'Giriş / Çıkış') {
      result = const [
        Entry('Deniz Arslan', '08.32 • Merkeze giriş • 4-A'),
        Entry('Ece Aydın', '08.40 • Merkeze giriş • 3-B'),
      ];
    } else if (module == 'Sınıflar' || module == 'Sınıflarım') {
      result = role == DemoRole.teacher
          ? [MockData.classes.first]
          : MockData.classes;
    } else if (module == 'Profilim') {
      result = [Entry(userName(role), 'Pusula Eğitim Merkezi • Demo hesap')];
    } else if (module == 'Ayarlar') {
      result = const [
        Entry('Bildirim tercihleri', 'Uygulama içi bildirimler açık'),
        Entry('Görünüm', 'Açık tema'),
        Entry('Dil', 'Türkçe'),
      ];
    } else if (module == 'Kullanıcı & Yetkiler') {
      result = const [
        Entry('Mehmet Kaya', 'Yönetici • Tüm modüller'),
        Entry('Elif Demir', 'Öğretmen • Eğitim ve sınıflar'),
        Entry('Ayşe Yılmaz', 'Veli • Bağlı öğrenciler'),
      ];
    } else if (module == 'Uygulama Bilgileri') {
      result = const [
        Entry(
          'Pusula • 1.0.0',
          'UI/UX demo • Veriler cihaz belleğinde örnek olarak sunulur.',
        ),
      ];
    } else {
      result = MockData.center;
    }
    if (role == DemoRole.teacher && result.any((e) => e.studentId != null)) {
      result = result
          .where(
            (e) =>
                e.studentId == null || ['ahmet', 'deniz'].contains(e.studentId),
          )
          .toList();
    }
    final global =
        module.contains('Ödeme') ||
        [
          'Mesajlar',
          'Duyurular',
          'Bildirimler',
          'Veli İletişimi',
        ].contains(module);
    if (role == DemoRole.parent) {
      result = result
          .where(
            (e) =>
                e.studentId == null ||
                (global
                    ? parentChildren.any((s) => s.id == e.studentId)
                    : e.studentId == childId),
          )
          .toList();
    }
    if (module == 'Bekleyen Ödemeler') {
      result = result
          .where((e) => e.tag == 'Bekliyor' || e.tag == 'Kısmi')
          .toList();
    }
    if (module == 'Geciken Ödemeler') {
      result = result.where((e) => e.tag == 'Gecikti').toList();
    }
    if (module == 'Ödeme Geçmişi') {
      result = result.where((e) => e.tag == 'Ödendi').toList();
    }
    return result;
  }
}
