import 'package:bmi/data/local/hive_store.dart';
import 'package:bmi/data/models/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/extension_navigation.dart';

class ProfileService {
  ProfileService._();

  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  static final FirebaseAuth _auth = FirebaseAuth.instance;
  static const String userCollection = "users";
  static const String profileCollection = "profiles";
  static final String? uId = _auth.currentUser?.uid;

  static Future<void> saveProfile(String name, String gender) async {
    if (uId == null) {
      Get.snackbar(
        "Some Error Occurred",
        "Try Again Later",
        colorText: Colors.white,
        backgroundColor: Colors.red,
      );
    } else {
      try {
        String profileId = uId! + name;
        Profile profile = Profile(
          profileId: profileId,
          profileName: name,
          gender: gender,
        );
        await _firestore
            .collection(userCollection)
            .doc(uId)
            .collection(profileCollection)
            .doc(profileId)
            .set(profile.toJson());
        await HiveStore.saveProfile(profile);
        Get.back();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static Future<void> getProfile() async {
    if (uId == null) return;

    try {
      final snapshot = await _firestore
          .collection(userCollection)
          .doc(uId)
          .collection(profileCollection)
          .get();

      for (DocumentSnapshot doc in snapshot.docs) {
        if (doc.exists) {
          final data = doc.data() as Map<String, dynamic>;
          final profile = Profile.fromJson(data);

          await HiveStore.saveProfile(profile);
        }
      }
    } catch (e) {
      debugPrint("Error fetching profiles: $e");
    }
  }

  static Future<void> updateProfile(Profile profile) async {
    if (uId == null) {
    } else {
      try {
        await _firestore
            .collection(userCollection)
            .doc(uId)
            .collection(profileCollection)
            .doc(profile.profileId)
            .set(profile.toJson());
        await HiveStore.saveProfile(profile);
        Get.back();
      } catch (e) {
        debugPrint(e.toString());
      }
    }
  }

  static Future<void> deleteProfile(Profile profile) async {
    if(uId == null) return;
    try{
     await _firestore.collection(userCollection).doc(uId).collection(profileCollection).doc(profile.profileId).delete();
     await HiveStore.deleteProfile(profile.profileId);
    }
    catch(e)
    {
      debugPrint(e.toString());
    }
  }

}
