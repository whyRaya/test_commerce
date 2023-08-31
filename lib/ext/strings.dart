class Strings {
  Strings._();

  static const String appName = "Fake Commerce";
}

extension StringManipulator on String {

  String capitalizeFirstWord() {
    StringBuffer sb = StringBuffer();
    trim().split(" ").forEach((s) {
      final separator = sb.isEmpty? "" : " ";
      sb.write("$separator${s[0].toUpperCase()}${s.substring(1)}");
    });
    return sb.toString();
  }
}
