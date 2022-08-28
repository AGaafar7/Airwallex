import 'dart:io';

import 'airwallex_platform_interface.dart';

class Airwallex {
  Future<String> initialize(
      bool logging, String environment, List<String> componentProvider) {
    return AirwallexPlatform.instance
        .initialize(logging, environment, componentProvider);
  }

  Future<String> get getBaseUrl {
    return AirwallexPlatform.instance.getBaseUrl;
  }

  Future<String> login(String apiKey, String clientId) {
    return AirwallexPlatform.instance.login(apiKey, clientId);
  }

  Future<List> getBalances(String token) {
    return AirwallexPlatform.instance.getBalances(token);
  }

  Future<Map> checkPaymentStatus(String token, String paymentId) {
    return AirwallexPlatform.instance.checkPaymentStatus(token, paymentId);
  }

  Future<Map> createCard(String token, Map<String, dynamic> cardInfo) {
    return AirwallexPlatform.instance.createCard(token, cardInfo);
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
    return AirwallexPlatform.instance.getOAuthAuthorization(
        token,
        clientId,
        redirectUri,
        responseType,
        scope,
        codeChallenge,
        codeChallengeMethod,
        state);
  }

  Future<Map> exchangeToken(String clientId, String clientSecret, String code,
      String? codeVerifier, String grantType, String redirectUri) {
    return AirwallexPlatform.instance.exchangeToken(
        clientId, clientSecret, code, codeVerifier, grantType, redirectUri);
  }

  Future<Map> refreshToken(String clientId, String clientSecret,
      String grantType, String refreshToken) {
    return AirwallexPlatform.instance
        .refreshToken(clientId, clientSecret, grantType, refreshToken);
  }

  Future<Map> getInvoice(String token, String invoiceId) {
    return AirwallexPlatform.instance.getInvoice(token, invoiceId);
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
    return AirwallexPlatform.instance.getInvoices(
        token,
        customerId,
        fromCreatedAt,
        pageNumber,
        pageSize,
        status,
        subscriptionId,
        toCreatedAt);
  }

  Future<Map> getInvoiceItem(
      String token, String invoiceId, String invoiceItemId) {
    return AirwallexPlatform.instance
        .getInvoiceItem(token, invoiceId, invoiceItemId);
  }

  Future<Map> getInvoiceItems(
      String token, String invoiceId, String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getInvoiceItems(token, invoiceId, pageNumber, pageSize);
  }

  Future<Map> createPrice(String token, Map<String, dynamic> priceInfo) {
    return AirwallexPlatform.instance.createPrice(token, priceInfo);
  }

  Future<Map> getPrice(String token, String priceId) {
    return AirwallexPlatform.instance.getPrice(token, priceId);
  }

  Future<Map> updatePrice(
      String token, String priceId, Map<String, dynamic> priceInfo) {
    return AirwallexPlatform.instance.updatePrice(token, priceId, priceInfo);
  }

  Future<Map> deletePrice(String token, String priceId) {
    return AirwallexPlatform.instance.deletePrice(token, priceId);
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
    return AirwallexPlatform.instance.getPrices(token, active, currencyCode,
        pageNumber, pageSize, productId, recurringPeriod, recurringPeriodUnit);
  }

  Future<Map> createProduct(String token, Map<String, dynamic> productInfo) {
    return AirwallexPlatform.instance.createProduct(token, productInfo);
  }

  Future<Map> getProduct(String token, String productId) {
    return AirwallexPlatform.instance.getProduct(token, productId);
  }

  Future<Map> updateProduct(
      String token, String productId, Map<String, dynamic> newProductInfo) {
    return AirwallexPlatform.instance
        .updateProduct(token, productId, newProductInfo);
  }

  Future<Map> deleteProduct(String token, String productId) {
    return AirwallexPlatform.instance.deleteProduct(token, productId);
  }

  Future<Map> getProducts(
      String token, String? active, String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getProducts(token, active, pageNumber, pageSize);
  }

  Future<Map> createSubscription(String token, Map<String, dynamic> subInfo) {
    return AirwallexPlatform.instance.createSubscription(token, subInfo);
  }

  Future<Map> getSubscription(String token, String subscriptionId) {
    return AirwallexPlatform.instance.getSubscription(token, subscriptionId);
  }

  Future<Map> updateSubscription(
      String token, String subscriptionId, Map<String, dynamic> newSubInfo) {
    return AirwallexPlatform.instance
        .updateSubscription(token, subscriptionId, newSubInfo);
  }

  Future<Map> cancelSubscription(
      String token, String subscriptionId, String prorationBehavior) {
    return AirwallexPlatform.instance
        .cancelSubscription(token, subscriptionId, prorationBehavior);
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
    return AirwallexPlatform.instance.getSubscriptions(
        token,
        customerId,
        fromCreatedAt,
        pageNumber,
        pageSize,
        recurringPeriod,
        recurringPeriodUnit,
        status,
        toCreatedAt);
  }

  Future<Map> getSubscriptionItem(
      String token, String subscriptionId, String itemId) {
    return AirwallexPlatform.instance
        .getSubscriptionItem(token, subscriptionId, itemId);
  }

  Future<Map> getSubscriptionItems(String token, String subscriptionId,
      String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getSubscriptionItems(token, subscriptionId, pageNumber, pageSize);
  }

  Future<Map> createConfirmationLetter(
      String token, String format, String transactionId) {
    return AirwallexPlatform.instance
        .createConfirmationLetter(token, format, transactionId);
  }

  Future<Map> getBalancesHistory(
      String token,
      String? currencyCode,
      String? fromPostAt,
      String? pageNumber,
      String? pageSize,
      String? requestId,
      String? toPostAt) {
    return AirwallexPlatform.instance.getBalancesHistory(token, currencyCode,
        fromPostAt, pageNumber, pageSize, requestId, toPostAt);
  }

  Future<Map> getDeposits(String token, String? fromCreatedAt,
      String? pageNumber, String? pageSize, String? toCreatedAt) {
    return AirwallexPlatform.instance
        .getDeposits(token, fromCreatedAt, pageNumber, pageSize, toCreatedAt);
  }

  Future<Map> getDeposit(String token, String depositId) {
    return AirwallexPlatform.instance.getDeposit(token, depositId);
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
    return AirwallexPlatform.instance.getGlobalAccounts(
        token,
        countryCode,
        currencyCode,
        fromCreatedAt,
        nickname,
        pageNumber,
        pageSize,
        status,
        toCreatedAt);
  }

  Future<Map> getGlobalAccount(String token, String globalAccountId) {
    return AirwallexPlatform.instance.getGlobalAccount(token, globalAccountId);
  }

  Future<Map> createStatementLetter(String token, String globalAccountId,
      Map<String, dynamic> statementInfo) {
    return AirwallexPlatform.instance
        .createStatementLetter(token, globalAccountId, statementInfo);
  }

  Future<Map> getGlobalAccountTransactions(
      String token,
      String globalAccountId,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    return AirwallexPlatform.instance.getGlobalAccountTransactions(token,
        globalAccountId, fromCreatedAt, pageNumber, pageSize, toCreatedAt);
  }

  Future<Map> createGlobalAccount(
      String token,
      String countryCode,
      String currencyCode,
      String nickname,
      List<String> paymentMethods,
      String requestId) {
    return AirwallexPlatform.instance.createGlobalAccount(
        token, countryCode, currencyCode, nickname, paymentMethods, requestId);
  }

  Future<Map> updateGlobalAccount(
      String token, String globalAccountId, String newNickName) {
    return AirwallexPlatform.instance
        .updateGlobalAccount(token, globalAccountId, newNickName);
  }

  Future<Map> getFinancialReports(
      String token, String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getFinancialReports(token, pageNumber, pageSize);
  }

  Future<Map> getFinancialReport(String token, String reportId) {
    return AirwallexPlatform.instance.getFinancialReport(token, reportId);
  }

  Future<Map> getFinancialReportContent(String token, String reportId) {
    return AirwallexPlatform.instance
        .getFinancialReportContent(token, reportId);
  }

  Future<Map> createFinancialReport(
      String token, Map<String, dynamic> financialreportInfo) {
    return AirwallexPlatform.instance
        .createFinancialReport(token, financialreportInfo);
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
    return AirwallexPlatform.instance.getFinancialTransactions(
        token,
        batchId,
        currencyCode,
        fromCreatedAt,
        pageNumber,
        pageSize,
        sourceId,
        status,
        toCreatedAt,
        accountId);
  }

  Future<Map> getFinancialTransaction(
      String token, String financialtransactionId, String accountId) {
    return AirwallexPlatform.instance
        .getFinancialTransaction(token, financialtransactionId, accountId);
  }

  Future<Map> getSettlements(
      String token,
      String currencyCode,
      String fromSettledAt,
      String status,
      String toSettledAt,
      String? pageNumber,
      String? pageSize) {
    return AirwallexPlatform.instance.getSettlements(token, currencyCode,
        fromSettledAt, status, toSettledAt, pageNumber, pageSize);
  }

  Future<Map> getSettlement(String token, String settlementId) {
    return AirwallexPlatform.instance.getSettlement(token, settlementId);
  }

  Future<Map> getSettlementReport(String token, String settlementId) {
    return AirwallexPlatform.instance.getSettlementReport(token, settlementId);
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
    return AirwallexPlatform.instance.getAuthorizationsStatus(
        token,
        billingCurrencyCode,
        cardId,
        fromCreatedAt,
        pageNumber,
        pageSize,
        retrievalRef,
        status,
        toCreatedAt);
  }

  Future<Map> getAuthorizationStatus(String token, String authorizationId) {
    return AirwallexPlatform.instance
        .getAuthorizationStatus(token, authorizationId);
  }

  Future<Map> createCardHolder(
      String token, Map<String, dynamic> cardholderInfo) {
    return AirwallexPlatform.instance.createCardHolder(token, cardholderInfo);
  }

  Future<Map> getCardHolders(String token, String? cardholderStatus,
      String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getCardHolders(token, cardholderStatus, pageNumber, pageSize);
  }

  Future<Map> getCardHolderDetails(String token, String cardholderId) {
    return AirwallexPlatform.instance.getCardHolderDetails(token, cardholderId);
  }

  Future<Map> updateCardHolder(
      String token,
      String cardholderId,
      Map<String, String> address,
      Map<String, dynamic> individual,
      String mobileNumber,
      Map<String, String> postalAddress) {
    return AirwallexPlatform.instance.updateCardHolder(
        token, cardholderId, address, individual, mobileNumber, postalAddress);
  }

  Future<Map> getOnCardDetails(String token, String cardId) {
    return AirwallexPlatform.instance.getOnCardDetails(token, cardId);
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
    return AirwallexPlatform.instance.getCards(token, cardStatus, cardholderId,
        fromCreatedAt, nickname, pageNumber, pageSize, toCreatedAt);
  }

  Future<Map> activateCard(String token, String cardId) {
    return AirwallexPlatform.instance.activateCard(token, cardId);
  }

  Future<Map> getCardDetails(String token, String cardId) {
    return AirwallexPlatform.instance.getCardDetails(token, cardId);
  }

  Future<Map> getCardLimits(String token, String cardId) {
    return AirwallexPlatform.instance.getCardLimits(token, cardId);
  }

  Future<Map> updateCard(
      String token,
      String cardId,
      Map<String, dynamic> authorizationControls,
      String cardStatus,
      String nickname,
      Map<String, String> primaryContactDetails,
      String purpose) {
    return AirwallexPlatform.instance.updateCard(
        token,
        cardId,
        authorizationControls,
        cardStatus,
        nickname,
        primaryContactDetails,
        purpose);
  }

  Future<Map> getConfig(String token) {
    return AirwallexPlatform.instance.getConfig(token);
  }

  Future<Map> updateConfig(String token, Map<String, dynamic> remoteAuth) {
    return AirwallexPlatform.instance.updateConfig(token, remoteAuth);
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
    return AirwallexPlatform.instance.getTransactions(
        token,
        billingCurrencyCode,
        cardId,
        fromCreatedAt,
        pageNumber,
        pageSize,
        retrievalRef,
        toCreatedAt,
        transactionType);
  }

  Future<Map> getTransaction(String token, String transactionId) {
    return AirwallexPlatform.instance.getTransaction(token, transactionId);
  }

  Future<Map> getConfigPaymentMethodTypes(
      String token,
      String? active,
      String? countryCode,
      String? pageNumber,
      String? pageSize,
      String? transactionCurrency,
      String? transactionMode) {
    return AirwallexPlatform.instance.getConfigPaymentMethodTypes(
        token,
        active,
        countryCode,
        pageNumber,
        pageSize,
        transactionCurrency,
        transactionMode);
  }

  Future<Map> getAvailableBanks(String token, String paymentMethodType,
      String? countryCode, String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance.getAvailableBanks(
        token, paymentMethodType, countryCode, pageNumber, pageSize);
  }

  Future<Map> getAvailableMandatesDetails(String token, String? pageNumber,
      String? pageSize, String? paymentMethodType, String? version) {
    return AirwallexPlatform.instance.getAvailableMandatesDetails(
        token, pageNumber, pageSize, paymentMethodType, version);
  }

  Future<Map> createCustomer(String token, Map<String, dynamic> customerInfo) {
    return AirwallexPlatform.instance.createCustomer(token, customerInfo);
  }

  Future<Map> getCustomer(String token, String customerId) {
    return AirwallexPlatform.instance.getCustomer(token, customerId);
  }

  Future<Map> updateCustomer(
      String token, String customerId, Map<String, dynamic> newCustomerInfo) {
    return AirwallexPlatform.instance
        .updateCustomer(token, customerId, newCustomerInfo);
  }

  Future<String> createClientSecretForCustomer(
      String token, String customerId) {
    return AirwallexPlatform.instance
        .createClientSecretForCustomer(token, customerId);
  }

  Future<Map> getCustomers(
      String token,
      String? fromCreatedAt,
      String? merchantCustomerId,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    return AirwallexPlatform.instance.getCustomers(token, fromCreatedAt,
        merchantCustomerId, pageNumber, pageSize, toCreatedAt);
  }

  Future<Map> createCustomsDeclaration(
      String token, Map<String, dynamic> customsDeclarationInfo) {
    return AirwallexPlatform.instance
        .createCustomsDeclaration(token, customsDeclarationInfo);
  }

  Future<Map> updateCustomsDeclaration(
      String token,
      String customsDeclarationId,
      Map<String, dynamic> customsDeclarationInfo) {
    return AirwallexPlatform.instance.updateCustomsDeclaration(
        token, customsDeclarationId, customsDeclarationInfo);
  }

  Future<Map> redeclareCustomsDeclaration(
      String token, String customsDeclarationId, String requestId) {
    return AirwallexPlatform.instance
        .redeclareCustomsDeclaration(token, customsDeclarationId, requestId);
  }

  Future<Map> getCustomsDeclaration(String token, String customsDeclarationId) {
    return AirwallexPlatform.instance
        .getCustomsDeclaration(token, customsDeclarationId);
  }

  Future<Map> createFundsSplitReversal(
      String token, Map<String, dynamic> fundsSplitReversalInfo) {
    return AirwallexPlatform.instance
        .createFundsSplitReversal(token, fundsSplitReversalInfo);
  }

  Future<Map> getFundsSplitReversal(String token, String fundsSplitReversalId) {
    return AirwallexPlatform.instance
        .getFundsSplitReversal(token, fundsSplitReversalId);
  }

  Future<Map> getFundsSplitReversals(
      String token, String fundsSplitId, String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getFundsSplitReversals(token, fundsSplitId, pageNumber, pageSize);
  }

  Future<Map> createFundsSplit(
      String token, Map<String, dynamic> fundsSplitInfo) {
    return AirwallexPlatform.instance.createFundsSplit(token, fundsSplitInfo);
  }

  Future<Map> getFundsSplit(String token, String fundsSplitId) {
    return AirwallexPlatform.instance.getFundsSplit(token, fundsSplitId);
  }

  Future<Map> getAllFundsSplit(String token, String sourceId, String sourceType,
      String? pageNumber, String? pageSize) {
    return AirwallexPlatform.instance
        .getAllFundsSplit(token, sourceId, sourceType, pageNumber, pageSize);
  }

  Future<Map> releaseFundsSplit(
      String token, String fundsSplitId, String requestId) {
    return AirwallexPlatform.instance
        .releaseFundsSplit(token, fundsSplitId, requestId);
  }

  Future<Map> getPaymentAttempt(String token, String paymentAttemptId) {
    return AirwallexPlatform.instance
        .getPaymentAttempt(token, paymentAttemptId);
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
    return AirwallexPlatform.instance.getPaymentAttempts(
        token,
        currencyCode,
        fromCreatedAt,
        pageNumber,
        pageSize,
        paymentIntentId,
        status,
        toCreatedAt);
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
    return AirwallexPlatform.instance.createPaymentConsent(
        token,
        connectedAccountId,
        customerId,
        merchantTriggerReason,
        metadata,
        nextTriggerReason,
        paymentMethod,
        requestId,
        requiresCVC);
  }

  Future<Map> updatePaymentConsent(
      String token,
      String paymentConsentId,
      Map<String, dynamic>? metadata,
      Map<String, dynamic>? paymentMethod,
      String requestId) {
    return AirwallexPlatform.instance.updatePaymentConsent(
        token, paymentConsentId, metadata, paymentMethod, requestId);
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
    return AirwallexPlatform.instance.verifyPaymentConsent(
        token,
        paymentConsentId,
        descriptor,
        deviceData,
        requestId,
        returnUrl,
        riskControlOptions,
        verificationOptions);
  }

  Future<Map> disablePaymentConsent(
      String token, String paymentConsentId, String requestId) {
    return AirwallexPlatform.instance
        .disablePaymentConsent(token, paymentConsentId, requestId);
  }

  Future<Map> getPaymentConsent(String token, String paymentConsentId) {
    return AirwallexPlatform.instance
        .getPaymentConsent(token, paymentConsentId);
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
    return AirwallexPlatform.instance.getPaymentConsents(
        token,
        customerId,
        fromCreatedAt,
        merchantTriggerReason,
        nextTriggerBy,
        pageNumber,
        pageSize,
        status,
        toCreatedAt);
  }

  Future<Map> createPaymentIntent(
      String token, Map<String, dynamic> paymentIntentInfo) {
    return AirwallexPlatform.instance
        .createPaymentIntent(token, paymentIntentInfo);
  }

  Future<Map> getPaymentIntent(String token, String paymentIntentId) {
    return AirwallexPlatform.instance.getPaymentIntent(token, paymentIntentId);
  }

  Future<Map> confirmPaymentIntent(String token, String paymentIntentId,
      Map<String, dynamic> paymentIntentInfo) {
    return AirwallexPlatform.instance
        .confirmPaymentIntent(token, paymentIntentId, paymentIntentInfo);
  }

  Future<Map> continueConfirmPaymentIntent(String token, String paymentIntentId,
      Map<String, dynamic> paymentIntentInfo) {
    return AirwallexPlatform.instance.continueConfirmPaymentIntent(
        token, paymentIntentId, paymentIntentInfo);
  }

  Future<Map> capturePaymentIntent(
      String token, String paymentIntentId, String requestId, num amount) {
    return AirwallexPlatform.instance
        .capturePaymentIntent(token, paymentIntentId, requestId, amount);
  }

  Future<Map> cancelPaymentIntent(String token, String paymentIntentId,
      String? cancellationReason, String requestId) {
    return AirwallexPlatform.instance.cancelPaymentIntent(
        token, paymentIntentId, cancellationReason, requestId);
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
    return AirwallexPlatform.instance.getPaymentIntents(
        token,
        currencyCode,
        fromCreatedAt,
        merchantOrderId,
        pageNumber,
        pageSize,
        paymentConsentId,
        status,
        toCreatedAt);
  }

  Future<Map> createPaymentLink(
      String token, Map<String, dynamic> paymentLinkInfo) {
    return AirwallexPlatform.instance.createPaymentLink(token, paymentLinkInfo);
  }

  Future<Map> updatePaymentLink(String token, String paymentLinkId,
      String title, String description, String reference) {
    return AirwallexPlatform.instance
        .updatePaymentLink(token, paymentLinkId, title, description, reference);
  }

  Future<Map> getPaymentLink(String token, String paymentLinkId) {
    return AirwallexPlatform.instance.getPaymentLink(token, paymentLinkId);
  }

  Future<String> sendPaymentLink(
      String token, String paymentLinkId, String shopperEmail) {
    return AirwallexPlatform.instance
        .sendPaymentLink(token, paymentLinkId, shopperEmail);
  }

  Future<Map> activatePaymentLink(String token, String paymentLinkId) {
    return AirwallexPlatform.instance.activatePaymentLink(token, paymentLinkId);
  }

  Future<Map> deactivatePaymentLink(String token, String paymentLinkId) {
    return AirwallexPlatform.instance
        .deactivatePaymentLink(token, paymentLinkId);
  }

  Future<String> deletePaymentLink(String token, String paymentLinkId) {
    return AirwallexPlatform.instance.deletePaymentLink(token, paymentLinkId);
  }

  Future<Map> getPaymentLinks(
      String token,
      String? active,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? reusable,
      String? toCreatedAt) {
    return AirwallexPlatform.instance.getPaymentLinks(token, active,
        fromCreatedAt, pageNumber, pageSize, reusable, toCreatedAt);
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
    return AirwallexPlatform.instance.createPaymentMethod(token, applepay, card,
        googlepay, customerId, metadata, requestId, type);
  }

  Future<Map> getPaymentMethod(String token, String paymentMethodId) {
    return AirwallexPlatform.instance.getPaymentMethod(token, paymentMethodId);
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
    return AirwallexPlatform.instance.getPaymentMethods(token, customerId,
        fromCreatedAt, pageNumber, pageSize, status, toCreatedAt, type);
  }

  Future<Map> disablePaymentMethod(
      String token, String paymentMethodId, String requestId) {
    return AirwallexPlatform.instance
        .disablePaymentMethod(token, paymentMethodId, requestId);
  }

  Future<Map> createQuote(String token, String paymentCurrencyCode,
      String settlementCurrencyCode, String type) {
    return AirwallexPlatform.instance
        .createQuote(token, paymentCurrencyCode, settlementCurrencyCode, type);
  }

  Future<Map> getQuote(String token, String quoteId) {
    return AirwallexPlatform.instance.getQuote(token, quoteId);
  }

  Future<Map> getQuotes(
      String token,
      String paymentCurrencyCode,
      String settlementCurrencyCode,
      String? fromCreatedAt,
      String? pageNumber,
      String? pageSize,
      String? toCreatedAt) {
    return AirwallexPlatform.instance.getQuotes(
        token,
        paymentCurrencyCode,
        settlementCurrencyCode,
        fromCreatedAt,
        pageNumber,
        pageSize,
        toCreatedAt);
  }

  Future<List> getBINInfo(String token, String bin) {
    return AirwallexPlatform.instance.getBINInfo(token, bin);
  }

  Future<Map> createRefund(
      String token,
      String? amount,
      Map<String, dynamic>? metadata,
      String? paymentAttemptId,
      String? paymentIntentId,
      String? reason,
      String requestId) {
    return AirwallexPlatform.instance.createRefund(token, amount, metadata,
        paymentAttemptId, paymentIntentId, reason, requestId);
  }

  Future<Map> getRefund(String token, String refundId) {
    return AirwallexPlatform.instance.getRefund(token, refundId);
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
    return AirwallexPlatform.instance.getRefunds(
        token,
        currencyCode,
        fromCreatedAt,
        pageNumber,
        pageSize,
        paymentAttemptId,
        paymentIntentId,
        status,
        toCreatedAt);
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
    return AirwallexPlatform.instance.getBeneficiaries(
        token,
        bankAccountNumber,
        companyName,
        entityType,
        fromDate,
        name,
        nickname,
        pageNumber,
        pageSize,
        toDate);
  }

  Future<Map> getBeneficiary(String token, String beneficiaryId) {
    return AirwallexPlatform.instance.getBeneficiary(token, beneficiaryId);
  }

  Future<Map> createBeneficiary(
      String token, Map<String, dynamic> beneficiaryInfo) {
    return AirwallexPlatform.instance.createBeneficiary(token, beneficiaryInfo);
  }

  Future<bool> deleteBeneficiary(String token, String beneficiaryId) {
    return AirwallexPlatform.instance.deleteBeneficiary(token, beneficiaryId);
  }

  Future<Map> updateBeneficiary(String token, String beneficiaryId,
      Map<String, dynamic> newBeneficiaryInfo) {
    return AirwallexPlatform.instance
        .updateBeneficiary(token, beneficiaryId, newBeneficiaryInfo);
  }

  Future<Map> validateBeneficiary(
      String token, Map<String, dynamic> beneficiaryInfo) {
    return AirwallexPlatform.instance
        .validateBeneficiary(token, beneficiaryInfo);
  }

  Future<Map> getBeneficiaryApiSchema(
      String token,
      String? bankCountryCode,
      String? accountCurrency,
      String? paymentMethod,
      String? localClearingSystem,
      String? entityType) {
    return AirwallexPlatform.instance.getBeneficiaryApiSchema(
        token,
        bankCountryCode,
        accountCurrency,
        paymentMethod,
        localClearingSystem,
        entityType);
  }

  Future<Map> getBeneficiaryFormSchema(
      String token,
      String? bankCountryCode,
      String? accountCurrency,
      String? paymentMethod,
      String? localClearingSystem,
      String? entityType) {
    return AirwallexPlatform.instance.getBeneficiaryFormSchema(
        token,
        bankCountryCode,
        accountCurrency,
        paymentMethod,
        localClearingSystem,
        entityType);
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
    return AirwallexPlatform.instance.getPayments(
        token,
        fromCreatedAt,
        pageNumber,
        pageSize,
        paymentCurrency,
        requestId,
        shortReferrenceId,
        status,
        toCreatedAt);
  }

  Future<Map> getPayment(String token, String paymentId) {
    return AirwallexPlatform.instance.getPayment(token, paymentId);
  }

  Future<Map> cancelPayment(String token, String paymentId) {
    return AirwallexPlatform.instance.cancelPayment(token, paymentId);
  }

  Future<Map> createPayment(String token, Map<String, dynamic> paymentInfo) {
    return AirwallexPlatform.instance.createPayment(token, paymentInfo);
  }

  Future<Map> retryPayment(
      String token, String paymentId, Map<String, dynamic> paymentInfo) {
    return AirwallexPlatform.instance
        .retryPayment(token, paymentId, paymentInfo);
  }

  Future<Map> updatePayment(
      String token, String paymentId, Map<String, dynamic> newpaymentInfo) {
    return AirwallexPlatform.instance
        .updatePayment(token, paymentId, newpaymentInfo);
  }

  Future<Map> validatePayment(String token, Map<String, dynamic> paymentInfo) {
    return AirwallexPlatform.instance.validatePayment(token, paymentInfo);
  }

  Future<Map> createAccount(String token, Map<String, dynamic> accountInfo) {
    return AirwallexPlatform.instance.createAccount(token, accountInfo);
  }

  Future<Map> updateConnectedAccount(
      String token, String accountId, Map<String, dynamic> accountInfo) {
    return AirwallexPlatform.instance
        .updateConnectedAccount(token, accountId, accountInfo);
  }

  Future<Map> submitAccount(String token, String accountId) {
    return AirwallexPlatform.instance.submitAccount(token, accountId);
  }

  Future<Map> getAccount(String token, String accountId) {
    return AirwallexPlatform.instance.getAccount(token, accountId);
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
    return AirwallexPlatform.instance.getAccounts(token, accountStatus, email,
        fromCreatedAt, identifier, metadata, pageNumber, pageSize, toCreatedAt);
  }

  Future<Map> getYourAccount(String token) {
    return AirwallexPlatform.instance.getYourAccount(token);
  }

  Future<Map> agreement(String token, String accountId) {
    return AirwallexPlatform.instance.agreement(token, accountId);
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
    return AirwallexPlatform.instance.getCharges(
        token,
        currencyCode,
        fromCreatedAt,
        pageNumber,
        pageSize,
        requestId,
        source,
        status,
        toCreatedAt);
  }

  Future<Map> getCharge(String token, String chargeId) {
    return AirwallexPlatform.instance.getCharge(token, chargeId);
  }

  Future<Map> createCharge(String token, String amount, String currencyCode,
      String reason, String reference, String requestId, String source) {
    return AirwallexPlatform.instance.createCharge(
        token, amount, currencyCode, reason, reference, requestId, source);
  }

  Future<Map> createInvitationLink(
      String token, Map<String, dynamic> invitationLinkInfo) {
    return AirwallexPlatform.instance
        .createInvitationLink(token, invitationLinkInfo);
  }

  Future<Map> getInvitationLink(String token, String invitationLinkId) {
    return AirwallexPlatform.instance
        .getInvitationLink(token, invitationLinkId);
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
    return AirwallexPlatform.instance.getTransfers(
        token,
        currencyCode,
        destination,
        fromCreatedAt,
        pageNumber,
        pageSize,
        requestId,
        status,
        toCreatedAt);
  }

  Future<Map> getTransfer(String token, String transferId) {
    return AirwallexPlatform.instance.getTransfer(token, transferId);
  }

  Future<Map> createTransfer(String token, String amount, String currencyCode,
      String destination, String reason, String reference, String requestId) {
    return AirwallexPlatform.instance.createTransfer(
        token, amount, currencyCode, destination, reason, reference, requestId);
  }

  Future<Map> updateAccountStatus(
      String token, String accountId, String nextStatus, String? force) {
    return AirwallexPlatform.instance
        .updateAccountStatus(token, accountId, nextStatus, force);
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
    return AirwallexPlatform.instance.createCardTransaction(
        token,
        transactionAmount,
        transactionCurrencyCode,
        merchantInfo,
        merchantCategoryCode,
        cardNumber,
        cardId,
        authCode);
  }

  Future<Map> captureTransaction(String token, String transactionId) {
    return AirwallexPlatform.instance.captureTransaction(token, transactionId);
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
    return AirwallexPlatform.instance.createGlobalAccountDeposit(token, amount,
        globalAccountId, payerBank, payerCountry, payerName, reference, status);
  }

  Future<Map> paymentStatusTransition(
      String token, String paymentId, String? failureType, String nextStatus) {
    return AirwallexPlatform.instance
        .paymentStatusTransition(token, paymentId, failureType, nextStatus);
  }

  Future<Map> getFileDownloadLink(String token, List<String> fileIds) {
    return AirwallexPlatform.instance.getFileDownloadLink(token, fileIds);
  }

  Future<Map> uploadFile(
      String token, String environment, String? notes, File file) {
    return AirwallexPlatform.instance
        .uploadFile(token, environment, notes, file);
  }

  Future<Map> createNotification(
      String token, String deliverType, String sourceId) {
    return AirwallexPlatform.instance
        .createNotification(token, deliverType, sourceId);
  }

  Future<Map> getIndustryCategories(String token) {
    return AirwallexPlatform.instance.getIndustryCategories(token);
  }

  Future<Map> getInvalidConversionDates(String token, String currencyPair) {
    return AirwallexPlatform.instance
        .getInvalidConversionDates(token, currencyPair);
  }

  Future<Map> getSupportedCurrencies(String token) {
    return AirwallexPlatform.instance.getSupportedCurrencies(token);
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
    return AirwallexPlatform.instance.createConversion(
        token,
        buyAmount,
        buyCurrency,
        conversionDate,
        quoteId,
        reason,
        requestId,
        sellAmount,
        sellCurrency,
        termAgreement);
  }

  Future<Map> getConversion(String token, String conversionId) {
    return AirwallexPlatform.instance.getConversion(token, conversionId);
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
    return AirwallexPlatform.instance.getConversions(
        token,
        buyCurrency,
        fromCreatedAt,
        pageNumber,
        pageSize,
        requestId,
        sellCurrency,
        status,
        toCreatedAt);
  }

  Future<Map> createLockFXQuote(
      String token,
      String? buyAmount,
      String buyCurrency,
      String? conversionDate,
      String? sellAmount,
      String sellCurrency,
      String validity) {
    return AirwallexPlatform.instance.createLockFXQuote(token, buyAmount,
        buyCurrency, conversionDate, sellAmount, sellCurrency, validity);
  }

  Future<Map> getMarketFxQuote(
      String token,
      String? buyAmount,
      String buyCurrencyCode,
      String sellCurrencyCode,
      String? sellAmount,
      String? conversionDate) {
    return AirwallexPlatform.instance.getMarketFxQuote(token, buyAmount,
        buyCurrencyCode, sellCurrencyCode, sellAmount, conversionDate);
  }

  Future<Map> quoteAmendment(
      String token,
      String? chargeCurrency,
      String conversionId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) {
    return AirwallexPlatform.instance.quoteAmendment(
        token, chargeCurrency, conversionId, metadata, requestId, type);
  }

  Future<Map> createAmendment(
      String token,
      String? chargeCurrency,
      String conversionId,
      Map<String, dynamic>? metadata,
      String requestId,
      String type) {
    return AirwallexPlatform.instance.createAmendment(
        token, chargeCurrency, conversionId, metadata, requestId, type);
  }

  Future<Map> getAmendment(String token, String conversionAmendmentId) {
    return AirwallexPlatform.instance
        .getAmendment(token, conversionAmendmentId);
  }

  Future<Map> getAmendments(String token, String conversionId) {
    return AirwallexPlatform.instance.getAmendments(token, conversionId);
  }
}
