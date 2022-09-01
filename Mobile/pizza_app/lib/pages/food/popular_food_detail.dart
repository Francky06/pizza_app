import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
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

    var prod = Get.find<RecommendedProductController>().recommendedProductList[pageId];

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
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(20),
                child: Container(
                  child: Center(child: BigText(size: Dimensions.font26, text: prod.name!)),
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
                AppConstants.BASE_URL+AppConstants.UPLOAD_URL+prod.img!,
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
                    ExtensibleText(text: prod.description!
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
                    BigText(text: recommendedProduct.quantity.toString()),
                    SizedBox(width: Dimensions.width10/2),
                    GestureDetector(
                        onTap: () {
                          recommendedProduct.setQuantity(true);
                        },
                        child: Icon(Icons.add, color: AppColors.signColor)),
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.only(top: Dimensions.height15, bottom: Dimensions.height15, left: Dimensions.width20, right: Dimensions.width20),
                child: BigText(text:"${prod.price!}€ | Ajouter", color: Colors.white),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: AppColors.mainColor,
                ),
              )
            ],
          ),
        );
      }),
    );
  }
}
