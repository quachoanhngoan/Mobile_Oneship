import 'package:oneship_merchant_app/presentation/data/model/banner/banner.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

mixin _URL {
  static const String banner = '/api/v1/merchant/banners';
}

abstract class OrderRepository {
  Future<List<BannerM>> getBanner(String page);
}

class OrderImpl implements OrderRepository {
  final DioUtil _clientDio;
  OrderImpl(
    this._clientDio,
  );

  @override
  Future<List<BannerM>> getBanner(String page) async {
    final httpResponse = await _clientDio.get(
      _URL.banner,
      queryParameters: {'page': page},
      // isShowError: false,
      isTranformData: true,
      isAuth: false,
    );

    return httpResponse.data.map<BannerM>((e) => BannerM.fromJson(e)).toList();
  }
}
