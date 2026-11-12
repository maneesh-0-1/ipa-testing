import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:sixam_mart/common/widgets/custom_snackbar.dart';
import 'package:sixam_mart/helper/route_helper.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/images.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoInternetScreen extends StatelessWidget {
  final Widget? child;
  final VoidCallback? onRetry;
  const NoInternetScreen({super.key, this.child, this.onRetry});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.height*0.025),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(Images.noInternet, width: 300, height: 300),
            Text('oops'.tr, style: robotoBold.copyWith(
              fontSize: 30,
              color: Theme.of(context).textTheme.bodyLarge!.color,
            )),
            const SizedBox(height: Dimensions.paddingSizeExtraSmall),
            Text(
              'no_internet_connection'.tr,
              textAlign: TextAlign.center,
              style: robotoRegular.copyWith(color: Theme.of(context).disabledColor),
            ),
            const SizedBox(height: 40),

            GestureDetector(
              onTap: () async {
                final List<ConnectivityResult> connectivityResult = await (Connectivity().checkConnectivity());
                final bool offline = connectivityResult.isEmpty ||
                    (connectivityResult.length == 1 && connectivityResult.contains(ConnectivityResult.none));
                if(!offline) {
                  if (onRetry != null) {
                    onRetry!();
                  } else if (child != null) {
                    Get.off(() => child!);
                  } else {
                    Get.offAllNamed(RouteHelper.getInitialRoute());
                  }
                } else {
                  showCustomSnackBar('no_internet_connection'.tr);
                }
              },
              child: Container(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Theme.of(context).primaryColor,
                ),
                padding: const EdgeInsets.all(10),
                child: InkWell(
                  child: Center(child: Icon(Icons.refresh, size: 34, color: Theme.of(context).cardColor)),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }
}
