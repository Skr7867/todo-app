import 'package:get/get_navigation/src/root/internacionalization.dart';

class Language extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
    'en_Us': {
      'email_hint': 'Enter email',
      'internet_exception': 'Please check your data',
      'general_exception':
          'We are Unable to process your request\n Please try again',
      'welcome_back': 'Welcome Back !',
      'email_hints': 'Enter your email',
      'password_hints': 'Enter your password',
    },
    'ur_pk': {'email_hint': 'ای میل درج کریں'},
  };
}
