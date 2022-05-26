class Validator {
  static String? nameControl(String? name) {
    name = name?.trim();
    RegExp regex = RegExp(
        "^[abcçdefgğhıijklmnoöprsştuüvyzqwxABCÇDEFGHIİJKLMNOÖPRSŞTUÜVYZQWX]+\$");
    if (!regex.hasMatch(name!)) {
      return "İsim numara veya boşluk içermemeli";
    } else {
      return null;
    }
  }

  static String? surnamemControl(String? surname) {
    surname = surname?.trim();
    RegExp regex = RegExp(
        "^[abcçdefgğhıijklmnoöprsştuüvyzqwxABCÇDEFGHIİJKLMNOÖPRSŞTUÜVYZQWX]+\$");
    if (!regex.hasMatch(surname!)) {
      return "Soyisim numara veya boşluk içermemeli";
    } else {
      return null;
    }
  }

  static String? emailControl(String? email) {
    String pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = RegExp(pattern);
    if (!regex.hasMatch(email!)) {
      return "Geçersiz email";
    } else {
      return null;
    }
  }
}