import 'package:shared_preferences/shared_preferences.dart';

/// A service for managing application preferences using [SharedPreferences].
///
/// [PreferencesService] provides methods to [saveChoice] and [loadChoice]
/// from the user
class PreferencesService {
  Future<void> saveChoice<T>(String request, T value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();

    if (value is int) {
      await prefs.setInt(request, value);
    } else if (value is String) {
      await prefs.setString(request, value);
    } else if (value is bool) {
      await prefs.setBool(request, value);
    } else if (value is double) {
      await prefs.setDouble(request, value);
    } else if (value is List<String>) {
      await prefs.setStringList(request, value);
    } else {
      throw Exception('Unsupported type');
    }
  }

  Future<T> loadChoice<T>(String request, T defaultValue) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    Type type = T;

    if (type == int) {
      return (prefs.getInt(request) ?? defaultValue) as T;
    } else if (type == String) {
      return (prefs.getString(request) ?? defaultValue) as T;
    } else if (type == bool) {
      return (prefs.getBool(request) ?? defaultValue) as T;
    } else if (type == double) {
      return (prefs.getDouble(request) ?? defaultValue) as T;
    } else if (type == List<String>) {
      return (prefs.getStringList(request) ?? defaultValue) as T;
    } else {
      throw Exception('Unsupported type');
    }
  }
}
