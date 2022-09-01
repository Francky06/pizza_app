

import 'package:get/get.dart';
import 'package:pizza_app/data/api/api_client.dart';

import '../../utils/app_constants.dart';

class CategorieProductRepo extends GetxService {
  final ApiClient apiClient;
  CategorieProductRepo({ required this.apiClient });

  Future<Response> getCategorieProductList() async {
    return await apiClient.getData(AppConstants.POPULAR_PRODUCT_URI);
}

}
