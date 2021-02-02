// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'UserDetails.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserDetails _$UserDetailsFromJson(Map<String, dynamic> json) {
  return UserDetails(
    id: json['id'] as int,
    email: json['email'] as String,
    username: json['username'] as String,
    passwordConfirm: json['passwordConfirm'] as String,
  );
}

Map<String, dynamic> _$UserDetailsToJson(UserDetails instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'passwordConfirm': instance.passwordConfirm,
    };
