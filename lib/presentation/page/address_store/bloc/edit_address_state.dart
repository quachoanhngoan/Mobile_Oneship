part of 'edit_address_cubit.dart';

class EditAddressState {
  final EState getBannerStatus;
  final EState updateAddressStatus;
  final List<AddressStoreM> addressStores;
  final RequestUpdateAddress requestUpdateAddress;
  EditAddressState({
    this.getBannerStatus = EState.initial,
    this.updateAddressStatus = EState.initial,
    this.addressStores = const [],
    this.requestUpdateAddress = const RequestUpdateAddress(),
  });

  EditAddressState copyWith({
    EState? getBannerStatus,
    EState? updateAddressStatus,
    List<AddressStoreM>? addressStores,
    RequestUpdateAddress? requestUpdateAddress,
  }) {
    return EditAddressState(
      getBannerStatus: getBannerStatus ?? this.getBannerStatus,
      updateAddressStatus: updateAddressStatus ?? this.updateAddressStatus,
      addressStores: addressStores ?? this.addressStores,
      requestUpdateAddress: requestUpdateAddress ?? this.requestUpdateAddress,
    );
  }
}
