import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSingleResponse.dart' as index;
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsByUserResponse.dart' as prof;
import 'package:phinex/Bles/Model/responses/rating/make_rate/make_rate_response.dart';
import 'package:phinex/Bles/Model/responses/restaurant/RestaurantSingleResponse.dart';
import 'package:phinex/Bles/bloc/index/IndexBloc.dart';
import 'package:phinex/Bles/bloc/medical_service/MedicalCommonBloc.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/Bles/bloc/restaurant/RestaurantBloc.dart';
import 'package:phinex/Bles/bloc/store/RateBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class RateItemPage extends StatefulWidget {
  final String itemName;
  final int productID;
  final String objectName;
  final String catalougeType;

  const RateItemPage({
    Key key,
    @required this.itemName,
    @required this.productID,
    @required this.objectName, this.catalougeType,
  }) : super(key: key);

  @override
  _RateItemPageState createState() => _RateItemPageState();
}

class _RateItemPageState extends State<RateItemPage> {
  double userRate = 0.0;

  TextEditingController commentController = TextEditingController();

  bool submit = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
          AppLocalization.of(context).translate('write_review'), context),
      body: Container(
        width: double.infinity,
        child: Padding(
          padding: EdgeInsets.all(
            ScreenUtil().setWidth(14),
          ),
          child: SingleChildScrollView(
            physics: bouncingScrollPhysics,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Text(
                  widget.itemName,
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                RatingBar.builder(
                  initialRating: userRate,
                  minRating: 1,
                  itemSize: 35,
                  ignoreGestures: false,
                  direction: Axis.horizontal,
                  allowHalfRating: true,
                  itemCount: 5,
                  itemPadding: EdgeInsets.symmetric(
                    horizontal: ScreenUtil().setWidth(10),
                  ),
                  itemBuilder: (context, _) => Icon(
                    Icons.star,
                    color: goldColor,
                  ),
                  onRatingUpdate: (rating) {
                    userRate = rating;
                  },
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(18),
                ),
                MyTextFormField(
                  controller: commentController,
                  hintText: AppLocalization.of(context)
                      .translate('tell_us_your_experience'),
                  maxLines: 5,
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(40),
                ),
                submit
                    ? Loader(
                        size: 30,
                      )
                    : myButton(
                        AppLocalization.of(context).translate('submit'),
                        btnColor: mainColor,
                        onTap: () async {
                          if (commentController.text.isEmpty) {
                            AppUtils.showToast(
                                msg: translate(context, 'write_your_comment'));
                            return;
                          }

                          if (userRate < 1) {
                            AppUtils.showToast(
                              msg: translate(context, 'make_rate'),
                            );

                            return;
                          }

                          AppUtils.hideKeyboard(context);

                          setState(() {
                            submit = true;
                          });

                          MakeRateResponse response = await rateBloc.makeRate(
                            MakeRateRequest(
                              commentController.text,
                              widget.productID,
                              widget.objectName,
                              userRate,
                              AppUtils.userData.id,
                            ),
                          );

                          setState(() {
                            submit = false;
                          });

                          print(response.toString());

                          if (response.code == null ||
                              response.code >= 200 && response.code < 300) {
                            AppUtils.showToast(msg: translate(context, 'done'), bgColor: deepBlueColor,);

                            if (widget.objectName == 'technician') {
                              updateProfession(response);
                            } else if (widget.objectName == RateObjectName.restaurant) {
                              updateRestaurant(response);
                            } else if (widget.objectName == RateObjectName.doctor) {
                              updateMedicalService(response);
                            } else if (widget.objectName == RateObjectName.clinic) {
                              updateMedicalService(response);
                            } else if (widget.objectName == RateObjectName.catalouge) {
                              if(widget.catalougeType == 'index') {
                                updateIndex(response);
                              }
                            }

                            Navigator.of(context).pop();
                          } else {
                            print('there is no instance with given id');
                            AppUtils.showToast(
                              msg: translate(
                                  context, response.message.toString()),
                              bgColor: Colors.red,
                            );
                          }
                        },
                      ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void updateProfession(MakeRateResponse response) async {
    professionsBloc.single.value.data.rate.add(
      RateBean(
        comment: commentController.text,
        objectId: widget.productID,
        createdAt: DateTime.now().toString(),
        rate: userRate,
        objectName: widget.objectName,
        userId: AppUtils.userData.id,
        user: prof.UserBean(
          apiToken: AppUtils.userData.token,
          chanel: AppUtils.userData.chanel,
          firstName: AppUtils.userData.firstName,
          lastName: AppUtils.userData.lastName,
          id: AppUtils.userData.id,
          imageUrl: AppUtils.userData.imageUrl,
          phone: AppUtils.userData.phone,
          phoneVerifiedAt: AppUtils.userData.phoneVerifiedAt,
          type: AppUtils.userData.type,
          username: AppUtils.userData.username,
          verificationCode: AppUtils.userData.verificationCode,
        ),
        id: widget.productID,
      ),
    );

    professionsBloc.single.value.data.totalRates =
        num.parse(response.data.totalRates).toInt();
    professionsBloc.single.value.data.totalReviews =
        num.parse(response.data.totalReviews).toInt();
    professionsBloc.single.value = professionsBloc.single.value;

    for (var techs in professionsBloc.landing.value.data.CategoryTechnicians) {
      techs.technicians.forEach((element) {
        if (element.id == widget.productID) {
          element.totalReviews = num.parse(response.data.totalReviews).toInt();
          element.totalRates = num.parse(response.data.totalRates).toInt();
        }
      });
    }

    if(professionsBloc.search.value != null) {
      for (var techs in professionsBloc.search.value.data.results) {
        if (techs.id == widget.productID) {
          techs.totalReviews = num.parse(response.data.totalReviews).toInt();
          techs.totalRates = num.parse(response.data.totalRates).toInt();
        }
      }
    }

    professionsBloc.landing.value = professionsBloc.landing.value;
    professionsBloc.search.value = professionsBloc.search.value;
  }

  void updateRestaurant(MakeRateResponse response) async {
    restaurantBloc.single.value.data.rates.add(Rates(
        id: widget.productID,
        userId: AppUtils.userData.id,
        objectName: widget.objectName,
        comment: commentController.text,
        createdAt: DateTime.now().toString(),
        rate: userRate.toInt(),
        objectId: widget.productID,
        user: User(
          id: AppUtils.userData.id,
          username: AppUtils.userData.username,
          type: AppUtils.userData.type,
          phoneVerifiedAt: AppUtils.userData.phoneVerifiedAt,
          phone: AppUtils.userData.phone,
          imageUrl: AppUtils.userData.imageUrl,
          lastName: AppUtils.userData.lastName,
          firstName: AppUtils.userData.firstName,
          chanel: AppUtils.userData.chanel,
        )));

    restaurantBloc.single.value.data.setTotalReviews(
        num.parse(response.data.totalReviews.toString()).toInt());
    restaurantBloc.single.value.data
        .setTotalRates(num.parse(response.data.totalRates.toString()).toInt());

    restaurantBloc.single.value = restaurantBloc.single.value;

    restaurantBloc.landing.value.data.restaurants.forEach((element) {
      if (element.id == widget.productID) {
        element.totalRates = num.parse(response.data.totalRates).toInt();
        element.totalReviews = num.parse(response.data.totalReviews).toInt();
      }
    });

    restaurantBloc.landing.value = restaurantBloc.landing.value;
  }

  void updateIndex(MakeRateResponse response) async {
    indexBloc.single.value.data.rates.add(
     index.RatesBean(
        comment: commentController.text,
        objectId: widget.productID,
        createdAt: DateTime.now().toString(),
        rate: userRate,
        objectName: widget.objectName,
        userId: AppUtils.userData.id,
        user: index.UserBean(
          apiToken: AppUtils.userData.token,
          chanel: AppUtils.userData.chanel,
          firstName: AppUtils.userData.firstName,
          lastName: AppUtils.userData.lastName,
          id: AppUtils.userData.id,
          imageUrl: AppUtils.userData.imageUrl,
          phone: AppUtils.userData.phone,
          phoneVerifiedAt: AppUtils.userData.phoneVerifiedAt,
          type: AppUtils.userData.type,
          username: AppUtils.userData.username,
          verificationCode: AppUtils.userData.verificationCode,
        ),
        id: widget.productID,
      ),
    );

    indexBloc.single.value.data.catalogue.totalRates = (num.parse(response.data.totalRates.toString())).toString();
    indexBloc.single.value.data.catalogue.totalReviews = (num.parse(response.data.totalReviews.toString())).toString();

    indexBloc.single.value = indexBloc.single.value;
  }

  void updateMedicalService(MakeRateResponse response) {
    commonBloc.landing.value.data.forEach((element) {
      if(element.id.toString() == widget.productID.toString()) {
        element.totalRates = num.parse(response.data.totalRates.toString());
        element.totalReviews = num.parse(response.data.totalReviews.toString());
      }
    });

    commonBloc.landing.value = commonBloc.landing.value;
    commonBloc.single.value = commonBloc.single.value;
  }
}
