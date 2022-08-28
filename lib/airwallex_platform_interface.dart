import 'dart:io';

import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'airwallex_method_channel.dart';

abstract class AirwallexPlatform extends PlatformInterface {
  /// Constructs a AirwallexPlatform.
  AirwallexPlatform() : super(token: _token);

  static final Object _token = Object();

  static AirwallexPlatform _instance = MethodChannelAirwallex();

  /// The default instance of [AirwallexPlatform] to use.
  ///
  /// Defaults to [MethodChannelAirwallex].
  static AirwallexPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AirwallexPlatform] when
  /// they register themselves.
  static set instance(AirwallexPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String> initialize(
      bool logging, String environment, List<String> componentProvider) {
    throw UnimplementedError("initialize has not been implemented");
  }

  Future<String> get getBaseUrl {
    throw UnimplementedError("GetUrl has not been implemented");
  }

  Future<String> login(String apiKey, String clientId) {
    throw UnimplementedError("Login has not been implemented");
  }

  Future<List> getBalances(String token) {
    throw UnimplementedError("Get Balances has not been implemented");
  }

  Future<Map> checkPaymentStatus(String token, String paymentId) {
    throw UnimplementedError("Check Payment Status has not been implemented");
  }

  Future<Map> createCard(String token, Map<String, dynamic> cardInfo) {
    throw UnimplementedError("Create Card has not been implemented");
  }

  Future<Map> getOAuthAuthorization(
      String token,
      String clientId,
      String redirectUri,
      String responseType,
      String scope,
      String? codeChallenge,
      String? codeChallengeMethod,
      String? state) {
    throw UnimplementedError(
        "Get OAuth Authorization has not been implemented");
  }

  Future<Map> exchangeToken(String clientId, String clientSecret, String code,
      String? codeVerifier, String grantType, String redirectUri) {
    throw UnimplementedError("Exchange Token has not been implemented");
  }

  Future<Map> refreshToken(String clientId, String clientSecret,
      String grantType, String refreshToken) {
    throw UnimplementedError("Refresh Token has not been implemented");
  }

  Future<Map> getInvoice(String token, String invoiceId) {
    throw UnimplementedError("Get Invoice has not been implemented");
  }

  Future<Map> getInvoices(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? subscriptionId,
      String? toCreatedAt) {
    throw UnimplementedError("Get invoices has not been implemented");
  }

  Future<Map> getInvoiceItem(
      String token, String invoiceId, String invoiceItemId) {
    throw UnimplementedError("Get Invoice Item has not been implemented");
  }

  Future<Map> getInvoiceItems(
      String token, String invoiceId, String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get Invoice has not been implemented");
  }

  Future<Map> createPrice(String token, Map<String, dynamic> priceInfo) {
    throw UnimplementedError("Create Price has not been implemented");
  }

  Future<Map> getPrice(String token, String priceId) {
    throw UnimplementedError("Get Price has not been implemented");
  }

  Future<Map> updatePrice(
      String token, String priceId, Map<String, dynamic> priceInfo) {
    throw UnimplementedError("Update Price has not been implemented");
  }

  Future<Map> deletePrice(String token, String priceId) {
    throw UnimplementedError("Delete Price has not been implemented");
  }

  Future<Map> getPrices(
      String token,
      String? active,
      String? currencyCode,
      String? pageNumber,
      String? pageSize,
      String? productId,
      String? recurringPeriod,
      String? recurringPeriodUnit) {
    throw UnimplementedError("Get Prices has not been implemented");
  }

  Future<Map> createProduct(String token, Map<String, dynamic> productInfo) {
    throw UnimplementedError("Create Product has not been implemented");
  }

  Future<Map> getProduct(String token, String productId) {
    throw UnimplementedError("Get Product has not been implemented");
  }

  Future<Map> updateProduct(
      String token, String productId, Map<String, dynamic> newProductInfo) {
    throw UnimplementedError("Update Product has not been implemented");
  }

  Future<Map> deleteProduct(String token, String productId) {
    throw UnimplementedError("Delete Product has not been implemented");
  }

  Future<Map> getProducts(
      String token, String? active, String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get Products has not been implemented");
  }

  Future<Map> createSubscription(String token, Map<String, dynamic> subInfo) {
    throw UnimplementedError("Create Subscription has not been implemented");
  }

  Future<Map> getSubscription(String token, String subscriptionId) {
    throw UnimplementedError("Get Subscription has not been implemented");
  }

  Future<Map> updateSubscription(
      String token, String subscriptionId, Map<String, dynamic> newSubInfo) {
    throw UnimplementedError("Update Subscription has not been implemented");
  }

  Future<Map> cancelSubscription(
      String token, String subscriptionId, String prorationBehavior) {
    throw UnimplementedError("Cancel Subscription has not been implemented");
  }

  Future<Map> getSubscriptions(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? recurringPeriod,
      String? recurringPeriodUnit,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Subscriptions has not been implemented");
  }

  Future<Map> getSubscriptionItem(
      String token, String subscriptionId, String itemId) {
    throw UnimplementedError("Get Subscription Item has not been implemented");
  }

  Future<Map> getSubscriptionItems(String token, String subscriptionId,
      String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get Subscription Items has not been implemented");
  }

  Future<Map> createConfirmationLetter(
      String token, String format, String transactionId) {
    throw UnimplementedError(
        "Create Confirmation Letter has not been implemented");
  }

  Future<Map> getBalancesHistory(
      String token,
      String? currencyCode,
      String? fromPostAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? toPostAt) {
    throw UnimplementedError("Get Balances History has not been implemented");
  }

  Future<Map> getDeposits(String token, String? fromCreatedAt,
      String? pageNumber, String? pageSize, String? toCreatedAt) {
    throw UnimplementedError("Get Deposits has not been implemented");
  }

  Future<Map> getDeposit(String token, String depositId) {
    throw UnimplementedError("Get Deposit has not been implemented");
  }

  Future<Map> getGlobalAccounts(
      String token,
      String? countryCode,
      String? currencyCode,
      String? fromCreatedAt,
      String? nickname,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Global Accounts has not been implemented");
  }

  Future<Map> getGlobalAccount(String token, String globalAccountId) {
    throw UnimplementedError("Get Global Account has not been implemented");
  }

  Future<Map> createStatementLetter(String token, String globalAccountId,
      Map<String, dynamic> statementInfo) {
    throw UnimplementedError(
        "Create Statement Letter for a Global Account has not been implemented");
  }

  Future<Map> getGlobalAccountTransactions(
      String token,
      String globalAccountId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    throw UnimplementedError(
        "Get Global Account Transactions has not been implemented");
  }

  Future<Map> createGlobalAccount(
      String token,
      String countryCode,
      String currencyCode,
      String nickname,
      List<String> paymentMethods,
      String requestId) {
    throw UnimplementedError("Create Global Account has not been implemented");
  }

  Future<Map> updateGlobalAccount(
      String token, String globalAccountId, String newNickName) {
    throw UnimplementedError("Update Global Account has not been implemented");
  }

  Future<Map> getFinancialReports(
      String token, String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get Financial Reports has not been implemented");
  }

  Future<Map> getFinancialReport(String token, String reportId) {
    throw UnimplementedError("Get Financial Report has not been implemented");
  }

  Future<Map> getFinancialReportContent(String token, String reportId) {
    throw UnimplementedError(
        "Get Financial Report Content has not been implemented");
  }

  Future<Map> createFinancialReport(
      String token, Map<String, dynamic> financialreportInfo) {
    throw UnimplementedError(
        "Create Financial Report has not been implemented");
  }

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
      String accountId) {
    throw UnimplementedError(
        "Get Financial Transactions has not been implemented");
  }

  Future<Map> getFinancialTransaction(
      String token, String financialtransactionId, String accountId) {
    throw UnimplementedError(
        "Get Financial Transaction has not been implemented");
  }

  Future<Map> getSettlements(
      String token,
      String currencyCode,
      String fromSettledAt,
      String status,
      String toSettledAt,
      String? pageNumber,
      String? pageSize) {
    throw UnimplementedError("Get Settlements has not been implemented");
  }

  Future<Map> getSettlement(String token, String settlementId) {
    throw UnimplementedError("Get Settlement has not been implemented");
  }

  Future<Map> getSettlementReport(String token, String settlementId) {
    throw UnimplementedError("Get Settlement Report has not been implemented");
  }

  Future<Map> getAuthorizationsStatus(
      String token,
      String? billingCurrencyCode,
      String? cardId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? retrievalRef,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Authorizations has not been implemented");
  }

  Future<Map> getAuthorizationStatus(String token, String authorizationId) {
    throw UnimplementedError("Get Authorization has not been implemented");
  }

  Future<Map> createCardHolder(
      String token, Map<String, dynamic> cardholderInfo) {
    throw UnimplementedError("Create CardHolder has not been implemented");
  }

  Future<Map> getCardHolders(String token, String? cardholderStatus,
      String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get CardHolders has not been implemented");
  }

  Future<Map> getCardHolderDetails(String token, String cardholderId) {
    throw UnimplementedError("Get CardHolder Details has not been implemented");
  }

  Future<Map> updateCardHolder(
      String token,
      String cardholderId,
      Map<String, String> address,
      Map<String, dynamic> individual,
      String mobileNumber,
      Map<String, String> postalAddress) {
    throw UnimplementedError("Update CardHolder has not been implemented");
  }

  Future<Map> getOnCardDetails(String token, String cardId) {
    throw UnimplementedError("Get OnCard Details has not been implemented");
  }

  Future<Map> getCards(
      String token,
      String? cardStatus,
      String? cardholderId,
      String? fromCreatedAt,
      String? nickname,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    throw UnimplementedError("Get Cards has not been implemented");
  }

  Future<Map> activateCard(String token, String cardId) {
    throw UnimplementedError("Activate Card has not been implemented");
  }

  Future<Map> getCardDetails(String token, String cardId) {
    throw UnimplementedError("Get Card Details has not been implemented");
  }

  Future<Map> getCardLimits(String token, String cardId) {
    throw UnimplementedError("Get Card Limits has not been implemented");
  }

  Future<Map> updateCard(
      String token,
      String cardId,
      Map<String, dynamic> authorizationControls,
      String cardStatus,
      String nickname,
      Map<String, String> primaryContactDetails,
      String purpose) {
    throw UnimplementedError("Update Card has not been implemented");
  }

  Future<Map> getConfig(String token) {
    throw UnimplementedError("Get Config has not been implemented");
  }

  Future<Map> updateConfig(String token, Map<String, dynamic> remoteAuth) {
    throw UnimplementedError("Update Config has not been implemented");
  }

  Future<Map> getTransactions(
      String token,
      String? billingCurrencyCode,
      String? cardId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? retrievalRef,
      String? toCreatedAt,
      String? transactionType) {
    throw UnimplementedError("Get Transactions has not been implemented");
  }

  Future<Map> getTransaction(String token, String transactionId) {
    throw UnimplementedError("Get Transaction has not been implemented");
  }

  Future<Map> getConfigPaymentMethodTypes(
      String token,
      String? active,
      String? countryCode,
      String? pageNumber,
      String? pageSize,
      String? transactionCurrency,
      String? transactionMode) {
    throw UnimplementedError(
        "Get Config PaymentMethod Types has not been implemented");
  }

  Future<Map> getAvailableBanks(String token, String paymentMethodType,
      String? countryCode, String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get Availabe Banks has not been implemented");
  }

  Future<Map> getAvailableMandatesDetails(String token, String? pageNumber,
      String? pageSize, String? paymentMethodType, String? version) {
    throw UnimplementedError(
        "Get Availabe Mandates Details has not been implemented");
  }

  Future<Map> createCustomer(String token, Map<String, dynamic> customerInfo) {
    throw UnimplementedError("Create Customer has not been implemented");
  }

  Future<Map> getCustomer(String token, String customerId) {
    throw UnimplementedError("Get Customer has not been implemented");
  }

  Future<Map> updateCustomer(
      String token, String customerId, Map<String, dynamic> newCustomerInfo) {
    throw UnimplementedError("Update Customer has not been implemented");
  }

  Future<String> createClientSecretForCustomer(
      String token, String customerId) {
    throw UnimplementedError(
        "Create Client Secret for a Customer has not been implemented");
  }

  Future<Map> getCustomers(
      String token,
      String? fromCreatedAt,
      String? merchantCustomerId,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    throw UnimplementedError("Get Customers has not been implemented");
  }

  Future<Map> createCustomsDeclaration(
      String token, Map<String, dynamic> customsDeclarationInfo) {
    throw UnimplementedError(
        "Create Customs Declaration has not been implemented");
  }

  Future<Map> updateCustomsDeclaration(
      String token,
      String customsDeclarationId,
      Map<String, dynamic> customsDeclarationInfo) {
    throw UnimplementedError(
        "Update Customs Declaration has not been implemented");
  }

  Future<Map> redeclareCustomsDeclaration(
      String token, String customsDeclarationId, String requestId) {
    throw UnimplementedError(
        "Redeclare Customs Declaration has not been implemented");
  }

  Future<Map> getCustomsDeclaration(String token, String customsDeclarationId) {
    throw UnimplementedError(
        "Get Customs Declaration has not been implemented");
  }

  Future<Map> createFundsSplitReversal(
      String token, Map<String, dynamic> fundsSplitReversalInfo) {
    throw UnimplementedError(
        "Create FundsSplitReversal has not been implemented");
  }

  Future<Map> getFundsSplitReversal(String token, String fundsSplitReversalId) {
    throw UnimplementedError("Get FundsSplitReversal has not been implemented");
  }

  Future<Map> getFundsSplitReversals(
      String token, String fundsSplitId, String? pageNumber, String? pageSize) {
    throw UnimplementedError(
        "Get FundsSplitReversals has not been implemented");
  }

  Future<Map> createFundsSplit(
      String token, Map<String, dynamic> fundsSplitInfo) {
    throw UnimplementedError("Create FundsSplit has not been implemented");
  }

  Future<Map> getFundsSplit(String token, String fundsSplitId) {
    throw UnimplementedError("Get a FundsSplit has not been implemented");
  }

  Future<Map> getAllFundsSplit(String token, String sourceId, String sourceType,
      String? pageNumber, String? pageSize) {
    throw UnimplementedError("Get All FundsSplit has not been implemented");
  }

  Future<Map> releaseFundsSplit(
      String token, String fundsSplitId, String requestId) {
    throw UnimplementedError("Release FundsSplit has not been implemented");
  }

  Future<Map> getPaymentAttempt(String token, String paymentAttemptId) {
    throw UnimplementedError("Get Payment Attempt has not been implemented");
  }

  Future<Map> getPaymentAttempts(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? paymentIntentId,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Payment Attempts has not been implemented");
  }

  Future<Map> createPaymentConsent(
      String token,
      String? connectedAccountId,
      String customerId,
      String? merchantTriggerReason,
      Map<String, dynamic>? metadata,
      String nextTriggerReason,
      Map<String, dynamic>? paymentMethod,
      String requestId,
      bool? requiresCVC) {
    throw UnimplementedError("Create Payment Consent has not been implemented");
  }

  Future<Map> updatePaymentConsent(
      String token,
      String paymentConsentId,
      Map<String, dynamic>? metadata,
      Map<String, dynamic>? paymentMethod,
      String requestId) {
    throw UnimplementedError("Update Payment Consent has not been implemented");
  }

  Future<Map> verifyPaymentConsent(
      String token,
      String paymentConsentId,
      String? descriptor,
      Map<String, dynamic>? deviceData,
      String requestId,
      String? returnUrl,
      Map<String, dynamic>? riskControlOptions,
      Map<String, dynamic>? verificationOptions) {
    throw UnimplementedError("Verify Payment Consent has not been implemented");
  }

  Future<Map> disablePaymentConsent(
      String token, String paymentConsentId, String requestId) {
    throw UnimplementedError(
        "Disable Payment Consent has not been implemented");
  }

  Future<Map> getPaymentConsent(String token, String paymentConsentId) {
    throw UnimplementedError("Get Payment Consent has not been implemented");
  }

  Future<Map> getPaymentConsents(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? merchantTriggerReason,
      String? nextTriggerBy,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Payment Consents has not been implemented");
  }

  Future<Map> createPaymentIntent(
      String token, Map<String, dynamic> paymentIntentInfo) {
    throw UnimplementedError("Create Payment Intent has not been implemented");
  }

  Future<Map> getPaymentIntent(String token, String paymentIntentId) {
    throw UnimplementedError("Get Payment Intent has not been implemented");
  }

  Future<Map> confirmPaymentIntent(String token, String paymentIntentId,
      Map<String, dynamic> paymentIntentInfo) {
    throw UnimplementedError("Confirm Payment Intent has not been implemented");
  }

  Future<Map> continueConfirmPaymentIntent(String token, String paymentIntentId,
      Map<String, dynamic> paymentIntentInfo) {
    throw UnimplementedError(
        "Continue Confirm Payment Intent has not been implemented");
  }

  Future<Map> capturePaymentIntent(
      String token, String paymentIntentId, String requestId, num amount) {
    throw UnimplementedError("Capture Payment Intent has not been implemented");
  }

  Future<Map> cancelPaymentIntent(String token, String paymentIntentId,
      String? cancellationReason, String requestId) {
    throw UnimplementedError("Cancel Payment Intent has not been implemented");
  }

  Future<Map> getPaymentIntents(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? merchantOrderId,
      String? pageNumber,
      String? pageSize,
      String? paymentConsentId,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Payment Intents has not been implemented");
  }

  Future<Map> createPaymentLink(
      String token, Map<String, dynamic> paymentLinkInfo) {
    throw UnimplementedError("Create Payment Link has not been implemented");
  }

  Future<Map> updatePaymentLink(String token, String paymentLinkId,
      String title, String description, String reference) {
    throw UnimplementedError("Update Payment Link has not been implemented");
  }

  Future<Map> getPaymentLink(String token, String paymentLinkId) {
    throw UnimplementedError("Get Payment Link has not been implemented");
  }

  Future<String> sendPaymentLink(
      String token, String paymentLinkId, String shopperEmail) {
    throw UnimplementedError("Send Payment Link has not been implemented");
  }

  Future<Map> activatePaymentLink(String token, String paymentLinkId) {
    throw UnimplementedError("Activate Payment Link has not been implemented");
  }

  Future<Map> deactivatePaymentLink(String token, String paymentLinkId) {
    throw UnimplementedError(
        "Deactivate Payment Link has not been implemented");
  }

  Future<String> deletePaymentLink(String token, String paymentLinkId) {
    throw UnimplementedError("Delete Payment Link has not been implemented");
  }

  Future<Map> getPaymentLinks(
      String token,
      String? active,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? reusable,
      String? toCreatedAt) {
    throw UnimplementedError("Get Payment Links has not been implemented");
  }

  Future<Map> createPaymentMethod(
      String token,
      Map<String, dynamic>? applepay,
      Map<String, dynamic>? card,
      Map<String, dynamic>? googlepay,
      String customerId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) {
    throw UnimplementedError("Create Payment Method has not been implemented");
  }

  Future<Map> getPaymentMethod(String token, String paymentMethodId) {
    throw UnimplementedError("Get Payment Method has not been implemented");
  }

  Future<Map> getPaymentMethods(
      String token,
      String? customerId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? status,
      String? toCreatedAt,
      String? type) {
    throw UnimplementedError("Get Payment Methods has not been implemented");
  }

  Future<Map> disablePaymentMethod(
      String token, String paymentMethodId, String requestId) {
    throw UnimplementedError("Disable Payment Method has not been implemented");
  }

  Future<Map> createQuote(String token, String paymentCurrencyCode,
      String settlementCurrencyCode, String type) {
    throw UnimplementedError("Create Quote has not been implemented");
  }

  Future<Map> getQuote(String token, String quoteId) {
    throw UnimplementedError("Get Quote has not been implemented");
  }

  Future<Map> getQuotes(
      String token,
      String paymentCurrencyCode,
      String settlementCurrencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    throw UnimplementedError("Get Quotes has not been implemented");
  }

  Future<List> getBINInfo(String token, String bin) {
    throw UnimplementedError("Get BINInfo has not been implemented");
  }

  Future<Map> createRefund(
      String token,
      String? amount,
      Map<String, dynamic>? metadata,
      String? paymentAttemptId,
      String? paymentIntentId,
      String? reason,
      String requestId) {
    throw UnimplementedError("Create Refund has not been implemented");
  }

  Future<Map> getRefund(String token, String refundId) {
    throw UnimplementedError("Get Refund has not been implemented");
  }

  Future<Map> getRefunds(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? paymentAttemptId,
      String? paymentIntentId,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Refunds has not been implemented");
  }

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
      String? toDate) {
    throw UnimplementedError("Get Beneficiaries has not been implemented");
  }

  Future<Map> getBeneficiary(String token, String beneficiaryId) {
    throw UnimplementedError("Get Beneficiary has not been implemented");
  }

  Future<Map> createBeneficiary(
      String token, Map<String, dynamic> beneficiaryInfo) {
    throw UnimplementedError("Create Beneficiary has not been implemented");
  }

  Future<bool> deleteBeneficiary(String token, String beneficiaryId) {
    throw UnimplementedError("Delete Beneficiary has not been implemented");
  }

  Future<Map> updateBeneficiary(String token, String beneficiaryId,
      Map<String, dynamic> newBeneficiaryInfo) {
    throw UnimplementedError("Update Beneficiary has not been implemented");
  }

  Future<Map> validateBeneficiary(
      String token, Map<String, dynamic> beneficiaryInfo) {
    throw UnimplementedError("Validate Beneficiary has not been implemented");
  }

  Future<Map> getBeneficiaryApiSchema(
      String token,
      String? bankCountryCode,
      String? accountCurrency,
      String? paymentMethod,
      String? localClearingSystem,
      String? entityType) {
    throw UnimplementedError(
        "Get Beneficiary Api Schema has not been implemented");
  }

  Future<Map> getBeneficiaryFormSchema(
      String token,
      String? bankCountryCode,
      String? accountCurrency,
      String? paymentMethod,
      String? localClearingSystem,
      String? entityType) {
    throw UnimplementedError(
        "Get Beneficiary Form Schema has not been implemented");
  }

  Future<Map> getPayments(
      String token,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? paymentCurrency,
      String? requestId,
      String? shortReferrenceId,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Payments has not been implemented");
  }

  Future<Map> getPayment(String token, String paymentId) {
    throw UnimplementedError("Get Payment has not been implemented");
  }

  Future<Map> cancelPayment(String token, String paymentId) {
    throw UnimplementedError("Cancel Payment has not been implemented");
  }

  Future<Map> createPayment(String token, Map<String, dynamic> paymentInfo) {
    throw UnimplementedError("Create Payment has not been implemented");
  }

  Future<Map> retryPayment(
      String token, String paymentId, Map<String, dynamic> paymentInfo) {
    throw UnimplementedError("Retry Payment has not been implemented");
  }

  Future<Map> updatePayment(
      String token, String paymentId, Map<String, dynamic> newpaymentInfo) {
    throw UnimplementedError("Update Payment has not been implemented");
  }

  Future<Map> validatePayment(String token, Map<String, dynamic> paymentInfo) {
    throw UnimplementedError("Validate Payment has not been implemented");
  }

  Future<Map> createAccount(String token, Map<String, dynamic> accountInfo) {
    throw UnimplementedError("Create Account has not been implemented");
  }

  Future<Map> updateConnectedAccount(
      String token, String accountId, Map<String, dynamic> accountInfo) {
    throw UnimplementedError(
        "Update Connected Account has not been implemented");
  }

  Future<Map> submitAccount(String token, String accountId) {
    throw UnimplementedError("Submit Account has not been implemented");
  }

  Future<Map> getAccount(String token, String accountId) {
    throw UnimplementedError("Get Account has not been implemented");
  }

  Future<Map> getAccounts(
      String token,
      String? accountStatus,
      String? email,
      String? fromCreatedAt,
      String? identifier,
      String? metadata,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    throw UnimplementedError("Get Accounts has not been implemented");
  }

  Future<Map> getYourAccount(String token) {
    throw UnimplementedError("Get Your Account has not been implemented");
  }

  Future<Map> agreement(String token, String accountId) {
    throw UnimplementedError("Agreement has not been implemented");
  }

  Future<Map> getCharges(
      String token,
      String? currencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? source,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Charges has not been implemented");
  }

  Future<Map> getCharge(String token, String chargeId) {
    throw UnimplementedError("Get Charge has not been implemented");
  }

  Future<Map> createCharge(String token, String amount, String currencyCode,
      String reason, String reference, String requestId, String source) {
    throw UnimplementedError("Create Charge has not been implemented");
  }

  Future<Map> createInvitationLink(
      String token, Map<String, dynamic> invitationLinkInfo) {
    throw UnimplementedError("Create Invitation Link has not been implemented");
  }

  Future<Map> getInvitationLink(String token, String invitationLinkId) {
    throw UnimplementedError("Get Invitation Link has not been implemented");
  }

  Future<Map> getTransfers(
      String token,
      String? currencyCode,
      String? destination,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Transfers has not been implemented");
  }

  Future<Map> getTransfer(String token, String transferId) {
    throw UnimplementedError("Get Transfer has not been implemented");
  }

  Future<Map> createTransfer(String token, String amount, String currencyCode,
      String destination, String reason, String reference, String requestId) {
    throw UnimplementedError("Create Transfer has not been implemented");
  }

  Future<Map> updateAccountStatus(
      String token, String accountId, String nextStatus, String? force) {
    throw UnimplementedError("Update Account Status has not been implemented");
  }

  Future<Map> createCardTransaction(
      String token,
      String transactionAmount,
      String transactionCurrencyCode,
      String? merchantInfo,
      String? merchantCategoryCode,
      String? cardNumber,
      String? cardId,
      String? authCode) {
    throw UnimplementedError(
        "Create Card Transaction has not been implemented");
  }

  Future<Map> captureTransaction(String token, String transactionId) {
    throw UnimplementedError("Capture Transaction has not been implemented");
  }

  Future<Map> createGlobalAccountDeposit(
      String token,
      String amount,
      String globalAccountId,
      String? payerBank,
      String? payerCountry,
      String? payerName,
      String? reference,
      String? status) {
    throw UnimplementedError(
        "Create GlobalAccount Deposit has not been implemented");
  }

  Future<Map> paymentStatusTransition(
      String token, String paymentId, String? failureType, String nextStatus) {
    throw UnimplementedError(
        "Payment Status Transition has not been implemented");
  }

  Future<Map> getFileDownloadLink(String token, List<String> fileIds) {
    throw UnimplementedError("Get File Download Link has not been implemented");
  }

  Future<Map> uploadFile(
      String token, String environment, String? notes, File file) {
    throw UnimplementedError("Upload File has not been implemented");
  }

  Future<Map> createNotification(
      String token, String deliverType, String sourceId) {
    throw UnimplementedError("Create Notification has not been implemented");
  }

  Future<Map> getIndustryCategories(String token) {
    throw UnimplementedError(
        "Get Industry Catergories has not been implemented");
  }

  Future<Map> getInvalidConversionDates(String token, String currencyPair) {
    throw UnimplementedError(
        "Get Invalid Conversion Dates has not been implemented");
  }

  Future<Map> getSupportedCurrencies(String token) {
    throw UnimplementedError(
        "Get Supported Currencies Dates has not been implemented");
  }

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
      bool termAgreement) {
    throw UnimplementedError("Create Conversion has not been implemented");
  }

  Future<Map> getConversion(String token, String conversionId) {
    throw UnimplementedError("Get Conversion has not been implemented");
  }

  Future<Map> getConversions(
      String token,
      String? buyCurrency,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? sellCurrency,
      String? status,
      String? toCreatedAt) {
    throw UnimplementedError("Get Conversions has not been implemented");
  }

  Future<Map> createLockFXQuote(
      String token,
      String? buyAmount,
      String buyCurrency,
      String? conversionDate,
      String? sellAmount,
      String sellCurrency,
      String validity) {
    throw UnimplementedError("Create LockFX Quote has not been implemented");
  }

  Future<Map> getMarketFxQuote(
      String token,
      String? buyAmount,
      String buyCurrencyCode,
      String sellCurrencyCode,
      String? sellAmount,
      String? conversionDate) {
    throw UnimplementedError("Get Quote has not been implemented");
  }

  Future<Map> quoteAmendment(
      String token,
      String? chargeCurrency,
      String conversionId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) {
    throw UnimplementedError("Quote Amendment has not been implemented");
  }

  Future<Map> createAmendment(
      String token,
      String? chargeCurrency,
      String conversionId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) {
    throw UnimplementedError("Create Amendment has not been implemented");
  }

  Future<Map> getAmendment(String token, String conversionAmendmentId) {
    throw UnimplementedError("Get Amendment has not been implemented");
  }

  Future<Map> getAmendments(String token, String conversionId) {
    throw UnimplementedError("Get Amendments has not been implemented");
  }
}
