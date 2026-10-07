import 'package:flutter/foundation.dart';

import '../models/entities.dart';
import 'education_repository.dart';

class DemoState extends ChangeNotifier {
  DemoState(this.repository) : childId = repository.parentChildren.first.id;
  final EducationRepository repository;
  DemoRole? role;
  String childId;
  int tab = 3;
  String? module;
  String? communicationFilter;
  Student get child =>
      repository.parentChildren.firstWhere((s) => s.id == childId);
  void selectRole(DemoRole? value) {
    role = value;
    tab = 3;
    module = null;
    communicationFilter = null;
    notifyListeners();
  }

  void selectChild(String id) {
    childId = id;
    notifyListeners();
  }

  void navigate(int index, [String? detail]) {
    tab = index;
    module = detail;
    communicationFilter = null;
    notifyListeners();
  }

  void filter(String? id) {
    communicationFilter = id;
    notifyListeners();
  }
}
