import 'package:flutter/material.dart';
import 'package:hitek_test/common/theme/app_color.dart';

class StorePage extends StatefulWidget {
  const StorePage({super.key});

  @override
  State<StorePage> createState() => _StorePageState();
}

class _StorePageState extends State<StorePage> {
  late ScrollController _scrollController;

  bool _isAtTop = true;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.atEdge) {
        if (_scrollController.position.pixels == 0) {
          
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      color: Colors.redAccent,
      child: CustomScrollView(
        controller: _scrollController,
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            pinned: true,
            snap: false,
            floating: false,
            expandedHeight: 120,
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: AppColor.TRANSPARENT,
            flexibleSpace: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [AppColor.APP_BAR_START, AppColor.APP_BAR_END]
                )
              ),
              child: const FlexibleSpaceBar(
                titlePadding: EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 0,
                ),
                title: Text(
                  "Product",
                  style: TextStyle(
                    fontSize: 28,
                    color: AppColor.DEFAULT_BLACK,
                    fontWeight: FontWeight.w500
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
