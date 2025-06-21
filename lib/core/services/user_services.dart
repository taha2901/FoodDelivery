import 'package:firebase_auth/firebase_auth.dart';
import 'package:food_delivery/core/services/firestore_services.dart';
import 'package:food_delivery/features/auth/data/user_data.dart';
import 'package:food_delivery/core/utilities/constants.dart';

class UserServices {
  final _firestoreServices = FirestoreServices.instance;

  Future<UserData> fetchUserData() async {
    final uid = FirebaseAuth.instance.currentUser!.uid;
    return await _firestoreServices.getDocument<UserData>(
      path: ApiPaths.users(uid),
      builder: (data, id) => UserData.fromMap(data, id),
    );
  }

  Future<void> updateUserData(UserData userData) async {
    await _firestoreServices.setData(
      path: ApiPaths.users(userData.id),
      data: userData.toMap(),
    );
  }
}
