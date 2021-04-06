import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/index/IndexSearchResponse.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';
import 'comapines_details_page.dart';

class IndexCompanyCardItem extends StatefulWidget {
  final IndexSearchResult currentItem;

  const IndexCompanyCardItem({Key key, @required this.currentItem})
      : super(key: key);

  @override
  _IndexCompanyCardItemState createState() => _IndexCompanyCardItemState();
}

class _IndexCompanyCardItemState extends State<IndexCompanyCardItem> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        height: ScreenUtil().setHeight(360),
        width: double.infinity,
        margin: EdgeInsets.symmetric(
          horizontal: ScreenUtil().setWidth(4),
          vertical: ScreenUtil().setHeight(4),
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
        ),
        child: Card(
          elevation: 4,
          child: Padding(
            padding: EdgeInsets.all(10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                widget.currentItem.imageUrl == null ||
                        widget.currentItem.imageUrl == ''
                    ? Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CompaniesDetailsPage(
                                  id: widget.currentItem.id,
                                  name: widget.currentItem.title,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: Image.asset(
                              'assets/images/no-product-image.png',
                              fit: BoxFit.contain,
                            ),
                          ),
                        ),
                      )
                    : Expanded(
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => CompaniesDetailsPage(
                                  id: widget.currentItem.id,
                                  name: widget.currentItem.title,
                                ),
                              ),
                            );
                          },
                          child: ClipRRect(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(12),
                              topRight: Radius.circular(12),
                            ),
                            child: CachedNetworkImage(
                              imageUrl: widget.currentItem.imageUrl,
                              fit: BoxFit.contain,
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
                SizedBox(
                  height: ScreenUtil().setHeight(20),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentItem.title,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.phone,
                          color: deepBlueColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          widget.currentItem.phone ?? 'No Mobile Number',
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.email,
                          color: deepBlueColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Text(
                          widget.currentItem.website ??
                              AppLocalization.of(context)
                                  .translate('no_website'),
                          style: TextStyle(
                            color: widget.currentItem.website == null
                                ? null
                                : Colors.blue,
                            decoration: widget.currentItem.website == null
                                ? null
                                : TextDecoration.underline,
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on,
                          color: deepBlueColor,
                          size: 20,
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(8),
                        ),
                        Flexible(
                          child: Text(
                            widget.currentItem.address ??
                                AppLocalization.of(context)
                                    .translate('no_address'),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
