class SingletonUserDetails {
  static final SingletonUserDetails _singleton = SingletonUserDetails._internal();
  int _id;
  String _email;
  String _username;
  String _passwordConfirm;

  factory SingletonUserDetails() {
    return _singleton;
  }
  void setSingletonUserDetails(  int id, String email, String username,String passwordConfirm){
    this._id = id;
    this._email = email;
    this._username = username;
    this._passwordConfirm = passwordConfirm;
  }
  static SingletonUserDetails create() {
    return SingletonUserDetails();
  }

  static SingletonUserDetails get singleton => _singleton;

  SingletonUserDetails._internal();

  int get id => _id;

  String get passwordConfirm => _passwordConfirm;

  String get username => _username;

  String get email => _email;
}