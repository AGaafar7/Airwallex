class AirwallexApiException implements Exception {
  final int? statusCode;
  final String? message;
  const AirwallexApiException({this.statusCode, this.message});
}
