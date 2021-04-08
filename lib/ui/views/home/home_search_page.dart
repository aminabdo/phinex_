import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/responses/SearchAllResponse.dart';
import 'package:phinex/Bles/bloc/general/GeneralBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/auctions/auction_user_view_page.dart';
import 'package:phinex/ui/views/buy_and_sell/buy_sell_product_details_page.dart';
import 'package:phinex/ui/views/chats/profile/person_profile_page.dart';
import 'package:phinex/ui/views/medical_services/clinics/single_clinic_details_page.dart';
import 'package:phinex/ui/views/medical_services/doctors/single_doctor_details_page.dart';
import 'package:phinex/ui/views/medical_services/pharmacy/single_pharmacy_details_page.dart';
import 'package:phinex/ui/views/profession/profession_details_page.dart';
import 'package:phinex/ui/views/store/store_item_details_page.dart';
import 'package:phinex/ui/views/vendor/vendor_profile_page.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/utils/app_localization.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';

import 'home_contents.dart';

class HomeSearchPage extends StatefulWidget {
  @override
  _HomeSearchPageState createState() => _HomeSearchPageState();
}

class _HomeSearchPageState extends State<HomeSearchPage> {
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
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
                        child: TextFormField(
                          controller: searchController,
                          onFieldSubmitted: (String input) async {
                            if (searchController.text.isEmpty) {
                              return;
                            }

                            await generalBloc.searchGet(input);
                            if(mounted) setState(() {});
                          },
                          onSaved: (String input) async {
                            if (searchController.text.isEmpty) {
                              return;
                            }

                            await generalBloc.searchGet(input);
                            if(mounted) setState(() {});
                          },
                          onChanged: (String input) async {
                            if(input.isEmpty) return;

                            await generalBloc.searchGet(input);
                            if(mounted) setState(() {});
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
                          AppUtils.hideKeyboard(context);
                          Provider.of<PageProvider>(context, listen: false).setPage(HomeContents.pageIndex, HomeContents());
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
              if (searchController.text.isEmpty) SizedBox.shrink()
              else StreamBuilder<SearchAllResponse>(
                stream: generalBloc.search.stream,
                builder: (context, snapshot) {
                  if (generalBloc.loading.value) {
                    return Column(
                      children: [
                        SizedBox(height: MediaQuery.of(context).size.height / 2),
                        Loader(),
                        SizedBox(height: MediaQuery.of(context).size.height / 2),
                      ],
                    );
                  } else {
                    if (snapshot.hasData && snapshot.data != null) {
                      print(snapshot.data);
                      return Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Column(
                          children: [
                            snapshot.data.data.users != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'users'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => PersonProfilePage(id: snapshot.data.data.users[index].id, name: snapshot.data.data.users[index].username)));
                                          },
                                          title: Text(snapshot.data.data.users[index].username ?? ''),
                                          leading: CircleAvatar(
                                            backgroundImage: snapshot.data.data.users[index].imageUrl == null || snapshot.data.data.users[index].imageUrl == '' ? Image.asset('assets/images/avatar.png').image : CachedNetworkImageProvider(snapshot.data.data.users[index].imageUrl),
                                          ),
                                        );
                                      },
                                      itemCount: snapshot.data.data.users.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.products != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'products'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => StoreCartItemDetailsPage(
                                                  productId: snapshot.data.data.products[index].id,
                                                  productName: snapshot.data.data.products[index].name,
                                                  isFavourite: false,
                                                  quantity: 0,
                                                  price: 50.0,
                                                 ),
                                               ),
                                            );
                                          },
                                          title: Text(snapshot.data.data.products[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.products[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.products.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.technicians != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'profession'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => ProfessionDetailsPage(id: snapshot.data.data.technicians[index].id, title: snapshot.data.data.technicians[index].name)));
                                          },
                                          title: Text(snapshot.data.data.technicians[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.technicians[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.technicians.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.auctions != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'auctions'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            // Navigator.of(context).push(MaterialPageRoute(builder: (_) => AuctionUserViewPage(id: snapshot.data.data.auctions[index].id, name: snapshot.data.data.auctions[index].name)));
                                          },
                                          title: Text(snapshot.data.data.auctions[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.auctions[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.auctions.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.buyAndSell != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'buy_and_sell'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => BuyAndSellProductDetailsPage(itemId: snapshot.data.data.buyAndSell[index].id, itemName: snapshot.data.data.buyAndSell[index].name)));
                                          },
                                          title: Text(snapshot.data.data.buyAndSell[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.buyAndSell[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.buyAndSell.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.catalogues != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'catalogues'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(snapshot.data.data.catalogues[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.catalogues[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.catalogues.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.medical_services != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'medical_service'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => SingleDoctorDetailsPage(id: snapshot.data.data.medical_services.doctors[index].id, title: snapshot.data.data.medical_services.doctors[index].name)));
                                          },
                                          title: Text(snapshot.data.data.medical_services.doctors[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.medical_services.doctors[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.medical_services.doctors.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => SingleClinicDetailsPage(id: snapshot.data.data.medical_services.clinics[index].id, title: snapshot.data.data.medical_services.clinics[index].name)));
                                          },
                                          title: Text(snapshot.data.data.medical_services.clinics[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.medical_services.clinics[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.medical_services.clinics.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => SinglePharmacyDetailsPage(id: snapshot.data.data.medical_services.pharmacies[index].id, title: snapshot.data.data.medical_services.pharmacies[index].name)));
                                          },
                                          title: Text(snapshot.data.data.medical_services.pharmacies[index].name ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.medical_services.pharmacies.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.realestate != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'real_state'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          title: Text(snapshot.data.data.realestate[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.realestate[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.realestate.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                            snapshot.data.data.vendors != null ? Card(
                              elevation: 6,
                              child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(AppUtils.translate(context, 'vendor'), style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                                    Divider(thickness: 1.5,),
                                    ListView.builder(
                                      itemBuilder: (context, index) {
                                        return ListTile(
                                          onTap: () {
                                            Navigator.of(context).push(MaterialPageRoute(builder: (_) => VendorProfilePage(vendorId: snapshot.data.data.vendors[index].id)));
                                          },
                                          title: Text(snapshot.data.data.vendors[index].name ?? ''),
                                          subtitle: Text(snapshot.data.data.vendors[index].categoryName ?? ''),
                                        );
                                      },
                                      itemCount: snapshot.data.data.vendors.length,
                                      shrinkWrap: true,
                                      physics: NeverScrollableScrollPhysics(),
                                    ),
                                  ],
                                ),
                              ),
                            ) : null,
                          ].where((element) => element != null).toList(),
                        ),
                      );
                    }
                    return Loader();
                  }
                },
              ),
            ].where((element) => element != null).toList(),
          ),
        ),
      ),
    );
  }
}
