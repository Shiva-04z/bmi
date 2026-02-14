import 'package:hive/hive.dart';
import '../models/profile.dart';
import '../models/operator.dart';

class HiveStore {
  HiveStore._();

  static late final Box<Operator> _userBox;
  static late final Box<Profile> _profileBox;
  static bool _isInitialized = false;

  static void _ensureInitialized() {
    if (!_isInitialized) {
      throw Exception("Call HiveStore.onInit() before using HiveStore.");
    }
  }

  static Future<void> onInit() async {
    if (!_isInitialized) {
      _userBox = await Hive.openBox<Operator>("User");
      _profileBox = await Hive.openBox<Profile>("Profile");
      _isInitialized = true;
    }
  }

  static Future<void> saveUser(Operator user) async {
    _ensureInitialized();
    await _userBox.put(
      0,
      user,
    ); // Only one Login , for storing multiple users change by user.id
  }

  static Future<void> saveProfile(Profile profile) async {
    _ensureInitialized();
    await _profileBox.put(profile.profileId, profile);
  }

  static List<Profile> loadProfiles() {
    _ensureInitialized();
    return _profileBox.values.toList();
  }

  static Profile? loadProfile(String profileId) {
    _ensureInitialized();
    return _profileBox.get(profileId);
  }

  static Operator? getUser() {
    _ensureInitialized();
    return _userBox.get(0);
  }

  static Future<void> deleteProfile(String profileId) async {
    _ensureInitialized();
    await _profileBox.delete(profileId);
  }

  static Future<void> deleteUser() async {
    _ensureInitialized();
    await _profileBox.clear();
    await _userBox.clear();
  }
}
