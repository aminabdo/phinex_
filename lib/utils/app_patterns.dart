class PatternUtils {
  static const String _email_pattern =
      r"^^[a-zA-Z0-9.!#$%&*+\/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$";
  static const String _name_pattern = r'^[a-zA-Z]+$';
  static const String _url_pattern =
      r'(http[s]?:\/\/)?[^\s(["<,>]*\.[^\s[",><]*';
  static const String _egypt_mobile_number_pattern = r'^(01)[0-9]{8}';

  static bool emailIsValid({email}) {
    RegExp emailRegularExpression = RegExp(_email_pattern);
    if (emailRegularExpression.hasMatch(email)) {
      return true;
    } else {
      return false;
    }
  }

  static bool nameIsValid({name}) {
    RegExp nameRegularExpression = RegExp(_name_pattern);
    if (nameRegularExpression.hasMatch(name)) {
      return true;
    } else {
      return false;
    }
  }

  static bool urlIsValid({url}) {
    RegExp urlRegularExpression = RegExp(_url_pattern);
    if (urlRegularExpression.hasMatch(url)) {
      return true;
    } else {
      return false;
    }
  }

  // only egyptian phone
  static bool phoneIsValid({phone}) {
    RegExp phoneRegularExpression = RegExp(_egypt_mobile_number_pattern);
    if (phoneRegularExpression.hasMatch(phone)) {
      return true;
    } else {
      return false;
    }
  }
}
