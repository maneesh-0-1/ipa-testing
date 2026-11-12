class TypeConverterHelper {
  static bool getBool(dynamic value){
    return value == 1 || value == true || value == '1' || value == 'true';
  }

  static bool? getNullableBool(dynamic value) {
    if (value == null) return null;
    if (value is bool) return value;
    if (value is num) return value != 0;
    if (value is String) {
      final String normalized = value.trim().toLowerCase();
      if (normalized == '1' || normalized == 'true' || normalized == 'yes') return true;
      if (normalized == '0' || normalized == 'false' || normalized == 'no' || normalized.isEmpty) return false;
    }
    return null;
  }

  static double getDouble(dynamic value){
    return num.tryParse(value.toString())?.toDouble() ?? 0.0;
  }

  static double? getNullableDouble(dynamic value) {
    if (value == null) return null;
    if (value is num) return value.toDouble();
    return num.tryParse(value.toString().trim())?.toDouble();
  }

  static int getInt(dynamic value){
    return num.tryParse(value.toString())?.toInt() ?? 0;
  }

  static int? getNullableInt(dynamic value) {
    if (value == null) return null;
    if (value is int) return value;
    if (value is num) return value.toInt();
    if (value is bool) return value ? 1 : 0;
    return num.tryParse(value.toString().trim())?.toInt();
  }

  static String? getNullableString(dynamic value) {
    if (value == null) return null;
    if (value is String) return value;
    return value.toString();
  }

  /// 1 => 1 | 1.0 => 1.0 | 1.2 => 1.2 (first priority INT)
  static dynamic getIntOrDouble(dynamic value){
    final res = num.tryParse(value.toString()) ?? 0;
    if(res == res.toInt()){
      return res.toInt();
    }
    return res.toDouble();
  }
}