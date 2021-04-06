import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:phinex/Bles/Model/responses/chat/IntiateNewChatResponse.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/consts.dart';

class GroupSettingsPage extends StatefulWidget {
  final List<Subscriptions> subscriptions;
  final int chatId;

  const GroupSettingsPage(
      {Key key, @required this.chatId, @required this.subscriptions})
      : super(key: key);

  @override
  _GroupSettingsPageState createState() => _GroupSettingsPageState();
}

class _GroupSettingsPageState extends State<GroupSettingsPage> {
  TextEditingController groupNameController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: myAppBar(translate(context, 'group_settings'), context),
      body: LoadingOverlay(
        isLoading: isLoading,
        opacity: .5,
        progressIndicator: Loader(),
        color: Colors.white,
        child: SingleChildScrollView(
          physics: bouncingScrollPhysics,
          child: Padding(
            padding: EdgeInsets.all(14.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ListView.builder(
                  itemBuilder: (context, index) {
                    var user = widget.subscriptions[index];
                    return ListTile(
                      title: Text(user.username),
                      leading: CircleAvatar(
                        backgroundImage: user.details != null &&
                                user.details.imageUrl != null &&
                                user.details.imageUrl != ''
                            ? CachedNetworkImageProvider(user.details.imageUrl)
                            : AssetImage('assets/images/avatar.png'),
                      ),
                    );
                  },
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: widget.subscriptions.length,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
