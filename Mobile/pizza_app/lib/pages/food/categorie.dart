import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart'
import 'package:get/get_state_manager/src/simple/get_state.dart';;
import 'package:pizza_app/utils/colors.dart';
import 'package:pizza_app/widgets/app_icon.dart';
import 'package:pizza_app/widgets/extensible_text.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/app_constants.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';
import '../../widgets/small_text.dart';


class ProductDetail extends StatelessWidget {
  const ProductDetail({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            toolbarHeight: 70,
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                AppIcon(icon: Icons.clear),
                AppIcon(icon: Icons.shopping_cart_outlined)
              ],
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(20),
              child: Container(
                child: Center(child: BigText(size: Dimensions.font26, text: "Pizza Mega Croute")),
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
              background: Image.asset(
                "assets/img/pizza-coin.jpg",
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
                    child: ExtensibleText(text:
                        "La pizza est une recette de cuisine traditionnelle de la cuisine italienne, originaire de Naples à base de galette de pâte à pain, garnie de divers ingrédients (sauce tomate, tomates séchées, légumes, fromage, charcuterie, olives, huile d'olive…)1 et cuite au four. Plat emblématique de la culture italienne, et de la restauration rapide dans le monde entier, elle est déclinée sous de multiples variantes. « L'art de fabriquer des pizzas napolitaines artisanales traditionnelles par les pizzaïolos napolitains » est inscrit au Patrimoine mondial de l'UNESCO depuis 2017. La pizza est une recette de cuisine traditionnelle de la cuisine italienne, originaire de Naples à base de galette de pâte à pain, garnie de divers mélanges d’ingrédients (sauce tomate, tomates séchées, légumes, fromage, charcuterie, olives, huile d'olive…)1 et cuite au four. Plat emblématique de la culture italienne, et de la restauration rapide dans le monde entier, elle est déclinée sous de multiples variantes. « L'art de fabriquer des pizzas napolitaines artisanales traditionnelles par les pizzaïolos napolitains » est inscrit au Patrimoine mondial de l'UNESCO depuis 2017."
                    ),
                  )
                  GetBuilder<RecommendedProductController>(builder: (recommendedProduct) {
                    return recommendedProduct.isLoaded ? ListView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: recommendedProduct.recommendedProductList.length,
                        itemBuilder: (context, index) {
                          return Container(
                            margin: EdgeInsets.only(left: Dimensions.width20, right: Dimensions.width20, top: Dimensions.height10),
                            child: Row(
                              children: [
                                Container(
                                  width:Dimensions.listViewImg,
                                  height: Dimensions.listViewImg,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(Dimensions.radius20),
                                      color: Colors.white38,
                                      image: DecorationImage(
                                          fit: BoxFit.cover,
                                          image: NetworkImage(
                                            AppConstants.BASE_URL + AppConstants.UPLOAD_URL + recommendedProduct.recommendedProductList[index].img!,
                                          )
                                      )
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    height: Dimensions.listViewTextContainer,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.only(
                                        topRight: Radius.circular(Dimensions.radius20),
                                        bottomRight: Radius.circular(Dimensions.radius20),
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          BigText(text: recommendedProduct.recommendedProductList[index].name!),
                                          SizedBox(height: Dimensions.height10),
                                          SmallText(text: "Tomate, basilic, mozzarella, olives, origan, camembert, magie, pied de cochons, pincée de sel, cheddar, droide"),
                                          SizedBox(height: Dimensions.height10),
                                          /* Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    IconAndText(icon: Icons.circle_sharp, text: "Normal", iconColor: AppColors.iconColor1),
                                    IconAndText(icon: Icons.location_on, text: "1.7Km", iconColor: AppColors.mainColor),
                                    IconAndText(icon: Icons.access_time_filled_rounded, text: "27 min", iconColor: AppColors.iconColor2),
                                  ],
                                )*/
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }) : CircularProgressIndicator(
                      color: AppColors.mainColor,
                    );
                  })
                ],
              )
            ),
          )
        ],
      ),
      bottomNavigationBar: Column(
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
      ),
    );
  }
}
