import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/auth/model/user_data_model.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class FacebookLoginAuthService {
  final facebookAuth = FacebookAuth.instance;
  final facebookProvider = FacebookAuthProvider();

  Future<UserData> signIn() async {
    if (isWeb) return signInWeb();

    return signInNative();
  }

  Future<UserData> signInNative() {
    return facebookAuth.login().then((result) async {
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential authResult =
            await auth.signInWithCredential(credential);

        return UserData.fromFirebaseUserCredential(authResult);
      } else {
        throw USER_NOT_CREATED;
      }
    });
  }

  Future<UserData> signInWeb() async {
    try {
      facebookProvider.addScope('email');
      facebookProvider.setCustomParameters({'display': 'popup'});

      final userCredential =
          await FirebaseAuth.instance.signInWithProvider(facebookProvider);

      return UserData.fromFirebaseUserCredential(userCredential);
    } catch (e) {
      appStore.setLoading(false);
      throw USER_NOT_CREATED;
    }
  }
}
