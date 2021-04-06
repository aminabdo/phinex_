import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:phinex/Bles/Model/responses/professions/ProfessionsSearchResponse.dart';
import 'package:phinex/Bles/bloc/professions/Professions.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_sliver_grid_delegate.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/consts.dart';

import 'profession_cart_item.dart';

class ProfessionSearchPage extends StatefulWidget {
  @override
  _ProfessionSearchPageState createState() => _ProfessionSearchPageState();
}

class _ProfessionSearchPageState extends State<ProfessionSearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: Column(
        children: [
          SizedBox(
            height: MediaQuery.of(context).padding.top,
          ),
          Material(
            elevation: 8,
            color: Colors.white,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: ScreenUtil().setWidth(4),
                vertical: ScreenUtil().setHeight(8),
              ),
              child: Row(
                children: [
                  SizedBox(
                    width: ScreenUtil().setWidth(10),
                  ),
                  Expanded(
                    child: TextField(
                      controller: searchController,
                      onChanged: (String input) {
                        professionsBloc.getSearch(input);
                        setState(() {});
                      },
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixIcon: Icon(
                          Icons.search,
                          color: Colors.grey[300],
                        ),
                        suffixIcon: searchController.text.isNotEmpty
                            ? GestureDetector(
                                onTap: () {
                                  searchController.clear();
                                  setState(() {});
                                },
                                child: Icon(
                                  Icons.cancel_rounded,
                                  color: deepBlueColor,
                                ),
                              )
                            : SizedBox.shrink(),
                        contentPadding: EdgeInsets.symmetric(
                          horizontal: ScreenUtil().setWidth(10),
                          vertical: ScreenUtil().setHeight(0),
                        ),
                        hintText:
                            AppLocalization.of(context).translate('search'),
                        hintStyle: TextStyle(color: Colors.grey),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                            width: .8,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Colors.grey[300],
                            width: .8,
                          ),
                        ),
                      ),
                    ),
                  ),
                  FlatButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      AppLocalization.of(context).translate('cancel'),
                      style: TextStyle(
                        fontSize: 17,
                        letterSpacing: 1,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          searchController.text.isEmpty
              ? SizedBox.shrink()
              : Expanded(
                  child: StreamBuilder<ProfessionsSearchResponse>(
                    stream: professionsBloc.search.stream,
                    builder: (context, snapshot) {
                      if (professionsBloc.loading.value) {
                        return Loader();
                      } else {
                        return GridView.builder(
                          physics: bouncingScrollPhysics,
                          itemBuilder: (context, index) {
                            return ProfessionCardItem(
                              currentItem: snapshot.data.data.results[index],
                            );
                          },
                          itemCount: snapshot.data.data.results.length,
                          gridDelegate:
                              MySliverGridDelegateWithFixedCrossAxisCountAndFixedHeight(
                            crossAxisCount: 2,
                            height: ScreenUtil().setHeight(380),
                          ),
                        );
                      }
                    },
                  ),
                )
        ],
      ),
    );
  }
}
