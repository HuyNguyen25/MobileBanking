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
}