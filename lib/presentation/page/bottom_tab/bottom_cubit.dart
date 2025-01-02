import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import 'bottom_tab.dart';

@singleton
class BottomCubit extends Cubit<BottomTab>{
  BottomCubit(): super(BottomTab.home);

  void updateTab(BottomTab tab){
    emit(tab);
  }
}