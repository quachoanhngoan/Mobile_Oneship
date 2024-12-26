import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:oneship_merchant_app/presentation/page/menu_diner/menu_diner_state.dart';

class MenuDinerCubit extends Cubit<MenuDinerState> {
  MenuDinerCubit() : super(const MenuDinerState());

  changePageTopping(int value) {
    emit(state.copyWith(indexPageTopping: value));
  }
}
