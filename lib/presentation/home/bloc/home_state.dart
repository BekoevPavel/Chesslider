import 'package:flutter_chesslider_beta0/domain/enums/game_type.dart';

import '../../../core/lib/base_bloc/base_bloc.dart';
import '../../../domain/enums/team_enum.dart';
import '../../auth/bloc/auth_state.dart';

class HomeState extends BaseState {
  final AuthNavigate? navigate;
  final TeamEnum team;
  final GameType gameType;

  HomeState({
    super.status = BaseStatus.initial,
    this.navigate = AuthNavigate.menu,
    this.team = TeamEnum.white,
    required this.gameType,
  });

  @override
  HomeState copyWith({
    BaseStatus? status,
    String? email,
    AuthNavigate? navigate,
    TeamEnum? team,
    GameType? gameType,
  }) {
    return HomeState(
        status: status ?? BaseStatus.initial,
        navigate: navigate ?? this.navigate,
        team: team ?? this.team,
        gameType: gameType ?? this.gameType);
  }
}
