import 'package:equatable/equatable.dart';

class MenuDinerState extends Equatable {
  final int indexPageTopping;

  const MenuDinerState({this.indexPageTopping = 0});

  MenuDinerState copyWith({
    int? indexPageTopping,
  }) {
    return MenuDinerState(
        indexPageTopping: indexPageTopping ?? this.indexPageTopping);
  }

  @override
  List<Object?> get props => [indexPageTopping];
}
