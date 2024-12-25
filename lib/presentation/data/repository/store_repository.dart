import 'package:oneship_merchant_app/presentation/data/model/register_store/district_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/group_service_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/store_request_model.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

import '../model/register_store/provinces_model.dart';

mixin AuthUrl {
  static const String base = '/api/v1/merchant/stores';
  static const String provinces = '/api/v1/provinces';
  static const String groupService = "/api/v1/service-groups";
  static const String district = "/api/v1/districts";
  static const String ward = "/api/v1/wards";
  static const String register = "/api/v1/merchant/stores";
}

abstract class StoreRepository {
  Future<StoresResponse> getAll();

  Future<ProvinceResponse?> getProvinces();

  Future<List<GroupServiceModel>> getGroupService();

  Future<List<DistrictModel>> listDistrict(int idProvices);

  Future<List<DistrictModel>> listWard(int idDistrict);

  Future registerStore(StoreRequestModel request, {required bool isPost});
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

  @override
  Future<List<GroupServiceModel>> getGroupService() async {
    final httpResponse = await _clientDio.get(AuthUrl.groupService);
    final listData = httpResponse.data as List<dynamic>;
    return listData.map((json) => GroupServiceModel.fromJson(json)).toList();
  }

  @override
  Future<List<DistrictModel>> listDistrict(int idProvices) async {
    final httpResponse = await _clientDio
        .get(AuthUrl.district, queryParameters: {"provinceId": idProvices});
    final listData = httpResponse.data as List<dynamic>;
    return listData.map((json) => DistrictModel.fromJson(json)).toList();
  }

  @override
  Future<List<DistrictModel>> listWard(int idDistrict) async {
    final httpResponse = await _clientDio
        .get(AuthUrl.ward, queryParameters: {"districtId": idDistrict});
    final listData = httpResponse.data as List<dynamic>;
    return listData.map((json) => DistrictModel.fromJson(json)).toList();
  }

  @override
  Future registerStore(StoreRequestModel request,
      {required bool isPost}) async {
    final data = request.removeNullValues(request.toJson());
    if (isPost) {
      final httpResponse = await _clientDio.post(AuthUrl.register, data: data);
    }
    else {
      // final httpRespose = await _clientDio.patch(AuthUrl.register, data: , queryParameters: {"id": });
    }
  }
}
