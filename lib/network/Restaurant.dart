import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:json_annotation/json_annotation.dart';
part 'Restaurant.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class Restaurant {
  int id;
  String ocupacio;
  String emplacamament;
  double superficieOcupada;
  int taules;
  int cadires;
  double latitud;
  double longitud;
  String restaurantName;

  Restaurant({this.id,
    this.ocupacio,
    this.emplacamament,
    this.superficieOcupada,
    this.taules,
    this.cadires,
    this.latitud,
    this.longitud,
    this.restaurantName});

  LatLng locationCords(){
    return new LatLng(latitud, longitud);
  }
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory Restaurant.fromJson(Map<String, dynamic> json) => _$RestaurantFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$RestaurantToJson(this);
}