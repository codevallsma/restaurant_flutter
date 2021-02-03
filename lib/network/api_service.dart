import 'package:api_example/network/AuthData.dart';
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

  @POST("login")
  Future<TokenGetter> postLogin(@Body() UserSignIn userSignIn);
  @POST("registration")
  Future<UserDetails> registerUser(@Body() SignUpJson post);
  @GET("users")
  Future<UserDetails> getUserDetails(@Query("id") String username,  @Header("Authorization") String header);

}