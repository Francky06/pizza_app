import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:pizza_app/routes/route_helper.dart';
import 'package:pizza_app/utils/colors.dart';

import '../../controllers/popular_product_controller.dart';
import '../../controllers/recommended_product_controller.dart';
import '../../utils/dimensions.dart';
import '../../widgets/big_text.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> with TickerProviderStateMixin {

  late Animation<double> animation;
  late Animation<double> animation2;
  late AnimationController controller;

  Future<void> _loadRessources () async {
     await Get.find<PopularProductController>().getPopularProductList();
     await Get.find<RecommendedProductController>().getRecommendedProductList();
  }

  @override
  void initState() {
    super.initState;
    _loadRessources();
    controller = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 2000))..forward();

    animation = CurvedAnimation(
        parent: controller,
        curve: Curves.linear);

    animation2 = CurvedAnimation(
        parent: controller,
        curve: Curves.easeInOut);

    Timer(
      Duration(milliseconds: 2100),
        ()=> Get.offNamed( RouteHelper.getInitial())
    );

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,

        children: [
          ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/img/pizza-fighter.png", width: Dimensions.splashImg,),
            ),
          ),
          ScaleTransition(scale: animation,
          child: BigText(text: "Meki Pizza", size: 30, color: Colors.black,)),
  /*        ScaleTransition(
            scale: animation,
            child: Center(
              child: Image.asset(
                "assets/img/delivery-guy.png", width: 200,),
            ),
          ),*/
        ],
      ),
    );
  }
}
