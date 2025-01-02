part of 'home_cubit.dart';

class HomeState {
  final EState getBannerStatus;
  final List<BannerM> banners;

  HomeState({
    this.getBannerStatus = EState.initial,
    this.banners = const [],
  });

  HomeState copyWith({
    EState? getBannerStatus,
    List<BannerM>? banners,
  }) {
    return HomeState(
      getBannerStatus: getBannerStatus ?? this.getBannerStatus,
      banners: banners ?? this.banners,
    );
  }

  BannerM? get getBannerHomePosition {
    if (banners.isEmpty) return null;
    if (banners.firstWhereOrNull(
            (element) => element.position == "merchant-home-1") ==
        null) return null;
    return banners
        .firstWhere((element) => element.position == "merchant-home-1");
  }
}
