import 'package:json_annotation/json_annotation.dart';
part 'CategoriaResultAll.g.dart';

/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()

class CategoriaResultAll {
  int id;
  String categoria;

  CategoriaResultAll({this.id, this.categoria});
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory CategoriaResultAll.fromJson(Map<String, dynamic> json) => _$CategoriaResultAllFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$CategoriaResultAllToJson(this);
}