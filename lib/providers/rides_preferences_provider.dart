import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  final List<RidePreference> _pastPreferences = [];
  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    _fetchPastPreferences();
  }

  void _fetchPastPreferences() {
  }

  RidePreference? get currentPreference => _currentPreference;

  void setCurrentPreference(RidePreference pref) {
    if (_currentPreference != null && _currentPreference == pref) {
      return;
    }
    _currentPreference = pref;
    _addPreference(pref);
    notifyListeners();
  }

  void _addPreference(RidePreference preference) {
    if (!_pastPreferences.contains(preference)) {
      _pastPreferences.add(preference);
    }
  }

  List<RidePreference> get preferencesHistory => _pastPreferences.reversed.toList();
}