class SingletonApiToken {
  static final SingletonApiToken _singleton = SingletonApiToken._internal();
  String _token_Api;

  factory SingletonApiToken() {
    return _singleton;
  }
  void setApiToken(String token_Api){
    this._token_Api = token_Api;
  }
  static SingletonApiToken create() {
    return SingletonApiToken();
  }

  String get token_Api => _token_Api;

  String getTokenHeader(){
    return "Bearer "+_token_Api ;
  }

  SingletonApiToken._internal();
}