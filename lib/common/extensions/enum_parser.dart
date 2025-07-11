extension EnumParser on String {
  T _toEnumValue<T>(
    String enumClassName,
    List<T> enumValues,
    T undefinedEnumValue,
  ) {
    return enumValues.firstWhere(
      (enumValue) {
        return enumValue.toString().toLowerCase() ==
            '$enumClassName.$this'.toLowerCase();
      },
      orElse: () => undefinedEnumValue,
    );
  }
}
