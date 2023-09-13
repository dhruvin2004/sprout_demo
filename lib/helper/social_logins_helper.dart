import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../constants/app.export.dart';
import '../constants/injector.dart';
import '../constants/utils.dart';

class SocialLogins {
  static SocialLogins? socialLogins;

  factory SocialLogins() {
    return socialLogins ?? SocialLogins._internal();
  }

  SocialLogins._internal() {
    socialLogins = this;
  }

  static SocialLogins get shared => SocialLogins();

  static String generateNonce([int length = 32]) {
    const charset = '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)]).join();
  }

  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static getAppleLogin({Function? apiCall}) async {
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);
    try {
      final result = await SignInWithApple.getAppleIDCredential(
        scopes: [
          AppleIDAuthorizationScopes.email,
          AppleIDAuthorizationScopes.fullName,
        ],
        nonce: nonce,
      );
      // debugPrint(result.authorizationCode);
      Utils.showCircularProgressLottie(true);
      final oauthCredential = OAuthProvider("apple.com").credential(
        idToken: result.identityToken,
        rawNonce: rawNonce,
      );

      final displayName = '${result.givenName} ${result.familyName}';
      final userEmail = '${result.email}';

      if (result.identityToken != null) {
        // debugPrint("Your Name ${result.email}");
        // debugPrint("Your Email $userEmail");

        if (result.givenName != null) {
          // Injector.setSocialUserName(result.givenName!);
        }
        if (result.identityToken != null) {
          if (result.email != null) {
            await Injector.setProviderType("apple");
          }
          // debugPrint("here is the one =-=-=-=-=-=-=-=-=--=- ${await Injector.getAppleName()}");
          Utils.showCircularProgressLottie(false);
          if (apiCall != null) {
            apiCall();
          }
          // socialLogin(
          //     providerType: "apple",
          //     token: result.identityToken!,
          //     firstName: await Injector.getAppleName() != null
          //         ? await Injector.getAppleName()
          //         : result.givenName != null && result.givenName!.isNotEmpty
          //         ? result.givenName
          //         : "",
          //     lastName: await Injector.getAppleLastName() != null
          //         ? await Injector.getAppleLastName()
          //         : result.familyName != null && result.familyName!.isNotEmpty
          //         ? result.familyName
          //         : "",
          //     emailSocial: await Injector.getAppleEmail() != null
          //         ? await Injector.getAppleEmail()
          //         : result.email != null && result.email!.isNotEmpty
          //         ? result.email
          //         : "");
          // Utils.transitionWithTo(
          //   SelectUserPreferenceView(
          //       type: "apple", idToken: result.identityToken!),
          // );
        }
        // socialLogin(
        //   accountType: "user",
        //   providerType: 'apple',
        //   token: result.identityToken!,
        // );
      }
    } catch (error) {
      // Utils.showErrToast("Algo salió mal... inténtalo de nuevo más tarde...");
      debugPrint("Error with apple sign in ${error.toString()}");
    }
  }

  googleLogin({Function? apiCall}) async {
    try {
      Utils.showCircularProgressLottie(true);
      debugPrint('Google login method called...');
      var result = await Injector.googleSignIn.signIn();

      if (result == null) {
        debugPrint('Unable to login with google...');
        Utils.showCircularProgressLottie(false);
        return;
      }
      debugPrint("Success");

      final googleAuth = await result.authentication;
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      if (googleAuth.idToken != null) {
        Utils.showCircularProgressLottie(false);
        // Utils.transitionWithTo(
        //   SelectUserPreferenceView(type: "google", idToken: googleAuth.idToken),
        // );
       if(apiCall!=null){
         apiCall();
       }
      }
      debugPrint("Id token, ${googleAuth.idToken.toString()}");
      debugPrint("Google Access Token, ${googleAuth.accessToken.toString()}");
      debugPrint("Hello, ${result.displayName}!");
      debugPrint("Your email : ${result.email}");
      debugPrint("Profile pic URL : ${result.photoUrl}");
      debugPrint("Provide Id : ${result.id}");
    } catch (error) {
      Utils.showCircularProgressLottie(false);
      debugPrint(error.toString());
    }
  }

  static Future<String?> facebookSignin({Function? voidCallback}) async {
    try {
      final _instance = FacebookAuth.instance;
      Utils.showCircularProgressLottie(true);
      final result = await _instance.login(permissions: ['email']);
      if (result.status == LoginStatus.success) {
        final OAuthCredential credential = FacebookAuthProvider.credential(result.accessToken!.token);
        debugPrint("uzair shaikh here it is ");
        // final a = await FirebaseAuth.instance.signInWithCredential(credential);
        if (result.accessToken != null) {
          Utils.showCircularProgressLottie(false);
          if(voidCallback!=null){
            voidCallback();
          }
          // socialLogin(
          //   providerType: "apple",
          //   token: result.identityToken!,
          // );
          // Utils.transitionWithTo(
          //   SelectUserPreferenceView(
          //       type: "apple", idToken: result.identityToken!),
          // );
        } else {

          Utils.showCircularProgressLottie(false);
          Injector.googleSignIn.signOut();
          await Injector.firebaseAuth.signOut();
        }
        // await _instance.getUserData().then((userData) async {
        //   await _auth.currentUser!.updateEmail(userData['email']);
        // });
        return null;
      } else if (result.status == LoginStatus.cancelled) {
        Utils.showCircularProgressLottie(false);
        Injector.googleSignIn.signOut();
        await Injector.firebaseAuth.signOut();
        return 'Login cancelled';
      } else {
        Utils.showCircularProgressLottie(false);
        Injector.googleSignIn.signOut();
        await Injector.firebaseAuth.signOut();
        return 'Error';
      }
    } catch (e) {
      Injector.googleSignIn.signOut();
      await Injector.firebaseAuth.signOut();
      debugPrint(e.toString());
      // return e.toString();
    }
  }
}
