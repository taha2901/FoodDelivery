import 'package:firebase_auth/firebase_auth.dart';

abstract class AuthServices {
  Future<bool> loginWithEmailAndPassword(String email, String password);
  Future<bool> registerWithEmailAndPassword(String email, String password);
  User? currentUser();
  Future<void> logOut();
  // إضافة method جديدة لتحديث الإيميل
  Future<bool> updateUserEmail(String newEmail);
}

class AuthServicesImpl implements AuthServices {
  final _firebaseAuth = FirebaseAuth.instance;

  @override
  User? currentUser() {
    return _firebaseAuth.currentUser;
  }
    
  @override
  Future<bool> loginWithEmailAndPassword(String email, String password) async {
    final userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<bool> registerWithEmailAndPassword(
      String email, String password) async {
    final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    final user = userCredential.user;
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  @override
  Future<void> logOut() async {
    await _firebaseAuth.signOut();
  }

  // Method جديدة لتحديث الإيميل في Authentication
  @override
  Future<bool> updateUserEmail(String newEmail) async {
    try {
      final user = _firebaseAuth.currentUser;
      if (user != null) {
        // تحديث الإيميل في Firebase Authentication
        await user.updateEmail(newEmail);
        
        // إرسال إيميل تأكيد للإيميل الجديد (اختياري)
        await user.sendEmailVerification();
        
        return true;
      }
      return false;
    } catch (e) {
      // في حالة إن المستخدم محتاج re-authentication
      if (e is FirebaseAuthException && e.code == 'requires-recent-login') {
        throw FirebaseAuthException(
          code: 'requires-recent-login',
          message: 'يجب إعادة تسجيل الدخول لتحديث البريد الإلكتروني',
        );
      }
      rethrow;
    }
  }
}