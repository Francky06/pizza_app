import 'package:get/get.dart';
import '../data/repository/categorie_product_repo.dart';
import '../models/products_models.dart';

class CategorieProductController extends GetxController {
  final CategorieProductRepo categorieProductRepo;
  CategorieProductController({ required this.categorieProductRepo });
  List<dynamic> _categorieProductList = [];
  List<dynamic> get categorieProductList => _categorieProductList;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;




  Future<void> getCategorieProductList() async {
    Response response = await categorieProductRepo.getCategorieProductList();
    if( response.statusCode == 200) {
      print("got categorie");
      _categorieProductList = [];
      _categorieProductList.addAll(Product.fromJson(response.body).products);
      _isLoaded = true;
      update();
    } else {
      print('echec');
    }
  }

}