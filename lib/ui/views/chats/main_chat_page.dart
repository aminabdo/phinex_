import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/provider.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/chats/firends/create_group_page.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/utils/consts.dart';

import 'firends/friends_page.dart';
import 'profile/profile_page.dart';
import 'rooms/create_room_page.dart';
import 'rooms/groups_page.dart';
import 'members/members_page.dart';
import 'menu/menu_page.dart';

class MainChatPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _MainChatPageState createState() => _MainChatPageState();
}

class _MainChatPageState extends State<MainChatPage> {
  int selectedTap = 2;

  PageController pageController;

  @override
  void initState() {
    super.initState();

    pageController = PageController(
      initialPage: selectedTap,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(
        getTitle(),
        context,
        elevation: 0,
        actions: selectedTap == 1 ? [
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateRoomPage(),
                ),
              );
            },
            child: Text(translate(context, 'create_room'), style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ] : selectedTap == 2 ? [
          FlatButton(
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => CreateGroupPage(),
                ),
              );
            },
            child: Text(translate(context, 'create_group'), style: TextStyle(fontWeight: FontWeight.bold),),
          ),
        ] : null,
        onBackBtnClicked: () {
          Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
        },
      ),
      body: WillPopScope(
        child: Column(
          children: [
            taps(),
            Expanded(
              child: PageView(
                controller: pageController,
                physics: bouncingScrollPhysics,
                scrollDirection: Axis.horizontal,
                onPageChanged: (int page) {
                  selectedTap = page;
                  setState(() {});
                },
                children: [
                  MenuPage(),
                  GroupsPage(),
                  MembersPage(),
                  FriendsPage(),
                  ProfilePage(),
                ],
              ),
            ),
          ],
        ),
        onWillPop: () async {
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, HomeContents());

          return false;
        },
      ),
    );
  }

  Widget taps() {
    return Card(
      margin: EdgeInsets.zero,
      elevation: 4,
      child: Padding(
        padding: EdgeInsets.only(top: 8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            GestureDetector(
              onTap: () async {
                pageController.animateToPage(
                  0,
                  duration: Duration(milliseconds: 150),
                  curve: Curves.linear,
                );
                selectedTap = 0;
                setState(() {});
              },
              child: Column(
                children: [
                  Icon(
                    Icons.menu,
                    color: selectedTap == 0 ? mainColor : deepBlueColor,
                  ),
                  Text(
                    translate(context, 'more'),
                    style: TextStyle(
                      color: selectedTap == 0 ? mainColor : deepBlueColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(1,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.linear);
                selectedTap = 1;
                setState(() {});
              },
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.users,
                    color: selectedTap == 1 ? mainColor : deepBlueColor,
                  ),
                  Text(
                    translate(context, 'rooms'),
                    style: TextStyle(
                      color: selectedTap == 1 ? mainColor : deepBlueColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(2,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.linear);
                selectedTap = 2;
                setState(() {});
              },
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.solidCommentAlt,
                    color: selectedTap == 2 ? mainColor : deepBlueColor,
                  ),
                  Text(
                    translate(context, 'chats'),
                    style: TextStyle(
                      color: selectedTap == 2 ? mainColor : deepBlueColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(3,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.linear);
                selectedTap = 3;
                setState(() {});
              },
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.userFriends,
                    color: selectedTap == 3 ? mainColor : deepBlueColor,
                  ),
                  Text(
                    translate(context, 'friends'),
                    style: TextStyle(
                      color: selectedTap == 3 ? mainColor : deepBlueColor,
                    ),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () {
                pageController.animateToPage(4,
                    duration: Duration(milliseconds: 150),
                    curve: Curves.linear);
                selectedTap = 4;
                setState(() {});
              },
              child: Column(
                children: [
                  Icon(
                    FontAwesomeIcons.userCircle,
                    color: selectedTap == 4 ? mainColor : deepBlueColor,
                  ),
                  Text(
                    translate(context, 'profile'),
                    style: TextStyle(
                      color: selectedTap == 4 ? mainColor : deepBlueColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String getTitle() {
    switch(selectedTap) {
      case 0: return translate(context, 'menu');
      case 1: return translate(context, 'rooms');
      case 2: return translate(context, 'chats');
      case 3: return translate(context, 'friends');
      case 4: return translate(context, 'profile');
      default:
        return '';
    }
  }
}
