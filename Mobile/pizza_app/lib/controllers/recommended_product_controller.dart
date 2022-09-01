import 'package:get/get.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/products_models.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({ required this.recommendedProductRepo });
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;


  Future<void> getRecommendedProductList() async {
    Response response = await recommendedProductRepo.getRecommendedProductList();
    if( response.statusCode == 200) {
      print("got recommended product");
      _recommendedProductList = [];
      _recommendedProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print('echec');
    }
  }

  // incrementation produit

  void setQuantity(bool isIncrement) {
    if (isIncrement) {
      _quantity = checkQuantity(_quantity + 1);
    } else {
      _quantity = checkQuantity(_quantity - 1);
    }
    update();
  }
  int checkQuantity( int quantity) {
    if (quantity < 0) {
      return 0;
    } else if ( quantity > 10) {
      return 10;
    } else {
      return quantity;
    }
  }
}