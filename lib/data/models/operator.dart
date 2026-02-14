import 'package:hive/hive.dart';

part 'operator.g.dart';

@HiveType(typeId: 0)
class Operator {
  @HiveField(0)
  String userId;
  @HiveField(1)
  String userName;
  @HiveField(2)
  String userEmail;
  @HiveField(3)
  String userProfile;


  Operator({
    required this.userId,
    required this.userName,
    required this.userProfile,
    required this.userEmail,
  });

  factory Operator.fromJson(Map<String, dynamic> data){
    return Operator(userId: data['userId'],
        userName: data['userName'],
        userProfile: data['userProfile'],
        userEmail: data['userEmail']);
  }

}
