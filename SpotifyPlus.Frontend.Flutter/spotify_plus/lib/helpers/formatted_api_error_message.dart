String formattedErrorMessage({
  String? reason,
  String? method,
  String? endpoint
}) {
  return "Couldn't request api\nReason: $reason\nFailed method: $method\nEndpoint: $endpoint";
}