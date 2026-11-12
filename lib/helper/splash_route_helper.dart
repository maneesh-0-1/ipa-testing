import 'package:get/get.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/favourite/controllers/favourite_controller.dart';
import 'package:sixam_mart/features/notification/domain/models/notification_body_model.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/maintance_helper.dart';
import 'package:sixam_mart/helper/notification_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';

// class SplashRouteHelper{

  Future<void> route({NotificationBodyModel? body}) async {
    double minimumVersion = _getMinimumVersion() ?? 0;
    bool isMaintenanceMode = MaintenanceHelper.isMaintenanceEnable();
    bool needsUpdate = AppConstants.appVersion < minimumVersion;

    if(needsUpdate || isMaintenanceMode) {
      Get.offNamed(RouteHelper.getUpdateRoute(needsUpdate));
    }else if(!GetPlatform.isWeb){
      if(body != null) {
        _forNotificationRouteProcess(body);
      }else {
        await _handleUserRouting();
      }
    }
  }

  double? _getMinimumVersion() {
    final configModel = Get.find<SplashController>().configModel;
    if (GetPlatform.isAndroid) {
      return configModel?.appMinimumVersionAndroid ?? 0;
    } else if (GetPlatform.isIOS) {
      return configModel?.appMinimumVersionIos ?? 0;
    }
    return 0;
  }

  void _forNotificationRouteProcess(NotificationBodyModel? notificationBody) {
    final notificationType = notificationBody?.notificationType;

    final Map<NotificationType, Function> notificationActions = {
      NotificationType.order: () => Get.toNamed(RouteHelper.getOrderDetailsRoute(notificationBody!.orderId, fromNotification: true)),
      NotificationType.block: () => Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.notification)),
      NotificationType.unblock: () => Get.offNamed(RouteHelper.getSignInRoute(RouteHelper.notification)),
      NotificationType.message: () =>  Get.toNamed(RouteHelper.getChatRoute(notificationBody: notificationBody, conversationID: notificationBody!.conversationId, fromNotification: true)),
      NotificationType.otp: () => null,
      NotificationType.add_fund: () => Get.toNamed(RouteHelper.getWalletRoute(fromNotification: true)),
      NotificationType.referral_earn: () => Get.toNamed(RouteHelper.getWalletRoute(fromNotification: true)),
      NotificationType.cashback: () => Get.toNamed(RouteHelper.getWalletRoute(fromNotification: true)),
      NotificationType.loyalty_point: () => Get.toNamed(RouteHelper.getLoyaltyRoute(fromNotification: true)),
      NotificationType.general: () => Get.toNamed(RouteHelper.getNotificationRoute(fromNotification: true)),
      NotificationType.ride_request: () async {
        if(notificationBody != null) {
          // Convert NotificationBodyModel to Map for notificationRouteCheck
          Map<String, dynamic> notificationData = {
            'type': 'ride_request',
            'action': notificationBody.action,
            'ride_request_id': notificationBody.rideRequestId,
            'next_level': notificationBody.nextLevel,
            'reward_amount': notificationBody.rewardAmount,
            'reward_type': notificationBody.rewardType,
          };
          await NotificationHelper.rideNotificationRouteCheck(notificationData, formSplash: true);
        }
      },
    };

    notificationActions[notificationType]?.call();
  }

  Future<void> _forLoggedInUserRouteProcess() async {
    try {
      Get.find<AuthController>().updateToken();
    } catch (_) {}
    try {
      if(Get.find<SplashController>().module != null && Get.find<SplashController>().module!.moduleType.toString() != AppConstants.ride) {
        await Get.find<FavouriteController>().getFavouriteList().timeout(const Duration(seconds: 8));
      }
    } catch (_) {}
    Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
  }

  void _newlyRegisteredRouteProcess() {
    if(AppConstants.languages.length > 1) {
      Get.offNamed(RouteHelper.getLanguageRoute('splash'));
    }else {
      Get.offNamed(RouteHelper.getOnBoardingRoute());
    }
  }

  void _forGuestUserRouteProcess() {
    Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
  }

  Future<void> _handleUserRouting() async {
    if (AuthHelper.isLoggedIn()) {
      await _forLoggedInUserRouteProcess();
    } else if (Get.find<SplashController>().showIntro() == true) {
      _newlyRegisteredRouteProcess();
    } else if (AuthHelper.isGuestLoggedIn()) {
      _forGuestUserRouteProcess();
    } else {
      try {
        await Get.find<AuthController>().guestLogin().timeout(const Duration(seconds: 10));
      } catch (_) {}
      _forGuestUserRouteProcess();
    }
  }
// }