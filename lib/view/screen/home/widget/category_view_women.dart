import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:swape_user_app/data/model/response/category.dart';
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

class CategoryViewWomen extends StatelessWidget {
  final bool isHomePage;
  CategoryViewWomen({@required this.isHomePage});

  @override
  Widget build(BuildContext context) {
    return Consumer<CategoryProvider>(
      builder: (context, categoryProvider, child) {
        return categoryProvider.categoryList.length != 0
            ? GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 3,
                  childAspectRatio: (1.3 / 0.5),
                ),
                // itemCount: categoryProvider.categoryList[categoryProvider.categorySelectedIndex].subCategories.length+1,

                itemCount: isHomePage
                    ? categoryProvider
                                .categoryList[
                                    categoryProvider.categorySelectedIndex]
                                .subCategories
                                .length >
                            8
                        ? 8
                        : categoryProvider
                            .categoryList[
                                categoryProvider.categorySelectedIndex]
                            .subCategories
                            .length
                    : categoryProvider
                        .categoryList[categoryProvider.categorySelectedIndex]
                        .subCategories
                        .length,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, index) {
                  SubCategory _subCategory;
                  if (index != 0) {
                    _subCategory = categoryProvider
                        .categoryList[categoryProvider.categorySelectedIndex]
                        .subCategories[index];
                    // }
                  } else if (_subCategory.subSubCategories.length != 0) {
                    return Ink(
                      color: Theme.of(context).highlightColor,
                      child: Theme(
                        data: Provider.of<ThemeProvider>(context).darkTheme
                            ? ThemeData.dark()
                            : ThemeData.light(),
                        child: ExpansionTile(
                          key: Key(
                              '${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
                          title: Text(_subCategory.name,
                              style: titilliumSemiBold.copyWith(
                                  color: Theme.of(context)
                                      .textTheme
                                      .bodyText1
                                      .color),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis),
                          // children: _getSubSubCategories(context, _subCategory),
                        ),
                      ),
                    );
                  }
                  // else {
                  //   return InkWell(
                  //     onTap: () {
                  //       Navigator.push(
                  //           context,
                  //           MaterialPageRoute(
                  //               builder: (_) => BrandAndCategoryProductScreen(
                  //                     isBrand: false,
                  //                     id: _subCategory.id.toString(),
                  //                     name: _subCategory.name,
                  //                   )));
                  //     },
                  //     child: SubCategoryItem(
                  //       title: _subCategory.name,
                  //       icon: _subCategory.icon,
                  //     ),
                  //   );
                  // }
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (_) => BrandAndCategoryProductScreen(
                                    isBrand: false,
                                    id: categoryProvider.categoryList[index].id
                                        .toString(),
                                    // id: _subCategory.id.toString(),
                                    // name: categoryProvider
                                    //     .categoryList[index].subCategory.name,
                                    name: _subCategory.name,
                                  )));
                    },
                    child: Container(
                      margin: EdgeInsets.all(6),
                      height: 20,
                      decoration: BoxDecoration(
                        color: Color(0xffF3E5F5),
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
                                      _subCategory.name,
                                      // categoryProvider.categoryList.length != 0
                                      //     ? categoryProvider
                                      //         .categoryList[index].name
                                      // : getTranslated('CATEGORY', context),
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
                                  child: FadeInImage.assetNetwork(
                                    // placeholder: Images.placeholder,
                                    // image: '${Provider.of<SplashProvider>(context,listen: false).baseUrls.categoryImageUrl}'
                                    //     '/${categoryProvider.categoryList[index].icon}',
                                    // imageErrorBuilder: (c, o, s) => Image.asset(Images.placeholder),
                                    placeholder: Images.placeholder,
                                    fit: BoxFit.cover,
                                    image:
                                        '${Provider.of<SplashProvider>(context, listen: false).baseUrls.subcategoryImageUrl}',
                                    imageErrorBuilder: (c, o, s) => Image.asset(
                                        Images.placeholder,
                                        fit: BoxFit.cover),

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
                    baseColor: Color(0xFFFCE4EC),
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

class SubCategoryItem extends StatelessWidget {
  final String title;
  final String icon;
  SubCategoryItem({
    @required this.title,
    @required this.icon,
  });

  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
          Container(
            height: 70,
            width: 50,
            child: ClipRRect(
              child: FadeInImage.assetNetwork(
                placeholder: Images.placeholder,
                fit: BoxFit.cover,
                image:
                    '${Provider.of<SplashProvider>(context, listen: false).baseUrls.subcategoryImageUrl}/$icon',
                imageErrorBuilder: (c, o, s) =>
                    Image.asset(Images.placeholder, fit: BoxFit.cover),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
                horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
            child: Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                textAlign: TextAlign.center,
                style: titilliumSemiBold.copyWith(
                  fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
                )),
          ),
        ]),
      ),
    );
  }
}
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:swape_user_app/data/model/response/category.dart';
// import 'package:swape_user_app/localization/language_constrants.dart';
// import 'package:swape_user_app/provider/category_provider.dart';
// import 'package:swape_user_app/provider/splash_provider.dart';
// import 'package:swape_user_app/provider/theme_provider.dart';
// import 'package:swape_user_app/utill/color_resources.dart';
// import 'package:swape_user_app/utill/custom_themes.dart';
// import 'package:swape_user_app/utill/dimensions.dart';
// import 'package:swape_user_app/utill/images.dart';
// import 'package:swape_user_app/view/screen/product/brand_and_category_product_screen.dart';
// import 'package:provider/provider.dart';
// import 'package:shimmer/shimmer.dart';

// class CategoryViewWomen extends StatelessWidget {
//   final bool isHomePage;
//   CategoryViewWomen({@required this.isHomePage});

//   @override
//   Widget build(BuildContext context) {
//     return Consumer<CategoryProvider>(
//       builder: (context, categoryProvider, child) {
//         return categoryProvider.categoryList.length != 0
//             ? GridView.builder(
//                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//                   crossAxisCount: 3,
//                   // childAspectRatio: (1.3 / 0.5),
//                 ),
//                 // itemCount: isHomePage
//                 //     ? categoryProvider.categoryList.length > 8
//                 //         ? 8
//                 //         : categoryProvider.categoryList.length
//                 //     : categoryProvider.categoryList.length,

//                 itemCount: categoryProvider
//                     .categoryList[categoryProvider.categorySelectedIndex]
//                     .subCategories
//                     .length,
//                 shrinkWrap: true,
//                 physics: NeverScrollableScrollPhysics(),
//                 itemBuilder: (context, index) {
//                   SubCategory _subCategory;
//                   if (index != 0) {
//                     _subCategory = categoryProvider
//                         .categoryList[categoryProvider.categorySelectedIndex]
//                         .subCategories[index - 1];
//                   }
//                   if (index == 0) {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => BrandAndCategoryProductScreen(
//                                       isBrand: false,
//                                       id: categoryProvider
//                                           .categoryList[categoryProvider
//                                               .categorySelectedIndex]
//                                           .id
//                                           .toString(),
//                                       name: categoryProvider
//                                           .categoryList[categoryProvider
//                                               .categorySelectedIndex]
//                                           .name,
//                                     )));
//                       },
//                       child: AllItems(
//                         title: ('All'),
//                       ),
//                     );
//                   } else if (_subCategory.subSubCategories.length != 0) {
//                     return Ink(
//                       color: Theme.of(context).highlightColor,
//                       child: Theme(
//                         data: Provider.of<ThemeProvider>(context).darkTheme
//                             ? ThemeData.dark()
//                             : ThemeData.light(),
//                         child: ExpansionTile(
//                           key: Key(
//                               '${Provider.of<CategoryProvider>(context).categorySelectedIndex}$index'),
//                           title: Text(_subCategory.name,
//                               style: titilliumSemiBold.copyWith(
//                                   color: Theme.of(context)
//                                       .textTheme
//                                       .bodyText1
//                                       .color),
//                               maxLines: 2,
//                               overflow: TextOverflow.ellipsis),
//                           children: _getSubSubCategories(context, _subCategory),
//                         ),
//                       ),
//                     );
//                   } else {
//                     return InkWell(
//                       onTap: () {
//                         Navigator.push(
//                             context,
//                             MaterialPageRoute(
//                                 builder: (_) => BrandAndCategoryProductScreen(
//                                       isBrand: false,
//                                       id: _subCategory.id.toString(),
//                                       name: _subCategory.name,
//                                     )));
//                       },
//                       child: SubCategoryItem(
//                         title: _subCategory.name,
//                         icon: _subCategory.icon,
//                       ),
//                     );
//                   }
//                 },
//               )
//             : CategoryShimmer();
//       },
//     );
//   }

//   List<Widget> _getSubSubCategories(
//       BuildContext context, SubCategory subCategory) {
//     List<Widget> _subSubCategories = [];
//     _subSubCategories.add(Container(
//       color: ColorResources.getIconBg(context),
//       margin:
//           EdgeInsets.symmetric(horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//       child: ListTile(
//         title: Row(
//           children: [
//             Container(
//               height: 7,
//               width: 7,
//               decoration: BoxDecoration(
//                   color: ColorResources.getPrimary(context),
//                   shape: BoxShape.circle),
//             ),
//             SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//             Flexible(
//                 child: Text(
//               getTranslated('all', context),
//               style: titilliumSemiBold.copyWith(
//                   color: Theme.of(context).textTheme.bodyText1.color),
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             )),
//           ],
//         ),
//         onTap: () {
//           Navigator.push(
//               context,
//               MaterialPageRoute(
//                   builder: (_) => BrandAndCategoryProductScreen(
//                         isBrand: false,
//                         id: subCategory.id.toString(),
//                         name: subCategory.name,
//                       )));
//         },
//       ),
//     ));
//     for (int index = 0; index < subCategory.subSubCategories.length; index++) {
//       _subSubCategories.add(Container(
//         color: ColorResources.getIconBg(context),
//         margin: EdgeInsets.symmetric(
//             horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//         child: ListTile(
//           title: Row(
//             children: [
//               Container(
//                 height: 7,
//                 width: 7,
//                 decoration: BoxDecoration(
//                     color: ColorResources.getPrimary(context),
//                     shape: BoxShape.circle),
//               ),
//               SizedBox(width: Dimensions.PADDING_SIZE_SMALL),
//               Flexible(
//                   child: Text(
//                 subCategory.subSubCategories[index].name,
//                 style: titilliumSemiBold.copyWith(
//                     color: Theme.of(context).textTheme.bodyText1.color),
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//               )),
//             ],
//           ),
//           onTap: () {
//             Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                     builder: (_) => BrandAndCategoryProductScreen(
//                           isBrand: false,
//                           id: subCategory.subSubCategories[index].id.toString(),
//                           name: subCategory.subSubCategories[index].name,
//                         )));
//           },
//         ),
//       ));
//     }
//     return _subSubCategories;
//   }
// }

// class CategoryShimmer extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return GridView.builder(
//       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
//         crossAxisCount: 4,
//         childAspectRatio: (1 / 1),
//       ),
//       itemCount: 8,
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemBuilder: (BuildContext context, int index) {
//         return Container(
//           decoration: BoxDecoration(boxShadow: [
//             BoxShadow(
//                 color: Colors.grey[
//                     Provider.of<ThemeProvider>(context).darkTheme ? 700 : 200],
//                 spreadRadius: 2,
//                 blurRadius: 5)
//           ]),
//           margin: EdgeInsets.all(3),
//           child:
//               Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
//             Expanded(
//               flex: 7,
//               child: Shimmer.fromColors(
//                 baseColor: Colors.grey[300],
//                 highlightColor: Colors.grey[100],
//                 enabled: Provider.of<CategoryProvider>(context)
//                         .categoryList
//                         .length ==
//                     0,
//                 child: Container(
//                     decoration: BoxDecoration(
//                   color: Colors.white,
//                   borderRadius: BorderRadius.only(
//                       topLeft: Radius.circular(10),
//                       topRight: Radius.circular(10)),
//                 )),
//               ),
//             ),
//             Expanded(
//                 flex: 3,
//                 child: Container(
//                   alignment: Alignment.center,
//                   decoration: BoxDecoration(
//                     color: ColorResources.getTextBg(context),
//                     borderRadius: BorderRadius.only(
//                         bottomLeft: Radius.circular(10),
//                         bottomRight: Radius.circular(10)),
//                   ),
//                   child: Shimmer.fromColors(
//                     baseColor: Colors.grey[300],
//                     highlightColor: Colors.grey[100],
//                     enabled: Provider.of<CategoryProvider>(context)
//                             .categoryList
//                             .length ==
//                         0,
//                     child: Container(
//                         height: 10,
//                         color: Colors.white,
//                         margin: EdgeInsets.only(left: 15, right: 15)),
//                   ),
//                 )),
//           ]),
//         );
//       },
//     );
//   }
// }

// // }
// class SubCategoryItem extends StatelessWidget {
//   final String title;
//   final String icon;
//   SubCategoryItem({
//     @required this.title,
//     @required this.icon,
//   });

//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child:
//             Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           Container(
//             height: 70,
//             width: 50,
//             child: ClipRRect(
//               child: FadeInImage.assetNetwork(
//                 placeholder: Images.placeholder,
//                 fit: BoxFit.cover,
//                 image:
//                     '${Provider.of<SplashProvider>(context, listen: false).baseUrls.subcategoryImageUrl}/$icon',
//                 imageErrorBuilder: (c, o, s) =>
//                     Image.asset(Images.placeholder, fit: BoxFit.cover),
//               ),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//             child: Text(title,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: titilliumSemiBold.copyWith(
//                   fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
//                 )),
//           ),
//         ]),
//       ),
//     );
//   }
// }

// class AllItems extends StatelessWidget {
//   final String title;
//   AllItems({
//     @required this.title,
//   });

//   Widget build(BuildContext context) {
//     return Container(
//       child: Center(
//         child:
//             Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
//           Container(
//             height: 50,
//             width: 50,
//             child: ClipRRect(
//               child: Image.asset(Images.placeholder, fit: BoxFit.cover),
//             ),
//           ),
//           Padding(
//             padding: EdgeInsets.symmetric(
//                 horizontal: Dimensions.PADDING_SIZE_EXTRA_SMALL),
//             child: Text(title,
//                 maxLines: 2,
//                 overflow: TextOverflow.ellipsis,
//                 textAlign: TextAlign.center,
//                 style: titilliumSemiBold.copyWith(
//                   fontSize: Dimensions.FONT_SIZE_EXTRA_SMALL,
//                 )),
//           ),
//         ]),
//       ),
//     );
//   }
// }
