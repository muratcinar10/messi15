import 'package:flutter/material.dart';

import '../../models/entities.dart';

class Category {
  const Category(this.label, this.icon, this.modules);
  final String label;
  final IconData icon;
  final List<String> modules;
}

const home = Category('Ana Sayfa', Icons.home_rounded, []);
List<Category> categories(DemoRole role) => switch (role) {
  DemoRole.admin => const [
    Category('Kişiler', Icons.people_outline, [
      'Öğrenciler',
      'Veliler',
      'Öğretmenler',
      'Kayıt İşlemleri',
    ]),
    Category('Eğitim', Icons.school_outlined, [
      'Programlar',
      'Yoklama',
      'Öğretmen Görüşleri',
      'Veli Görüşmeleri',
    ]),
    Category('Merkez', Icons.apartment_rounded, [
      'Sınıflar',
      'Giriş / Çıkış',
      'Yemek Menüsü',
      'Merkez Bilgileri',
    ]),
    home,
    Category('Finans', Icons.account_balance_wallet_outlined, [
      'Ödemeler',
      'Ödeme Planları',
      'Bekleyen Ödemeler',
      'Geciken Ödemeler',
    ]),
    Category('İletişim', Icons.chat_bubble_outline, [
      'Mesajlar',
      'Duyurular',
      'Bildirimler',
      'Yoklama Mesajları',
    ]),
    Category('Yönetim', Icons.tune_rounded, [
      'Kullanıcı & Yetkiler',
      'Profilim',
      'Ayarlar',
      'Uygulama Bilgileri',
    ]),
  ],
  DemoRole.teacher => const [
    Category('Program', Icons.calendar_month_outlined, [
      'Ders Programım',
      'Etütlerim',
      'Sosyal Aktiviteler',
      'Eğitim Materyalleri',
    ]),
    Category('Sınıflarım', Icons.groups_outlined, [
      'Sınıflarım',
      'Öğrencilerim',
      'Öğretmen Görüşleri',
      'Veli Görüşmeleri',
    ]),
    Category('Yoklama', Icons.fact_check_outlined, [
      'Yoklama Al',
      'Bugünkü Yoklamalar',
      'Yoklama Geçmişi',
      'Devamsızlıklar',
    ]),
    home,
    Category('Öğrenciler', Icons.people_outline, [
      'Öğrencilerim',
      'Görüşler',
      'Veli Görüşmeleri',
      'Öğrenci Geçmişi',
    ]),
    Category('İletişim', Icons.chat_bubble_outline, [
      'Mesajlar',
      'Duyurular',
      'Bildirimler',
      'Veli İletişimi',
    ]),
    Category('Diğer', Icons.more_horiz, [
      'Yemek Menüsü',
      'Merkez Bilgileri',
      'Profilim',
      'Ayarlar',
    ]),
  ],
  DemoRole.parent => const [
    Category('Eğitim', Icons.school_outlined, [
      'Eğitim Materyalleri',
      'Öğretmen Görüşleri',
      'Veli Görüşmeleri',
    ]),
    Category('Program', Icons.calendar_month_outlined, [
      'Ders Programı',
      'Etüt Programı',
      'Sosyal Etkinlikler',
    ]),
    Category('Yoklama', Icons.fact_check_outlined, [
      'Yoklama Durumu',
      'Devamsızlık Geçmişi',
      'Yoklama Mesajları',
    ]),
    home,
    Category('Ödemeler', Icons.account_balance_wallet_outlined, [
      'Ödeme Özeti',
      'Aylık Ödemeler',
      'Ödeme Geçmişi',
    ]),
    Category('İletişim', Icons.chat_bubble_outline, [
      'Mesajlar',
      'Duyurular',
      'Bildirimler',
    ]),
    Category('Diğer', Icons.more_horiz, [
      'Yemek Menüsü',
      'Profilim',
      'Ayarlar',
    ]),
  ],
};
String roleLabel(DemoRole role) => ['Yönetici', 'Öğretmen', 'Veli'][role.index];
