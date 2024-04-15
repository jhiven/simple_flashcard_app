mixin CustomFormValidator {
  String? validateIsNotEmpty(String? value, String name) {
    if (value == null || value.isEmpty) {
      return '$name is required!';
    }
    return null;
  }

  String? validateFrontCard(String? value) {
    if (value == null || value.isEmpty) {
      return 'Front card is required!';
    }
    if (value.length > 128) {
      return 'Front card must be less than 128 characters';
    }
    return null;
  }
}
