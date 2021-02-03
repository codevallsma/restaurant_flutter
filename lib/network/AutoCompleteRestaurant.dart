import 'package:json_annotation/json_annotation.dart';
part 'AutoCompleteRestaurant.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class AutoCompleteRestaurant {
  int restaurantId;
  String restaurantName;
  AutoCompleteRestaurant({this.restaurantId, this.restaurantName});
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory AutoCompleteRestaurant.fromJson(Map<String, dynamic> json) => _$AutoCompleteRestaurantFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$AutoCompleteRestaurantToJson(this);
}