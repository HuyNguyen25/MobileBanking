class StringUtils {
  static bool isNonNegativeNumeric(String source) {
    try{
      final result = double.parse(source);
      if(result >= 0)
        return true;
      return false;
    } catch(e) {
      return false;
    }
  }

  static bool isValidEmail(String email) {
    // Regular expression for validating an email address
    final RegExp emailRegex = RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
    );

    // Check if the email matches the regular expression
    return emailRegex.hasMatch(email);
  }
}