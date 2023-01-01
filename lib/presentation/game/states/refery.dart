import 'package:flutter_chesslider_beta0/core/lib/core.dart';
import 'package:flutter_chesslider_beta0/domain/enums/team_enum.dart';

class Refery {
  TeamEnum whoseMove = TeamEnum.white;
  int whiteTeamValue = 0;
  int blackTeamValue = 0;

  TeamEnum whoWin() {
    if (whiteTeamValue > blackTeamValue) {
      AppLogger.whoWin(TeamEnum.white, whiteTeamValue, blackTeamValue);
      return TeamEnum.white;
    } else {
      AppLogger.whoWin(TeamEnum.black, whiteTeamValue, blackTeamValue);
      return TeamEnum.black;
    }
  }
}
