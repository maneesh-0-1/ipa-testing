import 'dart:convert';

import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sixam_mart/common/models/module_model.dart';
import 'package:sixam_mart/features/address/domain/models/address_model.dart';
import 'package:sixam_mart/util/app_constants.dart';

class HeaderHelper {
  static Map<String, String> featuredHeader() {
    SharedPreferences sharedPreferences = Get.find<SharedPreferences>();
    AddressModel? addressModel;
    try {
      addressModel = AddressModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.userAddress)!));
    }catch(_) {}
    int? moduleID;
    if(GetPlatform.isWeb && sharedPreferences.containsKey(AppConstants.moduleId)) {
      try {
        moduleID = ModuleModel.fromJson(jsonDecode(sharedPreferences.getString(AppConstants.moduleId)!)).id;
      }catch(_) {}
    }
    moduleID ??= 2;
    List<int> effectiveZoneIds = (addressModel?.zoneIds != null && addressModel!.zoneIds!.isNotEmpty)
        ? List<int>.from(addressModel.zoneIds!)
        : List<int>.from(AppConstants.defaultZoneIds);
    if (!effectiveZoneIds.contains(AppConstants.defaultZoneId)) {
      effectiveZoneIds.insert(0, AppConstants.defaultZoneId);
    }
    final String effectiveLat = (addressModel?.latitude != null && addressModel!.latitude!.isNotEmpty && addressModel.latitude != '0')
        ? addressModel.latitude!
        : AppConstants.defaultLatitude;
    final String effectiveLng = (addressModel?.longitude != null && addressModel!.longitude!.isNotEmpty && addressModel.longitude != '0')
        ? addressModel.longitude!
        : AppConstants.defaultLongitude;
    return {
      'Content-Type': 'application/json; charset=UTF-8',
      AppConstants.zoneId: jsonEncode(effectiveZoneIds),
      AppConstants.moduleId: '$moduleID',
      AppConstants.localizationKey: sharedPreferences.getString(AppConstants.languageCode) ?? AppConstants.languages[0].languageCode!,
      AppConstants.latitude: effectiveLat,
      AppConstants.longitude: effectiveLng,
      // 'Authorization': 'Bearer $token'
    };
  }
}