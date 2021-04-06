import 'package:expandable/expandable.dart';
import 'package:flutter/material.dart';
import 'package:phinex/Bles/Model/responses/room/RoomLandingResponse.dart';
import 'package:phinex/Bles/bloc/social/RoomBloc.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/consts.dart';

import 'private_group_chat_page.dart';

class GroupsPage extends StatefulWidget {
  @override
  _GroupsPageState createState() => _GroupsPageState();
}

class _GroupsPageState extends State<GroupsPage> {
  @override
  void initState() {
    super.initState();

    roomBloc.getRoomLanding();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      physics: bouncingScrollPhysics,
      child: StreamBuilder<RoomLandingResponse>(
        stream: roomBloc.roomLanding.stream,
        builder: (context, snapshot) {
          if (roomBloc.loading.value) {
            return Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
                Loader(),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 4,
                ),
              ],
            );
          } else {
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ExpandablePanel(
                    header: Text(
                      translate(context, 'admin_rooms'),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                        color: Colors.grey,
                      ),
                    ),
                    expanded: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PrivateGroupChatPage(
                                  roomId:
                                      snapshot.data.data.adminsRooms[index].id,
                                  roomName: snapshot
                                      .data.data.adminsRooms[index].name,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            snapshot.data.data.adminsRooms[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text('send me the icons please '),
                          // trailing: Text(
                          //   '8 members',
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          leading: Stack(
                            overflow: Overflow.visible,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                              Positioned(
                                right: -10,
                                top: 5,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                ),
                              ),
                              Positioned(
                                left: -6,
                                bottom: -15,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: snapshot.data.data.adminsRooms.length,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  ExpandablePanel(
                    header: Text(
                      translate(context, 'users_rooms'),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: Colors.grey),
                    ),
                    expanded: ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        return ListTile(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => PrivateGroupChatPage(
                                  roomId:
                                      snapshot.data.data.usersRooms[index].id,
                                  roomName:
                                      snapshot.data.data.usersRooms[index].name,
                                ),
                              ),
                            );
                          },
                          title: Text(
                            snapshot.data.data.usersRooms[index].name,
                            style: TextStyle(fontWeight: FontWeight.bold),
                          ),
                          // subtitle: Text('send me the icons please '),
                          // trailing: Text(
                          //   '8 members',
                          //   style: TextStyle(color: Colors.grey),
                          // ),
                          leading: Stack(
                            overflow: Overflow.visible,
                            children: [
                              CircleAvatar(
                                radius: 15,
                                backgroundImage:
                                    AssetImage('assets/images/avatar.png'),
                              ),
                              Positioned(
                                right: -10,
                                top: 5,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                ),
                              ),
                              Positioned(
                                left: -6,
                                bottom: -15,
                                child: CircleAvatar(
                                  radius: 15,
                                  backgroundImage:
                                      AssetImage('assets/images/avatar.png'),
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      itemCount: snapshot.data.data.usersRooms.length,
                    ),
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
