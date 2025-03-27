import 'package:flutter/material.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';
import 'package:week_3_blabla_project/providers/async_value.dart';
import 'package:week_3_blabla_project/repository/ride_preferences_repository.dart';

class RidesPreferencesProvider extends ChangeNotifier {
  RidePreference? _currentPreference;
  late AsyncValue<List<RidePreference>> pastPreferences;

  final RidePreferencesRepository repository;

  RidesPreferencesProvider({required this.repository}) {
    pastPreferences = AsyncValue.loading();
    fetchPastPreferences();
  }

  Future<void> fetchPastPreferences() async {
    try {
      List<RidePreference> prefs = await repository.getPastPreferences();
      pastPreferences = AsyncValue.success(prefs);
    } catch (e) {
      pastPreferences = AsyncValue.error(e);
    }
    notifyListeners();
  }

  RidePreference? get currentPreference => _currentPreference;

  Future<void> setCurrentPreference(RidePreference pref) async {
    if (_currentPreference != null && _currentPreference == pref) {
      return;
    }
    _currentPreference = pref;
    await _addPreference(pref);
    notifyListeners();
  }

  Future<void> _addPreference(RidePreference preference) async {
    await repository.addPreference(preference);
    await fetchPastPreferences();
  }

  List<RidePreference> get preferencesHistory =>
      pastPreferences.data ?? [];
}