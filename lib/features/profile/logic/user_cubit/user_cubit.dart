import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:food_delivery/core/services/user_services.dart';
import 'package:food_delivery/features/auth/data/user_data.dart';
import 'package:food_delivery/features/profile/logic/user_cubit/user_states.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());

  final UserServices _userServices = UserServices();

  Future<void> getUserData() async {
    emit(UserLoading());
    try {
      final user = await _userServices.fetchUserData();
      emit(UserLoaded(user));
    } catch (e) {
      emit(UserError('فشل في تحميل البيانات: $e'));
    }
  }

  Future<void> updateUser(UserData userData) async {
    emit(UserUpdating());
    try {
      await _userServices.updateUserData(userData);
      emit(UserUpdated());
      getUserData(); 
    } catch (e) {
      emit(UserError('فشل في التحديث: $e'));
    }
  }
}
