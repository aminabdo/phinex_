import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:url_launcher/url_launcher.dart';

class MyContactsInfoContainer extends StatefulWidget {
  final String phone;
  final String address;
  final String email;
  final String website;
  final String lat;
  final String long;

  const MyContactsInfoContainer(this.lat, this.long,{
    Key key,
    @required this.phone,
    @required this.address,
    @required this.email,
    @required this.website,
  }) : super(key: key);

  @override
  _MyContactsInfoContainerState createState() =>
      _MyContactsInfoContainerState();
}

class _MyContactsInfoContainerState extends State<MyContactsInfoContainer> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(1),
      child: Card(
        elevation: 4,
        margin: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: ScreenUtil().setWidth(16),
                  vertical: ScreenUtil().setHeight(10),
              ),
              child: Text(
                AppUtils.translate(context, 'contacts'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.black,
                ),
              ),
            ),
            divider(),
            ListTile(
              onTap: widget.phone == null
                  ? null
                  : () async {
                      await launch("tel://${widget.phone}");
                    },
              leading: Icon(
                Icons.phone,
                color: mainColor,
              ),
              title: widget.phone == null
                  ? Text(AppUtils.translate(context, 'no_phone'))
                  : Text(widget.phone.toString()),
            ),
            divider(),
            ListTile(
              onTap: () async {
                if(widget.address != null && widget.address != '') {
                  String googleUrl = 'https://www.google.com/maps/search/?api=1&query=${widget.lat},${widget.long}';
                  if (await canLaunch(googleUrl)) {
                    await launch(googleUrl);
                  } else {
                    AppUtils.showToast(msg: 'Could not open the map.');
                  }
                }
              },
              leading: Icon(
                Icons.location_on,
                color: mainColor,
              ),
              title: widget.address == null
                  ? Text(AppUtils.translate(context, 'no_address'))
                  : Text(widget.address.toString()),
            ),
            divider(),
            widget.website == null ? SizedBox.shrink() : ListTile(
              onTap: widget.website == null
                  ? null
                  : () async {
                      await launch(widget.website);
                    },
              leading: Icon(
                Icons.language,
                color: mainColor,
              ),
              title: Text(widget.website == null
                  ? AppUtils.translate(context, 'no_website')
                  : widget.website.toString()),
            ),
            divider(),
            ListTile(
              onTap: widget.email == null
                  ? null
                  : () async {
                      final Uri params = Uri(
                        scheme: 'mailto',
                        path: widget.email,
                        query: 'subject=App Feedback&body=App Version 3.23',
                      );

                      await launch(params.toString());
                    },
              leading: Icon(
                Icons.email,
                color: mainColor,
              ),
              title: Text(widget.email == null
                  ? AppUtils.translate(context, 'no_email_address')
                  : widget.email.toString()),
            ),
          ],
        ),
      ),
    );
  }

  Widget divider() {
    return Divider(
      thickness: 1,
      height: 5,
    );
  }
}
