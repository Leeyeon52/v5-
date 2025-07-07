//C:\Users\user\Desktop\0703flutter_v2\lib\features\history\viewmodel\history_viewmodel.dart
import 'package:flutter/material.dart';
import '../../diagnosis/model/tooth_image.dart';

class HistoryViewModel extends ChangeNotifier {
  final List<ToothImage> _history = [];

  List<ToothImage> get history => List.unmodifiable(_history);

  void add(ToothImage result) {
    _history.add(result);
    notifyListeners();
  }

  void clear() {
    _history.clear();
    notifyListeners();
  }
}