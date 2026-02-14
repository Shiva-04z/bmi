import 'package:hive_flutter/hive_flutter.dart';

part 'bmi.g.dart';

@HiveType(typeId: 1)
class BMI {
  @HiveField(0)
  double weight;

  @HiveField(1)
  double height;

  @HiveField(2)
  String gender;

  @HiveField(3)
  double bmi;

  @HiveField(4)
  String status;

  BMI({
    required this.weight,
    required this.height,
    required this.gender,
  })  : bmi = weight / (height * height),
        status = _calculateStatus(weight / (height * height));


  static String _calculateStatus(double bmi) {
    if (bmi < 18.5) {
      return "Underweight";
    } else if (bmi < 25) {
      return "Normal";
    } else if (bmi < 30) {
      return "Overweight";
    } else {
      return "Obese";
    }
  }

  factory BMI.fromJson(Map<String, dynamic> data) {
    return BMI(
      weight: data['weight'],
      height: data['height'],
      gender: data['gender'],
    );
  }

  BMI copyWith({
    double? weight,
    double? height,
    String? gender,
  }) {
    return BMI(
      weight: weight ?? this.weight,
      height: height ?? this.height,
      gender: gender ?? this.gender,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "weight": weight,
      "height": height,
      "gender": gender,
      "bmi": bmi,
      "status": status,
    };
  }
}
