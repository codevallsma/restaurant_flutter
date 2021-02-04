// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Restaurant.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Restaurant _$RestaurantFromJson(Map<String, dynamic> json) {
  return Restaurant(
    id: json['id'] as int,
    ocupacio: json['ocupacio'] as String,
    emplacamament: json['emplacamament'] as String,
    superficieOcupada: (json['superficieOcupada'] as num)?.toDouble(),
    taules: json['taules'] as int,
    cadires: json['cadires'] as int,
    latitud: (json['latitud'] as num)?.toDouble(),
    longitud: (json['longitud'] as num)?.toDouble(),
    restaurantName: json['restaurantName'] as String,
  );
}

Map<String, dynamic> _$RestaurantToJson(Restaurant instance) =>
    <String, dynamic>{
      'id': instance.id,
      'ocupacio': instance.ocupacio,
      'emplacamament': instance.emplacamament,
      'superficieOcupada': instance.superficieOcupada,
      'taules': instance.taules,
      'cadires': instance.cadires,
      'latitud': instance.latitud,
      'longitud': instance.longitud,
      'restaurantName': instance.restaurantName,
    };
