import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:student_pal/features/settings/model/user_model.dart';

class FirebaseService {
  final auth = FirebaseAuth.instance;
  final fireStore = FirebaseFirestore.instance;

  Future<({bool? loggedIn, String? error})> login(
      {required String email, required String password}) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      await auth.currentUser?.reload();
      return (loggedIn: true, error: null);
    } on FirebaseAuthException catch (e) {
      return (loggedIn: null, error: e.message);
    } catch (e) {
      return (loggedIn: null, error: e.toString());
    }
  }

  Future<({bool? registered, String? error})> register(
      {required String email,
      required String password,
      required String name}) async {
    try {
      await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      await auth.currentUser?.reload();
      await fireStore
          .collection("users")
          .doc(auth.currentUser?.uid)
          .set(UserModel(
            uid: auth.currentUser?.uid,
            name: name,
            email: email,
          ).toJson());
      return (registered: true, error: null);
    } on FirebaseAuthException catch (e) {
      return (registered: null, error: e.message);
    } catch (e) {
      return (registered: null, error: e.toString());
    }
  }

  Future<void> logout() async {
    try {
      await auth.signOut();
    } catch (_) {}
  }

  Future<UserModel?> getUserData() async {
    try {
      String? uid = auth.currentUser?.uid;
      if (uid == null) return null;

      DocumentSnapshot<Map<String, dynamic>> doc =
          await fireStore.collection("users").doc(uid).get();

      if (doc.exists) {
        return UserModel.fromJson(doc.data()!);
      }
      return null;
    } catch (e) {
      return null;
    }
  }
}
