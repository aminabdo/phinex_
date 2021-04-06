import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/car_rental/CarRentalFilterResponse.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'car_details_page.dart';

class CarCartItem extends StatefulWidget {
  final CarsBean currentCar;

  const CarCartItem({Key key, @required this.currentCar}) : super(key: key);

  @override
  _CarCartItemState createState() => _CarCartItemState();
}

class _CarCartItemState extends State<CarCartItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) => CarDetailsPage(
                      name: widget.currentCar.title,
                      id: widget.currentCar.id,
                    ),
                  ),
                );
              },
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                ),
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                  ),
                  child: widget.currentCar.carModel.imageUrl == null
                      ? Image.asset('assets/images/no-product-image.png')
                      : CachedNetworkImage(
                          imageUrl:widget.currentCar.carModel.imageUrl,
                          height: ScreenUtil().setHeight(250),
                          fit: BoxFit.fill,
                          errorWidget: (_, __, ___) {
                            return Center(
                              child: Icon(
                                Icons.error,
                                color: Colors.red,
                              ),
                            );
                          },
                          placeholder: (context, url) {
                            return Loader(
                              size: 40,
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(
              ScreenUtil().setWidth(10),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.currentCar.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(4),
                ),
                Text(
                  '${widget.currentCar.rentalPricePerPeriod} ${AppUtils.currency}/ ${widget.currentCar.rentalPeriod}',
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: ScreenUtil().setHeight(10),
                ),
                Container(
                  height: ScreenUtil().setHeight(45),
                  decoration: BoxDecoration(
                    color: deepBlueColor,
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(6),
                    child: FlatButton(
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => CarDetailsPage(
                              name: widget.currentCar.title,
                              id: widget.currentCar.id,
                            ),
                          ),
                        );
                      },
                      padding: EdgeInsets.all(0),
                      child: Center(
                        child: Text(
                          AppLocalization.of(context).translate('see_details'),
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
