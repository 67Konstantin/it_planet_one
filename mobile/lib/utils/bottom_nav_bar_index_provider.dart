import 'package:flutter/material.dart';

class BottomNavBarIndexProvider with ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void selectTab(int index) {
    _selectedIndex = index;
    notifyListeners(); // Уведомляем слушателей об изменении
  }
}
