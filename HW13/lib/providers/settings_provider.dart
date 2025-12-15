import 'package:flutter/material.dart';
import 'package:hive/hive.dart';

class SettingsProvider with ChangeNotifier {
  late Box _settingsBox;
  String _currency = 'UAH';
  double _monthlyBudget = 0.0;

  SettingsProvider() {
    _settingsBox = Hive.box('settings');
    _currency = _settingsBox.get('currency', defaultValue: 'UAH');
    _monthlyBudget = _settingsBox.get('monthlyBudget', defaultValue: 0.0);
  }

  String get currency => _currency;
  double get monthlyBudget => _monthlyBudget;

  void updateCurrency(String newCurrency) {
    _currency = newCurrency;
    _settingsBox.put('currency', newCurrency);
    notifyListeners();
  }

  void updateMonthlyBudget(double newBudget) {
    _monthlyBudget = newBudget;
    _settingsBox.put('monthlyBudget', newBudget);
    notifyListeners();
  }
}