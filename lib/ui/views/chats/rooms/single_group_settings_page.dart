import 'package:flutter/material.dart';
import 'package:phinex/Bles/bloc/social/RoomBloc.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_text_form_field.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

class SingleGroupSettingsPage extends StatefulWidget {

  final int roomId;
  final String name;

  const SingleGroupSettingsPage({Key key, @required this.roomId, this.name,}) : super(key: key);

  @override
  _SingleGroupSettingsPageState createState() =>
      _SingleGroupSettingsPageState();
}

class _SingleGroupSettingsPageState extends State<SingleGroupSettingsPage> {
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
                MyTextFormField(
                  controller: groupNameController,
                  onChanged: (String input) {
                    groupNameController.text = input;
                  },
                  title: widget.name,
                  titleStyle:
                      TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  suffixIcon: FlatButton(
                    onPressed: () async {
                      if (groupNameController.text.trim().isEmpty) return;
                      isLoading = true;
                      setState(() {});
                      await roomBloc.updateRoom(widget.roomId, groupNameController.text.trim());
                      isLoading = false;
                      setState(() {});
                      AppUtils.showToast(msg: translate(context, 'room_updated_successfully'), bgColor: mainColor);
                    },
                    child: Text(
                      'Save',
                      style: TextStyle(
                        color: mainColor,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                // Text(
                //   'Group Members',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // FlatButton(
                //   padding: EdgeInsets.zero,
                //   onPressed: () {
                //     Navigator.of(context).push(MaterialPageRoute(builder: (_) => AddMembersToGroupPage(),),);
                //   },
                //   child: Container(
                //     width: double.infinity,
                //     padding: EdgeInsets.all(10),
                //     decoration: BoxDecoration(
                //       borderRadius: BorderRadius.circular(5),
                //       color: greenColor.withOpacity(.2),
                //     ),
                //     child: Row(
                //       mainAxisAlignment: MainAxisAlignment.center,
                //       children: [
                //         Icon(
                //           Icons.add,
                //           color: greenColor,
                //         ),
                //         SizedBox(
                //           width: 10,
                //         ),
                //         Text(
                //           'Add Members',
                //           style: TextStyle(color: greenColor, fontSize: 15),
                //         ),
                //       ],
                //     ),
                //   ),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // ListView.builder(
                //   itemBuilder: (context, index) {
                //     return ListTile(
                //       trailing: index == 0
                //           ? null
                //           : GestureDetector(
                //               child: Icon(
                //               Icons.remove_circle,
                //               color: Colors.red,
                //             )),
                //       title: Text(
                //         index == 0 ? 'You' : 'Abanoub Fakhery',
                //         style: TextStyle(fontWeight: FontWeight.bold),
                //       ),
                //       leading: CircleAvatar(
                //         backgroundImage: AssetImage('assets/images/person.jpeg'),
                //       ),
                //     );
                //   },
                //   itemCount: 4,
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // Text(
                //   'Chat Media',
                //   style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                // ),
                // SizedBox(
                //   height: 15,
                // ),
                // GridView.builder(
                //   shrinkWrap: true,
                //   physics: NeverScrollableScrollPhysics(),
                //   itemCount: 20,
                //   itemBuilder: (context, index) {
                //     return ClipRRect(
                //       borderRadius: BorderRadius.circular(12),
                //       child: Image.asset('assets/images/person.jpeg', fit: BoxFit.fill,),
                //     );
                //   },
                //   gridDelegate:
                //       MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                //     crossAxisCount: 3,
                //         crossAxisSpacing: 10,
                //         mainAxisSpacing: 10,
                //         height: ScreenUtil().setHeight(100)
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
