import 'package:json_annotation/json_annotation.dart';
part 'UserDetails.g.dart';


/// An annotation for the code generator to know that this class needs the
/// JSON serialization logic to be generated.
@JsonSerializable()
class UserDetails {
  int id;
  String email;
  String username;
  String passwordConfirm;

  UserDetails({int id, String email, String username, String passwordConfirm}) {
    this.id = id;
    this.email = email;
    this.username = username;
    this.passwordConfirm = passwordConfirm;
  }
  /// A necessary factory constructor for creating a new User instance
  /// from a map. Pass the map to the generated `_$UserFromJson()` constructor.
  /// The constructor is named after the source class, in this case, User.
  factory UserDetails.fromJson(Map<String, dynamic> json) => _$UserDetailsFromJson(json);

  /// `toJson` is the convention for a class to declare support for serialization
  /// to JSON. The implementation simply calls the private, generated
  /// helper method `_$UserToJson`.
  Map<String, dynamic> toJson() => _$UserDetailsToJson(this);
}