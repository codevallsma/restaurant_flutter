import 'package:api_example/network/AuthData.dart';
import 'package:api_example/network/AutoCompleteRestaurant.dart';
import 'package:api_example/network/CategoriaResultAll.dart';
import 'package:api_example/network/Restaurant.dart';
import 'package:api_example/network/SignUp.dart';
import 'package:api_example/network/TokenGetter.dart';
import 'package:api_example/network/UserDetails.dart';
import 'package:dio/dio.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';
import 'package:retrofit/retrofit.dart';

part 'api_service.g.dart';

@RestApi(baseUrl: "http://10.0.2.2:8080/")
abstract class ApiService {
  factory ApiService(Dio dio, {String baseUrl})=_ApiService;

  static ApiService create() {
    final dio = Dio();
    dio.interceptors.add(PrettyDioLogger());
    return ApiService(dio);
  }

  //returns the jwt in order to access restringed zones in our api
  @POST("login")
  Future<TokenGetter> postLogin(@Body() UserSignIn userSignIn);
  // registers new users
  @POST("registration")
  Future<UserDetails> registerUser(@Body() SignUpJson post);
  //gets all the user details
  @GET("users")
  Future<UserDetails> getUserDetails(@Query("id") String username,  @Header("Authorization") String header);
  //autocomplete name restaurants
  @GET("restaurant/autocomplete")
  Future<List<AutoCompleteRestaurant>> getRestaurantNameAutocomplete(@Query("restaurantName") String restaurantName,  @Header("Authorization") String header);
  //gets all the category names
  @GET("category")
  Future<List<CategoriaResultAll>> getAllCategories(@Header("Authorization") String header);
  // gets all the restaurants given category
  @GET("restaurant")
  Future<List<Restaurant>> getRestaurantsGivenCategory(@Query("category") String restaurantName,  @Header("Authorization") String header);

}