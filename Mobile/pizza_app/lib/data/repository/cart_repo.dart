import 'dart:convert';

import 'package:pizza_app/utils/app_constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../models/cart_model.dart';

class CartRepo {
  final SharedPreferences sharedPreferences;
  CartRepo({ required this.sharedPreferences });

  List<String> cart = [];
  void addToCartList(List<CartModel> cartList) {
    cart = [];
    // convert object to string because sharedp take only string
    cartList.forEach((element) {
      return cart.add(jsonEncode(element));
    });
    sharedPreferences.setStringList(AppConstants.CART_LIST, cart);
    //print(sharedPreferences.getStringList(AppConstants.CART_LIST));
    getCartList();
  }
  // convert string to map
  List<CartModel> getCartList() {
    List<String> carts = [];
    if (sharedPreferences.containsKey(AppConstants.CART_LIST)) {
      carts = sharedPreferences.getStringList(AppConstants.CART_LIST)!;
      print("in cart: "+carts.toString());
    }
    List<CartModel> cartlist = [];
    
    carts.forEach((element) {
      cartlist.add(CartModel.fromJson(jsonDecode(element)));
    });
    return cartlist;
  }
}