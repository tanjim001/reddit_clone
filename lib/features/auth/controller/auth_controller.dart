import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:reddit/core/utils.dart';
import 'package:reddit/features/auth/repository/auth_repository.dart';
import 'package:reddit/model/user_model.dart';

final authcontrollerProvider = StateNotifierProvider<AuthController, bool>(
    (ref) => AuthController(
        authRepository: ref.watch(authrepositoryProvider), ref: ref));

final userProvider = StateProvider<Usermodel?>((ref) => null);

final authstatechangeprovider = StreamProvider((ref) {
  final authcontroller = ref.watch(authcontrollerProvider.notifier);
  return authcontroller.authStateChange;
});

final getUserDataProvider = StreamProvider.family((ref, String uid) {
  final authController = ref.watch(authcontrollerProvider.notifier);
  return authController.getUserData(uid);
});

class AuthController extends StateNotifier<bool> {
  final AuthRepository _authRepository;
  final Ref _ref;

  AuthController({required AuthRepository authRepository, required Ref ref})
      : _authRepository = authRepository,
        _ref = ref,
        super(false);

  //here firebase provided user class model
  Stream<User?> get authStateChange => _authRepository.authStateChange;

  void signInWithGoogle(BuildContext context) async {
    state = true;
    final user = await _authRepository.signInwithGoogle();
    state = false;
    user.fold(
        (l) => showSnackBar(context, l.message),
        (usermodel) =>
            _ref.read(userProvider.notifier).update((state) => usermodel));
  }

  Stream<Usermodel> getUserData(String uid) {
    return _authRepository.getUserData(uid);
  }
}
