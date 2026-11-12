import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/helper/type_converter_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';

class ConfigModel {
  String? businessName;
  String? logoFullUrl;
  String? address;
  String? phone;
  String? email;
  String? country;
  DefaultLocation? defaultLocation;
  String? currencySymbol;
  String? currencySymbolDirection;
  double? appMinimumVersionAndroid;
  String? appUrlAndroid;
  double? appMinimumVersionIos;
  String? appUrlIos;
  bool? customerVerification;
  bool? scheduleOrder;
  bool? orderDeliveryVerification;
  bool? cashOnDelivery;
  bool? digitalPayment;
  double? perKmShippingCharge;
  double? minimumShippingCharge;
  bool? demo;
  bool? maintenanceMode;
  String? orderConfirmationModel;
  bool? showDmEarning;
  bool? canceledByDeliveryman;
  String? timeformat;
  List<Language>? language;
  bool? toggleVegNonVeg;
  bool? toggleDmRegistration;
  bool? toggleRiderRegistration;
  bool? toggleStoreRegistration;
  int? scheduleOrderSlotDuration;
  int? digitAfterDecimalPoint;
  double? parcelPerKmShippingCharge;
  double? parcelMinimumShippingCharge;
  ModuleModel? module;
  ModuleConfig? moduleConfig;
  LandingPageSettings? landingPageSettings;
  List<SocialMedia>? socialMedia;
  String? footerText;
  DownloadUserAppLinks? downloadUserAppLinks;
  int? loyaltyPointExchangeRate;
  double? loyaltyPointItemPurchasePoint;
  int? loyaltyPointStatus;
  int? minimumPointToTransfer;
  int? customerWalletStatus;
  int? dmTipsStatus;
  int? refEarningStatus;
  double? refEarningExchangeRate;
  List<SocialLogin>? socialLogin;
  List<SocialLogin>? appleLogin;
  bool? refundActiveStatus;
  int? refundPolicyStatus;
  int? cancellationPolicyStatus;
  int? shippingPolicyStatus;
  bool? prescriptionStatus;
  String? cookiesText;
  int? homeDeliveryStatus;
  int? takeawayStatus;
  bool? partialPaymentStatus;
  String? partialPaymentMethod;
  bool? additionalChargeStatus;
  String? additionalChargeName;
  double? additionCharge;
  List<PaymentBody>? activePaymentMethodList;
  DigitalPaymentInfo? digitalPaymentInfo;
  ValidationConfig? validationConfig;
  bool? addFundStatus;
  bool? offlinePaymentStatus;
  bool? guestCheckoutStatus;
  double? adminCommission;
  int? subscriptionFreeTrialDays;
  bool? subscriptionFreeTrialStatus;
  int? subscriptionBusinessModel;
  int? commissionBusinessModel;
  String? subscriptionFreeTrialType;
  bool? countryPickerStatus;
  bool? firebaseOtpVerification;
  CentralizeLoginSetup? centralizeLoginSetup;
  double? vehicleDistanceMinPrice;
  double? vehicleHourlyMinPrice;
  double? vehicleDayWiseMinPrice;
  AdminFreeDelivery? adminFreeDelivery;
  bool? isSmsActive;
  bool? isMailActive;
  int? parcelCancellationStatus;
  ParcelCancellationBasicSetup? parcelCancellationBasicSetup;
  ParcelReturnTimeFee? parcelReturnTimeFee;
  bool? websocketEnabled;
  String? websocketUrl;

  bool? safetyFeatureStatus;
  int? safetyFeatureMinimumTripDelayTime;
  String? safetyFeatureMinimumTripDelayTimeType;
  bool? afterTripCompleteSafetyFeatureActiveStatus;
  int? afterTripCompleteSafetyFeatureSetTime;
  String? afterTripCompleteSafetyFeatureSetTimeFormat;
  String? safetyFeatureEmergencyGovtNumber;
  bool? reviewStatus;
  int? popularTips;
  double? searchRadius;
  bool? otpConfirmationForTrip;
  double? minBookingAmount;
  double? maxBookingAmount;
  int? scheduleBooking;
  int? directProviderBooking;
  int? serviceAtProviderLocation;
  int? repeatBooking;
  int? instantBooking;
  // int? scheduleBookingTimeRestriction;
  AdvanceBooking? advanceBooking;
  bool? confirmationOtpStatus;
  int? bidingStatus;
  int? referralEarningStatus;
  double? completionRadius;
  bool? webSocketStatus;
  String? webSocketUri;
  int? webSocketPort;
  String? webSocketKey;
  String? webSocketScheme;
  ReferralData? dmReferralData;
  ReferralData? riderReferralData;
  int? customerRoutePreference;
  int? repeatOrderOption;
  int? monthlyOrderRemainder;
  MaintenanceModeData? maintenanceModeData;
  bool? proMemberStatus;
  bool? aiChatStatus;
  int? systemTaxIncludeStatus;

  ConfigModel({
    this.businessName,
    this.logoFullUrl,
    this.address,
    this.phone,
    this.email,
    this.country,
    this.defaultLocation,
    this.currencySymbol,
    this.currencySymbolDirection,
    this.appMinimumVersionAndroid,
    this.appUrlAndroid,
    this.appMinimumVersionIos,
    this.appUrlIos,
    this.customerVerification,
    this.scheduleOrder,
    this.orderDeliveryVerification,
    this.cashOnDelivery,
    this.digitalPayment,
    this.perKmShippingCharge,
    this.minimumShippingCharge,
    this.demo,
    this.maintenanceMode,
    this.orderConfirmationModel,
    this.showDmEarning,
    this.canceledByDeliveryman,
    this.timeformat,
    this.language,
    this.toggleVegNonVeg,
    this.toggleDmRegistration,
    this.toggleRiderRegistration,
    this.toggleStoreRegistration,
    this.scheduleOrderSlotDuration,
    this.digitAfterDecimalPoint,
    this.module,
    this.moduleConfig,
    this.parcelPerKmShippingCharge,
    this.parcelMinimumShippingCharge,
    this.landingPageSettings,
    this.socialMedia,
    this.footerText,
    this.downloadUserAppLinks,
    this.loyaltyPointExchangeRate,
    this.loyaltyPointItemPurchasePoint,
    this.loyaltyPointStatus,
    this.minimumPointToTransfer,
    this.customerWalletStatus,
    this.dmTipsStatus,
    this.refEarningStatus,
    this.refEarningExchangeRate,
    this.socialLogin,
    this.appleLogin,
    this.refundActiveStatus,
    this.refundPolicyStatus,
    this.cancellationPolicyStatus,
    this.shippingPolicyStatus,
    this.prescriptionStatus,
    this.cookiesText,
    this.homeDeliveryStatus,
    this.takeawayStatus,
    this.partialPaymentStatus,
    this.partialPaymentMethod,
    this.additionalChargeStatus,
    this.additionalChargeName,
    this.additionCharge,
    this.activePaymentMethodList,
    this.digitalPaymentInfo,
    this.validationConfig,
    this.addFundStatus,
    this.offlinePaymentStatus,
    this.guestCheckoutStatus,
    this.subscriptionFreeTrialDays,
    this.subscriptionFreeTrialStatus,
    this.subscriptionBusinessModel,
    this.commissionBusinessModel,
    this.subscriptionFreeTrialType,
    this.countryPickerStatus,
    this.firebaseOtpVerification,
    this.centralizeLoginSetup,
    this.vehicleDistanceMinPrice,
    this.vehicleHourlyMinPrice,
    this.vehicleDayWiseMinPrice,
    this.adminFreeDelivery,
    this.isSmsActive,
    this.isMailActive,
    this.parcelCancellationStatus,
    this.parcelCancellationBasicSetup,
    this.parcelReturnTimeFee,
    this.websocketEnabled,
    this.websocketUrl,
    this.afterTripCompleteSafetyFeatureActiveStatus,
    this.afterTripCompleteSafetyFeatureSetTime,
    this.afterTripCompleteSafetyFeatureSetTimeFormat,
    this.safetyFeatureEmergencyGovtNumber,
    this.safetyFeatureMinimumTripDelayTime,
    this.safetyFeatureMinimumTripDelayTimeType,
    this.safetyFeatureStatus,
    this.reviewStatus,
    this.popularTips,
    this.searchRadius,
    this.otpConfirmationForTrip,
    this.minBookingAmount,
    this.maxBookingAmount,
    this.scheduleBooking,
    this.directProviderBooking,
    this.serviceAtProviderLocation,
    this.repeatBooking,
    this.instantBooking,
    // this.scheduleBookingTimeRestriction,
    this.advanceBooking,
    this.confirmationOtpStatus,
    this.bidingStatus,
    this.referralEarningStatus,
    this.completionRadius,
    this.webSocketUri,
    this.webSocketPort,
    this.webSocketKey,
    this.webSocketStatus,
    this.webSocketScheme,
    this.dmReferralData,
    this.riderReferralData,
    this.customerRoutePreference,
    this.repeatOrderOption,
    this.monthlyOrderRemainder,
    this.maintenanceModeData,
    this.proMemberStatus,
    this.aiChatStatus,
    this.systemTaxIncludeStatus,
  });

  ConfigModel.fromJson(Map<String, dynamic> json) {
    businessName = TypeConverterHelper.getNullableString(json['business_name']);
    logoFullUrl = TypeConverterHelper.getNullableString(json['logo_full_url']);
    address = TypeConverterHelper.getNullableString(json['address']);
    phone = TypeConverterHelper.getNullableString(json['phone']);
    email = TypeConverterHelper.getNullableString(json['email']);
    country = 'KW';
    defaultLocation = json['default_location'] is Map<String, dynamic>
        ? DefaultLocation.fromJson(json['default_location'])
        : DefaultLocation(lat: AppConstants.defaultLatitude, lng: AppConstants.defaultLongitude);
    if (defaultLocation?.lat == null || defaultLocation?.lng == null || (defaultLocation!.lat!.startsWith('25.') && defaultLocation!.lng!.startsWith('55.'))) {
      defaultLocation = DefaultLocation(lat: AppConstants.defaultLatitude, lng: AppConstants.defaultLongitude);
    }
    currencySymbol = TypeConverterHelper.getNullableString(json['currency_symbol']);
    currencySymbolDirection = TypeConverterHelper.getNullableString(json['currency_symbol_direction']);
    appMinimumVersionAndroid = TypeConverterHelper.getNullableDouble(json['app_minimum_version_android']) ?? 0.0;
    appUrlAndroid = TypeConverterHelper.getNullableString(json['app_url_android']);
    appMinimumVersionIos = TypeConverterHelper.getNullableDouble(json['app_minimum_version_ios']) ?? 0.0;
    appUrlIos = TypeConverterHelper.getNullableString(json['app_url_ios']);
    customerVerification = TypeConverterHelper.getNullableBool(json['customer_verification']);
    scheduleOrder = TypeConverterHelper.getNullableBool(json['schedule_order']);
    orderDeliveryVerification = TypeConverterHelper.getNullableBool(json['order_delivery_verification']);
    cashOnDelivery = TypeConverterHelper.getNullableBool(json['cash_on_delivery']);
    digitalPayment = TypeConverterHelper.getNullableBool(json['digital_payment']);
    perKmShippingCharge = TypeConverterHelper.getNullableDouble(json['per_km_shipping_charge']);
    minimumShippingCharge = TypeConverterHelper.getNullableDouble(json['minimum_shipping_charge']);
    demo = TypeConverterHelper.getNullableBool(json['demo']);
    maintenanceMode = TypeConverterHelper.getNullableBool(json['maintenance_mode']);
    orderConfirmationModel = TypeConverterHelper.getNullableString(json['order_confirmation_model']);
    showDmEarning = TypeConverterHelper.getNullableBool(json['show_dm_earning']);
    canceledByDeliveryman = TypeConverterHelper.getNullableBool(json['canceled_by_deliveryman']);
    timeformat = TypeConverterHelper.getNullableString(json['timeformat']);
    if (json['language'] is List) {
      language = <Language>[];
      for (final dynamic v in json['language'] as List) {
        if (v is Map<String, dynamic>) {
          language!.add(Language.fromJson(v));
        }
      }
    }
    toggleVegNonVeg = TypeConverterHelper.getNullableBool(json['toggle_veg_non_veg']);
    toggleDmRegistration = TypeConverterHelper.getNullableBool(json['toggle_dm_registration']);
    toggleRiderRegistration = TypeConverterHelper.getNullableBool(json['toggle_rider_registration']);
    toggleStoreRegistration = TypeConverterHelper.getNullableBool(json['toggle_store_registration']);
    final int? rawSlotDuration = TypeConverterHelper.getNullableInt(json['schedule_order_slot_duration']);
    scheduleOrderSlotDuration = rawSlotDuration == 0 ? 30 : rawSlotDuration;
    digitAfterDecimalPoint = TypeConverterHelper.getNullableInt(json['digit_after_decimal_point']);
    module = json['module'] is Map<String, dynamic> ? ModuleModel.fromJson(json['module']) : null;
    moduleConfig = json['module_config'] is Map<String, dynamic> ? ModuleConfig.fromJson(json['module_config']) : null;
    parcelPerKmShippingCharge = TypeConverterHelper.getNullableDouble(json['parcel_per_km_shipping_charge']);
    parcelMinimumShippingCharge = TypeConverterHelper.getNullableDouble(json['parcel_minimum_shipping_charge']);
    landingPageSettings = json['landing_page_settings'] is Map<String, dynamic> ? LandingPageSettings.fromJson(json['landing_page_settings']) : null;
    if (json['social_media'] is List) {
      socialMedia = <SocialMedia>[];
      for (final dynamic v in json['social_media'] as List) {
        if (v is Map<String, dynamic>) {
          socialMedia!.add(SocialMedia.fromJson(v));
        }
      }
    }
    footerText = TypeConverterHelper.getNullableString(json['footer_text']);
    downloadUserAppLinks = json['download_user_app_links'] is Map<String, dynamic> ? DownloadUserAppLinks.fromJson(json['download_user_app_links']) : null;
    loyaltyPointExchangeRate = TypeConverterHelper.getNullableInt(json['loyalty_point_exchange_rate']);
    loyaltyPointItemPurchasePoint = TypeConverterHelper.getNullableDouble(json['loyalty_point_item_purchase_point']);
    loyaltyPointStatus = TypeConverterHelper.getNullableInt(json['loyalty_point_status']);
    minimumPointToTransfer = TypeConverterHelper.getNullableInt(json['loyalty_point_minimum_point']);
    customerWalletStatus = TypeConverterHelper.getNullableInt(json['customer_wallet_status']);
    dmTipsStatus = TypeConverterHelper.getNullableInt(json['dm_tips_status']);
    refEarningStatus = TypeConverterHelper.getNullableInt(json['ref_earning_status']);
    refundActiveStatus = TypeConverterHelper.getNullableBool(json['refund_active_status']);
    refEarningExchangeRate = TypeConverterHelper.getNullableDouble(json['ref_earning_exchange_rate']);
    if (json['social_login'] is List) {
      socialLogin = <SocialLogin>[];
      for (final dynamic v in json['social_login'] as List) {
        if (v is Map<String, dynamic>) {
          socialLogin!.add(SocialLogin.fromJson(v));
        }
      }
    }
    if (json['apple_login'] is List) {
      appleLogin = <SocialLogin>[];
      for (final dynamic v in json['apple_login'] as List) {
        if (v is Map<String, dynamic>) {
          appleLogin!.add(SocialLogin.fromJson(v));
        }
      }
    }
    refundPolicyStatus = TypeConverterHelper.getNullableInt(json['refund_policy']);
    cancellationPolicyStatus = TypeConverterHelper.getNullableInt(json['cancelation_policy']);
    shippingPolicyStatus = TypeConverterHelper.getNullableInt(json['shipping_policy']);
    prescriptionStatus = TypeConverterHelper.getNullableBool(json['prescription_order_status']);
    cookiesText = TypeConverterHelper.getNullableString(json['cookies_text']);
    homeDeliveryStatus = TypeConverterHelper.getNullableInt(json['home_delivery_status']);
    takeawayStatus = TypeConverterHelper.getNullableInt(json['takeaway_status']);
    partialPaymentStatus = TypeConverterHelper.getNullableBool(json['partial_payment_status']) ?? false;
    partialPaymentMethod = TypeConverterHelper.getNullableString(json['partial_payment_method']);
    additionalChargeStatus = TypeConverterHelper.getNullableBool(json['additional_charge_status']) ?? false;
    additionalChargeName = TypeConverterHelper.getNullableString(json['additional_charge_name']);
    additionCharge = TypeConverterHelper.getNullableDouble(json['additional_charge']) ?? 0;
    if (json['active_payment_method_list'] is List) {
      activePaymentMethodList = <PaymentBody>[];
      for (final dynamic v in json['active_payment_method_list'] as List) {
        if (v is Map<String, dynamic>) {
          activePaymentMethodList!.add(PaymentBody.fromJson(v));
        }
      }
    }
    digitalPaymentInfo = json['digital_payment_info'] is Map<String, dynamic> ? DigitalPaymentInfo.fromJson(json['digital_payment_info']) : null;
    validationConfig = json['validation_config'] is Map<String, dynamic> ? ValidationConfig.fromJson(json['validation_config']) : null;
    addFundStatus = TypeConverterHelper.getNullableBool(json['add_fund_status']) ?? false;
    offlinePaymentStatus = TypeConverterHelper.getNullableBool(json['offline_payment_status']) ?? false;
    guestCheckoutStatus = TypeConverterHelper.getNullableBool(json['guest_checkout_status']) ?? false;
    adminCommission = TypeConverterHelper.getNullableDouble(json['admin_commission']);
    subscriptionFreeTrialDays = TypeConverterHelper.getNullableInt(json['subscription_free_trial_days']);
    subscriptionFreeTrialStatus = TypeConverterHelper.getNullableBool(json['subscription_free_trial_status']) ?? false;
    subscriptionBusinessModel = TypeConverterHelper.getNullableInt(json['subscription_business_model']);
    commissionBusinessModel = TypeConverterHelper.getNullableInt(json['commission_business_model']);
    subscriptionFreeTrialType = TypeConverterHelper.getNullableString(json['subscription_free_trial_type']);
    countryPickerStatus = false;
    firebaseOtpVerification = TypeConverterHelper.getNullableBool(json['firebase_otp_verification']) ?? false;
    centralizeLoginSetup = json['centralize_login'] is Map<String, dynamic> ? CentralizeLoginSetup.fromJson(json['centralize_login']) : null;
    vehicleDistanceMinPrice = TypeConverterHelper.getNullableDouble(json['vehicle_distance_min']);
    vehicleHourlyMinPrice = TypeConverterHelper.getNullableDouble(json['vehicle_hourly_min']);
    vehicleDayWiseMinPrice = TypeConverterHelper.getNullableDouble(json['vehicle_day_wise_min']);
    adminFreeDelivery = json['admin_free_delivery'] is Map<String, dynamic> ? AdminFreeDelivery.fromJson(json['admin_free_delivery']) : null;
    isSmsActive = TypeConverterHelper.getNullableBool(json['is_sms_active']);
    isMailActive = TypeConverterHelper.getNullableBool(json['is_mail_active']);
    parcelCancellationStatus = TypeConverterHelper.getNullableInt(json['parcel_cancellation_status']);
    parcelCancellationBasicSetup = json['parcel_cancellation_basic_setup'] is Map<String, dynamic> ? ParcelCancellationBasicSetup.fromJson(json['parcel_cancellation_basic_setup']) : null;
    parcelReturnTimeFee = json['parcel_return_time_fee'] is Map<String, dynamic> ? ParcelReturnTimeFee.fromJson(json['parcel_return_time_fee']) : null;
    websocketEnabled = TypeConverterHelper.getNullableBool(json['websocket_status']) ?? false;
    websocketUrl = TypeConverterHelper.getNullableString(json['websocket_url']);

    safetyFeatureStatus = TypeConverterHelper.getNullableBool(json['safety_feature_status']) ?? false;
    safetyFeatureMinimumTripDelayTime = TypeConverterHelper.getNullableInt(json['ride_safety_delay_time']);
    safetyFeatureMinimumTripDelayTimeType = TypeConverterHelper.getNullableString(json['ride_safety_delay_time_format']);
    afterTripCompleteSafetyFeatureActiveStatus = TypeConverterHelper.getNullableBool(json['safety_feature_after_ride_complete_status']) ?? false;
    afterTripCompleteSafetyFeatureSetTime = TypeConverterHelper.getNullableInt(json['safety_feature_after_ride_complete_time']);
    afterTripCompleteSafetyFeatureSetTimeFormat = TypeConverterHelper.getNullableString(json['safety_feature_after_ride_complete_time_format']);
    safetyFeatureEmergencyGovtNumber = TypeConverterHelper.getNullableString(json['emergency_govt_number']);

    reviewStatus = TypeConverterHelper.getNullableBool(json['review_status']);
    popularTips = TypeConverterHelper.getNullableInt(json['popular_tips']);
    searchRadius = TypeConverterHelper.getNullableDouble(json['ride_search_radius']);
    otpConfirmationForTrip = TypeConverterHelper.getNullableBool(json['ride_otp_confirmation']) ?? false;
    minBookingAmount = TypeConverterHelper.getNullableDouble(json['min_booking_amount']);
    maxBookingAmount = TypeConverterHelper.getNullableDouble(json['max_booking_amount']);
    scheduleBooking = TypeConverterHelper.getNullableInt(json['schedule_booking']);
    directProviderBooking = TypeConverterHelper.getNullableInt(json['direct_provider_booking']);
    serviceAtProviderLocation = TypeConverterHelper.getNullableInt(json['service_at_provider_place']);
    repeatBooking = TypeConverterHelper.getNullableInt(json['repeat_booking']);
    instantBooking = TypeConverterHelper.getNullableInt(json['instant_booking']);
    advanceBooking = json['advanced_booking'] is Map<String, dynamic> ? AdvanceBooking.fromJson(json['advanced_booking']) : null;
    if (json['confirm_otp_for_complete_service'] != null) {
      confirmationOtpStatus = TypeConverterHelper.getNullableBool(json['confirm_otp_for_complete_service']) ?? false;
    }
    bidingStatus = TypeConverterHelper.getNullableInt(json['bidding_status']);
    referralEarningStatus = TypeConverterHelper.getNullableInt(json['rider_referral_earning_status']);
    completionRadius = TypeConverterHelper.getNullableDouble(json['rider_completion_radius']);
    dmReferralData = json['dm_referral_data'] is Map<String, dynamic> ? ReferralData.fromJson(json['dm_referral_data']) : null;
    riderReferralData = json['rider_referral_data'] is Map<String, dynamic> ? ReferralData.fromJson(json['rider_referral_data']) : null;
    customerRoutePreference = TypeConverterHelper.getNullableInt(json['customer_route_preference']);
    repeatOrderOption = TypeConverterHelper.getNullableInt(json['repeat_order_option']);
    monthlyOrderRemainder = TypeConverterHelper.getNullableInt(json['monthly_order_reminder']);
    maintenanceModeData = json['maintenance_mode_data'] is Map<String, dynamic> ? MaintenanceModeData.fromJson(json['maintenance_mode_data']) : null;
    proMemberStatus = TypeConverterHelper.getBool(json['pro_member_status']);
    aiChatStatus = TypeConverterHelper.getBool(json['ai_chat_status']);
    systemTaxIncludeStatus = TypeConverterHelper.getNullableInt(json['system_tax_include_status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_name'] = businessName;
    data['logo_full_url'] = logoFullUrl;
    data['address'] = address;
    data['phone'] = phone;
    data['email'] = email;
    data['country'] = country;
    if (defaultLocation != null) {
      data['default_location'] = defaultLocation!.toJson();
    }
    data['currency_symbol'] = currencySymbol;
    data['currency_symbol_direction'] = currencySymbolDirection;
    data['app_minimum_version_android'] = appMinimumVersionAndroid;
    data['app_url_android'] = appUrlAndroid;
    data['app_minimum_version_ios'] = appMinimumVersionIos;
    data['app_url_ios'] = appUrlIos;
    data['customer_verification'] = customerVerification;
    data['schedule_order'] = scheduleOrder;
    data['order_delivery_verification'] = orderDeliveryVerification;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    data['per_km_shipping_charge'] = perKmShippingCharge;
    data['minimum_shipping_charge'] = minimumShippingCharge;
    data['demo'] = demo;
    data['maintenance_mode'] = maintenanceMode;
    data['order_confirmation_model'] = orderConfirmationModel;
    data['show_dm_earning'] = showDmEarning;
    data['canceled_by_deliveryman'] = canceledByDeliveryman;
    data['timeformat'] = timeformat;
    if (language != null) {
      data['language'] = language!.map((v) => v.toJson()).toList();
    }
    data['toggle_veg_non_veg'] = toggleVegNonVeg;
    data['toggle_dm_registration'] = toggleDmRegistration;
    data['toggle_store_registration'] = toggleStoreRegistration;
    data['schedule_order_slot_duration'] = scheduleOrderSlotDuration;
    data['digit_after_decimal_point'] = digitAfterDecimalPoint;
    if (module != null) {
      data['module'] = module!.toJson();
    }
    if (moduleConfig != null) {
      data['module_config'] = moduleConfig!.toJson();
    }
    data['parcel_per_km_shipping_charge'] = parcelPerKmShippingCharge;
    data['parcel_minimum_shipping_charge'] = parcelMinimumShippingCharge;
    if (landingPageSettings != null) {
      data['landing_page_settings'] = landingPageSettings!.toJson();
    }
    if (socialMedia != null) {
      data['social_media'] = socialMedia!.map((v) => v.toJson()).toList();
    }
    data['footer_text'] = footerText;
    if (downloadUserAppLinks != null) {
      data['landing_page_links'] = downloadUserAppLinks!.toJson();
    }
    data['loyalty_point_exchange_rate'] = loyaltyPointExchangeRate;
    data['loyalty_point_item_purchase_point'] = loyaltyPointItemPurchasePoint;
    data['loyalty_point_status'] = loyaltyPointStatus;
    data['loyalty_point_minimum_point'] = minimumPointToTransfer;
    data['customer_wallet_status'] = customerWalletStatus;
    data['dm_tips_status'] = dmTipsStatus;
    data['ref_earning_status'] = refEarningStatus;
    data['ref_earning_exchange_rate'] = refEarningExchangeRate;
    data['refund_active_status'] = refundActiveStatus;
    if (socialLogin != null) {
      data['social_login'] = socialLogin!.map((v) => v.toJson()).toList();
    }
    if (appleLogin != null) {
      data['apple_login'] = appleLogin!.map((v) => v.toJson()).toList();
    }
    data['cookies_text'] = cookiesText;
    data['home_delivery_status'] = homeDeliveryStatus;
    data['takeaway_status'] = takeawayStatus;
    data['partial_payment_status'] = partialPaymentStatus;
    data['partial_payment_method'] = partialPaymentMethod;
    data['additional_charge_status'] = additionalChargeStatus;
    data['additional_charge_name'] = additionalChargeName;
    data['additional_charge'] = additionCharge;
    if (activePaymentMethodList != null) {
      data['active_payment_method_list'] = activePaymentMethodList!.map((v) => v.toJson()).toList();
    }
    if (digitalPaymentInfo != null) {
      data['digital_payment_info'] = digitalPaymentInfo!.toJson();
    }
    if (validationConfig != null) {
      data['validation_config'] = validationConfig!.toJson();
    }
    data['add_fund_status'] = addFundStatus;
    data['offline_payment_status'] = offlinePaymentStatus;
    data['guest_checkout_status'] = guestCheckoutStatus;
    data['admin_commission'] = adminCommission;
    data['subscription_free_trial_days'] = subscriptionFreeTrialDays;
    data['subscription_free_trial_status'] = subscriptionFreeTrialStatus;
    data['subscription_business_model'] = subscriptionBusinessModel;
    data['commission_business_model'] = commissionBusinessModel;
    data['subscription_free_trial_type'] = subscriptionFreeTrialType;
    data['country_picker_status'] = countryPickerStatus;
    data['firebase_otp_verification'] = firebaseOtpVerification;
    if (centralizeLoginSetup != null) {
      data['centralize_login'] = centralizeLoginSetup!.toJson();
    }
    data['vehicle_distance_min'] = vehicleDistanceMinPrice;
    data['vehicle_hourly_min'] = vehicleHourlyMinPrice;
    data['vehicle_day_wise_min'] = vehicleDayWiseMinPrice;
    if (adminFreeDelivery != null) {
      data['admin_free_delivery'] = adminFreeDelivery!.toJson();
    }
    data['is_sms_active'] = isSmsActive;
    data['is_mail_active'] = isMailActive;
    data['parcel_cancellation_status'] = parcelCancellationStatus;
    if (parcelCancellationBasicSetup != null) {
      data['parcel_cancellation_basic_setup'] = parcelCancellationBasicSetup!.toJson();
    }
    if (parcelReturnTimeFee != null) {
      data['parcel_return_time_fee'] = parcelReturnTimeFee!.toJson();
    }
    data['customer_route_preference'] = customerRoutePreference;
    data['repeat_order_option'] = repeatOrderOption;
    data['monthly_order_reminder'] = monthlyOrderRemainder;
    if (maintenanceModeData != null) {
      data['maintenance_mode_data'] = maintenanceModeData!.toJson();
    }
    data['pro_member_status'] = proMemberStatus;
    data['system_tax_include_status'] = systemTaxIncludeStatus;
    return data;
  }
}

class BaseUrls {
  String? itemImageUrl;
  String? customerImageUrl;
  String? bannerImageUrl;
  String? categoryImageUrl;
  String? reviewImageUrl;
  String? notificationImageUrl;
  String? vendorImageUrl;
  String? storeImageUrl;
  String? storeCoverPhotoUrl;
  String? deliveryManImageUrl;
  String? chatImageUrl;
  String? campaignImageUrl;
  String? moduleImageUrl;
  String? orderAttachmentUrl;
  String? parcelCategoryImageUrl;
  String? landingPageImageUrl;
  String? businessLogoUrl;
  String? refundImageUrl;
  String? vehicleImageUrl;
  String? vehicleBrandImageUrl;
  String? gatewayImageUrl;
  String? brandImageUrl;

  BaseUrls({
    this.itemImageUrl,
    this.customerImageUrl,
    this.bannerImageUrl,
    this.categoryImageUrl,
    this.reviewImageUrl,
    this.notificationImageUrl,
    this.vendorImageUrl,
    this.storeImageUrl,
    this.storeCoverPhotoUrl,
    this.deliveryManImageUrl,
    this.chatImageUrl,
    this.campaignImageUrl,
    this.moduleImageUrl,
    this.orderAttachmentUrl,
    this.parcelCategoryImageUrl,
    this.landingPageImageUrl,
    this.businessLogoUrl,
    this.refundImageUrl,
    this.vehicleImageUrl,
    this.vehicleBrandImageUrl,
    this.gatewayImageUrl,
    this.brandImageUrl,
  });

  BaseUrls.fromJson(Map<String, dynamic> json) {
    itemImageUrl = json['item_image_url'];
    customerImageUrl = json['customer_image_url'];
    bannerImageUrl = json['banner_image_url'];
    categoryImageUrl = json['category_image_url'];
    reviewImageUrl = json['review_image_url'];
    notificationImageUrl = json['notification_image_url'];
    vendorImageUrl = json['vendor_image_url'];
    storeImageUrl = json['store_image_url'];
    storeCoverPhotoUrl = json['store_cover_photo_url'];
    deliveryManImageUrl = json['delivery_man_image_url'];
    chatImageUrl = json['chat_image_url'];
    campaignImageUrl = json['campaign_image_url'];
    moduleImageUrl = json['module_image_url'];
    orderAttachmentUrl = json['order_attachment_url'];
    parcelCategoryImageUrl = json['parcel_category_image_url'];
    landingPageImageUrl = json['landing_page_image_url'];
    businessLogoUrl = json['business_logo_url'];
    refundImageUrl = json['refund_image_url'];
    vehicleImageUrl = json['vehicle_image_url'];
    vehicleBrandImageUrl = json['vehicle_brand_image_url'];
    gatewayImageUrl = json['gateway_image_url'];
    brandImageUrl = json['brand_image_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['item_image_url'] = itemImageUrl;
    data['customer_image_url'] = customerImageUrl;
    data['banner_image_url'] = bannerImageUrl;
    data['category_image_url'] = categoryImageUrl;
    data['review_image_url'] = reviewImageUrl;
    data['notification_image_url'] = notificationImageUrl;
    data['vendor_image_url'] = vendorImageUrl;
    data['store_image_url'] = storeImageUrl;
    data['store_cover_photo_url'] = storeCoverPhotoUrl;
    data['delivery_man_image_url'] = deliveryManImageUrl;
    data['chat_image_url'] = chatImageUrl;
    data['campaign_image_url'] = campaignImageUrl;
    data['module_image_url'] = moduleImageUrl;
    data['order_attachment_url'] = orderAttachmentUrl;
    data['parcel_category_image_url'] = parcelCategoryImageUrl;
    data['landing_page_image_url'] = landingPageImageUrl;
    data['business_logo_url'] = businessLogoUrl;
    data['refund_image_url'] = refundImageUrl;
    data['vehicle_image_url'] = vehicleImageUrl;
    data['vehicle_brand_image_url'] = vehicleBrandImageUrl;
    data['gateway_image_url'] = gatewayImageUrl;
    data['brand_image_url'] = brandImageUrl;
    return data;
  }
}

class DefaultLocation {
  String? lat;
  String? lng;

  DefaultLocation({this.lat, this.lng});

  DefaultLocation.fromJson(Map<String, dynamic> json) {
    lat = TypeConverterHelper.getNullableString(json['lat']);
    lng = TypeConverterHelper.getNullableString(json['lng']);
    if(lat == null || lng == null || lat == '0' || lng == '0' || (lat != null && lat!.startsWith('25.') && lng != null && lng!.startsWith('55.'))) {
      lat = AppConstants.defaultLatitude;
      lng = AppConstants.defaultLongitude;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['lat'] = lat ?? AppConstants.defaultLatitude;
    data['lng'] = lng ?? AppConstants.defaultLongitude;
    return data;
  }
}

class Language {
  String? key;
  String? value;

  Language({this.key, this.value});

  Language.fromJson(Map<String, dynamic> json) {
    key = TypeConverterHelper.getNullableString(json['key']);
    value = TypeConverterHelper.getNullableString(json['value']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['key'] = key;
    data['value'] = value;
    return data;
  }
}

class ModuleConfig {
  List<String>? moduleType;
  Module? module;

  ModuleConfig({this.moduleType, this.module});

  ModuleConfig.fromJson(Map<String, dynamic> json) {
    moduleType = json['module_type'] is List
        ? List<String>.from((json['module_type'] as List).map((e) => e.toString()))
        : <String>[];
    if (moduleType != null && moduleType!.isNotEmpty) {
      final String firstType = moduleType![0];
      module = json[firstType] is Map<String, dynamic> ? Module.fromJson(json[firstType]) : null;
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['module_type'] = moduleType;
    if (module != null && moduleType != null && moduleType!.isNotEmpty) {
      data[moduleType![0]] = module!.toJson();
    }
    return data;
  }
}

class Module {
  bool? orderPlaceToScheduleInterval;
  bool? addOn;
  bool? stock;
  bool? vegNonVeg;
  bool? unit;
  bool? orderAttachment;
  bool? showRestaurantText;
  bool? isParcel;
  bool? isTaxi;
  bool? isRide;
  bool? newVariation;
  String? description;

  Module({
    this.orderPlaceToScheduleInterval,
    this.addOn,
    this.stock,
    this.vegNonVeg,
    this.unit,
    this.orderAttachment,
    this.showRestaurantText,
    this.isParcel,
    this.isTaxi,
    this.isRide,
    this.newVariation,
    this.description,
  });

  Module.fromJson(Map<String, dynamic> json) {
    orderPlaceToScheduleInterval = TypeConverterHelper.getNullableBool(json['order_place_to_schedule_interval']);
    addOn = TypeConverterHelper.getNullableBool(json['add_on']);
    stock = TypeConverterHelper.getNullableBool(json['stock']);
    vegNonVeg = TypeConverterHelper.getNullableBool(json['veg_non_veg']);
    unit = TypeConverterHelper.getNullableBool(json['unit']);
    orderAttachment = TypeConverterHelper.getNullableBool(json['order_attachment']);
    showRestaurantText = TypeConverterHelper.getNullableBool(json['show_restaurant_text']);
    isParcel = TypeConverterHelper.getNullableBool(json['is_parcel']);
    isTaxi = TypeConverterHelper.getNullableBool(json['is_taxi']) ?? false;
    isRide = TypeConverterHelper.getNullableBool(json['is_ride']) ?? false;
    newVariation = TypeConverterHelper.getNullableBool(json['new_variation']);
    description = TypeConverterHelper.getNullableString(json['description']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['order_place_to_schedule_interval'] = orderPlaceToScheduleInterval;
    data['add_on'] = addOn;
    data['stock'] = stock;
    data['veg_non_veg'] = vegNonVeg;
    data['unit'] = unit;
    data['order_attachment'] = orderAttachment;
    data['show_restaurant_text'] = showRestaurantText;
    data['is_parcel'] = isParcel;
    data['is_taxi'] = isTaxi;
    data['new_variation'] = newVariation;
    data['description'] = description;
    return data;
  }
}

class OrderStatus {
  bool? accepted;

  OrderStatus({this.accepted});

  OrderStatus.fromJson(Map<String, dynamic> json) {
    accepted = TypeConverterHelper.getNullableBool(json['accepted']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['accepted'] = accepted;
    return data;
  }
}

class LandingPageSettings {
  String? mobileAppSectionImage;
  String? topContentImage;

  LandingPageSettings({this.mobileAppSectionImage, this.topContentImage});

  LandingPageSettings.fromJson(Map<String, dynamic> json) {
    mobileAppSectionImage = TypeConverterHelper.getNullableString(json['mobile_app_section_image']);
    topContentImage = TypeConverterHelper.getNullableString(json['top_content_image']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['mobile_app_section_image'] = mobileAppSectionImage;
    data['top_content_image'] = topContentImage;
    return data;
  }
}

class SocialMedia {
  int? id;
  String? name;
  String? link;
  int? status;

  SocialMedia({
    this.id,
    this.name,
    this.link,
    this.status,
  });

  SocialMedia.fromJson(Map<String, dynamic> json) {
    id = TypeConverterHelper.getNullableInt(json['id']);
    name = TypeConverterHelper.getNullableString(json['name']);
    link = TypeConverterHelper.getNullableString(json['link']);
    status = TypeConverterHelper.getNullableInt(json['status']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['link'] = link;
    data['status'] = status;
    return data;
  }
}

class DownloadUserAppLinks {
  String? playStoreUrlStatus;
  String? playStoreUrl;
  String? appleStoreUrlStatus;
  String? appleStoreUrl;

  DownloadUserAppLinks({
    this.playStoreUrlStatus,
    this.playStoreUrl,
    this.appleStoreUrlStatus,
    this.appleStoreUrl,
  });

  DownloadUserAppLinks.fromJson(Map<String, dynamic> json) {
    playStoreUrlStatus = TypeConverterHelper.getNullableString(json['playstore_url_status']);
    playStoreUrl = TypeConverterHelper.getNullableString(json['playstore_url']);
    appleStoreUrlStatus = TypeConverterHelper.getNullableString(json['apple_store_url_status']);
    appleStoreUrl = TypeConverterHelper.getNullableString(json['apple_store_url']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['playstore_url_status'] = playStoreUrlStatus;
    data['playstore_url'] = playStoreUrl;
    data['apple_store_url_status'] = appleStoreUrlStatus;
    data['apple_store_url'] = appleStoreUrl;
    return data;
  }
}

class SocialLogin {
  String? loginMedium;
  bool? status;
  String? clientId;
  String? redirectUrl;

  SocialLogin({this.loginMedium, this.status, this.clientId, this.redirectUrl});

  SocialLogin.fromJson(Map<String, dynamic> json) {
    loginMedium = TypeConverterHelper.getNullableString(json['login_medium']);
    status = TypeConverterHelper.getNullableBool(json['status']);
    clientId = TypeConverterHelper.getNullableString(json['client_id']);
    redirectUrl = TypeConverterHelper.getNullableString(json['redirect_url_flutter']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['login_medium'] = loginMedium;
    data['status'] = status;
    data['client_id'] = clientId;
    data['redirect_url_flutter'] = redirectUrl;
    return data;
  }
}

class PaymentBody {
  String? getWay;
  String? getWayTitle;
  String? getWayImageFullUrl;

  PaymentBody({this.getWay, this.getWayTitle, this.getWayImageFullUrl});

  PaymentBody.fromJson(Map<String, dynamic> json) {
    getWay = TypeConverterHelper.getNullableString(json['gateway']);
    getWayTitle = TypeConverterHelper.getNullableString(json['gateway_title']);
    getWayImageFullUrl = TypeConverterHelper.getNullableString(json['gateway_image_full_url']) ?? '';
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['gateway'] = getWay;
    data['gateway_title'] = getWayTitle;
    data['gateway_image_full_url'] = getWayImageFullUrl;
    return data;
  }
}

class DigitalPaymentInfo {
  bool? digitalPayment;
  bool? pluginPaymentGateways;
  bool? defaultPaymentGateways;

  DigitalPaymentInfo({this.digitalPayment, this.pluginPaymentGateways, this.defaultPaymentGateways});

  DigitalPaymentInfo.fromJson(Map<String, dynamic> json) {
    digitalPayment = TypeConverterHelper.getNullableBool(json['digital_payment']);
    pluginPaymentGateways = TypeConverterHelper.getNullableBool(json['plugin_payment_gateways']);
    defaultPaymentGateways = TypeConverterHelper.getNullableBool(json['default_payment_gateways']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['digital_payment'] = digitalPayment;
    data['plugin_payment_gateways'] = pluginPaymentGateways;
    data['default_payment_gateways'] = defaultPaymentGateways;
    return data;
  }
}

class ValidationConfig {
 String? imageFormat;
 String? imageExtension;
 String? imageFormatForValidation;
 String? videoFormat;
 String? videoExtension;
 int? productVideoMaxFileSize;
 String? documentFormat;
 String? documentExtension;
 String? audioFormat;
 String? audioExtension;
 String? fileFormat;
 String? fileFormatForImagePicker;
 String? fileExtension;
 int? maxFileSize;

  ValidationConfig({this.imageFormat, this.imageExtension, this.imageFormatForValidation, this.videoFormat,
    this.videoExtension, this.productVideoMaxFileSize, this.documentFormat, this.documentExtension, this.audioFormat,
    this.audioExtension, this.fileFormat, this.fileFormatForImagePicker, this.fileExtension, this.maxFileSize});

  ValidationConfig.fromJson(Map<String, dynamic> json) {
    imageFormat = TypeConverterHelper.getNullableString(json['image_format']);
    imageExtension = TypeConverterHelper.getNullableString(json['image_extension']);
    imageFormatForValidation = TypeConverterHelper.getNullableString(json['image_format_for_validation']);
    videoFormat = TypeConverterHelper.getNullableString(json['video_format']);
    videoExtension = TypeConverterHelper.getNullableString(json['video_extension']);
    productVideoMaxFileSize = TypeConverterHelper.getNullableInt(json['product_video_max_file_size']);
    documentFormat = TypeConverterHelper.getNullableString(json['document_format']);
    documentExtension = TypeConverterHelper.getNullableString(json['document_extension']);
    audioFormat = TypeConverterHelper.getNullableString(json['audio_format']);
    audioExtension = TypeConverterHelper.getNullableString(json['audio_extension']);
    fileFormat = TypeConverterHelper.getNullableString(json['file_format']);
    fileFormatForImagePicker = TypeConverterHelper.getNullableString(json['file_format_for_image_picker']);
    fileExtension = TypeConverterHelper.getNullableString(json['file_extension']);
    maxFileSize = TypeConverterHelper.getNullableInt(json['max_file_size']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['image_format'] = imageFormat;
    data['image_extension'] = imageExtension;
    data['image_format_for_validation'] = imageFormatForValidation;
    data['video_format'] = videoFormat;
    data['video_extension'] = videoExtension;
    data['product_video_max_file_size'] = productVideoMaxFileSize;
    data['document_format'] = documentFormat;
    data['document_extension'] = documentExtension;
    data['audio_format'] = audioFormat;
    data['audio_extension'] = audioExtension;
    data['file_format'] = fileFormat;
    data['file_format_for_image_picker'] = fileFormatForImagePicker;
    data['file_extension'] = fileExtension;
    data['max_file_size'] = maxFileSize;
    return data;
  }
}

class BusinessPlan {
  int? commission;
  int? subscription;

  BusinessPlan({this.commission, this.subscription});

  BusinessPlan.fromJson(Map<String, dynamic> json) {
    commission = TypeConverterHelper.getNullableInt(json['commission']);
    subscription = TypeConverterHelper.getNullableInt(json['subscription']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['commission'] = commission;
    data['subscription'] = subscription;
    return data;
  }
}

class CentralizeLoginSetup {
  bool? manualLoginStatus;
  bool? otpLoginStatus;
  bool? socialLoginStatus;
  bool? googleLoginStatus;
  bool? facebookLoginStatus;
  bool? appleLoginStatus;
  bool? emailVerificationStatus;
  bool? phoneVerificationStatus;

  CentralizeLoginSetup({
    this.manualLoginStatus,
    this.otpLoginStatus,
    this.socialLoginStatus,
    this.googleLoginStatus,
    this.facebookLoginStatus,
    this.appleLoginStatus,
    this.emailVerificationStatus,
    this.phoneVerificationStatus,
  });

  CentralizeLoginSetup.fromJson(Map<String, dynamic> json) {
    manualLoginStatus = TypeConverterHelper.getNullableBool(json['manual_login_status']) ?? false;
    otpLoginStatus = TypeConverterHelper.getNullableBool(json['otp_login_status']) ?? false;
    socialLoginStatus = TypeConverterHelper.getNullableBool(json['social_login_status']) ?? false;
    googleLoginStatus = TypeConverterHelper.getNullableBool(json['google_login_status']) ?? false;
    facebookLoginStatus = TypeConverterHelper.getNullableBool(json['facebook_login_status']) ?? false;
    appleLoginStatus = TypeConverterHelper.getNullableBool(json['apple_login_status']) ?? false;
    emailVerificationStatus = TypeConverterHelper.getNullableBool(json['email_verification_status']) ?? false;
    phoneVerificationStatus = TypeConverterHelper.getNullableBool(json['phone_verification_status']) ?? false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['manual_login_status'] = manualLoginStatus;
    data['otp_login_status'] = otpLoginStatus;
    data['social_login_status'] = socialLoginStatus;
    data['google_login_status'] = googleLoginStatus;
    data['facebook_login_status'] = facebookLoginStatus;
    data['apple_login_status'] = appleLoginStatus;
    data['email_verification_status'] = emailVerificationStatus;
    data['phone_verification_status'] = phoneVerificationStatus;
    return data;
  }
}

class AdminFreeDelivery {
  bool? status;
  String? type;
  double? freeDeliveryOver;

  AdminFreeDelivery({this.status, this.type, this.freeDeliveryOver});

  AdminFreeDelivery.fromJson(Map<String, dynamic> json) {
    status = TypeConverterHelper.getNullableBool(json['status']);
    type = TypeConverterHelper.getNullableString(json['type']);
    freeDeliveryOver = TypeConverterHelper.getNullableDouble(json['free_delivery_over']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['type'] = type;
    data['free_delivery_over'] = freeDeliveryOver;
    return data;
  }
}

class ParcelCancellationBasicSetup {
  String? returnFeeStatus;
  String? returnFee;
  //String? doNotChargeReturnFeeOnDeliverymanCancel;

  ParcelCancellationBasicSetup({this.returnFeeStatus, this.returnFee, /*this.doNotChargeReturnFeeOnDeliverymanCancel*/});

  ParcelCancellationBasicSetup.fromJson(Map<String, dynamic> json) {
    returnFeeStatus = TypeConverterHelper.getNullableString(json['return_fee_status']);
    returnFee = TypeConverterHelper.getNullableString(json['return_fee']);
    //doNotChargeReturnFeeOnDeliverymanCancel = json['do_not_charge_return_fee_on_deliveryman_cancel'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['return_fee_status'] = returnFeeStatus;
    data['return_fee'] = returnFee;
    //data['do_not_charge_return_fee_on_deliveryman_cancel'] = doNotChargeReturnFeeOnDeliverymanCancel;
    return data;
  }
}

class ParcelReturnTimeFee {
  String? status;
  String? parcelReturnTime;
  String? returnTimeType;
  String? returnFeeForDm;

  ParcelReturnTimeFee({this.status, this.parcelReturnTime, this.returnTimeType, this.returnFeeForDm});

  ParcelReturnTimeFee.fromJson(Map<String, dynamic> json) {
    status = TypeConverterHelper.getNullableString(json['status']);
    parcelReturnTime = TypeConverterHelper.getNullableString(json['parcel_return_time']);
    returnTimeType = TypeConverterHelper.getNullableString(json['return_time_type']);
    returnFeeForDm = TypeConverterHelper.getNullableString(json['return_fee_for_dm']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['parcel_return_time'] = parcelReturnTime;
    data['return_time_type'] = returnTimeType;
    data['return_fee_for_dm'] = returnFeeForDm;
    return data;
  }
}

class AdvanceBooking {
  int? advancedBookingRestrictionValue;
  int? advancedBookingRestrictionValueStatus;
  String? advancedBookingRestrictionType;

  AdvanceBooking({
    this.advancedBookingRestrictionValue,
    this.advancedBookingRestrictionType,
    this.advancedBookingRestrictionValueStatus,
  });

  AdvanceBooking.fromJson(Map<String, dynamic> json) {
    advancedBookingRestrictionValue = TypeConverterHelper.getNullableInt(json['advanced_booking_restriction_value']);
    advancedBookingRestrictionValueStatus = TypeConverterHelper.getNullableInt(json['advanced_booking_restriction_value_status']);
    advancedBookingRestrictionType = TypeConverterHelper.getNullableString(json['advanced_booking_restriction_type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['advanced_booking_restriction_value'] =
        advancedBookingRestrictionValue;
    data['advanced_booking_restriction_value_status'] =
        advancedBookingRestrictionValueStatus;
    data['advanced_booking_restriction_type'] =
        advancedBookingRestrictionType;
    return data;
  }
}

class ReferralData {
  bool? referalStatus;
  double? referalAmount;


  ReferralData({this.referalStatus, this.referalAmount});

  ReferralData.fromJson(Map<String, dynamic> json) {
    referalStatus = TypeConverterHelper.getNullableBool(json['referal_status']);
    referalAmount = TypeConverterHelper.getNullableDouble(json['referal_amount']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['referal_status'] = referalStatus;
    data['referal_amount'] = referalAmount;
    return data;
  }
}

class MaintenanceModeData {
  List<String>? maintenanceSystemSetup;
  MaintenanceDurationSetup? maintenanceDurationSetup;
  MaintenanceMessageSetup? maintenanceMessageSetup;

  MaintenanceModeData({this.maintenanceSystemSetup, this.maintenanceDurationSetup, this.maintenanceMessageSetup});

  MaintenanceModeData.fromJson(Map<String, dynamic> json) {
    if (json['maintenance_system_setup'] is List) {
      maintenanceSystemSetup = <String>[];
      for (final dynamic v in json['maintenance_system_setup'] as List) {
        maintenanceSystemSetup!.add(v.toString());
      }
    }
    maintenanceDurationSetup = json['maintenance_duration_setup'] is Map<String, dynamic>
        ? MaintenanceDurationSetup.fromJson(json['maintenance_duration_setup'])
        : null;
    maintenanceMessageSetup = json['maintenance_message_setup'] is Map<String, dynamic>
        ? MaintenanceMessageSetup.fromJson(json['maintenance_message_setup'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (maintenanceSystemSetup != null) {
      data['maintenance_system_setup'] = maintenanceSystemSetup;
    }
    if (maintenanceDurationSetup != null) {
      data['maintenance_duration_setup'] = maintenanceDurationSetup!.toJson();
    }
    if (maintenanceMessageSetup != null) {
      data['maintenance_message_setup'] = maintenanceMessageSetup!.toJson();
    }
    return data;
  }
}

class MaintenanceDurationSetup {
  String? maintenanceDuration;
  String? startDate;
  String? endDate;

  MaintenanceDurationSetup({this.maintenanceDuration, this.startDate, this.endDate});

  MaintenanceDurationSetup.fromJson(Map<String, dynamic> json) {
    maintenanceDuration = TypeConverterHelper.getNullableString(json['maintenance_duration']);
    startDate = TypeConverterHelper.getNullableString(json['start_date']);
    endDate = TypeConverterHelper.getNullableString(json['end_date']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['maintenance_duration'] = maintenanceDuration;
    data['start_date'] = startDate;
    data['end_date'] = endDate;
    return data;
  }
}

class MaintenanceMessageSetup {
  int? businessNumber;
  int? businessEmail;
  String? maintenanceMessage;
  String? messageBody;

  MaintenanceMessageSetup({this.businessNumber, this.businessEmail, this.maintenanceMessage, this.messageBody});

  MaintenanceMessageSetup.fromJson(Map<String, dynamic> json) {
    businessNumber = TypeConverterHelper.getNullableInt(json['business_number']);
    businessEmail = TypeConverterHelper.getNullableInt(json['business_email']);
    maintenanceMessage = TypeConverterHelper.getNullableString(json['maintenance_message']);
    messageBody = TypeConverterHelper.getNullableString(json['message_body']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['business_number'] = businessNumber;
    data['business_email'] = businessEmail;
    data['maintenance_message'] = maintenanceMessage;
    data['message_body'] = messageBody;
    return data;
  }
}