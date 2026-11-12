import 'package:sixam_mart/helper/type_converter_helper.dart';

class ModuleModel {
  int? id;
  String? moduleName;
  String? moduleType;
  String? slug;
  String? thumbnailFullUrl;
  String? iconFullUrl;
  int? themeId;
  String? shortDescription;
  String? description;
  int? storesCount;
  String? createdAt;
  String? updatedAt;
  List<ModuleZoneData>? zones;
  TopOffer? topOffer;
  String? minDeliveryTime;
  int? flashSale;
  int? freeDelivery;

  ModuleModel({
    this.id,
    this.moduleName,
    this.moduleType,
    this.slug,
    this.thumbnailFullUrl,
    this.storesCount,
    this.iconFullUrl,
    this.themeId,
    this.shortDescription,
    this.description,
    this.createdAt,
    this.updatedAt,
    this.zones,
    this.topOffer,
    this.minDeliveryTime,
    this.flashSale,
    this.freeDelivery,
  });

  ModuleModel.fromJson(Map<String, dynamic> json) {
    id = TypeConverterHelper.getNullableInt(json['id']);
    moduleName = TypeConverterHelper.getNullableString(json['module_name']);
    moduleType = TypeConverterHelper.getNullableString(json['module_type']);
    slug = TypeConverterHelper.getNullableString(json['slug']);
    thumbnailFullUrl = TypeConverterHelper.getNullableString(json['thumbnail_full_url']);
    iconFullUrl = TypeConverterHelper.getNullableString(json['icon_full_url']);
    themeId = TypeConverterHelper.getNullableInt(json['theme_id']);
    shortDescription = TypeConverterHelper.getNullableString(json['short_description']);
    description = TypeConverterHelper.getNullableString(json['description']);
    storesCount = TypeConverterHelper.getNullableInt(json['stores_count']);
    createdAt = TypeConverterHelper.getNullableString(json['created_at']);
    updatedAt = TypeConverterHelper.getNullableString(json['updated_at']);
    if (json['zones'] is List) {
      zones = <ModuleZoneData>[];
      for (final dynamic v in json['zones'] as List) {
        if (v is Map<String, dynamic>) {
          zones!.add(ModuleZoneData.fromJson(v));
        }
      }
    }
    topOffer = json['top_offer'] is Map<String, dynamic>
        ? TopOffer.fromJson(json['top_offer'])
        : null;
    minDeliveryTime = TypeConverterHelper.getNullableString(json['min_delivery_time']);
    flashSale = TypeConverterHelper.getNullableInt(json['flash_sale']);
    freeDelivery = TypeConverterHelper.getNullableInt(json['free_delivery']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['module_name'] = moduleName;
    data['module_type'] = moduleType;
    data['slug'] = slug;
    data['thumbnail_full_url'] = thumbnailFullUrl;
    data['icon_full_url'] = iconFullUrl;
    data['theme_id'] = themeId;
    data['short_description'] = shortDescription;
    data['description'] = description;
    data['stores_count'] = storesCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    if (zones != null) {
      data['zones'] = zones!.map((v) => v.toJson()).toList();
    }
    if (topOffer != null) {
      data['top_offer'] = topOffer!.toJson();
    }
    data['min_delivery_time'] = minDeliveryTime;
    data['flash_sale'] = flashSale;
    data['free_delivery'] = freeDelivery;
    return data;
  }
}

class ModuleZoneData {
  int? id;
  String? name;
  int? status;
  String? createdAt;
  String? updatedAt;
  bool? cashOnDelivery;
  bool? digitalPayment;

  ModuleZoneData({
    this.id,
    this.name,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.cashOnDelivery,
    this.digitalPayment,
  });

  ModuleZoneData.fromJson(Map<String, dynamic> json) {
    id = TypeConverterHelper.getNullableInt(json['id']);
    name = TypeConverterHelper.getNullableString(json['name']);
    status = TypeConverterHelper.getNullableInt(json['status']);
    createdAt = TypeConverterHelper.getNullableString(json['created_at']);
    updatedAt = TypeConverterHelper.getNullableString(json['updated_at']);
    cashOnDelivery = TypeConverterHelper.getNullableBool(json['cash_on_delivery']);
    digitalPayment = TypeConverterHelper.getNullableBool(json['digital_payment']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['status'] = status;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['cash_on_delivery'] = cashOnDelivery;
    data['digital_payment'] = digitalPayment;
    return data;
  }
}

class TopOffer {
  int? discount;
  String? discountType;

  TopOffer({this.discount, this.discountType});

  TopOffer.fromJson(Map<String, dynamic> json) {
    discount = TypeConverterHelper.getNullableInt(json['discount']);
    discountType = TypeConverterHelper.getNullableString(json['discount_type']);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['discount'] = discount;
    data['discount_type'] = discountType;
    return data;
  }
}