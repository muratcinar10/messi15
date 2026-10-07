import '../models/entities.dart';

abstract class EducationRepository {
  List<Entry> dashboard(DemoRole role);
  List<Student> get students;
  List<Student> get parentChildren;
  String userName(DemoRole role);
  String get dateLabel;
  List<Entry> records(String module, DemoRole role, String childId);
}
