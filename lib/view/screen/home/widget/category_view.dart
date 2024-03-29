import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/localization/language_constrants.dart';
import 'package:swape_user_app/provider/category_provider.dart';
import 'package:swape_user_app/provider/splash_provider.dart';
import 'package:swape_user_app/provider/theme_provider.dart';
import 'package:swape_user_app/utill/color_resources.dart';
import 'package:swape_user_app/utill/custom_themes.dart';
import 'package:swape_user_app/utill/dimensions.dart';
import 'package:swape_user_app/utill/images.dart';
import 'package:swape_user_app/view/screen/product/brand_and_category_product_screen.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class CategoryView extends StatelessWidget {
  final bool isHomePage;
  CategoryView({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (1.3 / 0.5),
                ),
                itemCount: isHomePage
                    ? categoryProvider.categoryList.length > 8
                        ? 8
                        : categoryProvider.categoryList.length
                    : categoryProvider.categoryList.length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (BuildContext context, int index) {
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BrandAndCategoryProductScreen(
                                    isBrand: false,
                                    id: categoryProvider.categoryList[index].id
                                        .toString(),
                                    name: categoryProvider
                                        .categoryList[index].name,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(6),
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xffF8F8F8),
                      ),
                      child: Row(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Expanded(
                                flex: 5,
                                child: Container(
                                  decoration: BoxDecoration(),
                                  child: Center(
                                    child: Text(
                                      categoryProvider.categoryList.length != 0
                                          ? categoryProvider
                                              .categoryList[index].name
                                          : getTranslated('CATEGORY', context),
                                      textAlign: TextAlign.center,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: titilliumSemiBold.copyWith(
                                          fontSize:
                                              Dimensions.FONT_SIZE_EXTRA_SMALL),
                                    ),
                                  ),
                                )),
                            Expanded(
                              flex: 5,
                              child: Padding(
                                padding: EdgeInsets.all(
                                    Dimensions.PADDING_SIZE_EXTRA_SMALL),
                                child: ClipRRect(
                                  // borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
                                  child: FadeInImage.assetNetwork(
                                    placeholder: Images.placeholder,
                                    image:
                                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.categoryImageUrl}'
                                        '/${categoryProvider.categoryList[index].icon}',
                                    imageErrorBuilder: (c, o, s) =>
                                        Image.asset(Images.placeholder),
                                    height: 10,
                                  ),
                                ),
                              ),
                            ),
                          ]),
                    ),
                  );
                },
              )
            : CategoryShimmer();
      },
    );
  }
}

class CategoryShimmer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        childAspectRatio: (1 / 1),
      ),
      itemCount: 8,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (BuildContext context, int index) {
        return Container(
          decoration: BoxDecoration(boxShadow: [
            BoxShadow(
                color: Colors.grey[
                    Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200],
                spreadRadius: 2,
                blurRadius: 5)
          ]),
          margin: EdgeInsets.all(3),
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Expanded(
              flex: 7,
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                enabled: Provider.of<CategoryProvider>(context)
                        .categoryList
                        .length ==
                    0,
                child: Container(
                    decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(10),
                      topRight: Radius.circular(10)),
                )),
              ),
            ),
            Expanded(
                flex: 3,
                child: Container(
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: ColorResources.getTextBg(context),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(10),
                        bottomRight: Radius.circular(10)),
                  ),
                  child: Shimmer.fromColors(
                    baseColor: Colors.grey[300],
                    highlightColor: Colors.grey[100],
                    enabled: Provider.of<CategoryProvider>(context)
                            .categoryList
                            .length ==
                        0,
                    child: Container(
                        height: 10,
                        color: Colors.white,
                        margin: EdgeInsets.only(left: 15, right: 15)),
                  ),
                )),
          ]),
        );
      },
    );
  }
}
