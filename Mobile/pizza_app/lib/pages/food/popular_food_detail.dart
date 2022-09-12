import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/controllers/cart_controller.dart';
import 'package:pizza_app/widgets/app_icon.dart';
import 'package:pizza_app/widgets/app_icon_food_detail.dart';
import 'package:pizza_app/widgets/extensible_text.dart';
import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../routes/route_helper.dart';
import '../../utils/app_constants.dart';
import '../../utils/colors.dart';
import '../../utils/dimensions.dart';
import '../../widgets/app_column_icon.dart';
import '../../widgets/big_text.dart';
import '../../widgets/icon_and_text.dart';
import '../../widgets/small_text.dart';

class PopularFoodDetail extends StatelessWidget {
  int pageId;
  PopularFoodDetail({Key? key, required this.pageId}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    var product = Get.find<RecommendedProductController>().recommendedProductList[pageId];
    Get.find<RecommendedProductController>().initProduct(product, Get.find<CartController>());

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
                  onTap: (){
                    Get.toNamed(RouteHelper.getInitial());
                  },
                  child: AppIcon(icon: Icons.clear),
                ),
                GetBuilder<RecommendedProductController>(builder: (controller) {
                  return Stack(
                    children: [
                      AppIcon(icon: Icons.shopping_cart_outlined),
                      Get.find<RecommendedProductController>().totalItems >= 1 ?
                      Positioned(
                        right: 0, top: 0,
                        child: AppIcon(icon: Icons.circle, size: 20,
                            iconColor: Colors.transparent,
                            backgroundColor: AppColors.mainColor),
                      ) :
                      Container(),

                      Get.find<RecommendedProductController>().totalItems >= 1 ?
                      Positioned(
                        right: 4, top: 3,
                        child: BigText(text: Get.find<RecommendedProductController>().totalItems.toString(),
                        size: 12, color: Colors.white),
                      ) :
                      Container(),
                    ],
                  );
                })
              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(child: BigText(size: Dimensions.font26, text: product.name!)),
                  width: double.maxFinite,
                  padding: EdgeInsets.only(top: 0, bottom: 10),
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
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+product.img!,
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
                      child: Container(
                        padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15, bottom: 10),
                        child: AppIconFoodDetail(),
                      ),
                    ),
                    SizedBox(height: Dimensions.height10),
                    ExtensibleText(text: product.description!
                    ),
                  ],
                )
            ),
          )
        ],
      ),
      bottomNavigationBar: GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
        return Container(
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
                padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20, right: Dimensions.width20),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                ),
                child: Row(
                  children: [
                    GestureDetector(
                        onTap: () {
                          recommendedProduct.setQuantity(false);
                    },
                    child: Icon(Icons.remove, color: AppColors.signColor)
                    ),

                    SizedBox(width: Dimensions.width10/2),
                    BigText(text: recommendedProduct.inCartItems.toString()),
                    SizedBox(width: Dimensions.width10/2),
                    GestureDetector(
                        onTap: () {
                          recommendedProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              ),
              GestureDetector(
                onTap: () {
                  recommendedProduct.addItem(product);
                },
                child: Container(
                  padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20, right: Dimensions.width20),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(Dimensions.radius20),
                    color: AppColors.mainColor,
                  ),
                      child: BigText(text:"${product.price!}€ | Ajouter",
                          color: Colors.white),
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
