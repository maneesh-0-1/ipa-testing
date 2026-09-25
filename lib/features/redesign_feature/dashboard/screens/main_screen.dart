import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/controllers/theme_controller.dart';
import 'package:sixam_mart/common/widgets/back_to_top.dart';
import 'package:sixam_mart/features/home/screens/home_screen.dart';
import 'package:sixam_mart/features/home/widgets/refer_bottom_sheet_widget.dart';
import 'package:sixam_mart/features/location/controllers/location_controller.dart';
import 'package:sixam_mart/features/profile/controllers/profile_controller.dart';
import 'package:sixam_mart/features/redesign_feature/dashboard/domain/model/module_model.dart';
import 'package:sixam_mart/features/redesign_feature/dashboard/widgets/explore_restaurant_section.dart';
import 'package:sixam_mart/features/redesign_feature/dashboard/widgets/home_status_bar_tint.dart';
import 'package:sixam_mart/features/redesign_feature/dashboard/widgets/search_header_widget.dart';
import 'package:sixam_mart/features/redesign_feature/dashboard/widgets/top_header_widget.dart';
import 'package:sixam_mart/features/redesign_feature/food/screens/food_module_screen.dart';
import 'package:sixam_mart/features/redesign_feature/grocery/screens/grocery_module_screen.dart';
import 'package:sixam_mart/features/redesign_feature/parcel/screens/parcel_module_screen.dart';
import 'package:sixam_mart/features/redesign_feature/parcel/widget/parcel_deliver_to_header_widget.dart';
import 'package:sixam_mart/features/redesign_feature/pharmacy/screens/pharmacy_module_screen.dart';
import 'package:sixam_mart/features/rental_module/home/screens/rental_module_screen.dart';
import 'package:sixam_mart/features/redesign_feature/shop/screens/shop_module_screen.dart';
import 'package:sixam_mart/features/ride_share_module/ride_home/screens/ride_home_screen.dart';
import 'package:sixam_mart/features/ride_share_module/ride_order/controllers/ride_controller.dart';
import 'package:sixam_mart/features/service_module/service_home/screens/service_screen.dart';
import 'package:sixam_mart/features/splash/controllers/splash_controller.dart';
import 'package:sixam_mart/helper/address_helper.dart';
import 'package:sixam_mart/helper/auth_helper.dart';
import 'package:sixam_mart/helper/responsive_helper.dart';
import 'package:sixam_mart/util/app_constants.dart';
import 'package:sixam_mart/util/dimensions.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> with AutomaticKeepAliveClientMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _scrollViewKey = GlobalKey();
  final GlobalKey _searchHeaderKey = GlobalKey();
  final GlobalKey _exploreRestaurantFilterKey = GlobalKey();
  final GlobalKey _topHeaderKey = GlobalKey();
  bool _isSearchPinned = false;
  bool _isExploreRestaurantFilterPinned = false;
  double _pinnedTopFilterScrollOutOffset = 0;
  bool _showBackToTop = false;
  // Whether the top header (module tabs strip) has scrolled above the viewport.
  // Modules without a pinnable search header (parcel/rental/rideshare) rely on
  // this to tint the status bar like the other modules.
  bool _isTopHeaderScrolledOut = false;
  static const double _backToTopThreshold = 400;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_handleScroll);
    AuthHelper.isLoggedIn();

    HomeScreen.loadData(false).then((value) {
      Get.find<SplashController>().getReferBottomSheetStatus();
      if((Get.find<ProfileController>().userInfoModel?.isValidForDiscount??false) && Get.find<SplashController>().showReferBottomSheet) {
        _showReferBottomSheet();
      }
    });

    if(!ResponsiveHelper.isWeb()) {
      final String? lat = AddressHelper.getUserAddressFromSharedPref()?.latitude;
      final String? lng = AddressHelper.getUserAddressFromSharedPref()?.longitude;
      final String effectiveLat = (lat != null && lat.isNotEmpty) ? lat : AppConstants.defaultLatitude;
      final String effectiveLng = (lng != null && lng.isNotEmpty) ? lng : AppConstants.defaultLongitude;
      Get.find<LocationController>().getZone(
        effectiveLat,
        effectiveLng, false, updateInAddress: true,
      );
    }
  }

  @override
  void didUpdateWidget(covariant MainScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
  }

  void _handleScroll() {
    if(!_scrollController.hasClients) {
      return;
    }

    final double? searchHeaderTop = _getSearchHeaderTop();
    final bool isPinned = searchHeaderTop != null && searchHeaderTop <= 0;
    final double? exploreRestaurantFilterTop = _getExploreRestaurantFilterTop();
    final double pinnedTopFilterScrollOutOffset = _getPinnedTopFilterScrollOutOffset(exploreRestaurantFilterTop);
    final bool isExploreRestaurantFilterPinned = exploreRestaurantFilterTop != null && exploreRestaurantFilterTop <= SearchAndQuickFilterWidget.searchOnlyHeight;
    final bool showBackToTop = _scrollController.position.pixels > _backToTopThreshold;
    final bool isTopHeaderScrolledOut = _getIsTopHeaderScrolledOut();

    if(isPinned != _isSearchPinned || isExploreRestaurantFilterPinned != _isExploreRestaurantFilterPinned || pinnedTopFilterScrollOutOffset != _pinnedTopFilterScrollOutOffset || showBackToTop != _showBackToTop || isTopHeaderScrolledOut != _isTopHeaderScrolledOut) {
      setState(() {
        _isSearchPinned = isPinned;
        _isExploreRestaurantFilterPinned = isExploreRestaurantFilterPinned;
        _pinnedTopFilterScrollOutOffset = pinnedTopFilterScrollOutOffset;
        _showBackToTop = showBackToTop;
        _isTopHeaderScrolledOut = isTopHeaderScrolledOut;
      });
    }
  }

  // True once the top header's bottom edge has passed above the viewport top,
  // i.e. module content (cardColor) now sits behind the status bar. Used to tint
  // the status bar for modules that have no pinnable search header.
  bool _getIsTopHeaderScrolledOut() {
    final BuildContext? topHeaderContext = _topHeaderKey.currentContext;
    final BuildContext? scrollContext = _scrollViewKey.currentContext;
    if(topHeaderContext == null || scrollContext == null) {
      return _isTopHeaderScrolledOut;
    }

    final RenderObject? topHeaderObject = topHeaderContext.findRenderObject();
    final RenderObject? scrollObject = scrollContext.findRenderObject();
    if(topHeaderObject is! RenderBox || scrollObject is! RenderBox || !topHeaderObject.attached || !scrollObject.attached) {
      return _isTopHeaderScrolledOut;
    }

    final double topHeaderBottom = topHeaderObject.localToGlobal(Offset(0, topHeaderObject.size.height)).dy - scrollObject.localToGlobal(Offset.zero).dy;
    return topHeaderBottom <= 0;
  }

  void _scrollToTop() {
    if (!_scrollController.hasClients) {
      return;
    }
    _scrollController.animateTo(0, duration: const Duration(milliseconds: 400), curve: Curves.easeOut);
  }

  // The per-frame measurement in _handleScroll reads localToGlobal one frame
  // behind the actual scroll, so when scrolling stops the last value can be
  // stale (e.g. the pinned top-filter scroll-out offset doesn't settle to its
  // right position). When the scroll goes idle, re-measure once the final
  // layout has been laid out so every pinned offset lands correctly.
  bool _onScrollEnd(ScrollEndNotification notification) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _handleScroll();
      }
    });
    return false;
  }

  double _getPinnedTopFilterScrollOutOffset(double? filterTop) {
    if(filterTop == null) {
      return 0;
    }

    return (SearchAndQuickFilterWidget.height - filterTop).clamp(0, SearchAndQuickFilterWidget.topFilterHeight).toDouble();
  }

  double? _getSearchHeaderTop() {
    final BuildContext? searchHeaderContext = _searchHeaderKey.currentContext;
    final BuildContext? scrollContext = _scrollViewKey.currentContext;

    if(searchHeaderContext == null || scrollContext == null) {
      return null;
    }

    final RenderObject? searchHeaderObject = searchHeaderContext.findRenderObject();
    final RenderObject? scrollObject = scrollContext.findRenderObject();

    if(searchHeaderObject is! RenderBox || scrollObject is! RenderBox || !searchHeaderObject.attached || !scrollObject.attached) {
      return null;
    }

    return searchHeaderObject.localToGlobal(Offset.zero).dy - scrollObject.localToGlobal(Offset.zero).dy;
  }

  double? _getExploreRestaurantFilterTop() {
    final BuildContext? filterContext = _exploreRestaurantFilterKey.currentContext;
    final BuildContext? scrollContext = _scrollViewKey.currentContext;

    if(filterContext == null || scrollContext == null) {
      return null;
    }

    final RenderObject? filterObject = filterContext.findRenderObject();
    final RenderObject? scrollObject = scrollContext.findRenderObject();

    if(filterObject is! RenderBox || scrollObject is! RenderBox || !filterObject.attached || !scrollObject.attached) {
      return null;
    }

    return filterObject.localToGlobal(Offset.zero).dy - scrollObject.localToGlobal(Offset.zero).dy;
  }

  @override
  void dispose() {
    _scrollController.removeListener(_handleScroll);
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> _onRefresh(ModuleModel selectedModule) async {
    final SplashController splashController = Get.find<SplashController>();
    splashController.setRefreshing(true);

    final String label = selectedModule.label.toLowerCase();
    final String moduleType = selectedModule.moduleType?.toLowerCase() ?? '';
    if (label == 'rideshare' || moduleType == AppConstants.ride) {
      await RideHomeScreen.loadData();
    } else if (label == 'rental' || moduleType == AppConstants.taxi) {
      await HomeScreen.loadTaxiApis();
    } else if (label == 'service' || moduleType == AppConstants.service) {
      await ServiceScreen.loadData();
    } else {
      await HomeScreen.loadData(true, fromModule: true);
    }

    splashController.setRefreshing(false);
  }

  void _showReferBottomSheet() {
    ResponsiveHelper.isDesktop(context) ? Get.dialog(
      Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge)),
        insetPadding: const EdgeInsets.all(22),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: const ReferBottomSheetWidget(),
      ),
      useSafeArea: false,
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false))
        : showModalBottomSheet(
      isScrollControlled: true, useRootNavigator: true, context: Get.context!,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(Dimensions.radiusExtraLarge), topRight: Radius.circular(Dimensions.radiusExtraLarge)),
      ),
      builder: (context) {
        return ConstrainedBox(
          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.8),
          child: const ReferBottomSheetWidget(),
        );
      },
    ).then((value) => Get.find<SplashController>().saveReferBottomSheetStatus(false));
  }

  ModuleModel _getSelectedModuleSelection(SplashController splashController) {
    if (splashController.module != null) {
      final module = splashController.module!;
      final String moduleType = module.moduleType?.toString() ?? AppConstants.food;
      return ModuleModel(label: _moduleLabel(module.moduleName, moduleType), moduleType: moduleType);
    }
    if (splashController.moduleList != null && splashController.moduleList!.isNotEmpty) {
      final module = splashController.moduleList![0];
      final String moduleType = module.moduleType?.toString() ?? AppConstants.food;
      return ModuleModel(label: _moduleLabel(module.moduleName, moduleType), moduleType: moduleType);
    }
    return const ModuleModel(label: 'Food', moduleType: AppConstants.food);
  }

  Widget _buildModuleView(ModuleModel selectedModule) {
    final String moduleType = selectedModule.moduleType?.toLowerCase() ?? '';
    final String label = selectedModule.label.toLowerCase();

    if (moduleType == AppConstants.food || label == 'food' || label == 'b.laban' || label == 'blaban') {
      return FoodModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
        scrollController: _scrollController,
        isSearchPinned: _isSearchPinned,
      );
    } else if (moduleType == AppConstants.grocery || label == 'grocery') {
      return GroceryModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
        scrollController: _scrollController,
        isSearchPinned: _isSearchPinned,
      );
    } else if (moduleType == AppConstants.pharmacy || label == 'pharmacy') {
      return PharmacyModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
        scrollController: _scrollController,
        isSearchPinned: _isSearchPinned,
      );
    } else if (moduleType == AppConstants.ecommerce || label == 'shop' || label == 'ecommerce') {
      return ShopModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
        scrollController: _scrollController,
        isSearchPinned: _isSearchPinned,
      );
    } else if (moduleType == AppConstants.parcel || label == 'parcel') {
      return ParcelModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
      );
    } else if (moduleType == AppConstants.taxi || label == 'rental' || label == 'taxi') {
      return RentalModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
      );
    } else if (moduleType == AppConstants.ride || label == 'rideshare' || label == 'ride') {
      return const RideHomeScreen();
    } else if (moduleType == AppConstants.service || label == 'service') {
      return ServiceScreen(scrollController: _scrollController);
    } else {
      return FoodModuleScreen(
        searchHeaderKey: _searchHeaderKey,
        exploreRestaurantKey: _exploreRestaurantFilterKey,
        scrollController: _scrollController,
        isSearchPinned: _isSearchPinned,
      );
    }
  }

  String _moduleLabel(String? moduleName, String moduleType) {
    if(moduleName != null && moduleName.trim().isNotEmpty) {
      return moduleName;
    }

    if(moduleType == AppConstants.food) {
      return 'Food';
    } else if(moduleType == AppConstants.grocery) {
      return 'Grocery';
    } else if(moduleType == AppConstants.ecommerce) {
      return 'Shop';
    } else if(moduleType == AppConstants.pharmacy) {
      return 'Pharmacy';
    } else if(moduleType == AppConstants.ride) {
      return 'rideshare';
    }

    return moduleType.isNotEmpty ? moduleType : 'Module';
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return GetBuilder<SplashController>(builder: (splashController) {
      ModuleModel selectedModule = _getSelectedModuleSelection(splashController);

      final String currentModuleType = selectedModule.moduleType?.toLowerCase() ?? '';
      final bool isParcelModule = currentModuleType == AppConstants.parcel || selectedModule.label.toLowerCase() == 'parcel';
      final bool showPinnedSearch = _isSearchPinned;
      final bool showPinnedExploreRestaurantFilter = _isSearchPinned && _isExploreRestaurantFilterPinned;

      // Status bar tint: matches the TopHeaderWidget (disabled tint) at the top, and
      // the pinned search bar (card color) once the search layer sticks.
      final bool isDark = Get.find<ThemeController>().darkTheme;
      // Opaque equivalent of the TopHeaderWidget tint (disabledColor@30 over card) so
      // it can back the status bar without a semi-transparent color bleeding to the window.
      final Color topStatusBarColor = Color.alphaBlend(
        Theme.of(context).disabledColor.withAlpha(30),
        Theme.of(context).cardColor,
      );
      final Color statusBarColor = (_isSearchPinned || _isTopHeaderScrolledOut) ? Theme.of(context).cardColor : topStatusBarColor;

      // Publish the tint so the root overlay can hold the status-bar colour above
      // modal barriers (bottom sheets / dialogs) opened from the home tab.
      if (!ResponsiveHelper.isWeb()) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          if (mounted) {
            HomeStatusBarTint.color.value = statusBarColor;
          }
        });
      }

      return AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle(
          statusBarColor: statusBarColor,
          statusBarIconBrightness: isDark ? Brightness.light : Brightness.dark,
          statusBarBrightness: isDark ? Brightness.dark : Brightness.light,
        ),
        child: Scaffold(
        extendBody: true,
        backgroundColor: Theme.of(context).cardColor,
        // endDrawer: const MenuDrawer(),
        // endDrawerEnableOpenDragGesture: false,
        // bottomNavigationBar: BottomNavigationWidget(padding: Dimensions.paddingSizeDefault),
        body: Column(
          children: [
            // Only the status-bar strip carries the dynamic tint; the body keeps
            // cardColor so the header (which adds its own tint) isn't double-tinted.
            Container(height: MediaQuery.paddingOf(context).top, color: statusBarColor),
            Expanded(child: SafeArea(
              top: false,
              bottom: false,
              child: Stack(
                clipBehavior: Clip.hardEdge,
                children: [
              NotificationListener<ScrollEndNotification>(
                onNotification: _onScrollEnd,
                child: RefreshIndicator(
                onRefresh: () => _onRefresh(selectedModule),
                child: CustomScrollView(
                  key: _scrollViewKey,
                  controller: _scrollController,
                  physics: const AlwaysScrollableScrollPhysics(),
                  slivers: [
                    // Section: top header without module tabs (Blaban direct load)
                    SliverToBoxAdapter(child: TopHeaderWidget(key: _topHeaderKey, isHomeModule: false, isParcelModule: isParcelModule, showModuleTabs: false)),

                    // module view
                    _buildModuleView(selectedModule),
                  ],
                ),
              ),
              ),

              if(showPinnedSearch)
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if(isParcelModule) const ParcelDeliverToHeaderWidget(),
                      SearchAndQuickFilterWidget(isPinned: true, showQuickFilters: true, topFilterScrollOutOffset: _pinnedTopFilterScrollOutOffset, isHomeModule: false, showBottomDivider: !showPinnedExploreRestaurantFilter,),
                    ],
                  ),
                ),

              if(showPinnedExploreRestaurantFilter)
                const Positioned(
                  top: SearchAndQuickFilterWidget.searchOnlyHeight,
                  left: 0,
                  right: 0,
                  child: FoodModuleExploreRestaurantFilterHeaderWidget(showBottomDivider: true),
                ),

              if(selectedModule.moduleType == AppConstants.ride || selectedModule.label.toLowerCase() == 'rideshare')
                GetBuilder<RideController>(builder: (rideController) =>
                rideController.tripDetails != null || rideController.rideDetails != null
                    ? const Positioned(
                  right: 20,
                  bottom: 100,
                  child: _RideTrackButton(),
                )
                    : const SizedBox(),
                ),

              BackToTopButton(visible: _showBackToTop, onTap: _scrollToTop),
            ],
          ),
        )),
          ],
        ),
        ));
    });
  }
}

class _RideTrackButton extends StatefulWidget {
  const _RideTrackButton();

  @override
  State<_RideTrackButton> createState() => _RideTrackButtonState();
}

class _RideTrackButtonState extends State<_RideTrackButton> with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Get.find<RideController>().getCurrentRideStatus(fromRefresh: true, showCustomLoader: true),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // Primary color button
          Container(
            height: 38,
            width: 38,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Theme.of(context).disabledColor.withValues(alpha: 0.5),
                  blurRadius: 12,
                  spreadRadius: 1,
                ),
              ],
            ),
            child: Icon(Icons.directions_car_rounded, size: 24, color: Theme.of(context).cardColor),
          ),
          // Red dot with ripple animation at top-right
          Positioned(
            top: 0,
            right: 0,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Expanding ripple 1
                ScaleTransition(
                  scale: Tween<double>(begin: 0.8, end: 2.0).animate(
                    CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
                  ),
                  child: Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.withValues(alpha: 0.3), width: 1.5),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Expanding ripple 2
                ScaleTransition(
                  scale: Tween<double>(begin: 0.5, end: 1.6).animate(
                    CurvedAnimation(
                      parent: _animationController,
                      curve: const Interval(0.15, 1.0, curve: Curves.easeOut),
                    ),
                  ),
                  child: Container(
                    height: 14,
                    width: 14,
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.red.withValues(alpha: 0.2), width: 1),
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
                // Red live dot
                Container(
                  height: 14,
                  width: 14,
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.red.withValues(alpha: 0.7),
                        blurRadius: 6,
                        spreadRadius: 1,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
