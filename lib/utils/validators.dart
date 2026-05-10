final _emailRegex = RegExp(r'^[^\s@]+@[^\s@]+\.[^\s@]+$');

String? validateEmail(String? value) {
  if (value == null || value.isEmpty) return 'Email is required';
  if (!_emailRegex.hasMatch(value)) return 'Enter a valid email';
  return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';
  if (value.length < 8) return 'Password must be at least 8 characters';
  return null;
}

String? validateAmount(String? value) {
  if (value == null || value.isEmpty) return 'Amount is required';
  final amount = int.tryParse(value);
  if (amount == null) return 'Enter a valid amount';
  if (amount < 100) return 'Minimum investment is ₹100';
  return null;
}
