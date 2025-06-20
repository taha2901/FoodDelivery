import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/auth_services.dart';
import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/core/utilities/constants.dart';
import 'package:food_delivery/features/auth/data/user_data.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  final AuthServices authServices = AuthServicesImpl();
  final firestoreServices = FirestoreServices.instance;

  Future<void> loginWithEmailAndPassword(String email, String password) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.loginWithEmailAndPassword(email, password);
      if (result) {
        emit(const AuthDone());
      } else {
        emit(AuthError(message: "Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(message: "Error: $e"));
    }
  }

  Future<void> registerWithEmailAndPassword(
      String email, String password, String username) async {
    emit(AuthLoading());
    try {
      final result =
          await authServices.registerWithEmailAndPassword(email, password);
      if (result) {
        await _saveUserData(email, username);
        emit(const AuthDone());
      } else {
        emit(AuthError(message: "Invalid email or password"));
      }
    } catch (e) {
      emit(AuthError(message: "Error: $e"));
    }
  }

  Future<void> _saveUserData(String email, String username) async {
    final currentUser = authServices.currentUser();
    final userData = UserData(
      id: currentUser!.uid,
      username: username,
      email: email,
      createdAt: DateTime.now().toIso8601String(),
    );

    await firestoreServices.setData(
      path: ApiPaths.users(userData.id),
      data: userData.toMap(),
    );
  }

  void checkAuth() {
    final user = authServices.currentUser();
    if (user != null) {
      emit(const AuthDone());
    }
  }

  Future<void> logOut() async {
    // print("Logging out...");
    emit(const AuthLogingout());
    try {
      await authServices.logOut();
      // print("Logged out successfully");
      emit(const AuthLogedout());
    } catch (e) {
      // print("Logout error: $e");
      emit(AuthLogoutError(message: "Error: $e"));
    }
  }
}
