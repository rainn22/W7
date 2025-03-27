import 'package:shared_preferences/shared_preferences.dart';
import 'package:week_3_blabla_project/data/repository/ride_preferences_repository.dart';
import 'package:week_3_blabla_project/model/ride/ride_pref.dart';

class LocalRidePreferencesRepository extends RidePreferencesRepository {
  static const String _preferencesKey = 'ride_preferences';

  @override
  Future<List<RidePreference>> getPastPreferences() async {
    final prefs = await SharedPreferences.getInstance();

    final List<String>? prefList = prefs.getStringList(_preferencesKey);

    return prefList?.map((pref) => RidePreference.fromJson(pref)).toList() ??
        [];
  }

  @override
  Future<void> addPreference(RidePreference preference) async {
    final prefs = await SharedPreferences.getInstance();

    final List<String> prefList = prefs.getStringList(_preferencesKey) ?? [];

    prefList.add(preference.toJson());

    await prefs.setStringList(_preferencesKey, prefList);
  }
}
