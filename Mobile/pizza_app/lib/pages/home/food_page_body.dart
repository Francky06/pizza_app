import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pizza_app/utils/colors.dart';
import 'package:pizza_app/utils/dimensions.dart';
import 'package:pizza_app/widgets/app_column_icon.dart';
import 'package:pizza_app/widgets/big_text.dart';
import 'package:pizza_app/widgets/icon_and_text.dart';
import 'package:pizza_app/widgets/small_text.dart';

class FoodPageBody extends StatefulWidget {
  const FoodPageBody({Key? key}) : super(key: key);
  @override
  _FoodPageBodyState createState() => _FoodPageBodyState();
}

class _FoodPageBodyState extends State<FoodPageBody> {
  PageController pageController = PageController(viewportFraction: 0.85);
  var _currPageValue = 0.0;
  double _scaleFactor = 0.8;
  double _height = Dimensions.pageViewContainer;

  //Index du carousel

  @override
  void initState() {
    super.initState();
    pageController.addListener(() {
      setState(() {
        _currPageValue =  pageController.page!;
      });
    });
  }

  @override
  void dispose() {
    pageController.dispose();
  }


// carousel

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
      Container(
      height: Dimensions.pageView,
      child: PageView.builder(
          controller: pageController,
          itemCount: 5,
          itemBuilder: (context, position){
            return _buildPageItem(position);
          }),
    ),
      new DotsIndicator(
        dotsCount: 5,
        position: _currPageValue,
        decorator: DotsDecorator(
          activeColor: AppColors.mainColor,
          size: const Size.square(9.0),
          activeSize: const Size(18.0, 9.0),
          activeShape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
        ),
      ),
        //popular text
        SizedBox(height: Dimensions.height30),
        Container(
          margin: EdgeInsets.only(left: Dimensions.width30),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              BigText(text: "Populaire"),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 3),
                child: BigText(text: ".", color: Colors.black26)
              ),
              SizedBox(width: Dimensions.width10),
              Container(
                margin: const EdgeInsets.only(bottom: 1),
                child: SmallText(text: "Faites votre choix"),
              )
            ],
          ),
        ),

        // list of food image

          ListView.builder(
            physics: NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              itemCount: 10,
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
                                image: AssetImage(
                                    "assets/img/pizza-basilic.jpg"
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
                                BigText(text: "Duo Tomate-Basilic et tout le tralala"),
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
              }),
      ],
    );
  }


  // scale header effect, master flutter ;)

  Widget _buildPageItem(int index){
    Matrix4 matrix = new Matrix4.identity();
    if(index == _currPageValue.floor()) {
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTransf = _height*(1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTransf, 0);

    } else if ( index == _currPageValue.floor()+1) {
      var currScale = _scaleFactor+(_currPageValue-index+1)*(1-_scaleFactor);
      var currTransf = _height*(1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTransf, 0);

    } else if ( index == _currPageValue.floor()-1) {
      var currScale = 1-(_currPageValue-index)*(1-_scaleFactor);
      var currTransf = _height*(1 - currScale) / 2;
      matrix = Matrix4.diagonal3Values(1, currScale, 1);
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, currTransf, 0);
    } else {
      var currScale = 0.8;
      matrix = Matrix4.diagonal3Values(1, currScale, 1)..setTranslationRaw(0, _height*(1-_scaleFactor)/2, 0);
    }


    //header

    return Transform(
      transform: matrix,
      child: Stack(
        children: [
          Container(
            height: Dimensions.pageViewContainer,
            margin: EdgeInsets.only(left: Dimensions.width10, right: Dimensions.width10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(Dimensions.radius30),
                color: index.isEven? Color(0xFF69c5df) : Color(0xFF9294cc),
                image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage(
                        "assets/img/pizza-blanche.jpg"
                    )
                )
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              height: Dimensions.pageViewTextContainer,
              margin: EdgeInsets.only(left: Dimensions.width30, right: Dimensions.width30, bottom: Dimensions.height30),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(Dimensions.radius20),
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                      color: Color(0xFFe8e8e8),
                      blurRadius: 5.0,
                      offset: Offset(0,5)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(-5,0)
                    ),
                    BoxShadow(
                        color: Colors.white,
                        offset: Offset(5,0)
                    )
                  ]


              ),
              child: Container(
                padding: EdgeInsets.only(top: Dimensions.height15, left: 15, right: 15),
                child: AppColumnIcon(text: "Pizza du moment",),
              ),
            ),
          )
        ],
      ),
    );
  }
}
