import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@injectable
class LocalStorageService {
  final SharedPreferencesAsync prefs = SharedPreferencesAsync();

  Future<void> save(String key, String value) async {
    print('Saving to local storage: $key = $value');
    await prefs.setString(key, value);
  }

  Future<String?> read(String key) {
    print('Reading from local storage: $key');
    return prefs.getString(key);
  }

  Future<void> delete(String key) async {
    print('Deleting from local storage: $key');
    await prefs.remove(key);
  }
}
