import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/checkout/controllers/checkout_controller.dart';
import 'package:sixam_mart/features/checkout/widgets_new/custom_card_checkout.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class DeliveryTypeSection extends StatefulWidget {
  final bool homeDeliveryEnabled;
  final bool takeAwayEnabled;
  final double total;
  final double charge;
  final List<CartModel?>? cartList;

  const DeliveryTypeSection({super.key,
    required this.homeDeliveryEnabled,
    required this.takeAwayEnabled,
    required this.total,
    required this.charge,
    this.cartList,
  });

  @override
  State<DeliveryTypeSection> createState() => _DeliveryTypeSectionState();
}

class _DeliveryTypeSectionState extends State<DeliveryTypeSection> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 200), () {
      if (!mounted) return;
      final bool isTakeawayOnly = Get.find<CartController>().isCartTakeawayOnly(widget.cartList);
      Get.find<CheckoutController>().setOrderType(
        isTakeawayOnly ? 'take_away' : (widget.homeDeliveryEnabled ? 'delivery' : 'take_away'),
        notify: true,
      );
    });
  }

  void _onSelect(String value) {
    if (Get.find<CartController>().isCartTakeawayOnly(widget.cartList) && value != 'take_away') {
      return;
    }
    final controller = Get.find<CheckoutController>();
    controller.setOrderType(value);
    controller.setInstruction(-1);

    if (controller.orderType == 'take_away') {
      if (controller.isPartialPay) {
        double tips = 0;
        try {
          tips = double.parse(controller.tipController.text);
        } catch (_) {}
        controller.checkBalanceStatus(widget.total, widget.charge + tips);
      }
    } else {
      if (controller.isPartialPay) {
        controller.changePartialPayment();
      } else {
        controller.setPaymentMethod(-1);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final bool isTakeawayOnly = Get.find<CartController>().isCartTakeawayOnly(widget.cartList);

    if (!widget.homeDeliveryEnabled && !widget.takeAwayEnabled && !isTakeawayOnly) {
      return const SizedBox.shrink();
    }

    return GetBuilder<CheckoutController>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.only(bottom: Dimensions.paddingSizeLarge),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomCardCheckout(
              child: Row(children: [
                if (!isTakeawayOnly && widget.homeDeliveryEnabled)
                  Expanded(child: _DeliveryTypeSegment(
                    title: 'home_delivery'.tr,
                    selected: controller.orderType == 'delivery',
                    onTap: () => _onSelect('delivery'),
                  )),
                if (widget.takeAwayEnabled || isTakeawayOnly)
                  Expanded(child: _DeliveryTypeSegment(
                    title: 'take_away'.tr,
                    selected: controller.orderType == 'take_away',
                    onTap: () => _onSelect('take_away'),
                  )),
              ]),
            ),

            if (isTakeawayOnly)
              Container(
                margin: const EdgeInsets.only(top: 8),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Theme.of(context).colorScheme.error.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: Theme.of(context).colorScheme.error.withOpacity(0.2)),
                ),
                child: Row(
                  children: [
                    Icon(Icons.info_outline, size: 18, color: Theme.of(context).colorScheme.error),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        'Your cart contains perishable items available for In-Store Pickup only. Home Delivery is disabled for this order.'.tr,
                        style: robotoRegular.copyWith(fontSize: Dimensions.fontSizeSmall),
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      );
    });
  }
}

class _DeliveryTypeSegment extends StatelessWidget {
  final String title;
  final bool selected;
  final VoidCallback onTap;

  const _DeliveryTypeSegment({required this.title, required this.selected, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(Dimensions.radiusExtraLarge),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(vertical: Dimensions.paddingSizeSmall + 2),
        decoration: BoxDecoration(
          color: selected ? Theme.of(context).primaryColor : Colors.transparent,
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge),
        ),
        alignment: Alignment.center,
        child: Text(
          title,
          style: robotoMedium.copyWith(
            color: selected ? Colors.white : Theme.of(context).hintColor,
          ),
        ),
      ),
    );
  }
}