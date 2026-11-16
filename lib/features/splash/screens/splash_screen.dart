import 'dart:async';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sixam_mart/common/enums/data_source_enum.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/features/auth/controllers/auth_controller.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/features/notification/domain/models/notification_body_model.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/route_helper.dart';
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
  Timer? _watchdogTimer;
  bool _hasNavigated = false;

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
        if(isConnected && !_hasNavigated) {
          if(Get.find<SplashController>().deeplinkRoute == null) {
            _route();
          }
        }
      }

      firstTime = false;
    });

    _initAndRoute();

    // Safety watchdog: ensure splash screen transitions even under network/cache jitter
    _watchdogTimer = Timer(const Duration(seconds: 5), () {
      if (mounted && !_hasNavigated) {
        final splashCtrl = Get.find<SplashController>();
        if (splashCtrl.configModel != null) {
          _hasNavigated = true;
          Get.offNamed(RouteHelper.getInitialRoute(fromSplash: true));
        } else {
          splashCtrl.getConfigData(source: DataSourceEnum.client, handleMaintenanceMode: false, notificationBody: widget.body);
        }
      }
    });
  }

  Future<void> _initAndRoute() async {
    try {
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
    } catch (e) {
      debugPrint('SplashScreen init error: $e');
      if (mounted && !_hasNavigated) {
        _route();
      }
    }
  }

  @override
  void dispose() {
    _watchdogTimer?.cancel();
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
