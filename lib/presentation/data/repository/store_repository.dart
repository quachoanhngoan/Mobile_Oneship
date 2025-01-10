import 'dart:convert';

import 'package:oneship_merchant_app/presentation/data/model/register_store/district_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/group_service_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/register_store/store_request_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/response_login_store_model.dart';
import 'package:oneship_merchant_app/presentation/data/model/search.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/address.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/bank.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/create_store.response.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';
import 'package:oneship_merchant_app/presentation/page/address_store/bloc/request_update_address.dart';

import '../model/register_store/provinces_model.dart';

mixin AuthUrl {
  static const String base = '/api/v1/merchant/stores';
  static const String provinces = '/api/v1/provinces';
  static const String banks = '/api/v1/banks';
  static const String getBanksBranch = '/api/v1/banks/:id/branches';
  static const String groupService = "/api/v1/service-groups";
  static const String district = "/api/v1/districts";
  static const String ward = "/api/v1/wards";
  static const String register = "/api/v1/merchant/stores";
  static const String loginStore = "/api/v1/merchant/auth/login-store";
  static const String address = "/api/v1/merchant/store-addresses";
}

abstract class StoreRepository {
  Future<StoresResponse> getAll();

  Future<ProvinceResponse?> getProvinces();

  Future<List<BankM>?> getBanks();
  Future<List<BranchBankM>?> getBanksBranch(int id);
  Future<List<GroupServiceModel>> getGroupService();

  Future<List<DistrictModel>> listDistrict(int idProvices);

  Future<List<DistrictModel>> listWard(int idDistrict);

  Future<CreateStoreResponse?> registerStore(StoreRequestModel request);
  Future<CreateStoreResponse> registerPatchStore(
      int id, StoreRequestModel request);
  Future<bool> deleteStore(int id);
  Future<CreateStoreResponse> getStoreById(int id);
  Future<ResponseLoginStoreModel?> loginStore(int idStore);

  Future<List<AddressStoreM>> getAddresss();
  Future<bool> updateAddresss(RequestUpdateAddress body);
  Future<SearchResponse> searchAddress({String? query});
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
  Future<List<BankM>?> getBanks() async {
    final httpResponse =
        await _clientDio.get(AuthUrl.banks, isTranformData: true);
    return List<BankM>.from(
        httpResponse.data?.map((x) => BankM.fromJson(x)) ?? []);
  }

  @override
  Future<List<BranchBankM>?> getBanksBranch(int id) async {
    final httpResponse = await _clientDio.get(
        AuthUrl.getBanksBranch.replaceAll(':id', id.toString()),
        isTranformData: true);
    return List<BranchBankM>.from(
        httpResponse.data?.map((x) => BranchBankM.fromJson(x)) ?? []);
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
  Future<CreateStoreResponse> registerStore(StoreRequestModel request) async {
    final result = await _clientDio.post(
      AuthUrl.register,
      data: request.removeNullValues(),
      isTranformData: true,
    );
    return CreateStoreResponse.fromJson(result.data ?? {});
  }

  @override
  Future<CreateStoreResponse> getStoreById(int id) async {
    final result = await _clientDio.get(
      '${AuthUrl.register}/$id',
      // data: request.removeNullValues(),
      isTranformData: true,
    );
    return CreateStoreResponse.fromJson(result.data ?? {});
  }

  @override
  Future<CreateStoreResponse> registerPatchStore(
      int id, StoreRequestModel request) async {
    final result = await _clientDio.patch(
      '${AuthUrl.register}/$id',
      data: request.removeNullValues(),
      isTranformData: true,
    );
    return CreateStoreResponse.fromJson(result.data ?? {});
  }

  @override
  Future<bool> deleteStore(int id) async {
    final result = await _clientDio.delete('${AuthUrl.base}/$id');
    return result.statusCode == 200;
  }

  //login store
  @override
  Future<ResponseLoginStoreModel?> loginStore(int idStore) async {
    final result = await _clientDio.post(
      AuthUrl.loginStore,
      data: {"storeId": idStore},
      isTranformData: true,
    );
    return ResponseLoginStoreModel.fromMap(result.data ?? {});
  }

  @override
  Future<List<AddressStoreM>> getAddresss() async {
    final httpResponse = await _clientDio.get(
      AuthUrl.address,
      isTranformData: true,
      isAuth: true,
    );
    return List<AddressStoreM>.from(
        httpResponse.data?.map((x) => AddressStoreM.fromJson(x)) ?? []);
  }

  @override
  Future<bool> updateAddresss(RequestUpdateAddress body) async {
    final httpResponse = await _clientDio.put(
      data: body.toJson(),
      AuthUrl.address,
      isTranformData: true,
      isAuth: true,
    );
    return httpResponse.statusCode == 200;
  }

  @override
  Future<SearchResponse> searchAddress({String? query}) async {
    final httpResponse = await _clientDio.get(
      "/api/v1/mapbox/geocoding/v5/mapbox.places/${query!}",
      isTranformData: true,
      isAuth: true,
    );
    return SearchResponse.fromJson(httpResponse.data ?? {});
  }
}
