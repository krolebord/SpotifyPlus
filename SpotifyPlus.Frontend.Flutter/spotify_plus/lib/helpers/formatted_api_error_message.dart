String formattedErrorMessage({
  required String reason,
  required String method,
  String? endpoint
}) {
  return "Couldn't request api\nReason: $reason\nFailed method: $method\nEndpoint: $endpoint";
}

