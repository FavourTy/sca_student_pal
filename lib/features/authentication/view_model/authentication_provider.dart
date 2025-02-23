import 'package:flutter/material.dart';
import 'package:student_pal/services/firebase_services.dart';

import '../../settings/model/user_model.dart';

class AuthenticationProvider extends ChangeNotifier {
  final FirebaseService firebaseService;

  AuthenticationProvider({required this.firebaseService});

  bool loading = false;
  UserModel? userModel;

  Future<void> fetchUserDetails() async {
    loading = true;
    notifyListeners();

    userModel = await firebaseService.getUserDetails();

    loading = false;
    notifyListeners();
  }

  Future<void> logout() async {
    await firebaseService.logout();
  }

  Future<({bool? loggedIn, String? error})> login(
      {required String email, required String password}) async {
    loading = true;
    notifyListeners();
    final login = await firebaseService.login(email: email, password: password);
    if (login.loggedIn ?? false) {
      loading = false;
      notifyListeners();

      return (loggedIn: true, error: null);
    } else {
      loading = false;
      notifyListeners();
      return (loggedIn: null, error: login.error);
    }
  }

  Future<({bool? registered, String? error})> register(
      {required String email,
      required String password,
      required String name}) async {
    loading = true;
    notifyListeners();
    final login = await firebaseService.register(
      name: name,
      email: email,
      password: password,
    );
    if (login.registered ?? false) {
      loading = false;
      notifyListeners();

      return (registered: true, error: null);
    } else {
      loading = false;
      notifyListeners();
      return (registered: null, error: login.error);
    }
  }
}
