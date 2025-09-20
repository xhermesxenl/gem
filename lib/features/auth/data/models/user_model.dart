import '../../domain/entities/user.dart';

class UserModel extends User {
  UserModel({required super.id, required super.email});

  factory UserModel.fromSupabase(String id, String email) {
    return UserModel(id: id, email: email);
  }
}
