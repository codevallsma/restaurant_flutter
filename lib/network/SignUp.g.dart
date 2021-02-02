// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpJson _$SignUpJsonFromJson(Map<String, dynamic> json) {
  return SignUpJson(
    json['user'] as String,
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$SignUpJsonToJson(SignUpJson instance) =>
    <String, dynamic>{
      'password': instance.password,
      'email': instance.email,
      'user': instance.user,
    };
