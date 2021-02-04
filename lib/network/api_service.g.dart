// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_service.dart';

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

class _ApiService implements ApiService {
  _ApiService(this._dio, {this.baseUrl}) {
    ArgumentError.checkNotNull(_dio, '_dio');
    baseUrl ??= 'http://10.0.2.2:8080/';
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

  @override
  Future<UserDetails> getUserDetails(username, header) async {
    ArgumentError.checkNotNull(username, 'username');
    ArgumentError.checkNotNull(header, 'header');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'id': username};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<Map<String, dynamic>>('users',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': header},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    final value = UserDetails.fromJson(_result.data);
    return value;
  }

  @override
  Future<List<AutoCompleteRestaurant>> getRestaurantNameAutocomplete(
      restaurantName, header) async {
    ArgumentError.checkNotNull(restaurantName, 'restaurantName');
    ArgumentError.checkNotNull(header, 'header');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'restaurantName': restaurantName
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('restaurant/autocomplete',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': header},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            AutoCompleteRestaurant.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<CategoriaResultAll>> getAllCategories(header) async {
    ArgumentError.checkNotNull(header, 'header');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('category',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': header},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) =>
            CategoriaResultAll.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Restaurant>> getRestaurantsGivenCategory(
      restaurantName, header) async {
    ArgumentError.checkNotNull(restaurantName, 'restaurantName');
    ArgumentError.checkNotNull(header, 'header');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{r'category': restaurantName};
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('restaurant',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': header},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Restaurant.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }

  @override
  Future<List<Restaurant>> getKNearestRestaurasnts(
      latitude, longitude, num_restaurants, header) async {
    ArgumentError.checkNotNull(latitude, 'latitude');
    ArgumentError.checkNotNull(longitude, 'longitude');
    ArgumentError.checkNotNull(num_restaurants, 'num_restaurants');
    ArgumentError.checkNotNull(header, 'header');
    const _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{
      r'lat': latitude,
      r'lng': longitude,
      r'num_restaurants': num_restaurants
    };
    final _data = <String, dynamic>{};
    final _result = await _dio.request<List<dynamic>>('restaurant/knn',
        queryParameters: queryParameters,
        options: RequestOptions(
            method: 'GET',
            headers: <String, dynamic>{r'Authorization': header},
            extra: _extra,
            baseUrl: baseUrl),
        data: _data);
    var value = _result.data
        .map((dynamic i) => Restaurant.fromJson(i as Map<String, dynamic>))
        .toList();
    return value;
  }
}
