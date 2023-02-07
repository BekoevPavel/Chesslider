//ignore_for_file: member-ordering
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

const double kLeadingWidth = 56.0;

const String kFontFamily = 'Fact';

class Constants {
  Constants._();

  /// Strings

  static const String appTitle = 'FIT\u00A0SERVICE';

  /// numbers

  static const int minGosNumberLength = 11;

  static int maxCountOfPhotos = 10;

  static const int bottomReachedHeight = 24;

  static const double buttonHeight = 48;

  static const int timeRemaining = 300;
  static const int nameMaxLength = 20;

  /// Duration

  static const Duration errorMessageDuration = Duration(seconds: 5);

  static MaskTextInputFormatter pinCodeMaskFormatter = MaskTextInputFormatter(
    mask: '****',
    // filter: {'*': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );
  static MaskTextInputFormatter birthdayMaskFormatter = MaskTextInputFormatter(
    mask: '##.##.####',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static const String locale = 'ru';

  static const double initialZoom = 14.0;

  static const double markerZoom = 17.0;

  static const double zoomIn = 1.5;

  static const double zoomOut = -1.5;

  static const Duration animationDuration = Duration(milliseconds: 350);

  static const Duration snackBarDuration = Duration(seconds: 5);

  static const Duration splashAnimationDuration = Duration(milliseconds: 300);

  static const Duration fullSplashAnimationDuration =
      Duration(milliseconds: 3900);

  static const Duration multiButtonDuration = Duration(seconds: 4);

  static final RegExp nameRegex = RegExp(r'[0-9-a-zA-Zа-яА-Я]+$');

  static final RegExp emailRegex = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");

  static final RegExp pinRegex = RegExp(r'^(\d)(?!\1+$)\d{3}$');

  static final TextInputFormatter russianRegex =
      FilteringTextInputFormatter.allow(RegExp('[а-яА-Я]'));

  static final TextInputFormatter russianSpaceRegex =
      FilteringTextInputFormatter.allow(RegExp('[а-яА-Я\\s]*\$'));

  static final MaskTextInputFormatter phoneMaskFormatter =
      MaskTextInputFormatter(
    mask: ' (###) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final MaskTextInputFormatter outputPhoneMaskFormatter =
      MaskTextInputFormatter(
    mask: '+# ### ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final MaskTextInputFormatter outputPhoneBracketsMaskFormatter =
      MaskTextInputFormatter(
    mask: '+# (###) ###-##-##',
    filter: {'#': RegExp(r'[0-9]')},
    type: MaskAutoCompletionType.lazy,
  );

  static final MaskTextInputFormatter gosNumberFormatter =
      MaskTextInputFormatter(
    mask: '% ### %% ###',
    filter: {
      '#': RegExp(r'[0-9]'),
      '%': RegExp('[а-яА-Яa-zA-Z]'),
    },
    type: MaskAutoCompletionType.lazy,
  );

  static const String phoneCode = '7';

  static const String privacyPolicy =
      'https://fitauto.ru/new/assets/files/politika-konfidencialnosti-ooo.pdf';

  static const String bonusProgramRulesRussia =
      'https://bonus.fitauto.ru/special/static/docs/conditions--ru.pdf';

  static const String bonusProgramRulesKazakhstan =
      'https://bonus.fitauto.ru/special/static/docs/conditions--kz.pdf';

  static const String viber = 'https://clck.ru/FBzAF';

  static const String telegram = 'https://telegram.im/@FiTServiceK_bot';

  static const String osagoUrl = 'https://www.sravni.ru/promo/fitservice/';

  static const String whatsapp = 'https://api.whatsapp.com/send?'
      'phone=79059458308&'
      'text=%d0%94%d0%be%d0%b1%d1%80%d1%8b%d0%b9%20%d0%'
      'b4%d0%b5%d0%bd%d1%8c%21%20%d0%9c%d0%b5%d0%bd%d1%8f%20'
      '%d0%b8%d0%bd%d1%82%d0%b5%d1%80%d0%b5%d1%81%d1%83'
      '%d0%b5%d1%82&source=&data=&app_absent=';
}

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}
