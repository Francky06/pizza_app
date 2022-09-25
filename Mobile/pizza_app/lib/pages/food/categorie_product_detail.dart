import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/controllers/popular_product_controller.dart';
import 'package:pizza_app/pages/home/main_food_page.dart';
import 'package:pizza_app/utils/app_constants.dart';
import 'package:pizza_app/utils/colors.dart';
import 'package:pizza_app/widgets/app_icon.dart';
import 'package:pizza_app/widgets/extensible_text.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../cart/cart_page.dart';


class CategorieProductDetail extends StatelessWidget {
  int pageId;
  final String page;
  CategorieProductDetail({Key? key, required this.pageId, required this.page}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var cat = Get.find<PopularProductController>().popularProductList[pageId];


    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            automaticallyImplyLeading: false,
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                    onTap: () {
                      Get.toNamed(RouteHelper.getInitial());
      },
                    child:
                AppIcon(icon: Icons.arrow_back_ios)),
                GetBuilder<RecommendedProductController>(builder: (controller) {
                  return GestureDetector(
                    onTap: () {
                      if (controller.totalItems >= 1)
                      Get.toNamed(RouteHelper.getcartPage());
                    },
                    child: Stack(
                      children: [
                        AppIcon(icon: Icons.shopping_cart_outlined),
                        // controller.totalItems >= 1 ?
                        Positioned(
                          right: 0, top: 0,
                            child: AppIcon(icon: Icons.circle, size: 20,
                                iconColor: Colors.transparent,
                                backgroundColor: AppColors.mainColor),
                          ),
                        // : Container(),

                        // controller.totalItems >= 1 ?
                        Positioned(
                          right: 4, top: -2,
                          child: BigText(text: "*",
                              // controller.totalItems.toString(),
                              size: 24, color: Colors.white),
                        )
                        // : Container(),
                      ],
                    ),
                  );
                })

              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(child: BigText(size: Dimensions.font26, text: cat.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 5, bottom: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(Dimensions.radius20),
                      topRight: Radius.circular(Dimensions.radius20),
                    ),
                  ),
                )
            ),
            pinned: true,
            backgroundColor: AppColors.yellowColor,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+cat.img!,
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
                margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                child: Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20),
                      child: ExtensibleText(text: cat.description!
                      ),
                    ),


                  ],
                )
            ),
          )
        ],
      ),



   // bottom bar
   /*   bottomNavigationBar: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            padding: EdgeInsets.only(
              left: Dimensions.width20*2.5,
              right: Dimensions.width20*2.5,
              top: Dimensions.height10,
              bottom: Dimensions.height10,
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.remove),
                BigText(text: "12.90€ "+" X "+" 0", color: AppColors.mainBlackColor, size: Dimensions.font26),
                AppIcon(
                    iconSize: Dimensions.iconSize24,
                    iconColor: Colors.white,
                    backgroundColor: AppColors.mainColor,
                    icon: Icons.add),
              ],
            ),
          ),
          Container(
            height: Dimensions.bottomHeight,
            padding: EdgeInsets.only(top: Dimensions.height30, bottom: Dimensions.height30, left: Dimensions.width20, right: Dimensions.width20),
            decoration: BoxDecoration(
                color: AppColors.buttonBgColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(Dimensions.radius20*2),
                  topRight: Radius.circular(Dimensions.radius20*2),
                )
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width30, right: Dimensions.width30),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: Colors.white,
                  ),
                  child: Icon(
                    Icons.favorite,
                    color: AppColors.mainColor,
                  ),
                ),
                Container(
                  padding: EdgeInsets.only(top: Dimensions.height20, bottom: Dimensions.height20, left: Dimensions.width30, right: Dimensions.width30),
                  child: BigText(text:" Ajouter ", color: Colors.white),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                )
              ],
            ),
          ),
        ],
      ) */

    );
  }
}
