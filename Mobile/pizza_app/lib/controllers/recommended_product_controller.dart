import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pizza_app/controllers/cart_controller.dart';
import 'package:pizza_app/utils/colors.dart';
import '../data/repository/recommended_product_repo.dart';
import '../models/cart_model.dart';
import '../models/products_models.dart';

class RecommendedProductController extends GetxController {
  final RecommendedProductRepo recommendedProductRepo;
  RecommendedProductController({ required this.recommendedProductRepo });
  List<dynamic> _recommendedProductList = [];
  List<dynamic> get recommendedProductList => _recommendedProductList;
  late CartController _cart;

  bool _isLoaded = false;
  bool get isLoaded => _isLoaded;

  int _quantity = 0;
  int get quantity => _quantity;
  int _inCartItems = 0;
  int get inCartItems => _inCartItems + _quantity;




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
      print("number of items "+ _quantity.toString());
    } else {
      _quantity = checkQuantity(_quantity - 1);
      print("number of items "+ _quantity.toString());
    }
    update();
  }
  int checkQuantity( int quantity) {
    if ((_inCartItems+quantity) < 0) {
      Get.snackbar("Easter Egg", "Un jour Chuck Norris a eu un zéro en latin, depuis c'est une langue morte.",
      backgroundColor: AppColors.mainColor,
      colorText: Colors.white);
      return 0;
    } else if ( (_inCartItems+quantity) > 10) {
      Get.snackbar("Easter Egg", "Les rires éclatent mieux lorsque la nourriture est bonne. Nul besoin d'en rajouter!",
          backgroundColor: AppColors.mainColor,
          colorText: Colors.white);
      return 0;
    } else {
      return quantity;
    }
  }

  // check quantity after open page random

  void initProduct( ProductModel product, CartController cart) {
    _quantity = 0;
    _inCartItems = 0;
    _cart = cart;
    var exist = false;
    exist = _cart.existingCart(product);
    print("exist ? "+ exist.toString());
    if(exist) {
      _inCartItems = _cart.getQuantity(product);
    }
    print("Q = "+ _inCartItems.toString());


    // get from storage _inCartItems
  }

  void addItem( ProductModel product) {
      _cart.addItem(product, _quantity);
      _quantity = 0;
      _inCartItems = _cart.getQuantity(product);
      _cart.items.forEach((key, value) {
        print("The id is " + value.id.toString()+ " The quantity is " + value.quantity.toString());
      });
      update();
  }

  int get totalItems {
    return _cart.totalItems;
  }

  List<CartModel> get getItems {
    return _cart.getItems;
  }
}