import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:oneship_merchant_app/core/core.dart';
import 'package:oneship_merchant_app/core/execute/execute.dart';
import 'package:oneship_merchant_app/presentation/data/model/banner/banner.dart';
import 'package:oneship_merchant_app/presentation/data/repository/banner_repository.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  final BannerRepository repository;
  HomeCubit(this.repository) : super(HomeState());

  Future<void> getBanners() async {
    setGetBannerStatus(EState.loading);
    try {
      final response = await execute(
        () => repository.getBanner("home"),
        isShowFailDialog: true,
      );
      response.when(success: (data) {
        setGetBannerStatus(EState.success);
        emit(state.copyWith(banners: data));
      }, failure: (error) {
        setGetBannerStatus(EState.failure);
      });
    } catch (e) {
      setGetBannerStatus(EState.failure);
    }
  }

  setGetBannerStatus(EState value) {
    emit(state.copyWith(getBannerStatus: value));
  }

  resetState() {
    emit(HomeState());
  }
}
