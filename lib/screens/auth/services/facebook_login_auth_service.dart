import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:grow_tokyo_app/main.dart';
import 'package:grow_tokyo_app/screens/auth/model/user_data_model.dart';
import 'package:grow_tokyo_app/utils/constants.dart';
import 'package:nb_utils/nb_utils.dart';

class FacebookLoginAuthService {
  final FacebookAuth facebookAuth = FacebookAuth.instance;

  Future<UserData> signIn(BuildContext context) {
    return facebookAuth.login().then((result) async {
      if (result.status == LoginStatus.success) {
        final AccessToken accessToken = result.accessToken!;
        final AuthCredential credential =
            FacebookAuthProvider.credential(accessToken.token);

        final UserCredential authResult =
            await auth.signInWithCredential(credential);
        final User user = authResult.user!;
        assert(!user.isAnonymous);

        final User currentUser = auth.currentUser!;
        assert(user.uid == currentUser.uid);

        log(currentUser);

        String firstName = '';
        String lastName = '';
        if (currentUser.displayName.validate().split(' ').isNotEmpty) {
          firstName = currentUser.displayName.splitBefore(' ');
        }
        if (currentUser.displayName.validate().split(' ').length >= 2) {
          lastName = currentUser.displayName.splitAfter(' ');
        }

        /// Create a temporary request to send
        UserData tempUserData = UserData()
          ..mobile = currentUser.phoneNumber.validate()
          ..email = currentUser.email.validate()
          ..firstName = firstName.validate()
          ..lastName = lastName.validate()
          ..socialImage = currentUser.photoURL.validate()
          ..profileImage = currentUser.photoURL.validate()
          ..userType = LoginTypeConst.LOGIN_TYPE_USER
          ..loginType = LoginTypeConst.LOGIN_TYPE_FACEBOOK
          ..playerId = appStore.playerId
          ..uid = user.uid
          ..username = (currentUser.email
                  .validate()
                  .splitBefore('@')
                  .replaceAll('.', ''))
              .toLowerCase();

        return tempUserData;
      } else {
        throw Exception('Facebook login failed');
      }
    });
  }
}
