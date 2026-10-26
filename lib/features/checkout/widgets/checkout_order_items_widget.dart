import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sixam_mart/common/widgets/custom_image.dart';
import 'package:sixam_mart/features/cart/controllers/cart_controller.dart';
import 'package:sixam_mart/features/cart/domain/models/cart_model.dart';
import 'package:sixam_mart/features/checkout/widgets_new/custom_card_checkout.dart';
import 'package:sixam_mart/helper/price_converter.dart';
import 'package:sixam_mart/util/dimensions.dart';
import 'package:sixam_mart/util/styles.dart';

class CheckoutOrderItemsWidget extends StatelessWidget {
  final List<CartModel?>? cartList;
  const CheckoutOrderItemsWidget({super.key, required this.cartList});

  @override
  Widget build(BuildContext context) {
    if (cartList == null || cartList!.isEmpty) {
      return const SizedBox.shrink();
    }

    return GetBuilder<CartController>(
      builder: (cartController) {
        final List<CartModel> items = cartController.cartList.isNotEmpty
            ? cartController.cartList
            : cartList!.whereType<CartModel>().toList();

        if (items.isEmpty) return const SizedBox.shrink();

        return CustomCardCheckout(
          padding: const EdgeInsets.all(Dimensions.paddingSizeDefault),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'order_summary'.tr,
                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeLarge),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: Dimensions.paddingSizeSmall,
                      vertical: Dimensions.paddingSizeExtraSmall,
                    ),
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                    ),
                    child: Text(
                      '${items.length} ${items.length == 1 ? 'item'.tr : 'items'.tr}',
                      style: robotoMedium.copyWith(
                        fontSize: Dimensions.fontSizeSmall,
                        color: Theme.of(context).primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),
              Divider(
                height: 1,
                thickness: 0.5,
                color: Theme.of(context).disabledColor.withValues(alpha: 0.2),
              ),
              const SizedBox(height: Dimensions.paddingSizeSmall),

              ConstrainedBox(
                constraints: const BoxConstraints(maxHeight: 280),
                child: Scrollbar(
                  thumbVisibility: items.length > 2,
                  child: ListView.separated(
                    shrinkWrap: true,
                    physics: items.length > 2
                        ? const AlwaysScrollableScrollPhysics()
                        : const NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.zero,
                    itemCount: items.length,
                    separatorBuilder: (context, index) => Divider(
                      height: Dimensions.paddingSizeLarge,
                      thickness: 0.5,
                      color: Theme.of(context).disabledColor.withValues(alpha: 0.15),
                    ),
                    itemBuilder: (context, index) {
                      final CartModel cart = items[index];
                      final double itemPrice = (cart.discountedPrice ?? cart.price ?? 0);
                      final bool isLoading = cartController.isLoading;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            child: CustomImage(
                              image: cart.item?.imageFullUrl ?? '',
                              height: 52,
                              width: 52,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  cart.item?.name ?? '',
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: robotoMedium.copyWith(fontSize: Dimensions.fontSizeDefault),
                                ),
                                const SizedBox(height: Dimensions.paddingSizeExtraSmall),
                                Text(
                                  PriceConverter.convertPrice(itemPrice),
                                  style: robotoBold.copyWith(
                                    fontSize: Dimensions.fontSizeSmall,
                                    color: Theme.of(context).primaryColor,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(width: Dimensions.paddingSizeSmall),

                          Container(
                            decoration: BoxDecoration(
                              color: Theme.of(context).disabledColor.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(Dimensions.radiusSmall),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                InkWell(
                                  onTap: isLoading ? null : () {
                                    if ((cart.quantity ?? 1) > 1) {
                                      cartController.setQuantity(
                                        false, index, cart.stock, cart.quantityLimit,
                                      );
                                    }
                                  },
                                  borderRadius: const BorderRadius.only(
                                    topLeft: Radius.circular(Dimensions.radiusSmall),
                                    bottomLeft: Radius.circular(Dimensions.radiusSmall),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: Icon(
                                      Icons.remove_rounded,
                                      size: 16,
                                      color: (cart.quantity ?? 1) <= 1 || isLoading
                                          ? Theme.of(context).disabledColor
                                          : Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ),

                                Padding(
                                  padding: const EdgeInsets.symmetric(horizontal: Dimensions.paddingSizeExtraSmall),
                                  child: Text(
                                    '${cart.quantity ?? 1}',
                                    style: robotoBold.copyWith(fontSize: Dimensions.fontSizeDefault),
                                  ),
                                ),

                                InkWell(
                                  onTap: isLoading ? null : () {
                                    final int? modId = cart.item?.moduleId ?? (cartController.cartList.isNotEmpty ? cartController.cartList[0].item?.moduleId : null);
                                    if (modId != null) {
                                      cartController.forcefullySetModule(modId);
                                    }
                                    cartController.setQuantity(
                                      true, index, cart.stock, cart.quantityLimit,
                                    );
                                  },
                                  borderRadius: const BorderRadius.only(
                                    topRight: Radius.circular(Dimensions.radiusSmall),
                                    bottomRight: Radius.circular(Dimensions.radiusSmall),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(Dimensions.paddingSizeSmall),
                                    child: Icon(
                                      Icons.add_rounded,
                                      size: 16,
                                      color: isLoading
                                          ? Theme.of(context).disabledColor
                                          : Theme.of(context).textTheme.bodyLarge?.color,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
