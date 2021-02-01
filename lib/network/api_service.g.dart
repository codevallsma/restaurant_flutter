// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://192.168.1.45:8080/';
  }

  final Dio _dio;

  String baseUrl;

  @override
  Future<TokenGetter> postLogin(userSignIn) async {
    ArgumentError.checkNotNull(userSignIn, 'userSignIn');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(userSignIn?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('login',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = TokenGetter.fromJson(_result.data);
    return value;
  }

  @override
  Future<UserDetails> registerUser(post) async {
    ArgumentError.checkNotNull(post, 'post');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    _data.addAll(post?.toJson() ?? <String, dynamic>{});
    final _result = await _dio.request<Map<String, dynamic>>('registration',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'POST',
            headers: <String, dynamic>{},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserDetails.fromJson(_result.data);
    return value;
  }
}
