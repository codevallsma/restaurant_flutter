// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'AutoCompleteRestaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AutoCompleteRestaurant _$AutoCompleteRestaurantFromJson(
    Map<String, dynamic> json) {
  return AutoCompleteRestaurant(
    restaurantId: json['restaurantId'] as int,
    restaurantName: json['restaurantName'] as String,
  );
}

Map<String, dynamic> _$AutoCompleteRestaurantToJson(
        AutoCompleteRestaurant instance) =>
    <String, dynamic>{
      'restaurantId': instance.restaurantId,
      'restaurantName': instance.restaurantName,
    };
