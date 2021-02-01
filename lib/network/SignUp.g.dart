// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SignUp.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUp _$SignUpFromJson(Map<String, dynamic> json) {
  return SignUp(
    json['userName'] as String,
    json['email'] as String,
    json['password'] as String,
  );
}

Map<String, dynamic> _$SignUpToJson(SignUp instance) => <String, dynamic>{
      'password': instance.password,
      'email': instance.email,
      'userName': instance.userName,
    };
