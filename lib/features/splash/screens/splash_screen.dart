import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/notification/domain/models/notification_body_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/common/widgets/no_internet_screen.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final NotificationBodyModel? body;
  final String? deeplinkUrl;
  const SplashScreen({super.key, required this.body, required this.deeplinkUrl});

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  final GlobalKey<ScaffoldState> _globalKey = GlobalKey();
  StreamSubscription<List<ConnectivityResult>>? _onConnectivityChanged;

  @override
  void initState() {
    super.initState();

    bool firstTime = true;
    _onConnectivityChanged = Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      bool isConnected = result.contains(ConnectivityResult.wifi)
          || result.contains(ConnectivityResult.mobile)
          || result.contains(ConnectivityResult.ethernet)
          || result.contains(ConnectivityResult.vpn)
          || result.contains(ConnectivityResult.other);

      if(!firstTime && mounted) {
        showCustomSnackBar(isConnected ? 'connected'.tr : 'no_connection'.tr, isError: !isConnected);
        if(isConnected) {
          if(Get.find<SplashController>().deeplinkRoute == null) {
            _route();
          }
        }
      }

      firstTime = false;
    });

    _initAndRoute();
  }

  Future<void> _initAndRoute() async {
    await Get.find<SplashController>().initSharedData();
    if (!mounted) return;
    if(AddressHelper.getUserAddressFromSharedPref() != null && AddressHelper.getUserAddressFromSharedPref()!.zoneIds == null) {
      Get.find<AuthController>().clearSharedAddress();
    }
    if((AuthHelper.getGuestId().isNotEmpty || AuthHelper.isLoggedIn()) && Get.find<SplashController>().cacheModule != null) {
      Get.find<CartController>().getAllCarts();
    }
    if(Get.find<SplashController>().deeplinkRoute == null) {
      _route();
    }
  }

  @override
  void dispose() {
    _onConnectivityChanged?.cancel();
    super.dispose();
  }

  void _route() {
    Get.find<SplashController>().getConfigData(handleMaintenanceMode: false, notificationBody: widget.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _globalKey,
      body: GetBuilder<SplashController>(builder: (splashController) {
        return Center(
          child: splashController.hasConnection ? Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Image.asset(Images.logo, width: 200),
              const SizedBox(height: Dimensions.paddingSizeSmall),
            ],
          ) : NoInternetScreen(
            onRetry: _route,
            child: SplashScreen(body: widget.body, deeplinkUrl: widget.deeplinkUrl),
          ),
        );
      }),
    );
  }
}
