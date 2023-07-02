import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:hitek_test/modules/cart/cart_controller.dart';
import 'package:hitek_test/utils/dialog_utils.dart';

import '../../common/theme/app_color.dart';
import '../../data/models/product.dart';
import '../../utils/formatter.dart';
import '../../utils/image_path.dart';
import '../../widgets/scale_tap.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key, required this.controller});

  final CartController controller;

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> with AutomaticKeepAliveClientMixin {
  CartController get _cartController => widget.controller;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<dynamic>(
      stream: _cartController.cartControllerStream,
      builder: (context, snapshot) {
        return Container(
          color: isDarkMode() ? null : AppColor.STORE_BG_WHITE,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: CustomScrollView(
            controller: _cartController.scrollController,
            physics: const BouncingScrollPhysics(),
            slivers: [
              SliverAppBar(
                pinned: true,
                snap: false,
                floating: false,
                expandedHeight: 150,
                elevation: 0,
                automaticallyImplyLeading: false,
                backgroundColor: AppColor.TRANSPARENT,
                flexibleSpace: Container(
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [AppColor.APP_BAR_START, AppColor.APP_BAR_END],
                    ),
                  ),
                  child: FlexibleSpaceBar(
                    titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    title: Transform.translate(
                      offset: _cartController.titleState
                          ? Offset(0, _cartController.animationValue)
                          : const Offset(0, 0),
                      child: Text(
                        "Giỏ hàng",
                        style: TextStyle(
                          fontSize: _cartController.titleState ? 20 : 30,
                          color: AppColor.DEFAULT_BLACK,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    centerTitle: _cartController.titleState ? true : false,
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              if (CartController.listProductInCart.length > 1)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    child: Row(
                      children: [
                        Expanded(child: Container()),
                        ScaleTap(
                          onTap: () {
                            DialogUtils.showOptionalDialog(
                              title: "Đặt hàng",
                              content: "Bạn có muốn đặt hàng cho tất cả sản phẩm trong giỏ hàng?",
                              onConfirm: () {
                                CartController.removeAllProduct();
                                SnackBar snackBar = const SnackBar(
                                  duration: Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  content:
                                      Text('Đặt hàng thành công. Sản phẩm đang chờ được xác nhận.'),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              },
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: AppColor.DEFAULT_BLUE,
                                borderRadius: BorderRadius.circular(10)),
                            child: const Text(
                              "Đặt hàng tất cả",
                              style: TextStyle(
                                fontSize: 16,
                                color: AppColor.DEFAULT_WHITE,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              SliverList.list(
                children: List.generate(
                  CartController.listProductInCart.length,
                  (index) {
                    Product product = CartController.listProductInCart[index];
                    return _productItemWidget(product);
                  },
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 100,
                ),
              )
            ],
          ),
        );
      },
    );
  }

  _productItemWidget(Product? product) {
    return TweenAnimationBuilder(
      tween: Tween<double>(
        begin: 0.5,
        end: 1,
      ),
      duration: const Duration(milliseconds: 500),
      builder: (context, value, child) {
        return Transform.scale(
          scale: value,
          child: Opacity(
            opacity: value,
            child: Container(
              margin: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: isDarkMode() ? AppColor.WHITE_OPACITY_20 : AppColor.DEFAULT_WHITE,
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: isDarkMode() ? AppColor.TRANSPARENT : Colors.grey.withOpacity(0.25),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: const Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ClipRRect(
                    borderRadius: const BorderRadius.only(
                      topLeft: Radius.circular(10),
                      bottomLeft: Radius.circular(10),
                    ),
                    child: Image.network(
                      product!.thumbnail!,
                      fit: BoxFit.cover,
                      width: 100,
                      height: 100,
                    ),
                  ),
                  Flexible(
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          Text(
                            "${product.title}",
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                              fontWeight: FontWeight.bold,
                            ),
                            maxLines: 1,
                          ),
                          Text(
                            "${product.description}",
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 1,
                          ),
                          Text.rich(
                            TextSpan(
                                text: "SL: ",
                                style: const TextStyle(
                                  fontSize: 16,
                                ),
                                children: [
                                  TextSpan(
                                      text: "${product.amountInCart}",
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: AppColor.DEFAULT_BLUE,
                                        fontWeight: FontWeight.bold,
                                      ))
                                ]),
                          ),
                          Align(
                            alignment: AlignmentDirectional.bottomEnd,
                            child: Text(
                              "${Formatter.formatNumber(product.price.toString())} đ",
                              style: const TextStyle(
                                fontSize: 16,
                                color: AppColor.DEFAULT_RED,
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    width: 100,
                    height: 100,
                    padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        ScaleTap(
                          onTap: () {
                            DialogUtils.showOptionalDialog(
                              title: "Bỏ sản phẩm",
                              content: "Bạn có muốn bỏ sản phẩm ${product.title} ra khỏi giỏ hàng?",
                              onConfirm: () {
                                CartController.removeProduct(product);
                                SnackBar snackBar = SnackBar(
                                  duration: const Duration(seconds: 2),
                                  behavior: SnackBarBehavior.floating,
                                  content: Text("Bạn đã bỏ chọn sản phẩm ${product.title}."),
                                );
                                ScaffoldMessenger.of(context).showSnackBar(snackBar);
                              },
                            );
                          },
                          child: const Text(
                            "Bỏ chọn",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.DEFAULT_RED,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ScaleTap(
                          onTap: () {
                            DialogUtils.showConfirmOrderDialog(
                              product: product,
                              amount: product.amountInCart!,
                            );
                          },
                          child: const Text(
                            "Đặt hàng",
                            style: TextStyle(
                              fontSize: 16,
                              color: AppColor.DEFAULT_BLUE,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        );
      },
    );
  }

  bool isDarkMode() {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  @override
  bool get wantKeepAlive => true;
}
