// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AuthData.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserSignIn _$UserSignInFromJson(Map<String, dynamic> json) {
  return UserSignIn(
    json['user'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$UserSignInToJson(UserSignIn instance) =>
    <String, dynamic>{
      'password': instance.password,
      'user': instance.user,
    };
