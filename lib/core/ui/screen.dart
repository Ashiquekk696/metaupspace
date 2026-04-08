import 'package:flutter/widgets.dart';

class Screen {
  Screen.of(this.context);

  final BuildContext context;

  MediaQueryData get mq => MediaQuery.of(context);

  double get width => mq.size.width;
  double get height => mq.size.height;
  double get textScale => mq.textScaler.scale(1);

  bool get isCompact => width < 380;
  bool get isPhone => width < 600;
  bool get isTablet => width >= 600 && width < 1024;
  bool get isDesktop => width >= 1024;

  double gutter({double compact = 16, double phone = 20, double tablet = 28}) {
    if (isCompact) return compact;
    if (isPhone) return phone;
    return tablet;
  }

  double containerMaxWidth({double phone = 440, double tablet = 520}) {
    return isTablet || isDesktop ? tablet : phone;
  }

  int statsColumns() {
    if (width > 900) return 3;
    if (width > 560) return 3;
    if (width > 380) return 2;
    return 1;
  }
}

