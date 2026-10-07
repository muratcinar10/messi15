enum DemoRole { admin, teacher, parent }

class Student {
  const Student(this.id, this.name, this.className);
  final String id, name, className;
  String get firstName => name.split(' ').first;
}

class Entry {
  const Entry(
    this.title,
    this.subtitle, {
    this.studentId,
    this.tag = '',
    this.amount = 0,
  });
  final String title, subtitle, tag;
  final String? studentId;
  final int amount;
}
