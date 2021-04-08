import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_absolute_path/flutter_absolute_path.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:phinex/Bles/Model/requests/social/AddGalleryRequest.dart';
import 'package:phinex/Bles/Model/requests/social/UpdateUserProfile.dart';
import 'package:phinex/Bles/Model/responses/social/UserProfileResponse.dart';
import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
import 'package:phinex/ui/widgets/my_button2.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'edit_profile_page.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  List<File> selectedImages = [];
  File profileImage;
  File coverImage;

  bool uploadImage = false;

  @override
  void initState() {
    super.initState();

    socialBloc.getUserProfile(AppUtils.userData.id);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<UserProfileResponse>(
      stream: socialBloc.userProfile.stream,
      builder: (context, snapshot) {
        if (socialBloc.loading.value) {
          return Loader();
        } else {
          var userData = snapshot.data.data.details;

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
                                    userData.userDetails.coverImageUrl ==
                                        null ||
                                    userData.userDetails.coverImageUrl == ''
                                ? coverImage == null
                                    ? Image.asset(
                                        'assets/images/cover_image.jpg',
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                    : Image.file(
                                        coverImage,
                                        height:
                                            MediaQuery.of(context).size.height *
                                                .2,
                                        width: double.infinity,
                                        fit: BoxFit.cover,
                                      )
                                : CachedNetworkImage(
                                    imageUrl:
                                        userData.userDetails.coverImageUrl,
                                    height:
                                        MediaQuery.of(context).size.height * .2,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    placeholder: (context, url) {
                                      return Loader(
                                        size: 30,
                                      );
                                    },
                                  ),
                            Positioned(
                              top: 10,
                              left: 10,
                              child: Container(
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Colors.black26,
                                ),
                                child: Center(
                                  child: IconButton(
                                    icon: Icon(
                                      FontAwesomeIcons.edit,
                                      color: Colors.white,
                                      size: 18,
                                    ),
                                    onPressed: () async {
                                      var image = await AppUtils.getImage(1);
                                      if (image != null) {
                                        var path = await FlutterAbsolutePath
                                            .getAbsolutePath(
                                          image[0].identifier,
                                        );
                                        coverImage = File(path);
                                        setState(() {});
                                        socialBloc.updateUserProfileCoverImage(
                                            UpdateUserProfileRequest.coverImage(
                                          userId: AppUtils.userData.id,
                                          coverImage: coverImage,
                                        ));
                                      }
                                    },
                                  ),
                                ),
                              ),
                            ),
                            Positioned(
                              left: 0,
                              right: 0,
                              bottom: -7,
                              child: GestureDetector(
                                onTap: () async {
                                  var image = await AppUtils.getImage(1);
                                  if (image != null) {
                                    var path = await FlutterAbsolutePath
                                        .getAbsolutePath(
                                      image[0].identifier,
                                    );
                                    profileImage = File(path);
                                    setState(() {});

                                    socialBloc.updateUserProfileImage(
                                        UpdateUserProfileRequest.image(
                                      userId: AppUtils.userData.id,
                                      image: profileImage,
                                    ));
                                  }
                                },
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
                                          ? profileImage == null
                                              ? Image.asset(
                                                  'assets/images/avatar.png',
                                                  fit: BoxFit.fill,
                                                  width: 100,
                                                  height: 100,
                                                ).image
                                              : Image.file(
                                                  profileImage,
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
                        child: GestureDetector(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(),
                              ),
                            );
                          },
                          child: Text(
                            userData.userDetails != null &&
                                    userData.userDetails.description != null &&
                                    userData.userDetails.description != ''
                                ? userData.userDetails.description
                                : AppUtils.translate(context, 'add_bio'),
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(14.0),
                        child: myButton2(
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                FontAwesomeIcons.edit,
                                size: 20,
                                color: deepBlueColor,
                              ),
                              SizedBox(width: 10),
                              Text(
                                translate(context, 'edit_profile'),
                                style: TextStyle(
                                  color: deepBlueColor,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(),
                              ),
                            );
                          },
                          btnColor: Color(0xffEEEEEE),
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
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(),
                              ),
                            );
                          },
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
                                : translate(context, 'add_education'),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(),
                              ),
                            );
                          },
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
                                : translate(context, 'add_job'),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => EditProfilePage(),
                              ),
                            );
                          },
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
                                : translate(context, 'add_address'),
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              color: Colors.blue,
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
                            translate(context, 'your_media'),
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          snapshot.data.data.gallery.isEmpty
                              ? selectedImages.isEmpty
                                  ? GestureDetector(
                                      onTap: () async {
                                        var images =
                                            await AppUtils.getImage(10);
                                        if (images != null) {
                                          images.forEach((element) async {
                                            var path = await FlutterAbsolutePath
                                                .getAbsolutePath(
                                              element.identifier,
                                            );

                                            selectedImages.add(File(path));
                                          });
                                          setState(() {});
                                        }
                                      },
                                      child: Container(
                                        height: 140,
                                        margin: EdgeInsets.symmetric(
                                          horizontal: 20,
                                          vertical: 3,
                                        ),
                                      ),
                                    )
                                  : Column(
                                      children: [
                                        GridView.builder(
                                          shrinkWrap: true,
                                          physics: NeverScrollableScrollPhysics(),
                                          itemCount: selectedImages.length + 1,
                                          itemBuilder: (context, index) {
                                            if (index == 0) {
                                              return GestureDetector(
                                                onTap: () async {
                                                  var images = await AppUtils.getImage(10);
                                                  if (images != null) {
                                                    images.forEach((element) async {
                                                      var path = await FlutterAbsolutePath.getAbsolutePath(element.identifier,);
                                                      selectedImages.add(File(path));
                                                    });
                                                    setState(() {});
                                                  }
                                                },
                                                child: Container(
                                                  margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                ),
                                              );
                                            } else {
                                              return Container(
                                                margin: EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                                                child: Stack(
                                                  fit: StackFit.expand,
                                                  overflow: Overflow.visible,
                                                  children: [
                                                    ClipRRect(
                                                      borderRadius: BorderRadius.circular(12,),
                                                      child: Image.file(
                                                        selectedImages[index],
                                                        fit: BoxFit.fill,
                                                      ),
                                                    ),
                                                    Positioned(
                                                      right: -22,
                                                      top: -20,
                                                      child: IconButton(
                                                        icon: Icon(
                                                          Icons.cancel,
                                                          color: Colors.red,
                                                          size: 18,
                                                        ),
                                                        padding:
                                                        EdgeInsets.all(0),
                                                        onPressed: () {
                                                          selectedImages.removeAt(index);
                                                          setState(() {});
                                                        },
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              );
                                            }
                                          },
                                          gridDelegate:
                                              MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                                            crossAxisCount: 3,
                                            height: ScreenUtil().setHeight(125),
                                          ),
                                        ),
                                        SizedBox(
                                          height: 20,
                                        ),
                                        myButton2(
                                            uploadImage
                                                ? Loader(
                                                    size: 25,
                                                  )
                                                : Text(
                                                    translate(
                                                        context, 'upload'),
                                                    style: TextStyle(
                                                      fontSize: 15,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white,
                                                    ),
                                                  ), onTap: () async {
                                          uploadImage = true;
                                          setState(() {});
                                          await socialBloc.addGalleryToUser(
                                            AddGalleryRequest(
                                              AppUtils.userData.id,
                                              selectedImages,
                                            ),
                                          );

                                          uploadImage = false;
                                          setState(() {});

                                          socialBloc.getUserProfile(
                                              AppUtils.userData.id);
                                        }),
                                      ],
                                    )
                              : SizedBox.shrink(),
                          snapshot.data.data.gallery.isEmpty
                              ? SizedBox.shrink()
                              : GridView.builder(
                                  shrinkWrap: true,
                                  physics: NeverScrollableScrollPhysics(),
                                  itemCount: snapshot.data.data.gallery.length,
                                  itemBuilder: (context, index) {
                                    if (index == 0) {
                                    }
                                    return ClipRRect(
                                      borderRadius: BorderRadius.circular(12),
                                      child: CachedNetworkImage(
                                        imageUrl: snapshot
                                            .data.data.gallery[index - 1],
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
                            height: snapshot.data.data.gallery.isEmpty ? 5 : 18,
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
    );
  }
}
