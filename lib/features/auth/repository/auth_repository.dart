import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fpdart/fpdart.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:reddit/core/constants/constantsicon.dart';
import 'package:reddit/core/constants/firebase_constant.dart';
import 'package:reddit/core/failure.dart';
import 'package:reddit/core/provider/firebase_provider.dart';
import 'package:reddit/core/type_def.dart';
import 'package:reddit/model/user_model.dart';

final authrepositoryProvider = Provider((ref) => AuthRepository(
    firestore: ref.read(firestoreProvider),
    auth: ref.read(authProvider),
    googleSignIn: ref.read(googleSignInProvider)));

class AuthRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;
  final GoogleSignIn _googleSignIn;
  //getter method _users provides a reference to the "users" collection in Firestore
  CollectionReference get _users =>
      _firestore.collection(FirebaseConstants.usersCollection);

  Stream<Usermodel> getUserData(String uid) {
    return _users.doc(uid).snapshots().map(
        (event) => Usermodel.fromMap(event.data() as Map<String, dynamic>));
  }
  //
  Stream<User?>get authStateChange=>_auth.authStateChanges();
  //constructon for privae field
  AuthRepository(
      {required FirebaseFirestore firestore,
      required FirebaseAuth auth,
      required GoogleSignIn googleSignIn})
      : _firestore = firestore,
        _auth = auth,
        _googleSignIn = googleSignIn;
  //google sign in method
  FutureEither<Usermodel> signInwithGoogle() async {
    try {
      //signed in using google account
      final GoogleSignInAccount? googleuser = await _googleSignIn.signIn();
      //authinticated and passed authentication data to googleauth

      final googleauth = await googleuser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleauth?.accessToken, idToken: googleauth?.idToken);

      UserCredential userCredential =
          await _auth.signInWithCredential(credential);

      late Usermodel usermodel;

      if (userCredential.additionalUserInfo!.isNewUser) {
        usermodel = Usermodel(
            name: userCredential.user!.displayName ?? "",
            banner: Constanticon.bannerDefault,
            profile:
                userCredential.user!.photoURL ?? Constanticon.avatarDefault,
            uid: userCredential.user!.uid,
            isAuthinticated: true,
            karma: 0,
            awards: []);
        //its sends data to firestore databse
        await _users.doc(userCredential.user!.uid).set(usermodel.toMap());
      }else{
        usermodel= await getUserData(userCredential.user!.uid).first;
      }

      if (kDebugMode) {
        print("helllo");
        print(userCredential);
      }

      return right(usermodel);
    } on FirebaseException catch (e) {
      throw e.message!;
    } catch (e) {
      if (kDebugMode) {
        print("error authrepository");
        print(e);
      }
      return left(Failure(e.toString()));
    }
  }
}
