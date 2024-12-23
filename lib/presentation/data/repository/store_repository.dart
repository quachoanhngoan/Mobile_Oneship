import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

import '../model/store/provinces_model.dart';

mixin AuthUrl {
  static const String base = '/api/v1/merchant/stores';
  static const String provinces = '/api/v1/provinces';
}

abstract class StoreRepository {
  Future<StoresResponse> getAll();

  Future<ProvinceResponse?> getProvinces();
}

class StoreImpl implements StoreRepository {
  final DioUtil _clientDio;
  StoreImpl(
    this._clientDio,
  );

  @override
  Future<StoresResponse> getAll() async {
    final httpResponse = await _clientDio.get(
      AuthUrl.base,
      // data: request.toJson(),
      // isShowError: false,
      isTranformData: true,
      isAuth: true,
    );

    return StoresResponse.fromJson(httpResponse.data ?? {});
  }

  @override
  Future<ProvinceResponse?> getProvinces() async {
    final httpResponse = await _clientDio.get(AuthUrl.provinces);
    return ProvinceResponse.fromJson(httpResponse.data ?? {});
  }
}
