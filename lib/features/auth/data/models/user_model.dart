import 'package:freezed_annotation/freezed_annotation.dart';
import '../../domain/entities/user.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// LEARNING NOTES:
/// Responsible for: API calls and local storage.
/// NOT allowed to: contain business logic or UI.
/// 
/// PURPOSE: Represents the JSON response structure from the backend.
@freezed
abstract class UserModel with _$UserModel {
  const UserModel._(); // Required for adding methods to Freezed classes

  const factory UserModel({
    required int id,
    required String email,
    required String name,
  }) = _UserModel;

  User toEntity() => User(
        id: id,
        email: email,
        name: name,
      );

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
