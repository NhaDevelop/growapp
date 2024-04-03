import 'package:firebase_auth/firebase_auth.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/user_data_model.dart';

class GoogleSignInAuthService {
  final googleSignIn = GoogleSignIn(scopes: [
    'email',
    'https://www.googleapis.com/auth/contacts.readonly',
  ]);
  final googleProvider = GoogleAuthProvider();

  Future<UserData> signIn() async {
    // if (isWeb) return signInWeb();

    return signInNative();
  }

  Future<UserData> signInNative() async {
    GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      final UserCredential userCredential =
          await auth.signInWithCredential(credential);

      await googleSignIn.signOut();

      return UserData.fromFirebaseUserCredential(userCredential);
    } else {
      appStore.setLoading(false);
      throw USER_NOT_CREATED;
    }
  }

  Future<UserData> signInWeb() async {
    try {
      googleProvider
          .addScope('https://www.googleapis.com/auth/contacts.readonly');
      googleProvider.setCustomParameters({'login_hint': 'user@example.com'});

      final userCredential =
          await FirebaseAuth.instance.signInWithPopup(googleProvider);

      return UserData.fromFirebaseUserCredential(userCredential);
    } catch (e) {
      appStore.setLoading(false);
      log('sign in google web error: ${e.toString()}');
      throw USER_NOT_CREATED;
    }
  }
}
