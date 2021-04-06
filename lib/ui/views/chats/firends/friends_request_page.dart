import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:phinex/Bles/Model/responses/social/ShowFriendShipRequestsResponse.dart';
import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';
import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class FriendsRequestPage extends StatefulWidget {
  @override
  _FriendsRequestPageState createState() => _FriendsRequestPageState();
}

class _FriendsRequestPageState extends State<FriendsRequestPage> {
  @override
  void initState() {
    super.initState();

    socialBloc.getshowFriendsRequests(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(translate(context, 'friend_requests'), context),
      body: StreamBuilder<ShowFriendShipRequestsResponse>(
        stream: socialBloc.showFriendsRequest.stream,
        builder: (context, snapshot) {
          if (socialBloc.loading.value) {
            return Loader();
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: ListView.builder(
                physics: bouncingScrollPhysics,
                itemBuilder: (context, index) {
                  return UserRequestItem(
                    currentFriendShip: snapshot.data.data[index],
                    index: index,
                    onDeleteBtnClicked: () {
                      socialBloc.showFriendsRequest.value.data.removeAt(index);
                      setState(() {});
                    },
                  );
                },
                itemCount: snapshot.data.data.length,
              ),
            );
          }
        },
      ),
    );
  }
}

class UserRequestItem extends StatefulWidget {
  final UserSocial currentFriendShip;
  final int index;
  final Function onDeleteBtnClicked;

  const UserRequestItem({Key key, @required this.currentFriendShip, this.index, this.onDeleteBtnClicked})
      : super(key: key);

  @override
  _UserRequestItemState createState() => _UserRequestItemState();
}

class _UserRequestItemState extends State<UserRequestItem> {
  bool acceptFriendRequest = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: EdgeInsets.all(
        ScreenUtil().setWidth(8),
      ),
      child: Padding(
        padding: EdgeInsets.all(8.0),
        child: Row(
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
              child: CircleAvatar(
                radius: 40,
                backgroundImage: widget.currentFriendShip.userDetails == null || widget.currentFriendShip.userDetails.imageUrl == null ||
                        widget.currentFriendShip.userDetails.imageUrl == ''
                    ? AssetImage('assets/images/avatar.png')
                    : CachedNetworkImageProvider(
                        widget.currentFriendShip.userDetails.imageUrl,
                      ),
              ),
            ),
            Expanded(
              child: Padding(
                padding: EdgeInsets.all(ScreenUtil().setWidth(12)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.currentFriendShip.username,
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(10),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: myButton(
                              acceptFriendRequest
                                  ? translate(context, 'you_now_friends')
                                  : AppLocalization.of(context)
                                      .translate('confirm'), onTap: acceptFriendRequest ? null : () async {
                            acceptFriendRequest = true;
                            setState(() {});
                            await socialBloc.acceptFriendRequest(
                              AppUtils.userData.id,
                              widget.currentFriendShip.id,
                            );

                            widget.onDeleteBtnClicked();
                          },
                              btnColor: mainColor.withOpacity(.15),
                              textStyle: TextStyle(color: mainColor)),
                        ),
                        SizedBox(
                          width: ScreenUtil().setWidth(15),
                        ),
                        Container(
                          height: ScreenUtil().setHeight(45),
                          width: ScreenUtil().setWidth(45),
                          decoration: BoxDecoration(
                            color: Color(0xffFDE4E5),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: FlatButton(
                              padding: EdgeInsets.zero,
                              onPressed: () {
                                socialBloc.deleteFriendShipt(
                                  AppUtils.userData.id,
                                  widget.currentFriendShip.id,
                                );
                                widget.onDeleteBtnClicked();
                              },
                              child: Center(
                                child: Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
