import 'package:animated_flip_counter/animated_flip_counter.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/styles.dart';

class PriceConverter {
  static String convertPrice(double? price, {double? discount, String? discountType, bool forDM = false, bool isFoodVariation = false, String? formatedStringPrice, bool forTaxi = false, bool forMenuWallet = false}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount' && !isFoodVariation) {
        price = price! - discount;
      }else if(discountType == 'percent') {
        price = price! - ((discount / 100) * price);
      }
    }
    final configModel = Get.find<SplashController>().configModel;
    final bool isRightSide = configModel?.currencySymbolDirection == 'right';
    final String currencySymbol = configModel?.currencySymbol ?? '';
    final int digitAfterDecimal = configModel?.digitAfterDecimalPoint ?? 2;

    if(forMenuWallet) {
      return '${isRightSide ? '' : '$currencySymbol '}'
          '${intl.NumberFormat.compact().format(price)}'
          '${isRightSide ? ' $currencySymbol' : ''}';
    }

    if(forTaxi && (price ?? 0) > 100000) {
      return '${isRightSide ? '' : '$currencySymbol '}'
          '${intl.NumberFormat.compact().format(price)}'
          '${isRightSide ? ' $currencySymbol' : ''}';
    }
    return '${isRightSide ? '' : '$currencySymbol '}'
        '${formatedStringPrice ?? toFixed(price ?? 0).toStringAsFixed(forDM ? 0 : digitAfterDecimal)
        .replaceAllMapped(RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'), (Match m) => '${m[1]},')}'
        '${isRightSide ? ' $currencySymbol' : ''}';
  }

  static Widget convertAnimationPrice(double? price, {double? discount, String? discountType, bool forDM = false, TextStyle? textStyle}) {
    if(discount != null && discountType != null){
      if(discountType == 'amount') {
        price = (price ?? 0) - discount;
      }else if(discountType == 'percent') {
        price = (price ?? 0) - ((discount / 100) * (price ?? 0));
      }
    }
    final configModel = Get.find<SplashController>().configModel;
    final bool isRightSide = configModel?.currencySymbolDirection == 'right';
    final String currencySymbol = configModel?.currencySymbol ?? '';
    final int digitAfterDecimal = configModel?.digitAfterDecimalPoint ?? 2;
    return Directionality(
      textDirection: TextDirection.ltr,
      child: AnimatedFlipCounter(
        duration: const Duration(milliseconds: 500),
        value: toFixed(price ?? 0),
        textStyle: textStyle ?? robotoMedium,
        fractionDigits: forDM ? 0 : digitAfterDecimal,
        prefix: isRightSide ? '' : '$currencySymbol ',
        suffix: isRightSide ? '$currencySymbol ' : '',
      ),
    );
  }

  static double? convertWithDiscount(double? price, double? discount, String? discountType, {bool isFoodVariation = false}) {
    if(discountType == 'amount' && !isFoodVariation) {
      price = price! - discount!;
    }else if(discountType == 'percent') {
      price = price! - ((discount! / 100) * price);
    }
    return price;
  }

  static double calculation(double amount, double? discount, String type, int quantity) {
    double calculatedAmount = 0;
    if(type == 'amount' || type == 'fixed') {
      calculatedAmount = discount! * quantity;
    }else if(type == 'percent') {
      calculatedAmount = (discount! / 100) * (amount * quantity);
    }
    return calculatedAmount;
  }

  static String percentageCalculation(String price, String discount, String discountType) {
    final String currencySymbol = Get.find<SplashController>().configModel?.currencySymbol ?? '';
    return '$discount${discountType == 'percent' ? '%' : currencySymbol}';
  }

  static double toFixed(double val) {
    final int digitAfterDecimal = Get.find<SplashController>().configModel?.digitAfterDecimalPoint ?? 2;
    num mod = power(10, digitAfterDecimal);
    return (((val * mod).toPrecision(digitAfterDecimal)).floor().toDouble() / mod);
  }

  static int power(int x, int n) {
    int retval = 1;
    for (int i = 0; i < n; i++) {
      retval *= x;
    }
    return retval;
  }

  static int get customTipIndex => AppConstants.tips.indexOf('custom');
  static int get noTipIndex => AppConstants.tips.indexOf('0');

}