import 'package:json_annotation/json_annotation.dart';
part 'TokenGetter.g.dart';

@JsonSerializable()
class TokenGetter {
  TokenGetter({this.id_token});
  String id_token;

  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory TokenGetter.fromJson(Map<String, dynamic> json) => _$TokenGetterFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$TokenGetterToJson(this);
}