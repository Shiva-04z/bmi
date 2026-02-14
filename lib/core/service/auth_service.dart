import 'package:bmi/data/local/hive_store.dart';
import 'package:bmi/data/local/token_store.dart';
import 'package:bmi/data/models/operator.dart';
import 'package:bmi/data/remote/profile_repository.dart';
import 'package:bmi/navigation/routes_constant.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import '../../data/local/preferences_store.dart';


class AuthService {
  AuthService._();

  static final GoogleSignIn _googleSignIn = GoogleSignIn.instance;
  static final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  static bool isInitialized = false;

  static void _ensureInitialized() {
    if (!isInitialized) {
      throw Exception("Call AuthService.init() before using AuthService.");
    }
  }

  static Future<void> _saveUser() async {
    User? user = _firebaseAuth.currentUser;
    if (user != null) {
      String idToken = await user.getIdToken(true) ?? "";
      await TokenStore.saveIdToken(idToken);
      Operator operator = Operator(
        userId: user.uid,
        userName: user.displayName ?? "",
        userProfile: user.photoURL ?? "",
        userEmail: user.email ?? "",
      );
      PreferencesStore.setLoggedIn();
      await HiveStore.saveUser(operator);
      await ProfileService.getProfile();
      Get.offNamed(RoutesConstant.homePage);
    }
  }

  static Future<void> init() async {
    if (!isInitialized) {
      String serverClientID = await TokenStore.getServerId() ?? "";
      await _googleSignIn.initialize(serverClientId: serverClientID);
      isInitialized = true;
    }
  }

  static Future<void> login(String email, String password) async {
    _ensureInitialized();
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _saveUser();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> registerUser(
    String email,
    String password,
    String name,
  ) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      await _firebaseAuth.currentUser?.updateDisplayName(name);
      await _saveUser();
    } catch (e) {
      debugPrint(e.toString());
    }
  }

  static Future<void> logOut() async {
    PreferencesStore.logOut();
    await HiveStore.deleteUser();
    await _googleSignIn.signOut();
    await _firebaseAuth.signOut();
    await TokenStore.clearStore();
    Get.offAllNamed(RoutesConstant.loginPage);
  }

  static Future<void> signInWithGoogle() async {
    _ensureInitialized();
    try {
      GoogleSignInAccount? account = await _googleSignIn.authenticate(
        scopeHint: ['email'],
      );
      final idToken = account.authentication.idToken;
      if (idToken != null) {
        final credentials = GoogleAuthProvider.credential(idToken: idToken);
        await _firebaseAuth.signInWithCredential(credentials);
        await _saveUser();
      }
    } catch (e) {
      debugPrint(e.toString());
    }
  }
  static Future<void> forgotPassword(String mail) async {
    try {
      _firebaseAuth.sendPasswordResetEmail(email: mail);
    } catch (e) {
      debugPrint(e.toString());
    }
  }
}
