import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:app_chat_firebase/import_file/import_all.dart';


class AppleAuth{
  AppleAuth._();

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  static String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  static String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }

  static Future<AppleUserCredential> signInWithApple() async {
    if (!Platform.isIOS) {
      final provider = OAuthProvider("apple.com");
      provider.addScope('email');
      provider.addScope('name');
      final userCredential = await FirebaseAuth.instance.signInWithProvider(provider);
      return AppleUserCredential(
        userCredential: userCredential,
        appleUser: null,
      );
    }

    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );
    
    final familyName = appleCredential.familyName;
    final givenName = appleCredential.givenName;

    final displayName = [
      if (givenName != null) givenName,
      if (familyName != null) familyName,
    ].join(' ');

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    logger.i('oauthCredential.accessToken ${oauthCredential.accessToken}');
    logger.i('oauthCredential.accessToken ${appleCredential.authorizationCode}');

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    final userCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
    return AppleUserCredential(
      userCredential: userCredential,
      appleUser: AppleUser(
        fullName: displayName,
      ),
    );
  }
}

class AppleUserCredential {
  AppleUserCredential({
    required this.userCredential,
    this.appleUser,
  });

  final UserCredential userCredential;
  final AppleUser? appleUser;
}

class AppleUser {
  AppleUser({
    this.fullName,
  });

  final String? fullName;
}
