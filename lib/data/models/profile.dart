import 'package:hive/hive.dart';
import 'bmi.dart';

part 'profile.g.dart';

@HiveType(typeId: 2)
class Profile extends HiveObject {
  @HiveField(0)
  final String profileName;

  @HiveField(1)
  final String profileId;

  @HiveField(2)
  final Map<String, BMI> historyMap;

  @HiveField(3)
  final String gender;

  Profile({
    required this.profileId,
    required this.profileName,
    required this.gender,
    Map<String, BMI>? historyMap,
  }) : historyMap = historyMap ?? {};

  void addBMI(BMI bmi) {
    final String today = _onlyDate(DateTime.now());

    historyMap[today] = bmi;

    _maintainLast7Days();
    save();
  }

  void updateBMI(String isoDate, BMI bmi) {
    historyMap[isoDate] = bmi;

    _maintainLast7Days();
    save();
  }


  void _maintainLast7Days() {
    if (historyMap.length <= 7) return;

    final sortedKeys = historyMap.keys.toList()
      ..sort();

    while (sortedKeys.length > 7) {
      historyMap.remove(sortedKeys.first);
      sortedKeys.removeAt(0);
    }
  }

  String _onlyDate(DateTime date) {
    return date.toIso8601String().split('T').first;
  }

  Profile copyWith({String? profileName, String? gender}) {
    return Profile(
      profileId: profileId,
      profileName: profileName ?? this.profileName,
      gender: gender ?? this.gender,
      historyMap: Map<String, BMI>.from(historyMap),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "profileId": profileId,
      "profileName": profileName,
      "gender": gender,
      "historyMap": historyMap.map(
            (key, value) => MapEntry(key, value.toJson()),
      ),
    };
  }


  factory Profile.fromJson(Map<String, dynamic> data) {
    return Profile(
      profileId: data['profileId'],
      profileName: data['profileName'],
      gender: data['gender'],
      historyMap: (data['historyMap'] as Map<String, dynamic>).map(
            (key, value) => MapEntry(key, BMI.fromJson(value)),
      ),
    );
  }
}
