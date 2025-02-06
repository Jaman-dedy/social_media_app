// lib/core/utils/validators.dart
class Validators {
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }

    // Regular expression for email validation
    final emailRegExp = RegExp(
      r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+',
    );

    if (!emailRegExp.hasMatch(value)) {
      return 'Please enter a valid email address';
    }

    return null;
  }

  static String? password(String? value) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < 8) {
      return 'Password must be at least 8 characters long';
    }

    // Check for at least one uppercase letter
    if (!value.contains(RegExp(r'[A-Z]'))) {
      return 'Password must contain at least one uppercase letter';
    }

    // Check for at least one number
    if (!value.contains(RegExp(r'[0-9]'))) {
      return 'Password must contain at least one number';
    }

    // Check for at least one special character
    if (!value.contains(RegExp(r'[!@#$%^&*(),.?":{}|<>]'))) {
      return 'Password must contain at least one special character';
    }

    return null;
  }

  static String? confirmPassword(String? value, String password) {
    if (value == null || value.isEmpty) {
      return 'Please confirm your password';
    }

    if (value != password) {
      return 'Passwords do not match';
    }

    return null;
  }

  static String? username(String? value) {
    if (value == null || value.isEmpty) {
      return 'Username is required';
    }

    if (value.length < 3) {
      return 'Username must be at least 3 characters long';
    }

    // Only allow letters, numbers, and underscores
    final usernameRegExp = RegExp(r'^[a-zA-Z0-9_]+$');
    if (!usernameRegExp.hasMatch(value)) {
      return 'Username can only contain letters, numbers, and underscores';
    }

    return null;
  }

  static String? displayName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Display name is required';
    }

    if (value.length < 2) {
      return 'Display name must be at least 2 characters long';
    }

    if (value.length > 50) {
      return 'Display name cannot be longer than 50 characters';
    }

    return null;
  }

  static String? bio(String? value) {
    if (value == null) {
      return null;
    }

    if (value.length > 150) {
      return 'Bio cannot be longer than 150 characters';
    }

    return null;
  }

  static String? postContent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Post content cannot be empty';
    }

    if (value.length > 500) {
      return 'Post content cannot be longer than 500 characters';
    }

    return null;
  }

  static String? commentContent(String? value) {
    if (value == null || value.isEmpty) {
      return 'Comment cannot be empty';
    }

    if (value.length > 200) {
      return 'Comment cannot be longer than 200 characters';
    }

    return null;
  }

  static String? url(String? value) {
    if (value == null || value.isEmpty) {
      return null; // URL is optional
    }

    // Regular expression for URL validation
    final urlRegExp = RegExp(
      r'^(http:\/\/www\.|https:\/\/www\.|http:\/\/|https:\/\/)?[a-z0-9]+([\-\.]{1}[a-z0-9]+)*\.[a-z]{2,5}(:[0-9]{1,5})?(\/.*)?$',
    );

    if (!urlRegExp.hasMatch(value)) {
      return 'Please enter a valid URL';
    }

    return null;
  }

  static String? phone(String? value) {
    if (value == null || value.isEmpty) {
      return null; // Phone is optional
    }

    // Regular expression for phone number validation
    // Accepts formats: +1234567890, 123-456-7890, (123) 456-7890
    final phoneRegExp = RegExp(
      r'^\+?1?\d{9,15}$|^\(\d{3}\)\s?\d{3}-\d{4}$|^\d{3}-\d{3}-\d{4}$',
    );

    if (!phoneRegExp.hasMatch(value)) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  static String? searchQuery(String? value) {
    if (value == null || value.isEmpty) {
      return 'Search query cannot be empty';
    }

    if (value.length < 2) {
      return 'Search query must be at least 2 characters long';
    }

    return null;
  }

  /// Validates file size in bytes
  static String? fileSize(int size, {int maxSizeInMB = 10}) {
    final maxSizeInBytes = maxSizeInMB * 1024 * 1024;

    if (size > maxSizeInBytes) {
      return 'File size cannot exceed ${maxSizeInMB}MB';
    }

    return null;
  }

  /// Validates image dimensions
  static String? imageDimensions(
    int width,
    int height, {
    int minWidth = 100,
    int minHeight = 100,
    int maxWidth = 4096,
    int maxHeight = 4096,
  }) {
    if (width < minWidth || height < minHeight) {
      return 'Image dimensions must be at least ${minWidth}x${minHeight}';
    }

    if (width > maxWidth || height > maxHeight) {
      return 'Image dimensions cannot exceed ${maxWidth}x${maxHeight}';
    }

    return null;
  }
}
