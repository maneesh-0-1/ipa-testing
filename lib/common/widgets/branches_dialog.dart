import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';
import 'package:url_launcher/url_launcher_string.dart';

class BranchModel {
  final String nameKey;
  final String fallbackName;
  final String locationKey;
  final String fallbackLocation;
  final String mapUrl;

  const BranchModel({
    required this.nameKey,
    required this.fallbackName,
    required this.locationKey,
    required this.fallbackLocation,
    required this.mapUrl,
  });
}

class BranchesDialog extends StatelessWidget {
  const BranchesDialog({super.key});

  static const List<BranchModel> branches = [
    BranchModel(
      nameKey: 'salmiya_branch',
      fallbackName: 'Salmiya Branch',
      locationKey: 'salmiya_kuwait',
      fallbackLocation: 'Salmiya, Kuwait',
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=B+LABAN+Salmiya+Kuwait&query_place_id=ChIJu-4_JACdzz8R23EbzejO60w',
    ),
    BranchModel(
      nameKey: 'hawally_branch',
      fallbackName: 'Hawally Branch',
      locationKey: 'hawally_kuwait',
      fallbackLocation: 'Hawally, Kuwait',
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=B.LABAN+Hawally+Kuwait&query_place_id=ChIJnZVhMACdzz8RvkJ7X07B8KA',
    ),
    BranchModel(
      nameKey: 'fahaheel_branch',
      fallbackName: 'Fahaheel Branch',
      locationKey: 'fahaheel_kuwait',
      fallbackLocation: 'Fahaheel, Kuwait',
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=B.+Laban+Fahaheel+Kuwait&query_place_id=ChIJWbkSEQAHzz8RS84AiOl3yR4',
    ),
    BranchModel(
      nameKey: 'farwaniya_branch',
      fallbackName: 'Farwaniya Branch',
      locationKey: 'farwaniya_kuwait',
      fallbackLocation: 'Farwaniya, Kuwait',
      mapUrl: 'https://www.google.com/maps/search/?api=1&query=B-Laban+Farwaniya+Kuwait&query_place_id=ChIJ6aaFZgCbzz8RgF70yC8HY0w',
    ),
  ];

  static Future<void> openMap(String url) async {
    try {
      if (await canLaunchUrlString(url)) {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      } else {
        await launchUrlString(url, mode: LaunchMode.externalApplication);
      }
    } catch (_) {
      await launchUrlString(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final String title = 'our_branches'.tr.isNotEmpty && 'our_branches'.tr != 'our_branches'
        ? 'our_branches'.tr
        : 'Our Branches';
    final String subtitle = 'select_branch_to_view_location'.tr.isNotEmpty && 'select_branch_to_view_location'.tr != 'select_branch_to_view_location'
        ? 'select_branch_to_view_location'.tr
        : 'Select a branch to view on Google Maps';

    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusDefault)),
      insetPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      clipBehavior: Clip.antiAliasWithSaveLayer,
      backgroundColor: Theme.of(context).cardColor,
      child: PointerInterceptor(
        child: Container(
          width: 480,
          padding: const EdgeInsets.all(Dimensions.paddingSizeLarge),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // Header
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(Icons.storefront_rounded, color: Theme.of(context).primaryColor, size: 24),
                  ),
                  const SizedBox(width: Dimensions.paddingSizeSmall),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          title,
                          style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          subtitle,
                          style: robotoRegular.copyWith(
                            fontSize: Dimensions.fontSizeExtraSmall,
                            color: Theme.of(context).hintColor,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close_rounded, color: Theme.of(context).disabledColor),
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                    splashRadius: 20,
                    onPressed: () => Get.back(),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeDefault),
              Divider(height: 1, color: Theme.of(context).disabledColor.withValues(alpha: 0.2)),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              // Branches list
              Flexible(
                child: SingleChildScrollView(
                  child: Column(
                    children: branches.map((branch) {
                      final String branchName = branch.nameKey.tr.isNotEmpty && branch.nameKey.tr != branch.nameKey
                          ? branch.nameKey.tr
                          : branch.fallbackName;
                      final String branchLocation = branch.locationKey.tr.isNotEmpty && branch.locationKey.tr != branch.locationKey
                          ? branch.locationKey.tr
                          : branch.fallbackLocation;

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 6),
                        child: Material(
                          color: Theme.of(context).cardColor,
                          borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            onTap: () {
                              Get.back();
                              openMap(branch.mapUrl);
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                                border: Border.all(
                                  color: Theme.of(context).primaryColor.withValues(alpha: 0.15),
                                  width: 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                      color: Theme.of(context).primaryColor.withValues(alpha: 0.08),
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    child: Icon(
                                      Icons.location_on_rounded,
                                      color: Theme.of(context).primaryColor,
                                      size: 22,
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          branchName,
                                          style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                        ),
                                        const SizedBox(height: 3),
                                        Row(
                                          children: [
                                            Text(
                                              branchLocation,
                                              style: robotoRegular.copyWith(
                                                fontSize: Dimensions.fontSizeExtraSmall,
                                                color: Theme.of(context).hintColor,
                                              ),
                                            ),
                                            const SizedBox(width: 8),
                                            Container(
                                              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                                              decoration: BoxDecoration(
                                                color: Colors.red.withValues(alpha: 0.1),
                                                borderRadius: BorderRadius.circular(4),
                                              ),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.min,
                                                children: [
                                                  const Icon(Icons.map_rounded, size: 10, color: Colors.red),
                                                  const SizedBox(width: 3),
                                                  Text(
                                                    'Google Maps',
                                                    style: robotoMedium.copyWith(
                                                      fontSize: 9,
                                                      color: Colors.red,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(width: Dimensions.paddingSizeSmall),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    size: 14,
                                    color: Theme.of(context).disabledColor,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
