import '../../../core/lib/base_bloc/base_bloc.dart';
import '../../auth/bloc/auth_state.dart';

class HomeState extends BaseState {
  final AuthNavigate? navigate;

  HomeState(
      {super.status = BaseStatus.initial, this.navigate = AuthNavigate.menu});

  @override
  HomeState copyWith(
      {BaseStatus? status, String? email, AuthNavigate? navigate}) {
    // TODO: implement copyWith
    return HomeState(
        status: status ?? BaseStatus.initial,
        navigate: navigate ?? this.navigate);
  }
}
