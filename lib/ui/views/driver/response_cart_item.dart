import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';

import '../../../Bles/Model/responses/taxi_client/General.dart';
import '../../../utils/app_utils.dart';
import '../../../utils/consts.dart';
import '../../widgets/my_button.dart';

class ResponseCartItem extends StatefulWidget {

  final Ride_replyBean currentRequest;
  final Function(PolylineResult points) onAcceptOfferBtnClicked;
  final Function onRejectBtntapped;

  const ResponseCartItem({
    Key key,
    @required this.onAcceptOfferBtnClicked,
    @required this.currentRequest, this.onRejectBtntapped,
  }) : super(key: key);

  @override
  _ResponseCartItemState createState() => _ResponseCartItemState();
}

class _ResponseCartItemState extends State<ResponseCartItem> {
  @override
  Widget build(BuildContext context) {
    //print(widget.currentRequest.toJson());
    return Card(
      elevation: 6,
      child: Column(
        children: [
          SizedBox(
            height: 10,
          ),
          ListTile(
            title: Text(
              'Ahmad Magdi',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            subtitle: Row(
              children: [
                Text(
                  '4.7',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Icon(
                  Icons.star,
                  color: goldColor,
                  size: 20,
                ),
              ],
            ),
            trailing: Column(
              children: [
                Text(
                  'Nissan',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
                Text(
                  'AEO 125',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.grey,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
            leading: CircleAvatar(
              backgroundImage: AssetImage('assets/images/avatar.png'),
            ),
          ),
          Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              children: [
                Divider(
                  thickness: 1,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate(context, 'offer'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 20,
                      ),
                    ),
                    Row(
                      children: [
                        Text(
                          translate(context, 'cash'),
                          style: TextStyle(color: Colors.grey),
                        ),
                        SizedBox(
                          width: 8,
                        ),
                        Text(
                          '${AppUtils.currency} ${widget.currentRequest.price}',
                          style: TextStyle(
                            color: deepBlueColor,
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: myButton(
                        translate(context, 'accept'),
                        onTap: () async {
                          widget.onAcceptOfferBtnClicked(null);
                        },
                        btnColor: mainColor.withOpacity(.3),
                        textStyle: TextStyle(
                          color: mainColor,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 12,
                    ),
                    Expanded(
                      child: myButton(
                        translate(context, 'reject'),
                        onTap: () {
                          widget.onRejectBtntapped();
                        },
                        btnColor: Colors.red.withOpacity(.3),
                        textStyle: TextStyle(
                          color: Colors.red,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      flex: 2,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
