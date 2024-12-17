import 'package:dio/dio.dart' hide Headers;
import 'package:oneship_merchant_app/core/constant/api_constant.dart';
import 'package:oneship_merchant_app/domain/responses/response_domain.dart';
import 'package:retrofit/retrofit.dart';

import '../../domain/requests/register_phone/phone_register_request.dart';

part 'auth_api_service.g.dart';

@RestApi(baseUrl: ApiConstant.apiV1, parser: Parser.MapSerializable)
abstract class AuthApiService {
  factory AuthApiService(Dio dio, {String baseUrl}) = _AuthApiService;

  @Headers({
    'accept': '*/*',
    'Content-Type': 'application/json',
  })
  @POST("/auth/register/sms")
  Future<HttpResponse<ResponseDomain>> registerPhone(
      @Body() RegisterPhoneRequest request);
}
