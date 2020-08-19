import 'package:shared_preferences/shared_preferences.dart';

class LocalStorageRepository {
  static SharedPreferences _sharedPreferences;
  static const LANGUAGE_KEY = "lang";
  static const LIST_KEY = "list"; // The current list that should be shown
  static const CACHED_LISTS =
      "cached_lists"; // An array that is the cached lists.

  static List<String> fetchCacheLists() {
    return _sharedPreferences.getStringList(CACHED_LISTS) ?? [];
  }

  static Future<bool> insertToCache(String newListId) async {
    List<String> currentLists = fetchCacheLists();
    if(currentLists.contains(newListId)){
      return false;
    }
    currentLists.add(newListId);
    return await _sharedPreferences.setStringList(CACHED_LISTS, currentLists);
  }

  static Future<bool> clearCacheList() async {
    return await _sharedPreferences.remove(CACHED_LISTS);
  }

  static Future<void> initialize() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  static Future<bool> clear() async {
    return await _sharedPreferences.clear();
  }

  static Future<bool> clearListId() async {
    return await _sharedPreferences.remove(LIST_KEY);
  }

  static Future<bool> setLanguage(String language) async {
    bool success = await _sharedPreferences.setString(LANGUAGE_KEY, language);
    return success;
  }

  static String getLanguage() {
    return _sharedPreferences.getString(LANGUAGE_KEY);
  }

  static bool hasLanguage() {
    return _sharedPreferences.containsKey(LANGUAGE_KEY);
  }

  static bool hasListId() {
    return _sharedPreferences.containsKey(LIST_KEY);
  }

  static Future<bool> setListId(String id) async {
    bool result = await _sharedPreferences.setString(LIST_KEY, id);
    if (!result) {
      return false;
    }
    await insertToCache(id);
    return result;
  }

  static String getListId() {
    return _sharedPreferences.getString(LIST_KEY);
  }
}
