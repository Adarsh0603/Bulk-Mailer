import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

class Auth with ChangeNotifier {
  bool loading = false;
  GoogleSignInAccount _googleUser;
  GoogleSignInAccount get googleUser => _googleUser;
  final GoogleSignIn _googleSignIn =
      GoogleSignIn(scopes: ['https://www.googleapis.com/auth/drive.file']);
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<UserCredential> signInWithGoogle() async {
    loading = true;
    _googleUser = await _googleSignIn.signIn();
    notifyListeners();
    final GoogleSignInAuthentication googleAuth =
        await _googleUser.authentication;

    final GoogleAuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth.accessToken,
      idToken: googleAuth.idToken,
    );

    return await _auth.signInWithCredential(credential);
  }

  void autoLogin() {
    _googleSignIn.onCurrentUserChanged.listen((account) {
      _googleUser = account;
      notifyListeners();
    });
    _googleSignIn.signInSilently();
  }
}
