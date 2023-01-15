import 'dart:math';

class BaseGameVariables {
  BaseGameVariables._();

  static final List<int> weights = [8, 7, 6, 5, 4, 3, 2, 1];

  static int figureWeight(int number) => weights[number - 1];

  static double getRating(
    double Sa,
    double Ra,
    double Rb,
  ) {
    double K = 16;
    var Ea = 1 / (1 + pow(10, ((Rb - Ra) / 400)));
    var RaNew = Ra + K * (Sa - Ea);
    return RaNew;
  }
}
