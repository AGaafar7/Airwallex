import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'airwallex_platform_interface.dart';

/// An implementation of [AirwallexPlatform] that uses method channels.
class MethodChannelAirwallex extends AirwallexPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('airwallex');

  @override
  Future<String> initialize(
      bool logging, String environment, List<String> componentProvider) async {
    try {
      final String? result = await methodChannel.invokeMethod('initialize', {
        'logging': logging,
        'environment': environment,
        'componentProvider': componentProvider,
      });
      return result ?? 'Could not initialize.';
    } on PlatformException catch (ex) {
      return ex.message ?? 'Unexpected error';
    }
  }

  @override
  Future<String> get getBaseUrl async {
    final String? result = await methodChannel.invokeMethod('getBaseUrl');
    return result ?? 'could not get base url';
  }

  //Authentication
  @override
  Future<String> login(String apiKey, String clientId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/authentication/login");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "x-client-id": clientId,
        "x-api-key": apiKey
      },
    );
    var data = jsonDecode(response.body);
    var token = data['token'];

    return token;
  }

  //Check Payment Status
  @override
  Future<Map> checkPaymentStatus(String token, String paymentId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/payments/$paymentId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Authorization
  @override
  Future<Map> getOAuthAuthorization(
      String token,
      String clientId,
      String redirectUri,
      String responseType,
      String scope,
      String? codeChallenge,
      String? codeChallengeMethod,
      String? state) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    filters.add(clientId);
    prefixes.add("client_id=");
    filters.add(redirectUri);
    prefixes.add("redirect_uri=");
    filters.add(responseType);
    prefixes.add("response_type=");
    filters.add(scope);
    prefixes.add("scope=");
    if (codeChallenge != null) {
      filters.add(codeChallenge);
      prefixes.add("code_challenge=");
    }
    if (codeChallengeMethod != null) {
      filters.add(codeChallengeMethod);
      prefixes.add("code_challenge_method=");
    }
    if (state != null) {
      filters.add(state);
      prefixes.add("state=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/oauth/authorize$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Exchange access token
  @override
  Future<Map> exchangeToken(String clientId, String clientSecret, String code,
      String? codeVerifier, String grantType, String redirectUri) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/oauth/token");
    var bodyData = {
      "client_id": clientId,
      "client_secret": clientSecret,
      "code": code,
      "grant_type": grantType,
      "redirect_uri": redirectUri
    };
    if (codeVerifier != null) {
      bodyData.addAll({"code_verifier": codeVerifier});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Refresh access token
  @override
  Future<Map> refreshToken(String clientId, String clientSecret,
      String grantType, String refreshToken) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/oauth/token");
    var bodyData = {
      "client_id": clientId,
      "client_secret": clientSecret,
      "grant_type": grantType,
      "refresh_token": refreshToken
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {"Content-Type": "application/x-www-form-urlencoded"},
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve an Invoice
  @override
  Future<Map> getInvoice(String token, String invoiceId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/invoices/$invoiceId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Get a list of Invoices
  @override
  Future<Map> getInvoices(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? subscriptionId,
      String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (customerId != null) {
      filters.add(customerId);
      prefixes.add("customer_id=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (subscriptionId != null) {
      filters.add(subscriptionId);
      prefixes.add("subscription_id=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/invoices$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Retrieve an InvoiceItem
  @override
  Future<Map> getInvoiceItem(
      String token, String invoiceId, String invoiceItemId) async {
    final String baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/invoices/$invoiceId/items/$invoiceItemId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );

    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Get a list of InvoiceItems
  @override
  Future<Map> getInvoiceItems(String token, String invoiceId,
      String? pageNumber, String? pageSize) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/invoices/$invoiceId/items$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Prices
  //Create a Price
  @override
  Future<Map> createPrice(String token, Map<String, dynamic> priceInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/prices/create");
    var jsonBody = jsonEncode(priceInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a Price
  @override
  Future<Map> getPrice(String token, String priceId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/prices/$priceId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a Price
  @override
  Future<Map> updatePrice(
      String token, String priceId, Map<String, dynamic> priceInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/prices/$priceId/update");
    var jsonBody = jsonEncode(priceInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Delete a Price
  @override
  Future<Map> deletePrice(String token, String priceId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/prices/$priceId/delete");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a list of Prices
  @override
  Future<Map> getPrices(
      String token,
      String? active,
      String? currencyCode,
      String? pageNumber,
      String? pageSize,
      String? productId,
      String? recurringPeriod,
      String? recurringPeriodUnit) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (active != null) {
      filters.add(active);
      prefixes.add("active=");
    }
    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (productId != null) {
      filters.add(productId);
      prefixes.add("product_id=");
    }
    if (recurringPeriod != null) {
      filters.add(recurringPeriod);
      prefixes.add("recurring_period=");
    }
    if (recurringPeriodUnit != null) {
      filters.add(recurringPeriodUnit);
      prefixes.add("recurring_period_unit=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/prices$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Products
  //Create a Product
  @override
  Future<Map> createProduct(
      String token, Map<String, dynamic> productInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/products/create");
    var jsonBody = jsonEncode(productInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a Product
  @override
  Future<Map> getProduct(String token, String productId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/products/$productId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a Product
  @override
  Future<Map> updateProduct(String token, String productId,
      Map<String, dynamic> newProductInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/products/$productId/update");
    var jsonBody = jsonEncode(newProductInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Delete a Product
  @override
  Future<Map> deleteProduct(String token, String productId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/products/$productId/delete");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a list of Products
  @override
  Future<Map> getProducts(String token, String? active, String? pageNumber,
      String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (active != null) {
      filters.add(active);
      prefixes.add("active=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/products$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Subscription
  //Create a Subscription
  @override
  Future<Map> createSubscription(
      String token, Map<String, dynamic> subInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/subscriptions/create");
    var jsonBody = jsonEncode(subInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "x-jwt-account-id": "string"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a Subscription
  @override
  Future<Map> getSubscription(String token, String subscriptionId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/subscriptions/$subscriptionId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a Subscription
  @override
  Future<Map> updateSubscription(String token, String subscriptionId,
      Map<String, dynamic> newSubInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/subscriptions/$subscriptionId/update");
    var jsonBody = jsonEncode(newSubInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "x-jwt-account-id": "string"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Cancel a Subscription
  @override
  Future<Map> cancelSubscription(
      String token, String subscriptionId, String prorationBehavior) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/subscriptions/$subscriptionId/cancel");
    var bodyData = {"proration_behavior": prorationBehavior};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "x-jwt-account-id": "string"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a list of Subscriptions
  @override
  Future<Map> getSubscriptions(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? recurringPeriod,
      String? recurringPeriodUnit,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (customerId != null) {
      filters.add(customerId);
      prefixes.add("customer_id=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (recurringPeriod != null) {
      filters.add(recurringPeriod);
      prefixes.add("recurring_period=");
    }
    if (recurringPeriodUnit != null) {
      filters.add(recurringPeriodUnit);
      prefixes.add("recurring_period_unit=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/subscriptions$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a SubscriptionItem
  @override
  Future<Map> getSubscriptionItem(
      String token, String subscriptionId, String itemId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/subscriptions/$subscriptionId/items/$itemId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a list of SubscriptionItems
  @override
  Future<Map> getSubscriptionItems(String token, String subscriptionId,
      String? pageNumber, String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);
    var url =
        Uri.parse("$baseUrl/api/v1/subscriptions/$subscriptionId/items$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-jwt-account-id": "string"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Confirmation Letter
  //Create a Confirmation Letter
  @override
  Future<Map> createConfirmationLetter(
      String token, String format, String transactionId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/confirmation_letters/create");
    var bodyData = {"format": format, "transaction_id": transactionId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Balances
  //Get current balances
  @override
  Future<List> getBalances(String token) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/balances/current");
    var response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var data = jsonDecode(response.body);
    //print(response.body);
    return data;
  }

  //Get balance history
  @override
  Future<Map> getBalancesHistory(
      String token,
      String? currencyCode,
      String? fromPostAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? toPostAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (fromPostAt != null) {
      filters.add(fromPostAt);
      prefixes.add("from_post_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    if (requestId != null) {
      filters.add(requestId);
      prefixes.add("request_id=");
    }
    if (toPostAt != null) {
      filters.add(toPostAt);
      prefixes.add("to_post_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/balances/history$params");
    var response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var data = jsonDecode(response.body);
    //print(response.body);
    return data;
  }

  //Deposits
  //Get a list of deposits
  @override
  Future<Map> getDeposits(String token, String? fromCreatedAt,
      String? pageNumber, String? pageSize, String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/deposits$params");
    var response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a deposit by ID
  @override
  Future<Map> getDeposit(String token, String depositId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/deposits/$depositId");
    var response = await http.get(
      url,
      headers: {
        "Authorization": "Bearer $token",
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Global Accounts
  //Get a list of global accounts
  @override
  Future<Map> getGlobalAccounts(
      String token,
      String? countryCode,
      String? currencyCode,
      String? fromCreatedAt,
      String? nickname,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (countryCode != null) {
      filters.add(countryCode);
      prefixes.add("country_code=");
    }
    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (nickname != null) {
      filters.add(nickname);
      prefixes.add("nick_name=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/global_accounts$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Get global account by ID
  @override
  Future<Map> getGlobalAccount(String token, String globalAccountId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/global_accounts/$globalAccountId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Generate global account statement
  @override
  Future<Map> createStatementLetter(String token, String globalAccountId,
      Map<String, dynamic> statementInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/global_accounts/$globalAccountId/generate_statement_letter");
    var jsonBody = jsonEncode(statementInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get global account transactions
  @override
  Future<Map> getGlobalAccountTransactions(
      String token,
      String globalAccountId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse(
        "$baseUrl/api/v1/global_accounts/$globalAccountId/transactions$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Open a global account
  @override
  Future<Map> createGlobalAccount(
      String token,
      String countryCode,
      String currencyCode,
      String nickname,
      List<String> paymentMethods,
      String requestId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/global_accounts/create");
    var bodyData = {
      "country_code": countryCode,
      "currency": currencyCode,
      "nick_name": nickname,
      "payment_methods": paymentMethods,
      "request_id": requestId
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonBody,
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Update existing global account
  @override
  Future<Map> updateGlobalAccount(
      String token, String globalAccountId, String newNickName) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/global_accounts/update/$globalAccountId");
    var bodyData = {"nick_name": newNickName};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonBody,
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Financial Reports
  //Get list of financial reports
  @override
  Future<Map> getFinancialReports(
      String token, String? pageNumber, String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/finance/financial_reports$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Get financial report by ID
  @override
  Future<Map> getFinancialReport(String token, String reportId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/finance/financial_reports/$reportId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get contents of a financial report
  //This returns a file see what will you do
  @override
  Future<Map> getFinancialReportContent(String token, String reportId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/finance/financial_reports/$reportId/content");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Create a financial report
  @override
  Future<Map> createFinancialReport(
      String token, Map<String, dynamic> financialreportInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/finance/financial_reports/create");
    var jsonBody = jsonEncode(financialreportInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );

    var data = jsonDecode(response.body);
    return data;
  }

  //Financial Transactions
  //Get list of financial transactions
  //account's ID
  @override
  Future<Map> getFinancialTransactions(
      String token,
      String? batchId,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? sourceId,
      String? status,
      String? toCreatedAt,
      String accountId) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (batchId != null) {
      filters.add(batchId);
      prefixes.add("batch_id=");
    }
    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (sourceId != null) {
      filters.add(sourceId);
      prefixes.add("source_id=");
    }

    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/financial_transactions$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-on-behalf-of": accountId},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a financial transaction by ID
  @override
  Future<Map> getFinancialTransaction(
      String token, String financialtransactionId, String accountId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/financial_transactions/$financialtransactionId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-on-behalf-of": accountId},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Settlements
  //Get list of settlements
  @override
  Future<Map> getSettlements(
      String token,
      String currencyCode,
      String fromSettledAt,
      String status,
      String toSettledAt,
      String? pageNumber,
      String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    filters.add(currencyCode);
    prefixes.add("currency=");
    filters.add(fromSettledAt);
    prefixes.add("from_settled_at=");

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/pa/financial/settlements$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a settlement by ID
  @override
  Future<Map> getSettlement(String token, String settlementId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/financial/settlements/$settlementId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a settlement report by ID
  @override
  Future<Map> getSettlementReport(String token, String settlementId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/financial/settlements/$settlementId/report");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Authorizations
  //Get authorization status
  @override
  Future<Map> getAuthorizationsStatus(
      String token,
      String? billingCurrencyCode,
      String? cardId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? retrievalRef,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (billingCurrencyCode != null) {
      filters.add(billingCurrencyCode);
      prefixes.add("billing_currency=");
    }
    if (cardId != null) {
      filters.add(cardId);
      prefixes.add("card_id=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (retrievalRef != null) {
      filters.add(retrievalRef);
      prefixes.add("retrieval_ref=");
    }

    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/issuing/authorizations$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get single authorization status
  @override
  Future<Map> getAuthorizationStatus(
      String token, String authorizationId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/issuing/authorizations/$authorizationId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Cardholders
  //Create a CardHolder
  @override
  Future<Map> createCardHolder(
      String token, Map<String, dynamic> cardholderInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cardholders/create");
    var jsonBody = jsonEncode(cardholderInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get all cardholders
  @override
  Future<Map> getCardHolders(String token, String? cardholderStatus,
      String? pageNumber, String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (cardholderStatus != null) {
      filters.add(cardholderStatus);
      prefixes.add("cardholder_status=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/issuing/cardholders$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get cardholder details
  @override
  Future<Map> getCardHolderDetails(String token, String cardholderId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cardholders/$cardholderId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a CardHolder
  @override
  Future<Map> updateCardHolder(
      String token,
      String cardholderId,
      Map<String, String> address,
      Map<String, dynamic> individual,
      String mobileNumber,
      Map<String, String> postalAddress) async {
    final baseUrl = await getBaseUrl;
    var bodyData = {
      "address": address,
      "individual": individual,
      "mobile_number": mobileNumber,
      "postal_address": postalAddress
    };
    var jsonBody = jsonEncode(bodyData);
    var url =
        Uri.parse("$baseUrl/api/v1/issuing/cardholders/$cardholderId/update");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Cards
  //Create a Card
  @override
  Future<Map> createCard(String token, Map<String, dynamic> cardInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cards/create");
    var jsonBody = jsonEncode(cardInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Get sensitive card details
  @override
  Future<Map> getOnCardDetails(String token, String cardId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cards/$cardId/details");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Get all cards
  @override
  Future<Map> getCards(
      String token,
      String? cardStatus,
      String? cardholderId,
      String? fromCreatedAt,
      String? nickname,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (cardStatus != null) {
      filters.add(cardStatus);
      prefixes.add("card_status=");
    }
    if (cardholderId != null) {
      filters.add(cardholderId);
      prefixes.add("cardholder_status=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (nickname != null) {
      filters.add(nickname);
      prefixes.add("nick_name=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/issuing/cards$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Activate a card
  //this will have no response
  @override
  Future<Map> activateCard(String token, String cardId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cards/$cardId/activate");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get Card Details
  @override
  Future<Map> getCardDetails(String token, String cardId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cards/$cardId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Get card remaining limits
  @override
  Future<Map> getCardLimits(String token, String cardId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/cards/$cardId/limits");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Update a card
  @override
  Future<Map> updateCard(
      String token,
      String cardId,
      Map<String, dynamic> authorizationControls,
      String cardStatus,
      String nickname,
      Map<String, String> primaryContactDetails,
      String purpose) async {
    final String baseUrl = await getBaseUrl;
    var bodyData = {
      "authorization_controls": authorizationControls,
      "card_status": cardStatus,
      "nick_name": nickname,
      "primary_contact_details": primaryContactDetails,
      "purpose": purpose
    };
    var jsonBody = jsonEncode(bodyData);
    var url = Uri.parse("$baseUrl/api/v1/issuing/cards/$cardId/limits");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Config
  //Get issuing config
  @override
  Future<Map> getConfig(String token) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/config");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Update issuing config
  @override
  Future<Map> updateConfig(
      String token, Map<String, dynamic> remoteAuth) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/config/update");
    var bodyData = {"remote_auth": remoteAuth};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    //print(data);
    return data;
  }

  //Transactions
  //Get transactions
  @override
  Future<Map> getTransactions(
      String token,
      String? billingCurrencyCode,
      String? cardId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? retrievalRef,
      String? toCreatedAt,
      String? transactionType) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (billingCurrencyCode != null) {
      filters.add(billingCurrencyCode);
      prefixes.add("billing_currency=");
    }
    if (cardId != null) {
      filters.add(cardId);
      prefixes.add("card_id=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (retrievalRef != null) {
      filters.add(retrievalRef);
      prefixes.add("retrieval_ref=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    if (transactionType != null) {
      filters.add(transactionType);
      prefixes.add("transaction_type=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/issuing/transactions$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get single transaction
  @override
  Future<Map> getTransaction(String token, String transactionId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/issuing/transactions/$transactionId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payment Acceptance
  //Config
  //Get available payment method types
  @override
  Future<Map> getConfigPaymentMethodTypes(
      String token,
      String? active,
      String? countryCode,
      String? pageNumber,
      String? pageSize,
      String? transactionCurrency,
      String? transactionMode) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (active != null) {
      filters.add(active);
      prefixes.add("active=");
    }
    if (countryCode != null) {
      filters.add(countryCode);
      prefixes.add("country_code=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (transactionCurrency != null) {
      filters.add(transactionCurrency);
      prefixes.add("transaction_currency=");
    }

    if (transactionMode != null) {
      filters.add(transactionMode);
      prefixes.add("transaction_mode=");
    }

    String params = addFilter(filters, prefixes);

    var url =
        Uri.parse("$baseUrl/api/v1/pa/config/payment_method_types$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get available bank names
  @override
  Future<Map> getAvailableBanks(String token, String paymentMethodType,
      String? countryCode, String? pageNumber, String? pageSize) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    filters.add(paymentMethodType);
    prefixes.add("payment_method_type=");
    if (countryCode != null) {
      filters.add(countryCode);
      prefixes.add("country_code=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/config/banks$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get available mandates details
  @override
  Future<Map> getAvailableMandatesDetails(String token, String? pageNumber,
      String? pageSize, String? paymentMethodType, String? version) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (paymentMethodType != null) {
      filters.add(paymentMethodType);
      prefixes.add("payment_method_type=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (version != null) {
      filters.add(version);
      prefixes.add("version=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/pa/config/mandates$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Customers
  //Create a Customer
  @override
  Future<Map> createCustomer(
      String token, Map<String, dynamic> customerInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/customers/create");
    var jsonBody = jsonEncode(customerInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a Customer
  @override
  Future<Map> getCustomer(String token, String customerId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/customers/$customerId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a Customer
  @override
  Future<Map> updateCustomer(String token, String customerId,
      Map<String, dynamic> newCustomerInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/customers/$customerId/update");
    var jsonBody = jsonEncode(newCustomerInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Generate a client secret for a Customer
  @override
  Future<String> createClientSecretForCustomer(
      String token, String customerId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/customers/$customerId/generate_client_secret");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    var clientSecret = data['client_secret'];
    return clientSecret;
  }

  //Get list of Customers
  @override
  Future<Map> getCustomers(
      String token,
      String? fromCreatedAt,
      String? merchantCustomerId,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (merchantCustomerId != null) {
      filters.add(merchantCustomerId);
      prefixes.add("merchant_customer_id=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/customers$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Customs Declarations
  //Create a customs declaration
  @override
  Future<Map> createCustomsDeclaration(
      String token, Map<String, dynamic> customsDeclarationInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/customs_declarations/create");
    var jsonBody = jsonEncode(customsDeclarationInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update customs declaration
  @override
  Future<Map> updateCustomsDeclaration(
      String token,
      String customsDeclarationId,
      Map<String, dynamic> customsDeclarationInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/customs_declarations/$customsDeclarationId/update");
    var jsonBody = jsonEncode(customsDeclarationInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Redeclare customs declaration
  @override
  Future<Map> redeclareCustomsDeclaration(
      String token, String customsDeclarationId, String requestId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/customs_declarations/$customsDeclarationId/redeclare");
    var bodyData = {"request_id": requestId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve customs declaration
  @override
  Future<Map> getCustomsDeclaration(
      String token, String customsDeclarationId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/customs_declarations/$customsDeclarationId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Funds Split Reversals
  //Create a FundsSplitReversal
  @override
  Future<Map> createFundsSplitReversal(
      String token, Map<String, dynamic> fundsSplitReversalInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/funds_split_reversals/create");
    var jsonBody = jsonEncode(fundsSplitReversalInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a FundsSplitReversal
  @override
  Future<Map> getFundsSplitReversal(
      String token, String fundsSplitReversalId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/funds_split_reversals/$fundsSplitReversalId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of FundsSplitReversals
  @override
  Future<Map> getFundsSplitReversals(String token, String fundsSplitId,
      String? pageNumber, String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    filters.add(fundsSplitId);
    prefixes.add("funds_split_id=");
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/funds_split_reversals$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Funds Splits
  @override
  Future<Map> createFundsSplit(
      String token, Map<String, dynamic> fundsSplitInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/funds_splits/create");
    var jsonBody = jsonEncode(fundsSplitInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a FundsSplit
  @override
  Future<Map> getFundsSplit(String token, String fundsSplitId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/funds_splits/$fundsSplitId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of FundsSplits
  @override
  Future<Map> getAllFundsSplit(String token, String sourceId, String sourceType,
      String? pageNumber, String? pageSize) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    filters.add(sourceId);
    prefixes.add("source_id=");
    filters.add(sourceType);
    prefixes.add("source_type=");
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/pa/funds_splits$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Release a FundsSplit
  @override
  Future<Map> releaseFundsSplit(
      String token, String fundsSplitId, String requestId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/funds_splits/$fundsSplitId/release");
    var bodyData = {"request_id": requestId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payment Attempts
  @override
  Future<Map> getPaymentAttempt(String token, String paymentAttemptId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_attempts/$paymentAttemptId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve list of PaymentAttempts
  @override
  Future<Map> getPaymentAttempts(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? paymentIntentId,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (paymentIntentId != null) {
      filters.add(paymentIntentId);
      prefixes.add("payment_intent_id=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/payment_attempts$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payment Consents
  //Create a PaymentConsent
  @override
  Future<Map> createPaymentConsent(
      String token,
      String? connectedAccountId,
      String customerId,
      String? merchantTriggerReason,
      Map<String, dynamic>? metadata,
      String nextTriggerReason,
      Map<String, dynamic>? paymentMethod,
      String requestId,
      bool? requiresCVC) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_consents/create");

    Map<String, dynamic> bodyData = {
      "customer_id": customerId,
      "next_triggered_by": nextTriggerReason,
      "request_id": requestId
    };
    if (connectedAccountId != null) {
      bodyData.addAll({"connected_account_id": connectedAccountId});
    }
    if (merchantTriggerReason != null) {
      bodyData.addAll({"merchant_trigger_reason": merchantTriggerReason});
    }
    if (metadata != null) {
      bodyData.addAll({"metadata": metadata});
    }
    if (paymentMethod != null) {
      bodyData.addAll({"payment_method": paymentMethod});
    }
    if (requiresCVC != null) {
      bodyData.addAll({"requires_cvc": requiresCVC});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a PaymentConsent
  @override
  Future<Map> updatePaymentConsent(
      String token,
      String paymentConsentId,
      Map<String, dynamic>? metadata,
      Map<String, dynamic>? paymentMethod,
      String requestId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_consents/$paymentConsentId/update");
    Map<String, dynamic> bodyData = {
      "request_id": requestId,
    };
    if (metadata != null) {
      bodyData.addAll({"metadata": metadata});
    }
    if (paymentMethod != null) {
      bodyData.addAll({"payment_method": paymentMethod});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Verify a PaymentConsent
  @override
  Future<Map> verifyPaymentConsent(
      String token,
      String paymentConsentId,
      String? descriptor,
      Map<String, dynamic>? deviceData,
      String requestId,
      String? returnUrl,
      Map<String, dynamic>? riskControlOptions,
      Map<String, dynamic>? verificationOptions) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_consents/$paymentConsentId/verify");
    Map<String, dynamic> bodyData = {
      "request_id": requestId,
    };
    if (descriptor != null) {
      bodyData.addAll({"descriptor": descriptor});
    }
    if (deviceData != null) {
      bodyData.addAll({"device_data": deviceData});
    }
    if (returnUrl != null) {
      bodyData.addAll({"return_url": returnUrl});
    }
    if (riskControlOptions != null) {
      bodyData.addAll({"risk_control_options": riskControlOptions});
    }
    if (verificationOptions != null) {
      bodyData.addAll({"verification_options": verificationOptions});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Disable a PaymentConsent
  @override
  Future<Map> disablePaymentConsent(
      String token, String paymentConsentId, String requestId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_consents/$paymentConsentId/disable");
    var bodyData = {"request_id": requestId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a PaymentConsent
  @override
  Future<Map> getPaymentConsent(String token, String paymentConsentId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_consents/$paymentConsentId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of PaymentConsents
  @override
  Future<Map> getPaymentConsents(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? merchantTriggerReason,
      String? nextTriggerBy,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (customerId != null) {
      filters.add(customerId);
      prefixes.add("customer_id=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (merchantTriggerReason != null) {
      filters.add(merchantTriggerReason);
      prefixes.add("merchant_trigger_reason=");
    }
    if (nextTriggerBy != null) {
      filters.add(nextTriggerBy);
      prefixes.add("next_trigger_by=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/payment_consents$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payment Intents
  //Create a PaymentIntent
  @override
  Future<Map> createPaymentIntent(
      String token, Map<String, dynamic> paymentIntentInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_intents/create");
    var jsonBody = jsonEncode(paymentIntentInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a PaymentIntent
  @override
  Future<Map> getPaymentIntent(String token, String paymentIntentId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_intents/$paymentIntentId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Confirm a PaymentIntent
  @override
  Future<Map> confirmPaymentIntent(String token, String paymentIntentId,
      Map<String, dynamic> paymentIntentInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_intents/$paymentIntentId/confirm");
    var jsonBody = jsonEncode(paymentIntentInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Continue to confirm a PaymentIntent
  @override
  Future<Map> continueConfirmPaymentIntent(String token, String paymentIntentId,
      Map<String, dynamic> paymentIntentInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_intents/$paymentIntentId/confirm_continue");
    var jsonBody = jsonEncode(paymentIntentInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Capture a PaymentIntent
  @override
  Future<Map> capturePaymentIntent(String token, String paymentIntentId,
      String requestId, num amount) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_intents/$paymentIntentId/capture");
    var bodyData = {"amount": amount, "request_id": requestId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Cancel a PaymentIntent
  @override
  Future<Map> cancelPaymentIntent(String token, String paymentIntentId,
      String? cancellationReason, String requestId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_intents/$paymentIntentId/cancel");
    var bodyData = {
      "cancellation_reason": cancellationReason ?? "No Reason Provided",
      "request_id": requestId
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of PaymentIntents
  @override
  Future<Map> getPaymentIntents(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? merchantOrderId,
      String? pageNumber,
      String? pageSize,
      String? paymentConsentId,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (merchantOrderId != null) {
      filters.add(merchantOrderId);
      prefixes.add("merchant_order_id=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (paymentConsentId != null) {
      filters.add(paymentConsentId);
      prefixes.add("payment_consent_id=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_intents$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payment Links
  //Create a PaymentLink
  @override
  Future<Map> createPaymentLink(
      String token, Map<String, dynamic> paymentLinkInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_links/create");
    var jsonBody = jsonEncode(paymentLinkInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a PaymentLink
  @override
  Future<Map> updatePaymentLink(String token, String paymentLinkId,
      String title, String description, String reference) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_links/$paymentLinkId/update");
    var bodyData = {
      "description": description,
      "reference": reference,
      "title": title
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a PaymentLink
  @override
  Future<Map> getPaymentLink(String token, String paymentLinkId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_links/$paymentLinkId");

    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Send a PaymentLink
  @override
  Future<String> sendPaymentLink(
      String token, String paymentLinkId, String shopperEmail) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_links/$paymentLinkId/notify_shopper");
    var bodyData = {"shopper_email": shopperEmail};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Activate a PaymentLink
  @override
  Future<Map> activatePaymentLink(String token, String paymentLinkId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_links/$paymentLinkId/activate");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Deactivate a PaymentLink
  @override
  Future<Map> deactivatePaymentLink(String token, String paymentLinkId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_links/$paymentLinkId/deactivate");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Delete a PaymentLink
  @override
  Future<String> deletePaymentLink(String token, String paymentLinkId) async {
    final baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/pa/payment_links/$paymentLinkId/delete");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of PaymentLinks
  @override
  Future<Map> getPaymentLinks(
      String token,
      String? active,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? reusable,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (active != null) {
      filters.add(active);
      prefixes.add("active=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (reusable != null) {
      filters.add(reusable);
      prefixes.add("reusable=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_links$params");
    var response = await http.get(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payment Methods
  //Create a PaymentMethod
  @override
  Future<Map> createPaymentMethod(
      String token,
      Map<String, dynamic>? applepay,
      Map<String, dynamic>? card,
      Map<String, dynamic>? googlepay,
      String customerId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_methods/create");
    Map<String, dynamic> bodyData = {
      "customer_id": customerId,
      "request_id": requestId,
      "type": type
    };
    if (applepay != null) {
      bodyData.addAll({"applepay": applepay});
    }
    if (card != null) {
      bodyData.addAll({"card": card});
    }
    if (googlepay != null) {
      bodyData.addAll({"googlepay": googlepay});
    }
    if (metadata != null) {
      bodyData.addAll({"metadata": metadata});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a PaymentMethod
  @override
  Future<Map> getPaymentMethod(String token, String paymentMethodId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_methods/$paymentMethodId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of PaymentMethods
  @override
  Future<Map> getPaymentMethods(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? toCreatedAt,
      String? type) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (customerId != null) {
      filters.add(customerId);
      prefixes.add("customer_id=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    if (type != null) {
      filters.add(type);
      prefixes.add("type=");
    }
    String params = addFilter(filters, prefixes);
    var url = Uri.parse("$baseUrl/api/v1/pa/payment_methods$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Disable a PaymentMethod
  @override
  Future<Map> disablePaymentMethod(
      String token, String paymentMethodId, String requestId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/pa/payment_methods/$paymentMethodId/disable");
    var bodyData = {"request_id": requestId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //pa Quote
  //Create a Quote
  @override
  Future<Map> createQuote(String token, String paymentCurrencyCode,
      String settlementCurrencyCode, String type) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/quotes/create");
    var bodyData = {
      "payment_currency": paymentCurrencyCode,
      "settlement_currency": settlementCurrencyCode,
      "type": type
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a Quote
  @override
  Future<Map> getQuote(String token, String quoteId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/quotes/$quoteId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of Quotes
  @override
  Future<Map> getQuotes(
      String token,
      String paymentCurrencyCode,
      String settlementCurrencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    filters.add(paymentCurrencyCode);
    prefixes.add("payment_currency=");
    filters.add(settlementCurrencyCode);
    prefixes.add("settlement_currency=");

    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/quotes$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Reference Data
  //Retrieve Bin info
  @override
  Future<List> getBINInfo(String token, String bin) async {
    final baseUrl = await getBaseUrl;

    var url = Uri.parse("$baseUrl/api/v1/pa/reference/bin/lookup");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "x-pan": bin},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Refunds
  //Create a Refund
  @override
  Future<Map> createRefund(
      String token,
      String? amount,
      Map<String, dynamic>? metadata,
      String? paymentAttemptId,
      String? paymentIntentId,
      String? reason,
      String requestId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/refunds/create");
    Map<String, dynamic> bodyData = {
      "request_id": requestId,
    };
    if (amount != null) {
      bodyData.addAll({"amount": amount});
    }
    if (metadata != null) {
      bodyData.addAll({"metadata": metadata});
    }
    if (paymentAttemptId != null) {
      bodyData.addAll({"payment_attempt_id": paymentAttemptId});
    }
    if (paymentIntentId != null) {
      bodyData.addAll({"payment_intent_id": paymentIntentId});
    }
    if (reason != null) {
      bodyData.addAll({"reason": reason});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve a Refund
  @override
  Future<Map> getRefund(String token, String refundId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/pa/refunds/$refundId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of Refunds
  @override
  Future<Map> getRefunds(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? paymentAttemptId,
      String? paymentIntentId,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }

    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (paymentAttemptId != null) {
      filters.add(paymentAttemptId);
      prefixes.add("payment_attempt_id=");
    }
    if (paymentIntentId != null) {
      filters.add(paymentIntentId);
      prefixes.add("payment_intent_id=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }

    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/pa/refunds$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Beneficiaries
  //Get list of beneficiaries
  @override
  Future<Map> getBeneficiaries(
      String token,
      String? bankAccountNumber,
      String? companyName,
      String? entityType,
      String? fromDate,
      String? name,
      String? nickname,
      String? pageNumber,
      String? pageSize,
      String? toDate) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (bankAccountNumber != null) {
      filters.add(bankAccountNumber);
      prefixes.add("bank_account_number=");
    }

    if (companyName != null) {
      filters.add(companyName);
      prefixes.add("company_name=");
    }
    if (entityType != null) {
      filters.add(entityType);
      prefixes.add("entity_type=");
    }
    if (fromDate != null) {
      filters.add(fromDate);
      prefixes.add("from_date=");
    }
    if (name != null) {
      filters.add(name);
      prefixes.add("name=");
    }
    if (nickname != null) {
      filters.add(nickname);
      prefixes.add("nick_name=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }

    if (toDate != null) {
      filters.add(toDate);
      prefixes.add("to_date=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/beneficiaries$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a beneficiary by ID
  @override
  Future<Map> getBeneficiary(String token, String beneficiaryId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/beneficiaries/$beneficiaryId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Create a new beneficiary
  @override
  Future<Map> createBeneficiary(
      String token, Map<String, dynamic> beneficiaryInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/beneficiaries/create");
    var jsonBody = jsonEncode(beneficiaryInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Deleting existing beneficiary
  @override
  Future<bool> deleteBeneficiary(String token, String beneficiaryId) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/beneficiaries/delete/$beneficiaryId");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update existing beneficiary
  @override
  Future<Map> updateBeneficiary(String token, String beneficiaryId,
      Map<String, dynamic> newBeneficiaryInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/beneficiaries/update/$beneficiaryId");
    var jsonBody = jsonEncode(newBeneficiaryInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Validate beneficiary
  @override
  Future<Map> validateBeneficiary(
      String token, Map<String, dynamic> beneficiaryInfo) async {
    final baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/beneficiaries/validate");
    var jsonBody = jsonEncode(beneficiaryInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get the api schema
  @override
  Future<Map> getBeneficiaryApiSchema(
      String token,
      String? bankCountryCode,
      String? accountCurrency,
      String? paymentMethod,
      String? localClearingSystem,
      String? entityType) async {
    final baseUrl = await getBaseUrl;

    var url = Uri.parse("$baseUrl/api/v1/beneficiary_api_schemas/generate");
    var bodyData = {};
    if (accountCurrency != null) {
      bodyData.addAll({"account_currency": accountCurrency});
    }
    if (bankCountryCode != null) {
      bodyData.addAll({"bank_country_code": bankCountryCode});
    }
    if (entityType != null) {
      bodyData.addAll({"entity_type": entityType});
    }
    if (localClearingSystem != null) {
      bodyData.addAll({"local_clearing_system": localClearingSystem});
    }
    if (paymentMethod != null) {
      bodyData.addAll({"payment_method": paymentMethod});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "headers": "[object Object]"
        },
        body: jsonBody);
    var data = jsonDecode(response.body);
    return data;
  }

  //Get beneficiary Form schema
  @override
  Future<Map> getBeneficiaryFormSchema(
      String token,
      String? bankCountryCode,
      String? accountCurrency,
      String? paymentMethod,
      String? localClearingSystem,
      String? entityType) async {
    final baseUrl = await getBaseUrl;

    var url = Uri.parse("$baseUrl/api/v1/beneficiary_form_schemas/generate");
    var bodyData = {};
    if (accountCurrency != null) {
      bodyData.addAll({"account_currency": accountCurrency});
    }
    if (bankCountryCode != null) {
      bodyData.addAll({"bank_country_code": bankCountryCode});
    }
    if (entityType != null) {
      bodyData.addAll({"entity_type": entityType});
    }
    if (localClearingSystem != null) {
      bodyData.addAll({"local_clearing_system": localClearingSystem});
    }
    if (paymentMethod != null) {
      bodyData.addAll({"payment_method": paymentMethod});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(url,
        headers: {
          "Content-Type": "application/json",
          "Authorization": "Bearer $token",
          "headers": "[object Object]"
        },
        body: jsonBody);
    var data = jsonDecode(response.body);
    return data;
  }

  //Payments
  //Get list of payments
  @override
  Future<Map> getPayments(
      String token,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? paymentCurrency,
      String? requestId,
      String? shortReferrenceId,
      String? status,
      String? toCreatedAt) async {
    final baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (paymentCurrency != null) {
      filters.add(paymentCurrency);
      prefixes.add("payment_currency=");
    }
    if (requestId != null) {
      filters.add(requestId);
      prefixes.add("request_id=");
    }
    if (shortReferrenceId != null) {
      filters.add(shortReferrenceId);
      prefixes.add("short_reference_id=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/payments$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get payment by ID
  @override
  Future<Map> getPayment(String token, String paymentId) async {
    final baseUrl = await getBaseUrl;

    var url = Uri.parse("$baseUrl/api/v1/payments/$paymentId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Cancel a payment
  @override
  Future<Map> cancelPayment(String token, String paymentId) async {
    final baseUrl = await getBaseUrl;

    var url = Uri.parse("$baseUrl/api/v1/payments/cancel/$paymentId");
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Create a new payment
  // Create Payment
  @override
  Future<Map> createPayment(
      String token, Map<String, dynamic> paymentInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/payments/create");

    var jsonBody = jsonEncode(paymentInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retry a payment
  @override
  Future<Map> retryPayment(
      String token, String paymentId, Map<String, dynamic> paymentInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/payments/retry/$paymentId");

    var jsonBody = jsonEncode(paymentInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a payment
  @override
  Future<Map> updatePayment(String token, String paymentId,
      Map<String, dynamic> newpaymentInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/payments/update/$paymentId");

    var jsonBody = jsonEncode(newpaymentInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Validate payment
  @override
  Future<Map> validatePayment(
      String token, Map<String, dynamic> paymentInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/payments/validate");

    var jsonBody = jsonEncode(paymentInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Accounts
  @override
  Future<Map> createAccount(
      String token, Map<String, dynamic> accountInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/accounts/create");

    var jsonBody = jsonEncode(accountInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Update a connected account
  @override
  Future<Map> updateConnectedAccount(
      String token, String accountId, Map<String, dynamic> accountInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/accounts/$accountId/update");
    var jsonBody = jsonEncode(accountInfo);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Submit account for activation
  @override
  Future<Map> submitAccount(String token, String accountId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/accounts/$accountId/submit");

    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get account by ID
  @override
  Future<Map> getAccount(String token, String accountId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/accounts/$accountId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of connected accounts
  @override
  Future<Map> getAccounts(
      String token,
      String? accountStatus,
      String? email,
      String? fromCreatedAt,
      String? identifier,
      String? metadata,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];
    if (accountStatus != null) {
      filters.add(accountStatus);
      prefixes.add("account_status=");
    }
    if (email != null) {
      filters.add(email);
      prefixes.add("email=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }
    if (identifier != null) {
      filters.add(identifier);
      prefixes.add("identifier=");
    }
    if (metadata != null) {
      filters.add(metadata);
      prefixes.add("metadata=");
    }
    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/accounts$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token", "headers": "[object Object]"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retrieve account details
  @override
  Future<Map> getYourAccount(String token) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/account");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Agree to terms and conditions
  @override
  Future<Map> agreement(String token, String accountId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/accounts/$accountId/terms_and_conditions/agree");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "headers": "[object Object]"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Charges
  //Get list of charges
  @override
  Future<Map> getCharges(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? source,
      String? status,
      String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (requestId != null) {
      filters.add(requestId);
      prefixes.add("request_id=");
    }
    if (source != null) {
      filters.add(source);
      prefixes.add("source=");
    }
    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/charges$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a charge by ID
  @override
  Future<Map> getCharge(String token, String chargeId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/charges/$chargeId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Create a new charge
  @override
  Future<Map> createCharge(String token, String amount, String currencyCode,
      String reason, String reference, String requestId, String source) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/charges/create");
    var bodyData = {
      "amount": amount,
      "currency": currencyCode,
      "reason": reason,
      "reference": reference,
      "request_id": requestId,
      "source": source
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Invitation Links
  //Create an account invitation link
  @override
  Future<Map> createInvitationLink(
      String token, Map<String, dynamic> invitationLinkInfo) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/accounts/invitation_links/create");
    var jsonBody = jsonEncode(invitationLinkInfo);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
        "headers": "[object Object]"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get an account invitation link by ID
  @override
  Future<Map> getInvitationLink(String token, String invitationLinkId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/accounts/invitation_links/$invitationLinkId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Transfers
  //Get list of transfers
  @override
  Future<Map> getTransfers(
      String token,
      String? currencyCode,
      String? destination,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? status,
      String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (currencyCode != null) {
      filters.add(currencyCode);
      prefixes.add("currency=");
    }
    if (destination != null) {
      filters.add(destination);
      prefixes.add("destination=");
    }
    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (requestId != null) {
      filters.add(requestId);
      prefixes.add("request_id=");
    }

    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/transfers$params");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a transfer by ID
  @override
  Future<Map> getTransfer(String token, String transferId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/transfers/$transferId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Create a new transfer
  @override
  Future<Map> createTransfer(
      String token,
      String amount,
      String currencyCode,
      String destination,
      String reason,
      String reference,
      String requestId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/transfers/create");
    var bodyData = {
      "amount": amount,
      "currency": currencyCode,
      "destination": destination,
      "reason": reason,
      "reference": reference,
      "request_id": requestId
    };
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //SIMULATION (DEMO ONLY)
  //Accounts
  //Update status of connected account
  @override
  Future<Map> updateAccountStatus(
      String token, String accountId, String nextStatus, String? force) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/simulation/accounts/$accountId/update_status");
    var bodyData = {"next_status": nextStatus};
    if (force != null) {
      bodyData.addAll({"force": force});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Cards
  //Create a transaction for the provided card
  @override
  Future<Map> createCardTransaction(
      String token,
      String transactionAmount,
      String transactionCurrencyCode,
      String? merchantInfo,
      String? merchantCategoryCode,
      String? cardNumber,
      String? cardId,
      String? authCode) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/simulation/issuing/create");
    var bodyData = {
      "transaction_amount": transactionAmount,
      "transaction_currency": transactionCurrencyCode
    };
    if (authCode != null) {
      bodyData.addAll({"auth_code": authCode});
    }
    if (cardId != null) {
      bodyData.addAll({"card_id": cardId});
    }
    if (cardNumber != null) {
      bodyData.addAll({"card_number": cardNumber});
    }
    if (merchantCategoryCode != null) {
      bodyData.addAll({"merchant_category_code": merchantCategoryCode});
    }
    if (merchantInfo != null) {
      bodyData.addAll({"merchant_info": merchantInfo});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Capture the transaction with the provided id
  @override
  Future<Map> captureTransaction(String token, String transactionId) async {
    final String baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/simulation/issuing/$transactionId/capture");

    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Global Account
  //Create a global account deposit
  @override
  Future<Map> createGlobalAccountDeposit(
      String token,
      String amount,
      String globalAccountId,
      String? payerBank,
      String? payerCountry,
      String? payerName,
      String? reference,
      String? status) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/simulation/deposit/create");
    var bodyData = {
      "amount": amount,
      "global_account_id": globalAccountId,
    };
    if (payerBank != null) {
      bodyData.addAll({"payer_bankname": payerBank});
    }
    if (payerCountry != null) {
      bodyData.addAll({"payer_country": payerCountry});
    }
    if (payerName != null) {
      bodyData.addAll({"payer_name": payerName});
    }
    if (reference != null) {
      bodyData.addAll({"reference": reference});
    }
    if (status != null) {
      bodyData.addAll({"status": status});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Payouts
  //Transition Payment Status
  @override
  Future<Map> paymentStatusTransition(String token, String paymentId,
      String? failureType, String nextStatus) async {
    final String baseUrl = await getBaseUrl;
    var url =
        Uri.parse("$baseUrl/api/v1/simulation/payments/$paymentId/transition");
    var bodyData = {"next_status": nextStatus};
    if (failureType != null) {
      bodyData.addAll({"failure_type": failureType});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //File Service
  //Get onboarding file download links
  @override
  Future<Map> getFileDownloadLink(String token, List<String> fileIds) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/files/download_links");
    var bodyData = {"file_ids": fileIds};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Upload a file
  //Remember to add in the docs that this function take some time to load
  @override
  Future<Map> uploadFile(
      String token, String environment, String? notes, File file) async {
    String addNotes = notes != null ? "?notes=$notes" : "";
    String baseUrl = environment == "demo"
        ? "https://files-demo.airwallex.com"
        : "https://files.airwallex.com";
    var url = Uri.parse("$baseUrl/api/v1/files/upload$addNotes");
    var request = http.MultipartRequest('POST', url);
    request.fields['file'] = 'Folder';
    request.headers['Authorization'] = "Bearer $token";
    final toUploadFile = await http.MultipartFile.fromPath('file', file.path);

    request.files.add(toUploadFile);
    var response = await request.send();
    var responseData = await response.stream.toBytes();

    String stringData = String.fromCharCodes(responseData);

    var data = jsonDecode(stringData);
    return data;
  }

  //Notification
  //Create a new notification
  @override
  Future<Map> createNotification(
      String token, String deliverType, String sourceId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/notifications/create");
    var bodyData = {"deliver_type": deliverType, "source_id": sourceId};
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Reference Data
  //Industry Categories
  @override
  Future<Map> getIndustryCategories(String token) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/reference/industry_categories");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get Invalid Conversion Dates
  @override
  Future<Map> getInvalidConversionDates(
      String token, String currencyPair) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/reference/invalid_conversion_dates?currency_pair=$currencyPair");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Supported Currencies
  @override
  Future<Map> getSupportedCurrencies(String token) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/reference/supported_currencies");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Conversion
  //Create a conversion
  @override
  Future<Map> createConversion(
      String token,
      String? buyAmount,
      String buyCurrency,
      String? conversionDate,
      String? quoteId,
      String reason,
      String requestId,
      String? sellAmount,
      String sellCurrency,
      bool termAgreement) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/conversions/create");
    var bodyData = {
      "buy_currency": buyCurrency,
      "reason": reason,
      "request_id": requestId,
      "sell_currency": sellCurrency,
      "term_agreement": termAgreement
    };
    if (buyAmount != null) {
      bodyData.addAll({"buy_amount": buyAmount});
    }
    if (conversionDate != null) {
      bodyData.addAll({"conversion_date": conversionDate});
    }
    if (quoteId != null) {
      bodyData.addAll({"quote_id": quoteId});
    }
    if (sellAmount != null) {
      bodyData.addAll({"sell_amount": sellAmount});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Retreive a specific conversion
  @override
  Future<Map> getConversion(String token, String conversionId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/conversions/$conversionId");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //List of conversions
  @override
  Future<Map> getConversions(
      String token,
      String? buyCurrency,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? sellCurrency,
      String? status,
      String? toCreatedAt) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (buyCurrency != null) {
      filters.add(buyCurrency);
      prefixes.add("buy_currency=");
    }

    if (fromCreatedAt != null) {
      filters.add(fromCreatedAt);
      prefixes.add("from_created_at=");
    }

    if (pageNumber != null) {
      filters.add(pageNumber);
      prefixes.add("page_num=");
    }
    if (pageSize != null) {
      filters.add(pageSize);
      prefixes.add("page_size=");
    }
    if (requestId != null) {
      filters.add(requestId);
      prefixes.add("request_id=");
    }
    if (sellCurrency != null) {
      filters.add(sellCurrency);
      prefixes.add("sell_currency=");
    }

    if (status != null) {
      filters.add(status);
      prefixes.add("status=");
    }
    if (toCreatedAt != null) {
      filters.add(toCreatedAt);
      prefixes.add("to_created_at=");
    }
    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/conversions$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Conversion Amendments
  //Quote a new amendment
  @override
  Future<Map> quoteAmendment(
      String token,
      String? chargeCurrency,
      String conversionId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/conversion_amendments/quote");
    Map<String, dynamic> bodyData = {
      "conversion_id": conversionId,
      "request_id": requestId,
      "type": type
    };
    if (chargeCurrency != null) {
      bodyData.addAll({"charge_currency": chargeCurrency});
    }
    if (metadata != null) {
      bodyData.addAll({"metadata": metadata});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Create a new amendment
  @override
  Future<Map> createAmendment(
      String token,
      String? chargeCurrency,
      String conversionId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/conversion_amendments/create");
    Map<String, dynamic> bodyData = {
      "conversion_id": conversionId,
      "request_id": requestId,
      "type": type
    };
    if (chargeCurrency != null) {
      bodyData.addAll({"charge_currency": chargeCurrency});
    }
    if (metadata != null) {
      bodyData.addAll({"metadata": metadata});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get a specific amendment
  @override
  Future<Map> getAmendment(String token, String conversionAmendmentId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/conversion_amendments/$conversionAmendmentId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //Get list of amendments
  @override
  Future<Map> getAmendments(String token, String conversionId) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse(
        "$baseUrl/api/v1/conversion_amendments?conversion_id=$conversionId");

    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //LockFX
  //Create LockFX quote
  @override
  Future<Map> createLockFXQuote(
      String token,
      String? buyAmount,
      String buyCurrency,
      String? conversionDate,
      String? sellAmount,
      String sellCurrency,
      String validity) async {
    final String baseUrl = await getBaseUrl;
    var url = Uri.parse("$baseUrl/api/v1/lockfx/create");
    var bodyData = {
      "buy_currency": buyCurrency,
      "sell_currency": sellCurrency,
      "validity": validity
    };
    if (buyAmount != null) {
      bodyData.addAll({"buy_amount": buyAmount});
    }
    if (conversionDate != null) {
      bodyData.addAll({"conversion_date": conversionDate});
    }
    if (sellAmount != null) {
      bodyData.addAll({"sell_amount": sellAmount});
    }
    var jsonBody = jsonEncode(bodyData);
    var response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token"
      },
      body: jsonBody,
    );
    var data = jsonDecode(response.body);
    return data;
  }

  //MarketFX
  //Get Quote
  @override
  Future<Map> getMarketFxQuote(
      String token,
      String? buyAmount,
      String buyCurrencyCode,
      String sellCurrencyCode,
      String? sellAmount,
      String? conversionDate) async {
    final String baseUrl = await getBaseUrl;
    var filters = [];
    var prefixes = [];

    if (buyAmount != null) {
      filters.add(buyAmount);
      prefixes.add("buy_amount=");
    }
    filters.add(buyCurrencyCode);
    prefixes.add("buy_currency=");
    filters.add(sellCurrencyCode);
    prefixes.add("sell_currency=");

    if (sellAmount != null) {
      filters.add(sellAmount);
      prefixes.add("sell_amount=");
    }

    if (conversionDate != null) {
      filters.add(conversionDate);
      prefixes.add("conversion_date=");
    }

    String params = addFilter(filters, prefixes);

    var url = Uri.parse("$baseUrl/api/v1/marketfx/quote$params");
    var response = await http.get(
      url,
      headers: {"Authorization": "Bearer $token"},
    );
    var data = jsonDecode(response.body);
    return data;
  }

  String addFilter(List values, List prefixes) {
    var filters = values;
    if (values.isEmpty || prefixes.isEmpty) {
      return "";
    }

    if (filters.length == 1) {
      var edit = filters[0].toString().split('');
      edit.insert(0, '?');
      final prefix = prefixes[0].toString().split('').toList();

      edit.insertAll(1, prefix);
      filters[0] = edit.join("");
    }
    if (filters.length > 1) {
      var edit = filters[0].toString().split('');
      edit.insert(0, '?');
      final prefix = prefixes[0].toString().split('').toList();

      edit.insertAll(1, prefix);
      edit.insert(edit.length, '&');
      filters[0] = edit.join("");
    }
    for (final i in filters.getRange(1, filters.length)) {
      if (filters.indexOf(i) < filters.length - 1) {
        var edit = i.toString().split('');
        edit.insert(edit.length, "&");
        final prefix =
            prefixes[filters.indexOf(i)].toString().split('').toList();
        edit.insertAll(0, prefix);
        filters[filters.indexOf(i)] = edit.join("");
      } else if (filters.indexOf(i) == filters.length - 1) {
        var edit = i.toString().split('');
        final prefix =
            prefixes[filters.indexOf(i)].toString().split('').toList();
        edit.insertAll(0, prefix);
        filters[filters.indexOf(i)] = edit.join("");
      }
    }
    return filters.join("");
  }
}
