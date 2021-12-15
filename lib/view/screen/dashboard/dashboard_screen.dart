import 'package:flutter/material.dart';
import 'package:swape_user_app/helper/network_info.dart';
import 'package:swape_user_app/view/screen/chat/inbox_screen.dart';
import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/localization_provider.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/dashboard/widget/fancy_bottom_nav_bar.dart';
import 'package:swape_user_app/view/screen/home/home_screen.dart';
import 'package:swape_user_app/view/screen/more/more_screen.dart';
import 'package:swape_user_app/view/screen/notification/notification_screen.dart';
import 'package:swape_user_app/view/screen/order/order_screen.dart';
import 'package:swape_user_app/view/screen/category/all_category_screen.dart';
import 'package:provider/provider.dart';

class DashBoardScreen extends StatefulWidget {
  @override
  _DashBoardScreenState createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen> {
  PageController _pageController = PageController();
  int _pageIndex = 0;

  List<Widget> _screens;

  GlobalKey<FancyBottomNavBarState> _bottomNavKey = GlobalKey();
  GlobalKey<ScaffoldMessengerState> _scaffoldKey = GlobalKey();

  @override
  void initState() {
    super.initState();

    _screens = [
      HomePageScreen(),

      AllCategoryScreen(),
      // InboxScreen(isBackButtonExist: false),
      OrderScreen(isBacButtonExist: false),
      NotificationScreen(isBacButtonExist: false),
      MoreScreen(),
    ];

    NetworkInfo.checkConnectivity(context);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (_pageIndex != 0) {
          _bottomNavKey.currentState.setPage(0);
          return false;
        } else {
          return true;
        }
      },
      child: Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: FancyBottomNavBar(
          key: _bottomNavKey,
          initialSelection: _pageIndex,
          isLtr: Provider.of<LocalizationProvider>(context).isLtr,
          tabs: [
            FancyTabData(
                imagePath: Images.home_image,
                title: getTranslated('home', context)),
            //TODO: seller
            FancyTabData(imagePath: Images.category_image, title: 'Categories'),
            // FancyTabData(imagePath: Images.message_image, title: getTranslated('inbox', context)),
            FancyTabData(
                imagePath: Images.orders_image,
                title: getTranslated('orders', context)),
            FancyTabData(
                imagePath: Images.notifications, title: 'Notifications'),
            FancyTabData(
                imagePath: Images.more, title: getTranslated('more', context)),
          ],
          onTabChangedListener: (int index) {
            _pageController.jumpToPage(index);
            _pageIndex = index;
          },
        ),
        body: PageView.builder(
          controller: _pageController,
          itemCount: _screens.length,
          physics: NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return _screens[index];
          },
        ),
      ),
    );
  }
}
