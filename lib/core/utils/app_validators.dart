class AppValidators {
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    if (value.trim().length < 3) {
      return 'Name must be at least 3 characters';
    }

    return null;
  }
  static String? email(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Email is required';
    }

    final email = value.trim();

    if (email.length > 254) {
      return 'Email is too long';
    }

    final emailRegex = RegExp(
      r'^[a-zA-Z0-9.!#$%&*+/=?^_`{|}~-]+@'
      r'[a-zA-Z0-9-]+(\.[a-zA-Z0-9-]+)+$',
    );

    if (!emailRegex.hasMatch(email)) {
      return 'Please enter a valid email';
    }

    if (email.contains('..')) {
      return 'Email cannot contain consecutive dots';
    }

    final parts = email.split('@');

    if (parts.length != 2) {
      return 'Please enter a valid email';
    }

    final localPart = parts[0];
    final domain = parts[1];

    if (localPart.startsWith('.') || localPart.endsWith('.')) {
      return 'Please enter a valid email';
    }

    if (domain.startsWith('-') || domain.endsWith('-')) {
      return 'Please enter a valid email';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters';
    }

    return null;
  }
}