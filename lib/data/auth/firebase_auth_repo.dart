//import 'package:dr_gold/data/auth/apple_auth.dart';
import 'package:app_model/features/auth/user.dart';
import 'package:base_component/import_all.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';

import 'auth_exception.dart';

//import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginSocialResult {
  String? accessToken;
  String? email;
  String? displayName;
  String? socialId;
  String? photoUrl;
  UserCredential? userCredential;
//<editor-fold desc="Data Methods">

  LoginSocialResult({
    this.accessToken,
    this.email,
    this.displayName,
    this.socialId,
    this.photoUrl,
    this.userCredential,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LoginSocialResult &&
          runtimeType == other.runtimeType &&
          accessToken == other.accessToken &&
          email == other.email &&
          displayName == other.displayName &&
          socialId == other.socialId &&
          photoUrl == other.photoUrl);

  @override
  int get hashCode =>
      accessToken.hashCode ^
      email.hashCode ^
      displayName.hashCode ^
      socialId.hashCode ^
      photoUrl.hashCode ^
      userCredential.hashCode;

  @override
  String toString() {
    return 'LoginSocialResult{ accessToken: $accessToken, '
        'email: $email, displayName: $displayName, '
        'socialId: $socialId, '
        'photoUrl: $photoUrl,}';
  }

  LoginSocialResult copyWith({
    String? accessToken,
    String? email,
    String? displayName,
    String? socialId,
    String? photoUrl,
    UserCredential? userCredential,
  }) {
    return LoginSocialResult(
      accessToken: accessToken ?? this.accessToken,
      email: email ?? this.email,
      displayName: displayName ?? this.displayName,
      socialId: socialId ?? this.socialId,
      photoUrl: photoUrl ?? this.photoUrl,
      userCredential: userCredential ?? this.userCredential,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'accessToken': accessToken,
      'email': email,
      'displayName': displayName,
      'socialId': socialId,
      'photoUrl': photoUrl,
    };
  }

  factory LoginSocialResult.fromMap(Map<String, dynamic> map) {
    return LoginSocialResult(
      accessToken: map['accessToken'] as String,
      email: map['email'] as String,
      displayName: map['displayName'] as String,
      socialId: map['socialId'] as String,
      photoUrl: map['photoUrl'] as String,
      //userCredential: map['photoUrl'] as String,
    );
  }

//</editor-fold>
}

/// {@template authentication_repository}
/// Repository which manages user authentication.
/// {@endtemplate}
class FireBaseAuthRepo {
  static const int OTP_DURATION_SEC = 80;

  /// {@macro authentication_repository}
  FireBaseAuthRepo({
    firebase_auth.FirebaseAuth? firebaseAuth,
    GoogleSignIn? googleSignIn,
  }) : _firebaseAuth = firebaseAuth ?? firebase_auth.FirebaseAuth.instance,
  _googleSignIn = googleSignIn ?? GoogleSignIn.standard();

  final firebase_auth.FirebaseAuth _firebaseAuth;
  final GoogleSignIn _googleSignIn;

  // For phone login
  String? _verificationId;

  /// User cache key.
  /// Should only be used for testing purposes.
  @visibleForTesting
  static const userCacheKey = '__user_cache_key__';

  User _user = User.empty;

  /// Stream of [User] which will emit the current user when
  /// the authentication state changes.
  ///
  /// Emits [User.empty] if the user is not authenticated.
  Stream<User> get user {
    return _firebaseAuth.authStateChanges().map((firebaseUser) {
      final user = firebaseUser == null ? User.empty : firebaseUser.toUser;
      // _cache.write(key: userCacheKey, value: user);
      _user = user;
      return _user;
    });
  }

  /// Returns the current cached user.
  /// Defaults to [User.empty] if there is no cached user.
  User get currentUser {
    // return _cache.read<User>(key: userCacheKey) ?? User.empty;
    return _user;
  }

  /// Creates a new user with the provided [email] and [password].
  ///
  /// Throws a [SignUpWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> signUp({required String email, required String password}) async {
    try {
      await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (e) {
      throw SignUpWithEmailAndPasswordFailure.fromCode(e.code);
    } catch (_) {
      throw const SignUpWithEmailAndPasswordFailure();
    }
  }

  /// Signs in with the provided [email] and [password].
  ///
  /// Throws a [LogInWithEmailAndPasswordFailure] if an exception occurs.
  Future<void> logInWithEmailAndPassword({
    required String email,
    required String password,
  }) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
    } on FirebaseAuthException catch (error) {
      logger.e(error);
      return Future.error(LogInWithSocialFailure.fromCode(error.code));
    } catch (error) {
      logger.e(error);
      return Future.error(error);
    }
  }

  /// Sent OTP to the provided [phoneNumber].
  /// If automatic SMS code resolution -> call [onSuccessLogin]
  ///
  /// Throws a [LogInWithPhoneFailure] if an exception occurs.
  Future<void> logInPhone({
    required String phoneNumber,
    required void Function(String verificationID) onCodeSent,
    required void Function(String? msg) onFail,
    required VoidCallback onSuccessLogin,
  }) async {
    try {
      await _firebaseAuth.verifyPhoneNumber(
          phoneNumber: phoneNumber,
          verificationCompleted: (PhoneAuthCredential credential) async {
            await _firebaseAuth.signInWithCredential(credential).then((value) async {
              if (value.user != null) {
                _verificationId = null;
                onSuccessLogin();
              }
            });
          },
          verificationFailed: (FirebaseAuthException e) {
            throw LogInWithPhoneFailure.fromCode(e.code);
            if (e.code == 'invalid-phone-number') {
              onFail('invalid-phone-number');
            }
            onFail(e.message);
          },
          codeSent: (String verificationID, int? resendToken) async {
            onCodeSent(verificationID);
            // await SmsAutoFill().listenForCode;
            _verificationId = verificationID;
          },
          codeAutoRetrievalTimeout: (String verificationID) {
            _verificationId = verificationID;
          },
          timeout: const Duration(seconds: OTP_DURATION_SEC));
    } on FirebaseAuthException catch (e) {
      throw LogInWithPhoneFailure.fromCode(e.code);
    } catch (_) {
      throw const LogInWithPhoneFailure();
    }
  }

  Future<void> verifyOTPAndCredential({required String pin}) async {
    if (_verificationId == null) {
      return Future.error('verificationCode null');
    }

    try {
      await _firebaseAuth
          .signInWithCredential(
              PhoneAuthProvider.credential(verificationId: _verificationId!, smsCode: pin))
          .then((value) async {
        if (value.user != null) {
          // await _addToken(value.user!);
          _verificationId = null;
          return Future.value();
        } else {
          return Future.error('signInWithCredential error');
        }
      });
    } catch (e) {
      return Future.error(e);
    }
  }

  /// Starts the Sign In with Google Flow.
  ///
  /// Throws a [LogInWithGoogleFailure] if an exception occurs.
  Future<LoginSocialResult?> signInWithGoogle() async {
    try {
      final googleUser = await _googleSignIn.signIn();
      final googleAuth = await googleUser?.authentication;
      var accessToken = googleAuth?.accessToken;
      var idToken = googleAuth?.idToken;
      if (accessToken == null || idToken == null) {
        return Future.error(LogInWithSocialCancel());
      }

      // return LoginSocialResult(
      //   accessToken: googleAuth?.accessToken,
      //   displayName: googleUser?.displayName,
      //   email: googleUser?.email,
      //   socialId: googleUser?.id,
      //   photoUrl: googleUser?.photoUrl,
      // );

      late final firebase_auth.AuthCredential credential;
      credential = firebase_auth.GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken,
      );

      var userCredential = await _firebaseAuth.signInWithCredential(credential);
      return Future.value(LoginSocialResult(
        accessToken: accessToken,
        userCredential: userCredential,
        email: userCredential.user?.email,
        photoUrl: userCredential.user?.photoURL,
        displayName: userCredential.user?.displayName,
        socialId: userCredential.user?.uid,
      ));
    } on FirebaseAuthException catch (error) {
      logger.e(error);
      return Future.error(LogInWithSocialFailure.fromCode(error.code));
    } catch (error) {
      logger.e(error);
      return Future.error(error);
    }
  }

  Future<LoginSocialResult?> signInWithFacebook() async {
    // TODO: Handle signin with facebook
    throw UnimplementedError();
    // dynamic fbLoginRs = await FacebookAuth.instance.login();
    // try {
    //   if (fbLoginRs != null && fbLoginRs.status == LoginStatus.success) {
    //     logger.i('signInWithFacebook => $fbLoginRs');
    //     if (fbLoginRs is AccessToken) {
    //       logger.i('signInWithFacebook => AccessToken');

    //       // Login success
    //       final OAuthCredential fbAuthCredential =
    //       FacebookAuthProvider.credential(fbLoginRs.token);

    //       return await _firebaseAuth
    //           .signInWithCredential(fbAuthCredential)
    //           .then((value) async {
    //         if (value.user != null) {
    //           _verificationId = null;
    //         }
    //         logger.i(fbAuthCredential);
    //         logger.i(fbLoginRs);
    //         return LoginSocialResult(
    //           accessToken: fbAuthCredential.accessToken,
    //           socialId: fbLoginRs.userId,
    //           displayName: value.user?.displayName,
    //           email: value.user?.email,
    //           photoUrl: value.user?.photoURL,
    //         );
    //       });
    //     } else if (fbLoginRs is LoginResult) {
    //       logger.i('signInWithFacebook => LoginResult');
    //       if (fbLoginRs.accessToken?.token.isNullOrEmpty() == true) {
    //         logger
    //             .e('signInWithFacebook err => ${fbLoginRs.message.toString()}');
    //         return Future.error(fbLoginRs.message.toString());
    //       }

    //       final OAuthCredential fbAuthCredential =
    //       FacebookAuthProvider.credential(fbLoginRs.accessToken!.token);
    //       return await _firebaseAuth
    //           .signInWithCredential(fbAuthCredential)
    //           .then((value) async {
    //         if (value.user != null) {
    //           _verificationId = null;
    //         }

    //         return LoginSocialResult(
    //           accessToken: fbAuthCredential.accessToken,
    //           socialId: value.additionalUserInfo?.profile?['id'],
    //           displayName: value.user?.displayName,
    //           email: value.user?.email,
    //           photoUrl: value.user?.photoURL,
    //         );
    //       });
    //     }
    //   }
    // } on FirebaseAuthException catch (error) {
    //   logger.e(error);
    //   return Future.error(LogInWithSocialFailure.fromCode(error.code));
    // } catch (error) {
    //   logger.e(error);
    //   return Future.error(error);
    // }

    // return Future.error(LogInWithSocialCancel());
  }

  /// Sign in with apple
  // Future<LoginSocialResult?> signInWithApple() async {
  //   logger.i('--------------------');
  //   logger.i('Sign-in Apple: begin');
  //   logger.i(_firebaseAuth.currentUser);
  //   // To prevent replay attacks with the credential returned from Apple, we
  //   // include a nonce in the credential request. When signing in with
  //   // Firebase, the nonce in the id token returned by Apple, is expected to
  //   // match the sha256 hash of `rawNonce`.
  //
  //   if (Platform.isAndroid) {
  //     logger.i('Sign-in Apple: Android');
  //     try {
  //       const platform = MethodChannel('APPLE_DRGOLD_CHANNEL');
  //       final token = await platform.invokeMethod('signInWithApple');
  //
  //       final appleProvider = _firebaseAuth.currentUser?.providerData
  //           .firstWhereOrNull((element) => element.providerId == "apple.com");
  //
  //       return LoginSocialResult(
  //         accessToken: token,
  //         displayName: _firebaseAuth.currentUser?.displayName,
  //         email: _firebaseAuth.currentUser?.email,
  //         socialId: appleProvider?.uid ?? '',
  //         photoUrl: _firebaseAuth.currentUser?.photoURL,
  //       );
  //     } on PlatformException catch (e) {
  //       logger.i(e);
  //     }
  //     return Future.value();
  //   }
  //
  //   logger.i('Sign-in Apple: IOS');
  //   try {
  //     final rawNonce = AppleAuth.generateNonce();
  //     final nonce = AppleAuth.sha256ofString(rawNonce);
  //
  //     // Request credential for the currently signed in Apple account.
  //     final appleCredential = await SignInWithApple.getAppleIDCredential(
  //       scopes: [
  //         AppleIDAuthorizationScopes.email,
  //         AppleIDAuthorizationScopes.fullName,
  //       ],
  //       nonce: nonce,
  //     );
  //     if (appleCredential.identityToken != null) {
  //       logger.i('APPLE-appleCredential: ${appleCredential}');
  //       logger.i('APPLE-appleCredential token: ${appleCredential.identityToken}');
  //       // Create an `OAuthCredential` from the credential returned by Apple.
  //       final oauthCredential = OAuthProvider("apple.com").credential(
  //         idToken: appleCredential.identityToken,
  //         rawNonce: rawNonce,
  //       );
  //       // logger.i(oauthCredential);
  //       // logger.i('--------------------');
  //       // logger.i('APPLE-oauthCredential: ${oauthCredential.accessToken}');
  //       //
  //       var firebaseCredential = await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  //
  //       return LoginSocialResult(
  //         accessToken: appleCredential.authorizationCode,
  //         displayName: firebaseCredential.user?.displayName,
  //         email: firebaseCredential.user?.email,
  //         socialId: appleCredential.userIdentifier,
  //         // photoUrl: appleCredential.,
  //       );
  //
  //       // Sign in the user with Firebase. If the nonce we generated earlier does
  //       // not match the nonce in `appleCredential.identityToken`, sign in will fail.
  //       // return await FirebaseAuth.instance
  //       //     .signInWithCredential(oauthCredential)
  //       //     .then((value) async {
  //       //   if (value.user != null) {
  //       //     // await _addToken(value.user!);
  //       //     _verificationId = null;
  //       //   }
  //       //   // var id = value?.user?.providerData.getOrNull(0)?.uid ?? '';
  //       //   // logger.i('--------------------');
  //       //   // logger.i(id);
  //       //
  //       //   return LoginSocialResult(
  //       //       userCredential: value, accessToken: oauthCredential.accessToken);
  //       // });
  //     }
  //   } on FirebaseAuthException catch (error) {
  //     logger.e(error);
  //     return Future.error(LogInWithSocialFailure.fromCode(error.code));
  //   } on SignInWithAppleAuthorizationException catch (error) {
  //     if (AuthorizationErrorCode.canceled == error.code) {
  //       return Future.error(LogInWithSocialCancel());
  //     }
  //     return Future.error(error);
  //   } catch (error) {
  //     logger.e(error);
  //     return Future.error(error);
  //   }
  //   return Future.error(LogInWithSocialCancel());
  // }

  /// Signs out the current user which will emit
  /// [UserModel.empty] from the [user] Stream.
  ///
  /// Throws a [LogOutFailure] if an exception occurs.
  Future<void> logOut() async {
    try {
      debugPrint('${_firebaseAuth.currentUser}');
      await Future.wait([
        _firebaseAuth.signOut(),
        _googleSignIn.signOut(),
      ]);
      await _firebaseAuth.currentUser?.delete();

    } catch (e) {
      debugPrint('$e');
      throw LogOutFailure();
    }
  }
}

extension on firebase_auth.User {
  User get toUser {
    return User(id: uid, email: email, name: displayName, photo: photoURL);
  }
}
