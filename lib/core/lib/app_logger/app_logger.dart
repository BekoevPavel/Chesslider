part of core;

class AppLogger {
  static final _logger = Logger(
    level: null,
    printer: PrettyPrinter(
      methodCount: 0,
      errorMethodCount: 9,
      lineLength: 100,
      colors: true,
      printEmojis: true,
      //printTime: true,
    ),
  );

  //TODO: Когда появится работа с REST
  // static void logResponse(Response<dynamic> response) {
  //   final data = _formatJson(response.data);
  //   final message = '--- request ---\n'
  //       'path: ${response.requestOptions.path}\n'
  //       'data: ${_formatJson(response.requestOptions.data)}\n'
  //       'method: ${response.requestOptions.method}\n'
  //       'headers: ${_formatJson(response.requestOptions.headers)}\n'
  //       'queryParameters: ${response.requestOptions.queryParameters}\n'
  //       '--- response ---\n'
  //       'status code: ${response.statusCode}\n'
  //       'data: $data';
  //
  //   _logger.i(message);
  // }

  static void selectedFigureLog(Figure figure) {
    _logger.i(
        'Выбрана ${figure.team.name} фигура value: ${figure.value} , x: ${figure.x} , y:${figure.y}');
  }

  static void tapToStep({required s.Step step}) {
    _logger.i(
        'Сделан шаг ${step.figure.team.name} фигурой value: ${step.figure.value} по х: ${step.x} , y: ${step.y}');
  }

  static void whoseMove() {}

  static void whoWin(TeamEnum team, int whiteValue, int blackValue) {
    if (whiteValue != blackValue) {
      _logger.i(
          'Победа за ${team.name} ${whiteValue > blackValue ? whiteValue : blackValue} / ${whiteValue < blackValue ? whiteValue : blackValue}');
    } else {
      _logger.i('Ничья $blackValue / $whiteValue');
    }
  }

  static void showAllFigure(List<Figure> figures) {
    for (var f in figures) {
      _logger.d(
          'Фигура ${f.team.name} value ${f.value}, x: ${f.x}, y: ${f.y} ,, ');
    }
  }

  static void figuresConflict(
      Figure my, Figure other, int myValue, int otherValue) {
    _logger.i(
        'Конфликт: ${my.team.name} ${myValue} vs ${other.team.name} ${otherValue} , x: ${my.x}');
  }

  static void figureReachedTheEnd(Figure figure) {
    _logger
        .i('Фигура ${figure.team.name} value: ${figure.value} ДОШЛА ДО КОНЦА');
  }

  static void killFigure(Figure myFigure, Figure otherFigure) {
    _logger.i(
        'Фигура ${myFigure.team.name} ${myFigure.value} съела фигуру ${otherFigure.team.name} ${otherFigure.value}');
  }

  static dynamic _formatJson(dynamic json) {
    try {
      return const JsonEncoder.withIndent('  ').convert(json);
    } catch (_) {
      return json;
    }
  }

  static void logError(
      {String? message, Object? error, StackTrace? stackTrace}) {
    _logger.e(message, error, stackTrace);
  }
}
