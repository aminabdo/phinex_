import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phinex/Bles/Model/requests/chat/IntiateNewChatRequest.dart';
import 'package:phinex/Bles/Model/requests/social/AddNewFriendRequest.dart';
import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';
import 'package:phinex/Bles/bloc/social/ChatBloc.dart';
import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
import 'package:phinex/ui/views/chats/firends/private_single_chat_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button2.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class PersonProfilePage extends StatefulWidget {
  final int id;
  final String name;

  const PersonProfilePage({Key key, @required this.id, @required this.name})
      : super(key: key);

  @override
  _PersonProfilePageState createState() => _PersonProfilePageState();
}

class _PersonProfilePageState extends State<PersonProfilePage> {
  bool sendingFriendRequest = false;
  bool startChatting = false;
  bool uploadImage = false;

  String friendshipState = '';
  bool gotData = false;

  @override
  void initState() {
    super.initState();

    socialBloc.getUserProfile(widget.id);
  }

  void showPersonOptions(String state) async {
    await showModalBottomSheet(
      context: context,
      isDismissible: true,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(18),
          topRight: Radius.circular(18),
        ),
      ),
      builder: (context) {
        return Container(
          height: MediaQuery.of(context).size.height * .28,
          padding: EdgeInsets.all(16),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width / 3,
                  ),
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          widget.name,
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            'Cancel',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: deepBlueColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Divider(),
              ListTile(
                onTap: () async {
                  if (state == 'none') {
                    if (sendingFriendRequest) {
                      friendshipState = translate(context, 'cancel_friend_request');
                      sendingFriendRequest = false;
                      setState(() {});
                      await socialBloc.cancelFriendRequest(AppUtils.userData.id, widget.id);
                    } else {
                      friendshipState = translate(context, 'add_friend');
                      sendingFriendRequest = true;
                      setState(() {});
                      socialBloc.addFriendRequest(
                        AddNewFriendRequest(
                          AppUtils.userData.id,
                          widget.id,
                        ),
                      );
                    }
                  }
                  if (state == 'friend-request-send') {
                    sendingFriendRequest = false;
                    friendshipState = translate(context, 'cancel_friend_request');
                    setState(() {});
                    socialBloc.cancelFriendRequest(AppUtils.userData.id, widget.id);
                  }
                  if (state == 'friend-request-received') {
                    sendingFriendRequest = false;
                    friendshipState = translate(context, 'you_now_friends');
                    setState(() {});
                    socialBloc.acceptFriendRequest(AppUtils.userData.id, widget.id);
                  }
                  if (state == 'friend') {
                    friendshipState = translate(context, 'friendship_deleted');
                    sendingFriendRequest = false;
                    setState(() {});
                    socialBloc.deleteFriendShipt(AppUtils.userData.id, widget.id);
                  }

                  Navigator.pop(context);
                },
                leading: Icon(
                  state == 'friend'
                      ? FontAwesomeIcons.userTimes
                      : sendingFriendRequest
                          ? Icons.person_add_disabled
                          : Icons.person_add_alt_1,
                  color: deepBlueColor,
                ),
                title: Text(
                  state == 'none'
                      ? sendingFriendRequest
                          ? translate(context, 'cancel_friend_request')
                          : translate(context, 'add_friend')
                      : state == 'friend'
                          ? translate(context, 'delete_friendship')
                          : state == 'friend-request-received'
                              ? translate(context, 'accept_friend_request')
                              : state == 'friend-request-send'
                                  ? translate(context, 'cancel_friend_request')
                                  : '',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('${widget.name}', context),
      body: StreamBuilder<UserProfileResponse>(
        stream: socialBloc.userProfile.stream,
        builder: (context, snapshot) {
          if (socialBloc.loading.value) {
            return Loader();
          } else {
            if (!gotData) {
              print(snapshot.data);
              gotData = true;
              friendshipState = snapshot.data.data.friendshipStatus == 'none'
                  ? sendingFriendRequest
                      ? translate(context, 'cancel_friend_request')
                      :  translate(context, 'add_friend')
                  : snapshot.data.data.friendshipStatus == 'friend'
                      ? translate(context, 'you_now_friends')
                      : snapshot.data.data.friendshipStatus == 'friend-request-received'
                          ? translate(context, 'accept_friend_request')
                          : snapshot.data.data.friendshipStatus == 'friend-request-send'
                              ? translate(context, 'cancel_friend_request')
                              : '';
            }
            var userData = snapshot.data.data.details;
            if (userData == null) return Container();
            return SingleChildScrollView(
              physics: bouncingScrollPhysics,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.zero,
                    child: Column(
                      children: [
                        Container(
                          height: MediaQuery.of(context).size.height * .25,
                          child: Stack(
                            overflow: Overflow.visible,
                            children: [
                              userData.userDetails == null ||
                                      userData.userDetails.imageUrl == null ||
                                      userData.userDetails.imageUrl == ''
                                  ? Image.asset(
                                      'assets/images/cover_image.jpg',
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                    )
                                  : CachedNetworkImage(
                                      imageUrl: userData.userDetails.imageUrl,
                                      height:
                                          MediaQuery.of(context).size.height *
                                              .2,
                                      width: double.infinity,
                                      fit: BoxFit.cover,
                                      placeholder: (context, url) {
                                        return Loader(
                                          size: 30,
                                        );
                                      },
                                    ),
                              Positioned(
                                left: 0,
                                right: 0,
                                bottom: -7,
                                child: Container(
                                  width: 100,
                                  height: 100,
                                  alignment: Alignment.bottomCenter,
                                  padding: EdgeInsets.all(3),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                      image: userData.userDetails == null ||
                                              userData.userDetails.imageUrl ==
                                                  null ||
                                              userData.userDetails.imageUrl ==
                                                  ''
                                          ? Image.asset(
                                              'assets/images/avatar.png',
                                              fit: BoxFit.fill,
                                              width: 100,
                                              height: 100,
                                            ).image
                                          : CachedNetworkImageProvider(
                                              snapshot.data.data.details
                                                  .userDetails.imageUrl,
                                            ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 14,
                        ),
                        Text(
                          userData.username,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(5.0),
                          child: Text(
                            userData.userDetails != null &&
                                    userData.userDetails.description != null &&
                                    userData.userDetails.description != ''
                                ? userData.userDetails.description
                                : '',
                            style: TextStyle(color: Colors.grey, fontSize: 13),
                            textAlign: TextAlign.center,
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.all(14.0),
                          child: Row(
                            children: [
                              Expanded(
                                flex: 3,
                                child: myButton2(
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      snapshot.data.data.friendshipStatus ==
                                              'friend'
                                          ? SizedBox.shrink()
                                          : Icon(
                                              sendingFriendRequest
                                                  ? Icons.person_add_disabled
                                                  : Icons.person_add,
                                              color: deepBlueColor,
                                            ),
                                      SizedBox(width: 10),
                                      Text(
                                        friendshipState,
                                        style: TextStyle(
                                          color: deepBlueColor,
                                          fontSize: 12,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                  onTap: snapshot.data.data.friendshipStatus ==
                                          'friend'
                                      ? null
                                      : () {
                                          if (snapshot
                                                  .data.data.friendshipStatus ==
                                              'none') {
                                            if (sendingFriendRequest) {
                                              friendshipState = translate(context, 'you_now_friends');
                                              sendingFriendRequest = false;
                                              setState(() {});
                                              socialBloc.cancelFriendRequest(
                                                  AppUtils.userData.id,
                                                  widget.id);
                                            } else {
                                              sendingFriendRequest = true;
                                              friendshipState = translate(context, 'cancel_friend_request');
                                              setState(() {});
                                              socialBloc.addFriendRequest(
                                                AddNewFriendRequest(
                                                  AppUtils.userData.id,
                                                  widget.id,
                                                ),
                                              );
                                            }
                                          }
                                          if (snapshot
                                                  .data.data.friendshipStatus ==
                                              'friend-request-send') {
                                            sendingFriendRequest = false;
                                            friendshipState = translate(context, 'cancel_friend_request');
                                            setState(() {});
                                            socialBloc.cancelFriendRequest(
                                                AppUtils.userData.id,
                                                widget.id);
                                          }
                                          if (snapshot
                                                  .data.data.friendshipStatus ==
                                              'friend-request-received') {
                                            sendingFriendRequest = false;
                                            friendshipState = translate(context, 'accept_friend_request');
                                            setState(() {});
                                            socialBloc.acceptFriendRequest(
                                                AppUtils.userData.id,
                                                widget.id);
                                          }
                                        },
                                  btnColor: Color(0xffEEEEEE),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              snapshot.data.data.friendshipStatus != 'friend'
                                  ? SizedBox.shrink()
                                  : Expanded(
                                      child: myButton2(
                                        startChatting
                                            ? Loader(
                                                size: 10,
                                              )
                                            : Icon(
                                                FontAwesomeIcons.commentDots,
                                                size: 18,
                                                color: mainColor,
                                              ),
                                        onTap: () async {
                                          startChatting = true;
                                          setState(() {});

                                         var id =  await chatBloc.intiateNewChat(
                                            IntiateNewChatRequest(
                                              users: [
                                                snapshot.data.data.details.id,
                                                AppUtils.userData.id,
                                              ],
                                              title: 'make chat',
                                              creatorId: AppUtils.userData.id,
                                            ),
                                          );

                                          setState(() {});
                                          startChatting = false;
                                          Navigator.of(context).push(
                                            MaterialPageRoute(
                                              builder: (_) => PrivateChatPage(
                                                name: userData.username,
                                                id: id,
                                              ),
                                            ),
                                          );
                                        },
                                        btnColor: mainColor.withOpacity(.2),
                                      ),
                                    ),
                              SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: myButton2(
                                  Container(
                                    width: 20,
                                    height: 20,
                                    child: Center(
                                      child: Icon(
                                        Icons.more_vert,
                                        size: 13,
                                        color: Colors.white,
                                      ),
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.grey,
                                      shape: BoxShape.circle,
                                    ),
                                  ),
                                  onTap: () {
                                    showPersonOptions(
                                        snapshot.data.data.friendshipStatus);
                                  },
                                  btnColor: Colors.grey.withOpacity(.2),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Card(
                    elevation: 4,
                    margin: EdgeInsets.zero,
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            translate(context, 'about'),
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.bold),
                          ),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.graduationCap,
                              size: 15,
                              color: Colors.grey,
                            ),
                            title: Text(
                              userData.userDetails != null &&
                                      userData.userDetails.education != null &&
                                      userData.userDetails.education != ''
                                  ? userData.userDetails.education
                                  : translate(context, 'no_education_data'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              FontAwesomeIcons.briefcase,
                              size: 15,
                              color: Colors.grey,
                            ),
                            title: Text(
                              userData.userDetails != null &&
                                      userData.userDetails.jobTitle != null &&
                                      userData.userDetails.jobTitle != ''
                                  ? userData.userDetails.jobTitle
                                  : translate(context, 'no_job_data'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          ListTile(
                            leading: Icon(
                              Icons.location_on,
                              size: 20,
                              color: Colors.grey,
                            ),
                            title: Text(
                              userData.userDetails != null &&
                                      userData.userDetails.address != null &&
                                      userData.userDetails.address != ''
                                  ? userData.userDetails.address
                                  : translate(context, 'no_address_data'),
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(10),
                  ),
                  Container(
                    width: double.infinity,
                    child: Card(
                      elevation: 4,
                      margin: EdgeInsets.zero,
                      child: Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.name} ${translate(context, 'media')}',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: 8),
                            snapshot.data.data.gallery.isEmpty
                                ? Text(translate(context, 'no_media_found'))
                                : GridView.builder(
                                    shrinkWrap: true,
                                    physics: NeverScrollableScrollPhysics(),
                                    itemCount:
                                        snapshot.data.data.gallery.length,
                                    itemBuilder: (context, index) {
                                      return ClipRRect(
                                        borderRadius: BorderRadius.circular(12),
                                        child: CachedNetworkImage(
                                          imageUrl:
                                              snapshot.data.data.gallery[index],
                                          fit: BoxFit.fill,
                                          placeholder: (context, url) {
                                            return Loader(
                                              size: 25,
                                            );
                                          },
                                        ),
                                      );
                                    },
                                    gridDelegate:
                                        MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                      crossAxisCount: 3,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      height: ScreenUtil().setHeight(100),
                                    ),
                                  ),
                            SizedBox(
                              height:
                                  snapshot.data.data.gallery.isEmpty ? 5 : 18,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 18,
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }
}
