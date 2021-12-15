import 'package:flutter/material.dart';
import 'package:swape_user_app/provider/brand_provider.dart';
import 'package:swape_user_app/provider/splash_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class BrandView extends StatelessWidget {
  final bool isHomePage;
  BrandView({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    // return Consumer<BrandProvider>(
    //   builder: (context, brandProvider, child) {

    //     return brandProvider.brandList.length != 0 ? GridView.builder(
    //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
    //         crossAxisCount: 2,
    //         childAspectRatio: (1/1.3),
    //         mainAxisSpacing: 10,
    //         crossAxisSpacing: 5,
    //       ),
    //       itemCount: brandProvider.brandList.length != 0
    //           ? isHomePage
    //           ? brandProvider.brandList.length > 8
    //           ? 8
    //           : brandProvider.brandList.length
    //           : brandProvider.brandList.length
    //           : 8,
    //       shrinkWrap: true,
    //       physics: isHomePage ? NeverScrollableScrollPhysics() : BouncingScrollPhysics(),
    //       itemBuilder: (BuildContext context, int index) {

    //         return InkWell(
    //           onTap: () {
    //             Navigator.push(context, MaterialPageRoute(builder: (_) => BrandAndCategoryProductScreen(
    //               isBrand: true,
    //               id: brandProvider.brandList[index].id.toString(),
    //               name: brandProvider.brandList[index].name,
    //               image: brandProvider.brandList[index].image,
    //             )));
    //           },
    //           child: Column(
    //             crossAxisAlignment: CrossAxisAlignment.stretch,
    //             children: [
    //               Expanded(
    //                 child: Container(
    //                   // padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //                   padding: EdgeInsets.all(Dimensions.PADDING_SIZE_SMALL),
    //                   decoration: BoxDecoration(
    //                       color: Theme.of(context).highlightColor,
    //                       shape: BoxShape.rectangle,
    //                       boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.15), blurRadius: 1, spreadRadius: 1)]
    //                   ),
    //                   child: ClipOval(
    //                     child: FadeInImage.assetNetwork(
    //                       height: 30,
    //                       placeholder: Images.placeholder,
    //                       image: Provider.of<SplashProvider>(context,listen: false).baseUrls.brandImageUrl+'/'+brandProvider.brandList[index].image,
    //                       imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder),
    //                     ),
    //                   ),
    //                 ),
    //               ),
    //               // SizedBox(
    //               //   height: (MediaQuery.of(context).size.width/4) * 0.3,
    //               //   child: Center(child: Text(
    //               //     brandProvider.brandList[index].name,
    //               //     maxLines: 1,
    //               //     overflow: TextOverflow.ellipsis,
    //               //     textAlign: TextAlign.center,
    //               //     style: titilliumSemiBold.copyWith(fontSize: Dimensions.FONT_SIZE_SMALL),
    //               //   )),
    //               // ),
    //             ],
    //           ),
    //         );

    //       },
    //     ) : BrandShimmer(isHomePage: isHomePage);

    //   },
    // );

    return Consumer<BrandProvider>(
      builder: (context, brandProvider, child) {
        return brandProvider.brandList.length != 0
            ? isHomePage
                ? ConstrainedBox(
                    constraints: brandProvider.brandList.length > 0
                        ? BoxConstraints(maxHeight: 110)
                        : BoxConstraints(maxHeight: 0),
                    child: ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: brandProvider.brandList.length,
                        itemBuilder: (ctx, index) {
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (_) =>
                                          BrandAndCategoryProductScreen(
                                            isBrand: true,
                                            id: brandProvider
                                                .brandList[index].id
                                                .toString(),
                                            name: brandProvider
                                                .brandList[index].name,
                                            image: brandProvider
                                                .brandList[index].image,
                                          )));
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(2),
                              child: Container(
                                width:
                                    (MediaQuery.of(context).size.width / 4.6),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Container(
                                      width: 250,
                                      height: 80,
                                      padding: EdgeInsets.all(
                                          Dimensions.PADDING_SIZE_SMALL),
                                      decoration: BoxDecoration(
                                        color: Theme.of(context).highlightColor,
                                        shape: BoxShape.rectangle,
                                        // boxShadow: [BoxShadow(color: Colors.grey.withOpacity(0.10), blurRadius: 5, spreadRadius: 0.5)]
                                      ),
                                      child: ClipRRect(
                                        // borderRadius: BorderRadius.all(Radius.circular(50)),
                                        child: FadeInImage.assetNetwork(
                                          placeholder: Images.placeholder,
                                          image: Provider.of<SplashProvider>(
                                                      context,
                                                      listen: false)
                                                  .baseUrls
                                                  .brandImageUrl +
                                              '/' +
                                              brandProvider
                                                  .brandList[index].image,
                                          imageErrorBuilder: (c, o, s) =>
                                              Image.asset(Images.placeholder),
                                        ),
                                      ),
                                    ),
                                    Text(
                                      brandProvider.brandList[index].name,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      textAlign: TextAlign.center,
                                      style: titilliumSemiBold.copyWith(
                                          fontSize: Dimensions.FONT_SIZE_SMALL),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          );
                        }),
                  )
                : GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 4,
                      childAspectRatio: (1 / 1.3),
                      mainAxisSpacing: 10,
                      crossAxisSpacing: 5,
                    ),
                    itemCount: brandProvider.brandList.length,
                    shrinkWrap: true,
                    physics: isHomePage
                        ? NeverScrollableScrollPhysics()
                        : BouncingScrollPhysics(),
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => BrandAndCategoryProductScreen(
                                        isBrand: true,
                                        id: brandProvider.brandList[index].id
                                            .toString(),
                                        name:
                                            brandProvider.brandList[index].name,
                                        image: brandProvider
                                            .brandList[index].image,
                                      )));
                        },
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                              child: Container(
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_SMALL),
                                decoration: BoxDecoration(
                                    color: Theme.of(context).highlightColor,
                                    shape: BoxShape.circle,
                                    boxShadow: [
                                      BoxShadow(
                                          color: Colors.grey.withOpacity(0.15),
                                          blurRadius: 5,
                                          spreadRadius: 1)
                                    ]),
                                child: ClipOval(
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    image: Provider.of<SplashProvider>(context,
                                                listen: false)
                                            .baseUrls
                                            .brandImageUrl +
                                        '/' +
                                        brandProvider.brandList[index].image,
                                    imageErrorBuilder: (c, o, s) =>
                                        Image.asset(Images.placeholder),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(
                              height:
                                  (MediaQuery.of(context).size.width / 4) * 0.3,
                              child: Center(
                                  child: Text(
                                brandProvider.brandList[index].name,
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                                textAlign: TextAlign.center,
                                style: titilliumSemiBold.copyWith(
                                    fontSize: Dimensions.FONT_SIZE_SMALL),
                              )),
                            ),
                          ],
                        ),
                      );
                    },
                  )
            : BrandShimmer(
                isHomePage: null,
              );
      },
    );
  }
}

class BrandShimmer extends StatelessWidget {
  final bool isHomePage;
  BrandShimmer({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1 / 1.3),
        mainAxisSpacing: 10,
        crossAxisSpacing: 5,
      ),
      itemCount: isHomePage ? 8 : 30,
      shrinkWrap: true,
      physics: isHomePage ? NeverScrollableScrollPhysics() : null,
      itemBuilder: (BuildContext context, int index) {
        return Shimmer.fromColors(
          baseColor: Colors.grey[300],
          highlightColor: Colors.grey[100],
          enabled: Provider.of<BrandProvider>(context).brandList.length == 0,
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
                child: Container(
                    decoration: BoxDecoration(
                        color: ColorResources.WHITE, shape: BoxShape.circle))),
            Container(
                height: 10,
                color: ColorResources.WHITE,
                margin: EdgeInsets.only(left: 25, right: 25)),
          ]),
        );
      },
    );
  }
}
