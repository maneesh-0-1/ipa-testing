import 'package:get/get.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';

class MaintenanceHelper{
  static bool isMaintenanceEnable() {
    final configModel = Get.find<SplashController>().configModel;
    final bool isMaintenanceMode = configModel?.maintenanceMode ?? false;
    final String platform = GetPlatform.isWeb ? 'user_web_app' : 'user_mobile_app';

    return isMaintenanceMode
        && configModel?.maintenanceModeData?.maintenanceSystemSetup != null
        && configModel!.maintenanceModeData!.maintenanceSystemSetup!.contains(platform);
  }
}