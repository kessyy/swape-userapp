import 'package:flutter/material.dart';

import 'package:flutter_sixvalley_ecommerce/helper/product_type.dart';
import 'package:flutter_sixvalley_ecommerce/localization/language_constrants.dart';
import 'package:flutter_sixvalley_ecommerce/provider/auth_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/banner_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/brand_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/cart_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/category_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/featured_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/flash_deal_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/home_category_product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/localization_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/product_provider.dart';
import 'package:flutter_sixvalley_ecommerce/provider/top_seller_provider.dart';
import 'package:flutter_sixvalley_ecommerce/utill/color_resources.dart';
import 'package:flutter_sixvalley_ecommerce/utill/custom_themes.dart';
import 'package:flutter_sixvalley_ecommerce/utill/dimensions.dart';
import 'package:flutter_sixvalley_ecommerce/view/basewidget/title_row.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/category/all_category_screen.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/banners_single.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/category_view_interior_design.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/products_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/home/widget/top_seller_view.dart';
import 'package:flutter_sixvalley_ecommerce/view/screen/topSeller/all_top_seller_screen.dart';
import 'package:provider/provider.dart';

class InteriorDesignScreen extends StatefulWidget {
  @override
  State<InteriorDesignScreen> createState() => _InteriorDesignScreenState();
}

class _InteriorDesignScreenState extends State<InteriorDesignScreen> {
  final ScrollController _scrollController = ScrollController();

  Future<void> _loadData(BuildContext context, bool reload) async {
    String _languageCode =
        Provider.of<LocalizationProvider>(context, listen: false)
            .locale
            .languageCode;
    await Provider.of<BannerProvider>(context, listen: false)
        .getBannerList(reload, context);
    await Provider.of<BannerProvider>(context, listen: false)
        .getFooterBannerList(context);
    await Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList(reload, context, _languageCode);
    await Provider.of<HomeCategoryProductProvider>(context, listen: false)
        .getHomeCategoryProductList(reload, context, _languageCode);
    await Provider.of<TopSellerProvider>(context, listen: false)
        .getTopSellerList(reload, context, _languageCode);
    await Provider.of<FlashDealProvider>(context, listen: false)
        .getMegaDealList(reload, context, _languageCode);
    await Provider.of<BrandProvider>(context, listen: false)
        .getBrandList(reload, context, _languageCode);
    await Provider.of<ProductProvider>(context, listen: false)
        .getLatestProductList('1', context, _languageCode, reload: reload);
    await Provider.of<ProductProvider>(context, listen: false)
        .getFeaturedProductList('1', context, _languageCode, reload: reload);
    await Provider.of<FeaturedDealProvider>(context, listen: false)
        .getFeaturedDealList(reload, context, _languageCode);
    await Provider.of<ProductProvider>(context, listen: false)
        .getLProductList('1', context, _languageCode, reload: reload);
  }

  void passData(int index, String title) {
    index = index;
    title = title;
  }

  @override
  void initState() {
    super.initState();

    _loadData(context, false);

    Provider.of<CartProvider>(context, listen: false).uploadToServer(context);

    if (Provider.of<AuthProvider>(context, listen: false).isLoggedIn()) {
      Provider.of<CartProvider>(context, listen: false).getCartDataAPI(context);
    } else {
      Provider.of<CartProvider>(context, listen: false).getCartData();
    }
  }

  @override
  Widget build(BuildContext context) {
    List<String> types = [
      getTranslated('new_arrival', context),
      getTranslated('top_product', context),
      getTranslated('best_selling', context)
    ];
    return Scaffold(
      backgroundColor: ColorResources.getWhite(context),
      resizeToAvoidBottomInset: false,
      body: SafeArea(
        child: RefreshIndicator(
          backgroundColor: Theme.of(context).primaryColor,
          onRefresh: () async {
            await _loadData(context, true);
            return true;
          },
          child: CustomScrollView(
            controller: _scrollController,
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 5),
                      child: BannersSingleView(),
                    ),

                    // Category
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          20,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(
                          title: 'Shop By Category',
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (_) => AllCategoryScreen()));
                          }),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: CategoryViewInteriorDesign(isHomePage: true),
                    ),

                    // top seller
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                          Dimensions.PADDING_SIZE_SMALL,
                          20,
                          Dimensions.PADDING_SIZE_SMALL,
                          Dimensions.PADDING_SIZE_SMALL),
                      child: TitleRow(
                        title: getTranslated('top_seller', context),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => AllTopSellerScreen(
                                        topSeller: null,
                                      )));
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: TopSellerView(isHomePage: true),
                    ),

                    Padding(
                      padding: EdgeInsets.fromLTRB(20, 15, 0, 5),
                      child: Consumer<ProductProvider>(
                          builder: (ctx, prodProvider, child) {
                        return Row(children: [
                          Expanded(
                              child: Text(prodProvider.title,
                                  style: robotoBold.copyWith(
                                      fontSize: Dimensions.FONT_SIZE_DEFAULT))),
                          prodProvider.latestProductList != null
                              ? PopupMenuButton(
                                  itemBuilder: (context) {
                                    return [
                                      PopupMenuItem(
                                          value: ProductType.NEW_ARRIVAL,
                                          child: Text('New Arrival'),
                                          textStyle: robotoRegular.copyWith(
                                            color: Colors.black,
                                          )),
                                      PopupMenuItem(
                                          value: ProductType.TOP_PRODUCT,
                                          child: Text('Top Rated'),
                                          textStyle: robotoRegular.copyWith(
                                            color: Colors.black,
                                          )),
                                      PopupMenuItem(
                                          value: ProductType.BEST_SELLING,
                                          child: Text('Best Selling'),
                                          textStyle: robotoRegular.copyWith(
                                            color: Colors.black,
                                          )),
                                    ];
                                  },
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(
                                          Dimensions.PADDING_SIZE_SMALL)),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                        horizontal:
                                            Dimensions.PADDING_SIZE_SMALL),
                                    child: Icon(Icons.filter_list),
                                  ),
                                  onSelected: (value) {
                                    if (value == ProductType.NEW_ARRIVAL) {
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[0]);
                                    } else if (value ==
                                        ProductType.TOP_PRODUCT) {
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[1]);
                                    } else if (value ==
                                        ProductType.BEST_SELLING) {
                                      Provider.of<ProductProvider>(context,
                                              listen: false)
                                          .changeTypeOfProduct(value, types[2]);
                                    }

                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal:
                                              Dimensions.PADDING_SIZE_SMALL),
                                      child: ProductView(
                                          isHomePage: false,
                                          productType: value,
                                          scrollController: _scrollController),
                                    );
                                    Provider.of<ProductProvider>(context,
                                            listen: false)
                                        .getLatestProductList('1', context, '',
                                            reload: true);
                                  })
                              : SizedBox(),
                        ]);
                      }),
                    ),

                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: Dimensions.PADDING_SIZE_SMALL),
                      child: ProductView(
                          isHomePage: false,
                          productType: ProductType.NEW_ARRIVAL,
                          scrollController: _scrollController),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

// class SliverDelegate extends SliverPersistentHeaderDelegate {
//   Widget child;
//   SliverDelegate({@required this.child});

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return child;
//   }

//   @override
//   double get maxExtent => 50;

//   @override
//   double get minExtent => 50;

//   @override
//   bool shouldRebuild(SliverDelegate oldDelegate) {
//     return oldDelegate.maxExtent != 50 ||
//         oldDelegate.minExtent != 50 ||
//         child != oldDelegate.child;
//   }
// }
