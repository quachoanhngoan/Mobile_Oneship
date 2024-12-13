import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:oneship_merchant_app/core/core.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final AuthRepository repository;
  AuthCubit() : super(AuthState());
}
