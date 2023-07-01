import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hitek_test/common/theme/app_color.dart';
import 'package:hitek_test/modules/store/store_controller.dart';
import 'package:hitek_test/utils/image_path.dart';
import 'package:hitek_test/widgets/animated_loading_label.dart';
import 'package:hitek_test/widgets/scale_tap.dart';

import '../../data/models/product.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage>
    with TickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  late ScrollController _scrollController;
  bool _showSmallTitle = false;
  late AnimationController _animationController;
  late Animation _animation;

  late StoreController _storeController;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 250),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 50,
      end: 0,
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    )..addListener(() => setState(() {}));

    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.offset > 75) {
        setState(() {
          _animationController.forward();
          _showSmallTitle = true;
        });
      } else {
        setState(() {
          _animationController.reset();
          _showSmallTitle = false;
        });
      }

      if (_scrollController.position.atEdge) {
        bool isTop = _scrollController.position.pixels == 0;
        if (!isTop) {
          _storeController.onGetProduct();
        }
      }
    });

    _storeController = StoreController();
    _storeController.onGetProduct();
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
          child: CustomScrollView(
            controller: _scrollController,
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
                          colors: [AppColor.APP_BAR_START, AppColor.APP_BAR_END])),
                  child: Stack(
                    children: [
                      FlexibleSpaceBar(
                        titlePadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                        title: Transform.translate(
                          offset:
                              _showSmallTitle ? Offset(0, _animation.value) : const Offset(0, 0),
                          child: Text(
                            "Sản phẩm",
                            style: TextStyle(
                              fontSize: _showSmallTitle ? 20 : 30,
                              color: AppColor.DEFAULT_BLACK,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                        centerTitle: _showSmallTitle ? true : false,
                      ),
                      AnimatedPositioned(
                        top: _showSmallTitle ? 10 : null,
                        right: 20,
                        bottom: _showSmallTitle ? 10 : 20,
                        duration: const Duration(milliseconds: 500),
                        child: SvgPicture.asset(
                          ImagePaths.icon_cart,
                          width: 35,
                          height: 35,
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
                  _storeController.bsListProduct.value.length,
                  (index) {
                    Product product = _storeController.bsListProduct.value[index];
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
                onTap: () {},
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
                  child: Column(
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
                              width: 10,
                              color: Colors.black,
                            ),
                            const SizedBox(width: 2),
                            Text(
                              "Đã bán: ${product.quantitySold}",
                              style: const TextStyle(fontSize: 14),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  bool isDarkMode() {
    return MediaQuery.of(context).platformBrightness == Brightness.dark;
  }

  @override
  bool get wantKeepAlive => false;
}
