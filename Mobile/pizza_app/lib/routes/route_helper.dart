import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:get/get_navigation/src/routes/transitions_type.dart';
import 'package:pizza_app/pages/food/categorie_product_detail.dart';
import 'package:pizza_app/pages/home/main_food_page.dart';
import '../pages/food/product_detail.dart';

class RouteHelper {
  static const String initial = "/";
  static const String categorieFood = "/categorie";
  static const String productDetail = "/produit";

  static String getInitial() => '$initial';
  static String getCategorieFood(int pageId) => '$categorieFood?pageId=$pageId';
  static String getProductDetail(int pageId) => '$productDetail?pageId=$pageId';

  static List<GetPage> routes = [
    GetPage(name: initial, page: () => MainFoodPage()),

    GetPage(name: categorieFood, page: () {
      var pageId = Get.parameters['pageId'];
      return CategorieProductDetail(pageId: int.parse(pageId!));
    },
      transition: Transition.fadeIn
    ),

    GetPage(name: productDetail, page: () {
      var pageId = Get.parameters['pageId'];
      return ProductDetail(pageId: int.parse(pageId!));
    },
        transition: Transition.fadeIn
    ),

  ];
}