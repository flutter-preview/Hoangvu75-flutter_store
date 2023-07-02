import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/main/main_controller.dart';
import 'package:hitek_test/modules/store/store_controller.dart';
import 'package:hitek_test/utils/dialog_utils.dart';
import 'package:hitek_test/utils/formatter.dart';
import 'package:hitek_test/utils/image_path.dart';
import 'package:hitek_test/widgets/animated_loading_label.dart';
import 'package:hitek_test/widgets/scale_tap.dart';

import '../../data/models/product.dart';
import '../cart/cart_controller.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key, required this.controller});

  final StoreController controller;

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> with AutomaticKeepAliveClientMixin {
  StoreController get _storeController => widget.controller;

  @override
  void initState() {
    super.initState();
    _storeController.onGetProduct();
  }

  @override
  void dispose() {
    super.dispose();
    _storeController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return StreamBuilder<dynamic>(
      stream: _storeController.storeControllerStream,
      builder: (context, snapshot) {
        return Container(
          color: isDarkMode() ? null : AppColor.STORE_BG_WHITE,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: RefreshIndicator(
            onRefresh: () => _storeController.onRefreshProductList(),
            child: CustomScrollView(
              controller: _storeController.scrollController,
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
                    child: Stack(
                      children: [
                        FlexibleSpaceBar(
                          titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                          title: Transform.translate(
                            offset: _storeController.titleState ? Offset(0, _storeController.animationValue) : const Offset(0, 0),
                            child: Text(
                              "Sản phẩm",
                              style: TextStyle(
                                fontSize: _storeController.titleState ? 20 : 30,
                                color: AppColor.DEFAULT_BLACK,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                          centerTitle: _storeController.titleState ? true : false,
                        ),
                        Positioned(
                          top: _storeController.titleState ? 10 : null,
                          right: 20,
                          bottom: _storeController.titleState ? 0 : 20,
                          child: ScaleTap(
                            onTap: () {
                              MainController.onNavigate(1);
                            },
                            child: Stack(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        const SizedBox(
                                          height: 5,
                                        ),
                                        SvgPicture.asset(
                                          ImagePaths.icon_cart,
                                          width: 35,
                                          height: 35,
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      width: 5,
                                    ),
                                  ],
                                ),
                                Positioned(
                                  top: 0,
                                  right: 0,
                                  child: Container(
                                    width: 20,
                                    height: 20,
                                    decoration:
                                        BoxDecoration(borderRadius: BorderRadius.circular(100), color: AppColor.DEFAULT_YELLOW),
                                    child: Center(
                                      child: StreamBuilder<List<Product>>(
                                        stream: CartController.listProductInCartStream,
                                        builder: (context, snapshot) {
                                          return Text(
                                            "${CartController.listProductInCart.length}",
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: AppColor.DEFAULT_BLACK,
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 25,
                  ),
                ),
                SliverGrid.count(
                  crossAxisCount: 2,
                  childAspectRatio: 170 / 295,
                  children: List.generate(
                    _storeController.listProduct.length,
                    (index) {
                      Product product = _storeController.listProduct[index];
                      return _productItemWidget(product);
                    },
                  ),
                ),
                const SliverToBoxAdapter(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                      ),
                      AnimatedLoadingLabel(),
                      SizedBox(
                        height: 150,
                      )
                    ],
                  ),
                ),
              ],
            ),
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
            child: ScaleTap(
              onTap: () {
                DialogUtils.showOptionalDialog(
                  title: "Thêm sản phẩm",
                  content: "Bạn có muốn thêm ${product.title} vào giỏ hàng?",
                  onConfirm: () {
                    CartController.addProduct(product);
                    SnackBar snackBar = SnackBar(
                      duration: const Duration(seconds: 2),
                      behavior: SnackBarBehavior.floating,
                      content: const Text('Thêm hàng thành công, hãy kiểm tra giỏ hàng.'),
                      action: SnackBarAction(
                        label: 'Hoàn tác',
                        onPressed: () {
                          CartController.removeProduct(product);
                        },
                      ),
                    );
                    ScaffoldMessenger.of(context).showSnackBar(snackBar);
                  },
                );
              },
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
                child: Stack(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AspectRatio(
                          aspectRatio: 1 / 1,
                          child: ClipRRect(
                            borderRadius: const BorderRadius.only(
                              topLeft: Radius.circular(10),
                              topRight: Radius.circular(10),
                            ),
                            child: Image.network(
                              product!.thumbnail!,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          height: 60,
                          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          child: Text(
                            "${product.title}",
                            style: const TextStyle(
                              fontSize: 16,
                              overflow: TextOverflow.ellipsis,
                            ),
                            maxLines: 2,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          child: IntrinsicHeight(
                            child: Row(
                              children: [
                                for (int i = 0; i < 5; i++)
                                  Row(
                                    children: [
                                      SvgPicture.asset(
                                        ImagePaths.rating_star_yellow,
                                        width: 10,
                                        height: 10,
                                        color: (i > product.star! - 1) ? AppColor.DEFAULT_GREY : null,
                                      ),
                                      const SizedBox(width: 5),
                                    ],
                                  ),
                                const SizedBox(width: 2),
                                const VerticalDivider(
                                  thickness: 1,
                                  color: AppColor.DEFAULT_GREY,
                                ),
                                const SizedBox(width: 2),
                                Text(
                                  "Đã bán: ${product.quantitySold}",
                                  style: const TextStyle(fontSize: 14),
                                )
                              ],
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 1, horizontal: 10),
                          child: Text(
                            "${Formatter.formatNumber(product.price.toString())} đ",
                            style: const TextStyle(
                              fontSize: 16,
                              color: AppColor.DEFAULT_RED,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            vertical: 1,
                            horizontal: 10,
                          ),
                          margin: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 10,
                          ),
                          decoration: BoxDecoration(
                            color: AppColor.LIGHT_GREEN,
                            borderRadius: BorderRadius.circular(2.5),
                          ),
                          child: const Center(
                            child: Text(
                              "Hoa hồng: 100.000 đ",
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColor.GREEN,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                    (product.bestSale!)
                        ? Positioned(
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                vertical: 2.5,
                                horizontal: 5,
                              ),
                              decoration: const BoxDecoration(
                                  color: AppColor.DEFAULT_YELLOW,
                                  borderRadius: BorderRadius.only(
                                    bottomRight: Radius.circular(10),
                                    topLeft: Radius.circular(10),
                                  )),
                              child: const Text(
                                "Best saler",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          )
                        : Container(),
                  ],
                ),
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
