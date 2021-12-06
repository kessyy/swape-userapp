import 'package:flutter/material.dart';

import 'package:swape_user_app/helper/product_type.dart';
import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/auth_provider.dart';
import 'package:swape_user_app/provider/banner_provider.dart';
import 'package:swape_user_app/provider/brand_provider.dart';
import 'package:swape_user_app/provider/cart_provider.dart';
import 'package:swape_user_app/provider/category_provider.dart';
import 'package:swape_user_app/provider/featured_deal_provider.dart';
import 'package:swape_user_app/provider/flash_deal_provider.dart';
import 'package:swape_user_app/provider/home_category_product_provider.dart';
import 'package:swape_user_app/provider/localization_provider.dart';
import 'package:swape_user_app/provider/product_provider.dart';
import 'package:swape_user_app/provider/top_seller_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/basewidget/title_row.dart';
import 'package:swape_user_app/view/screen/brand/all_brand_screen.dart';
import 'package:swape_user_app/view/screen/cart/cart_screen.dart';
import 'package:swape_user_app/view/screen/category/all_category_screen.dart';
import 'package:swape_user_app/view/screen/featureddeal/featured_deal_screen.dart';
import 'package:swape_user_app/view/screen/home/widget/banners_view.dart';
import 'package:swape_user_app/view/screen/home/widget/banners_single.dart';
import 'package:swape_user_app/view/screen/home/widget/brand_view.dart';
import 'package:swape_user_app/view/screen/home/trialmenu.dart';
import 'package:swape_user_app/view/screen/chat/inbox_screen.dart';
import 'package:swape_user_app/view/screen/home/widget/category_view.dart';
import 'package:swape_user_app/view/screen/home/widget/category_view2.dart';
import 'package:swape_user_app/view/screen/home/widget/category_view_women.dart';
import 'package:swape_user_app/view/screen/home/widget/featured_deal_view.dart';
import 'package:swape_user_app/view/screen/home/widget/featured_product_view.dart';
import 'package:swape_user_app/view/screen/home/widget/flash_deals_view.dart';
import 'package:swape_user_app/view/screen/home/widget/home_category_product_view.dart';
import 'package:swape_user_app/view/screen/home/widget/latest_product_view.dart';
import 'package:swape_user_app/view/screen/home/widget/products_view.dart';
import 'package:swape_user_app/view/screen/flashdeal/flash_deal_screen.dart';
import 'package:swape_user_app/view/screen/home/widget/top_seller_view.dart';
import 'package:swape_user_app/view/screen/product/view_all_product_screen.dart';
import 'package:swape_user_app/view/screen/search/search_screen.dart';
import 'package:swape_user_app/view/screen/wishlist/wishlist_screen.dart';
import 'package:swape_user_app/view/screen/topSeller/all_top_seller_screen.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class Category2Screen extends StatefulWidget {
  @override
  State<Category2Screen> createState() => _Category2ScreenState();
}

class _Category2ScreenState extends State<Category2Screen> {
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
                      child: CategoryView2(isHomePage: true),
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
