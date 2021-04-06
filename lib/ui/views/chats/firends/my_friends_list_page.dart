import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:phinex/Bles/Model/requests/BaseRequestSkipTake.dart';
import 'package:phinex/Bles/Model/requests/car_rental/CarRentalSearchRequest.dart';
import 'package:phinex/Bles/Model/responses/social/FriendsListResponse.dart';
import 'package:phinex/Bles/bloc/social/SocialBloc.dart';
import 'package:phinex/ui/views/chats/profile/person_profile_page.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class MyFriendsListPage extends StatefulWidget {
  @override
  _MyFriendsListPageState createState() => _MyFriendsListPageState();
}

class _MyFriendsListPageState extends State<MyFriendsListPage> {
  int skip = 0;
  int take = 100;

  TextEditingController searchController = TextEditingController();

  @override
  void initState() {
    super.initState();

    socialBloc.getshowFriendsList(BaseRequestSkipTake(
      id: AppUtils.userData.id,
      skip: skip,
      take: take,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar('Friends List', context),
      body: StreamBuilder<FriendsListResponse>(
          stream: socialBloc.showFriendsList.stream,
          builder: (context, snapshot) {
            if (socialBloc.loading.value) {
              return Loader();
            } else {
              // _scrollController
              //   ..addListener(
              //     () {
              //       if (_scrollController.position.pixels ==
              //           _scrollController.position.maxScrollExtent) {
              //         skip += 10;
              //         take = 10;
              //         socialBloc.getshowFriendsList(
              //           BaseRequestSkipTake(
              //             id: AppUtils.userData.id,
              //             skip: skip,
              //             take: take,
              //           ),
              //         );
              //       }
              //     },
              //   );
              return SingleChildScrollView(
                physics: bouncingScrollPhysics,
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Column(
                    children: [
                      MyTextFormField(
                        titleStyle: TextStyle(fontSize: 1),
                        prefixIcon: Icon(Icons.search),
                        hintText: translate(context, 'type_the_name_of_person'),
                        onChanged: (String input) {
                          if (input.isEmpty || input == '') {
                            socialBloc.getshowFriendsList(BaseRequestSkipTake(
                              id: AppUtils.userData.id,
                              skip: skip,
                              take: 100,
                            ));
                          } else {
                            socialBloc.searchUser(
                              SearchRequest(
                                take: 30,
                                skip: 0,
                                search: input,
                              ),
                            );
                          }
                        },
                      ),
                      ListView.separated(
                        itemCount: snapshot.data.data.length,
                        itemBuilder: (context, index) {
                          return Card(
                            elevation: 3,
                            child: ListTile(
                              onTap: () {
                                Navigator.of(context).push(
                                  MaterialPageRoute(
                                    builder: (_) => PersonProfilePage(
                                      id: snapshot.data.data[index].id,
                                      name:
                                      snapshot.data.data[index].username,
                                    ),
                                  ),
                                );
                              },
                              trailing: Container(
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
                                  color: deepBlueColor,
                                  shape: BoxShape.circle,
                                ),
                              ),
                              title: Text(snapshot.data.data[index].username),
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (_) => PersonProfilePage(
                                        id: snapshot.data.data[index].id,
                                        name:
                                            snapshot.data.data[index].username,
                                      ),
                                    ),
                                  );
                                },
                                child: CircleAvatar(
                                  radius: 18,
                                  backgroundImage: snapshot.data.data[index].image_url == null || snapshot.data.data[index].image_url == ''
                                      ? AssetImage('assets/images/avatar.png')
                                      : CachedNetworkImageProvider(
                                          snapshot.data.data[index].image_url,
                                        ),
                                ),
                              ),
                            ),
                          );
                        },
                        physics: NeverScrollableScrollPhysics(),
                        shrinkWrap: true,
                        separatorBuilder: (BuildContext context, int index) {
                          return SizedBox(
                            height: 8,
                          );
                        },
                      )
                    ],
                  ),
                ),
              );
            }
          }),
    );
  }
}
