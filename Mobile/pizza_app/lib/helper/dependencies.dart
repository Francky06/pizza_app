import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/controllers/popular_product_controller.dart';
import 'package:pizza_app/data/api/api_client.dart';
import 'package:pizza_app/data/repository/popular_product_repo.dart';

import '../controllers/recommended_product_controller.dart';
import '../data/repository/recommended_product_repo.dart';
import '../utils/app_constants.dart';

Future<void> init()async {
  //api client
  Get.lazyPut(() => ApiClient(appBaseUrl: AppConstants.BASE_URL));

  //repo
  Get.lazyPut(() => PopularProductRepo(apiClient: Get.find()));
  Get.lazyPut(() => RecommendedProductRepo(apiClient: Get.find()));



  //controller
  Get.lazyPut(() => PopularProductController(popularProductRepo: Get.find()));
  Get.lazyPut(() => RecommendedProductController(recommendedProductRepo: Get.find()));



}