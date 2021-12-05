import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/category.dart';
import 'package:swape_user_app/provider/providers.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/home/AllScreen.dart';
import 'package:swape_user_app/view/screen/cart/cart_screen.dart';
import 'package:swape_user_app/view/screen/home/Men.dart';
import 'package:swape_user_app/view/screen/chat/inbox_screen.dart';
import 'package:swape_user_app/view/screen/home/interior_design.dart';
import 'package:swape_user_app/view/screen/home/kids.dart';
import 'package:swape_user_app/view/screen/search/search_screen.dart';
import 'package:swape_user_app/view/screen/home/women.dart';
import 'package:provider/provider.dart';
import 'dart:ui';

class HomePageScreen extends StatefulWidget {
  // final bool isHomePage;
  HomePageScreen({Key key}) : super(key: key);

  @override
  _HomePageScreenState createState() => _HomePageScreenState();
}

class _HomePageScreenState extends State<HomePageScreen> {
  @override
  void initState() {
    Provider.of<CategoryProvider>(context, listen: false)
        .getCategoryList(false, context, 'en');
    super.initState();
  }

  // HomePageScreen({Key key, this.isHomePage}) : super(key: key);
  // final List<Tab> myTabs = <Tab>[
  //   Tab(text: 'ALL'),
  //   Tab(text: 'MEN'),
  //   Tab(text: 'WOMEN'),
  //   Tab(text: 'INTERIOR DESIGN'),
  //   Tab(text: 'KIDS'),
  // ];

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
        builder: (context, categoryProvider, child) {
      return categoryProvider.categoryList.length != 0
          ? _tabs(categoryProvider.categoryList)
          : Scaffold();
    });
  }

  Widget _tabs(List<AllCategory> categories) {
    print({"FirstCategory": categories.first.toJson()});
    List<Tab> myTabs = [
      Tab(
        text: 'All',
      )
    ];
    if (categories.isEmpty) {
      return Scaffold();
    }
    for (int i = 0; i < categories.length; i++) {
      myTabs.add(Tab(
        child: Text(
          categories[i].name,
          // style: titilliumSemiBold.copyWith(
          //   fontSize: Dimensions.FONT_SIZE_LARGE,
          // ),
        ),
      ));
    }
    return DefaultTabController(
      length: categories.length + 1,
      child: Scaffold(
          body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return <Widget>[
            new SliverAppBar(
              floating: true,
              elevation: 0,
              centerTitle: true,
              automaticallyImplyLeading: true,
              backgroundColor: Theme.of(context).highlightColor,
              // TODO: change image when provided
              // title: Image.asset(Images.logo_with_name_image, height: 30),
              title: Text('SWAPE',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 30.0,
                      fontWeight: FontWeight.bold)),
              leading: Builder(builder: (context) {
                return IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => InboxScreen()));
                  },
                  icon: Image.asset(
                    Images.message_image,
                    height: Dimensions.ICON_SIZE_DEFAULT,
                    width: Dimensions.ICON_SIZE_DEFAULT,
                    color: ColorResources.getPrimary(context),
                  ),
                );
              }),
              actions: [
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => SearchScreen()));
                  },
                  icon: Image.asset(
                    Images.search_image,
                    height: Dimensions.ICON_SIZE_DEFAULT,
                    width: Dimensions.ICON_SIZE_DEFAULT,
                    color: ColorResources.getPrimary(context),
                  ),
                ),
                IconButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (_) => CartScreen()));
                  },
                  icon: Stack(clipBehavior: Clip.none, children: [
                    Image.asset(
                      Images.cart_arrow_down_image,
                      height: Dimensions.ICON_SIZE_LARGE,
                      width: Dimensions.ICON_SIZE_LARGE,
                      color: ColorResources.getPrimary(context),
                    ),
                    Positioned(
                      top: -4,
                      right: -4,
                      child: Consumer<CartProvider>(
                          builder: (context, cart, child) {
                        return CircleAvatar(
                          radius: 7,
                          backgroundColor: ColorResources.RED,
                          child: Text(cart.cartList.length.toString(),
                              style: titilliumSemiBold.copyWith(
                                color: ColorResources.WHITE,
                                fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                              )),
                        );
                      }),
                    ),
                  ]),
                ),
              ],

              bottom: TabBar(
                indicatorColor: Colors.black,
                indicatorSize: TabBarIndicatorSize.label,
                labelColor: Colors.black,
                isScrollable: true,
                labelStyle: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_LARGE,
                ),
                tabs: myTabs,
              ),
            ),
          ];
        },
        body: TabBarView(
          children: <Widget>[
            AllScreen(),
            MenScreen(),
            WomenScreen(),
            InteriorDesignScreen(),
            KidsScreen(),
            KidsScreen(),
            KidsScreen(),
          ],
        ),
      )),
    );
  }
}
