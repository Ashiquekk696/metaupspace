import 'package:metaupspace/data/models/user_profile.dart';

class LoginIdle {}

class LoginBusy {}

class LoginOk {
  LoginOk(this.profile);
  final UserProfile profile;
}

class LoginBad {
  LoginBad(this.message);
  final String message;
}
