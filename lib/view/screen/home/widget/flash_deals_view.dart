import 'package:flutter/material.dart';
import 'package:swape_user_app/helper/price_converter.dart';
import 'package:swape_user_app/provider/flash_deal_provider.dart';
import 'package:swape_user_app/provider/splash_provider.dart';
import 'package:swape_user_app/provider/theme_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/product/product_details_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class FlashDealsView extends StatelessWidget {
  final bool isHomeScreen;
  FlashDealsView({this.isHomeScreen = true});

  @override
  Widget build(BuildContext context) {
    return Consumer<FlashDealProvider>(
      builder: (context, megaProvider, child) {
        return Provider.of<FlashDealProvider>(context).flashDealList.length != 0
            ? ListView.builder(
                padding: EdgeInsets.all(0),
                scrollDirection: isHomeScreen ? Axis.horizontal : Axis.vertical,
                itemCount: megaProvider.flashDealList.length == 0
                    ? 2
                    : megaProvider.flashDealList.length,
                itemBuilder: (context, index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          PageRouteBuilder(
                            transitionDuration: Duration(milliseconds: 1000),
                            pageBuilder: (context, anim1, anim2) =>
                                ProductDetails(
                                    product: megaProvider.flashDealList[index]),
                          ));
                    },
                    child: Container(
                      margin: EdgeInsets.all(5),
                      width: isHomeScreen ? 150 : null,
                      height: 100,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(10),
                          color: Theme.of(context).highlightColor,
                          boxShadow: [
                            BoxShadow(
                                color: Colors.grey.withOpacity(0.3),
                                spreadRadius: 1,
                                blurRadius: 5)
                          ]),
                      child: Stack(children: [
                        Row(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Expanded(
                                flex: 4,
                                child: Container(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  decoration: BoxDecoration(
                                    color: ColorResources.getWhite(context),
                                    // borderRadius: BorderRadius.only(topLeft: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                  ),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    fit: BoxFit.cover,
                                    image:
                                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.productThumbnailUrl}'
                                        '/${megaProvider.flashDealList[index].thumbnail}',
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                        Images.placeholder,
                                        fit: BoxFit.cover),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Padding(
                                  padding: EdgeInsets.all(
                                      Dimensions.PADDING_SIZE_SMALL),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      // Text(
                                      //   megaProvider.flashDealList[index].name,
                                      //   style: robotoRegular,
                                      //   maxLines: 2,
                                      //   overflow: TextOverflow.ellipsis,
                                      // ),
                                      // SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),

                                      Text(
                                        PriceConverter.convertPrice(
                                            context,
                                            megaProvider
                                                .flashDealList[index].unitPrice,
                                            discountType: megaProvider
                                                .flashDealList[index]
                                                .discountType,
                                            discount: megaProvider
                                                .flashDealList[index].discount),
                                        style: robotoBold.copyWith(
                                            color: ColorResources.getPrimary(
                                                context)),
                                      ),
                                      SizedBox(
                                          height: Dimensions
                                              .PADDING_SIZE_EXTRA_SMALL),

                                      Row(children: [
                                        Expanded(
                                          child: Text(
                                            megaProvider.flashDealList[index]
                                                        .discount >
                                                    0
                                                ? PriceConverter.convertPrice(
                                                    context,
                                                    megaProvider
                                                        .flashDealList[index]
                                                        .unitPrice)
                                                : '',
                                            style: robotoBold.copyWith(
                                              color: ColorResources
                                                  .HINT_TEXT_COLOR,
                                              decoration:
                                                  TextDecoration.lineThrough,
                                              fontSize: Dimensions
                                                  .FONT_SIZE_EXTRA_SMALL,
                                            ),
                                          ),
                                        ),
                                        // Text(
                                        //   megaProvider.flashDealList[index].rating.length != 0 ? double.parse(megaProvider.flashDealList[index].rating[0].average).toStringAsFixed(1) : '0.0',
                                        //   style: robotoRegular.copyWith(color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.orange, fontSize: Dimensions.FONT_SIZE_SMALL),
                                        // ),
                                        // Icon(Icons.star, color: Provider.of<ThemeProvider>(context).darkTheme ? Colors.white : Colors.orange, size: 15),
                                      ]),
                                    ],
                                  ),
                                ),
                              ),
                            ]),

                        // Off
                        megaProvider.flashDealList[index].discount >= 1
                            ? Positioned(
                                top: 0,
                                left: 0,
                                child: Container(
                                  width: 60,
                                  height: 20,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                    color: ColorResources.getPrimary(context),
                                    // borderRadius: BorderRadius.only(topRight: Radius.circular(10), bottomLeft: Radius.circular(10)),
                                  ),
                                  child: Text(
                                    PriceConverter.percentageCalculation(
                                      context,
                                      megaProvider
                                          .flashDealList[index].unitPrice,
                                      megaProvider
                                          .flashDealList[index].discount,
                                      megaProvider
                                          .flashDealList[index].discountType,
                                    ),
                                    style: robotoRegular.copyWith(
                                        color: Theme.of(context).highlightColor,
                                        fontSize:
                                            Dimensions.FONT_SIZE_EXTRA_SMALL),
                                  ),
                                ),
                              )
                            : SizedBox.shrink(),
                      ]),
                    ),
                  );
                },
              )
            : MegaDealShimmer(isHomeScreen: isHomeScreen);
      },
    );
  }
}

class MegaDealShimmer extends StatelessWidget {
  final bool isHomeScreen;
  MegaDealShimmer({@required this.isHomeScreen});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      scrollDirection: isHomeScreen ? Axis.horizontal : Axis.vertical,
      itemCount: 2,
      itemBuilder: (context, index) {
        return Container(
          margin: EdgeInsets.all(5),
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: ColorResources.WHITE,
              boxShadow: [
                BoxShadow(
                    color: Colors.grey.withOpacity(0.3),
                    spreadRadius: 1,
                    blurRadius: 5)
              ]),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300],
            highlightColor: Colors.grey[100],
            enabled:
                Provider.of<FlashDealProvider>(context).flashDealList.length ==
                    0,
            child:
                Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
              Expanded(
                flex: 4,
                child: Container(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_LARGE),
                  decoration: BoxDecoration(
                    color: ColorResources.ICON_BG,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10),
                        bottomLeft: Radius.circular(10)),
                  ),
                ),
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
                  child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(height: 20, color: ColorResources.WHITE),
                        SizedBox(height: Dimensions.PADDING_SIZE_EXTRA_SMALL),
                        Row(children: [
                          Expanded(
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                      height: 20,
                                      width: 50,
                                      color: ColorResources.WHITE),
                                ]),
                          ),
                          Container(
                              height: 10,
                              width: 50,
                              color: ColorResources.WHITE),
                          Icon(Icons.star, color: Colors.orange, size: 15),
                        ]),
                      ]),
                ),
              ),
            ]),
          ),
        );
      },
    );
  }
}
