/*import 'package:airwallex/airwallex.dart';
import 'package:flutter_test/flutter_test.dart';
//import 'package:airwallex/airwallex.dart';
import 'package:airwallex/airwallex_platform_interface.dart';
import 'package:airwallex/airwallex_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';
*/
/*class MockAirwallexPlatform
    with MockPlatformInterfaceMixin
    implements AirwallexPlatform {
  @override
  Future<String> initialize(
      bool logging, String environment, List<String> componentProvider) {
    throw UnimplementedError();
  }

  @override
  Future<String> get getBaseUrl => Future.value("https://api-demo.com");

  @override
  Future<List> getBalances(String token) {
    throw UnimplementedError();
  }

  @override
  Future<String> login(String apiKey, String clientId) {
    throw UnimplementedError();
  }

  @override
  Future<Map> getMarketFxQuote(
      String buyAmount, String buyCurrency, String sellCurrency, String token) {
    throw UnimplementedError();
  }

  @override
  Future<Map> createPayment(String token, Map<String, dynamic> paymentInfo) {
    throw UnimplementedError();
  }

  @override
  Future<Map> checkPaymentStatus(String token, String paymentId) {
    throw UnimplementedError();
  }

  @override
  Future<Map> createCard(String token, Map<String, dynamic> cardInfo) {
    throw UnimplementedError();
  }

  @override
  Future<Map> getInvoice(String token, String invoiceId) {
    throw UnimplementedError();
  }

  @override
  Future<Map> getInvoices(
      String token,
      String customerId,
      String fromCreatedAt,
      String pageNumber,
      String pageSize,
      String status,
      String subscriptionId,
      String toCreatedAt) {
    throw UnimplementedError();
  }

  @override
  Future<Map> getInvoiceItem(
      String token, String invoiceId, String invoiceItemId) {
    throw UnimplementedError();
  }

  @override
  Future<Map> getInvoiceItems(
      String token, String invoiceId, String pageNumber, String pageSize) {
    throw UnimplementedError();
  }
}

void main() {
  final AirwallexPlatform initialPlatform = AirwallexPlatform.instance;

  test('$MethodChannelAirwallex is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAirwallex>());
  });

  test('getbaseUrl', () async {
    Airwallex airwallexPlugin = Airwallex();
    MockAirwallexPlatform fakePlatform = MockAirwallexPlatform();
    AirwallexPlatform.instance = fakePlatform;

    expect(await airwallexPlugin.getBaseUrl, "https://api-demo.com");
  });
}
*/