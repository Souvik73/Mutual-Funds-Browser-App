class AppConfig {
  AppConfig._();

  static const authEmail = String.fromEnvironment('AUTH_EMAIL');
  static const authPassword = String.fromEnvironment('AUTH_PASSWORD');
}
