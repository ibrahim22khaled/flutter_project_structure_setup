import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

/// LEARNING NOTES:
/// Responsible for: API calls and local storage.
/// NOT allowed to: contain business logic or UI.
/// 
/// PURPOSE: Represents the JSON response structure from the backend.
@freezed
abstract class UserModel with _$UserModel {
  const factory UserModel({
    required int id,
    required String email,
    required String name,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
