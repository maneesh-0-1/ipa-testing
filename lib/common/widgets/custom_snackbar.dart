import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

String? _lastSnackbarMessage;
DateTime? _lastSnackbarTime;

/// Modern floating snackbar (replaces the old Fluttertoast). Same signature as
/// before so every existing call site keeps working — `getXSnackBar` is accepted
/// for compatibility but no longer changes behaviour.
void showCustomSnackBar(String? message, {bool isError = true, bool getXSnackBar = false, int? showDuration, double? bottomMargin, String? actionLabel, VoidCallback? onAction}) {
  if (message == null || message.trim().isEmpty) return;

  // Never display raw HTML error pages (e.g. 503 Service Unavailable / 500) as snackbars
  if (message.contains('<!DOCTYPE') || message.contains('<html') || message.contains('<body')) return;

  final now = DateTime.now();
  if (_lastSnackbarMessage == message && _lastSnackbarTime != null && now.difference(_lastSnackbarTime!).inMilliseconds < 2500) {
    return;
  }
  _lastSnackbarMessage = message;
  _lastSnackbarTime = now;

  // Safely close currently open snackbar
  if (Get.isSnackbarOpen) {
    Get.closeCurrentSnackbar();
  }

  final Color background = isError ? const Color(0xFFD32F2F) : const Color(0xFF039D55);

  Get.showSnackbar(GetSnackBar(
    snackPosition: SnackPosition.BOTTOM,
    backgroundColor: background,
    borderRadius: Dimensions.radiusDefault,
    margin: EdgeInsets.fromLTRB(
      Dimensions.paddingSizeDefault, 0, Dimensions.paddingSizeDefault, bottomMargin ?? Dimensions.paddingSizeDefault,
    ),
    padding: const EdgeInsets.symmetric(
      horizontal: Dimensions.paddingSizeDefault, vertical: Dimensions.paddingSizeDefault,
    ),
    duration: Duration(seconds: showDuration ?? 2),
    animationDuration: const Duration(milliseconds: 350),
    forwardAnimationCurve: Curves.easeOutCirc,
    reverseAnimationCurve: Curves.easeInCirc,
    isDismissible: true,
    dismissDirection: DismissDirection.horizontal,
    boxShadows: <BoxShadow>[
      BoxShadow(color: Colors.black.withValues(alpha: 0.18), blurRadius: 12, offset: const Offset(0, 4)),
    ],
    mainButton: (actionLabel != null && onAction != null) ? TextButton(
      onPressed: () {
        Get.closeAllSnackbars();
        onAction();
      },
      child: Text(actionLabel, style: robotoMedium.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault)),
    ) : null,
    messageText: Row(children: <Widget>[
      Icon(isError ? Icons.error_outline_rounded : Icons.check_circle_outline_rounded, color: Colors.white, size: 22),
      const SizedBox(width: Dimensions.paddingSizeSmall),
      Expanded(
        child: Text(
          message,
          style: robotoMedium.copyWith(color: Colors.white, fontSize: Dimensions.fontSizeDefault),
        ),
      ),
    ]),
  ));
}
