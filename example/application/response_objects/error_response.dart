class ErrorResponse {
  static Map<String, String> fromMessage(String message) => {
    'error': message
  };
}