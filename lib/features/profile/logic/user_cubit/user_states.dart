import 'package:food_delivery/features/auth/data/user_data.dart';

// User States
abstract class UserState {}

class UserInitial extends UserState {}
class UserLoading extends UserState {}
class UserLoaded extends UserState {
  final UserData user;
  UserLoaded(this.user);
}
class UserUpdating extends UserState {}
class UserUpdated extends UserState {}
class UserError extends UserState {
  final String message;
  UserError(this.message);
}

class UserRequiresReauth extends UserState {
  final String message;
  final UserData userData; 
  UserRequiresReauth(this.message, this.userData);
}