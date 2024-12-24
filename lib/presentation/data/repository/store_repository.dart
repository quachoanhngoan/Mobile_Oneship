import 'package:oneship_merchant_app/presentation/data/model/store/bank.model.dart';
import 'package:oneship_merchant_app/presentation/data/model/store/store_model.dart';
import 'package:oneship_merchant_app/presentation/data/utils.dart';

import '../model/store/provinces_model.dart';

mixin AuthUrl {
  static const String base = '/api/v1/merchant/stores';
  static const String provinces = '/api/v1/provinces';
  static const String banks = '/api/v1/banks';
  static const String getBanksBranch = '/api/v1/banks/:id/branches';
}

abstract class StoreRepository {
  Future<StoresResponse> getAll();

  Future<ProvinceResponse?> getProvinces();

  Future<List<BankM>?> getBanks();
  Future<List<BranchBankM>?> getBanksBranch(String id);
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
  Future<List<BranchBankM>?> getBanksBranch(String id) async {
    final httpResponse = await _clientDio.get(
        AuthUrl.getBanksBranch.replaceAll(':id', id.toString()),
        isTranformData: true);
    return List<BranchBankM>.from(
        httpResponse.data?.map((x) => BranchBankM.fromJson(x)) ?? []);
  }
}
