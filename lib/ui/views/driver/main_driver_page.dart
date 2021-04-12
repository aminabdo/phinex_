import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:flutter_screenutil/screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:geocoder/geocoder.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_places_picker/google_places_picker.dart';
import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:phinex/Bles/Model/requests/rate/MakeRateRequest.dart';
import 'package:phinex/Bles/Model/requests/taxi_client/ChangeRideStatusRequest.dart';
import 'package:phinex/Bles/Model/requests/taxi_client/MakeRideRequest.dart';
import 'package:phinex/Bles/Model/responses/taxi_client/BaseRideResponse.dart';
import 'package:phinex/Bles/bloc/taxi/TaxiRideBloc.dart';
import 'package:phinex/providers/page_provider.dart';
import 'package:phinex/ui/views/home/home_contents.dart';
import 'package:phinex/ui/views/home/services_page.dart';
import 'package:phinex/ui/widgets/driver_loading_effect.dart';
import 'package:phinex/ui/widgets/my_app_bar.dart';
import 'package:phinex/ui/widgets/my_button.dart';
import 'package:phinex/ui/widgets/my_loader.dart';
import 'package:phinex/ui/widgets/my_rating_bar.dart';
import 'package:phinex/utils/app_utils.dart';
import 'package:phinex/utils/consts.dart';
import 'package:phinex/utils/location_utils.dart';
import 'package:url_launcher/url_launcher.dart';

import 'all_trips_page.dart';
import 'driver_behavour_class.dart';
import 'response_cart_item.dart';

class MainDriverPage extends StatefulWidget {
  static final int pageIndex = 0;

  @override
  _MainDriverPageState createState() => _MainDriverPageState();
}

class _MainDriverPageState extends State<MainDriverPage> {
  GoogleMapController _controller;
  Circle circles;
  Marker markers;
  Polyline polyline;
  LocationData _userPosition;
  double _circleRadius = 30;
  double zoomLevel = 18;

  int selectedVehicle = -1;
  List<Vehicles> vehicles = [];

  static final CameraPosition initialCameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  bool loadMap = false;
  bool startTimer = false;
  bool showResponse = true;
  double userRate = 0;

  String from, to;
  String time = '';

  Duration duration = Duration(milliseconds: 500);
  Timer timer;

  Place originPlace;
  Place destinationPlace;
  Vehicles _selectedVehicle;
  int rideId;

  bool gotVehicles = false;
  bool showResponses = false;

  @override
  void initState() {
    super.initState();
    PluginGooglePlacePicker.initialize(
      androidApiKey: MAP_KEY,
      iosApiKey: MAP_KEY,
    );

    askPermission();
    taxiBloc.getVehicleTypeResponse();
  }

  @override
  void dispose() {
    super.dispose();

    if (timer != null) {
      if (timer.isActive) {
        timer.cancel();
      }
    }
  }

  void askPermission() async {
    Location location = new Location();

    bool _serviceEnabled;

    _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return;
      }
    }

    // first of all check location permission
    var permissionIsGranted = await AppUtils.checkPermissionState(Permission.location);
    if (!permissionIsGranted) {
      permissionIsGranted = await AppUtils.askLocationPermission();
    }

    // case location permission is denied
    if (!permissionIsGranted) {
      AppUtils.showToast(msg: 'Location Permission Is Refused');
    } else {

      // case user don't open the location (GPS)
      if (!await LocationUtils.locationIsEnabled()) {
        AppUtils.showToast(msg: 'GPS IS Not Enabled');
        return;
      } else {
        // case everything is true and working
        // request current user location data
        LocationData position = await LocationUtils.getCurrentUserLocation();
        print(
          'position >>>>>>>>>>>>>> ${position.toString()}',
        );

        _userPosition = position;
        final coordinates =
            new Coordinates(position.latitude, position.longitude);
        var addresses =
            await Geocoder.google(MAP_KEY, language: AppUtils.language)
                .findAddressesFromCoordinates(coordinates);
        var first = addresses.first;
        from =
            ('${first.countryName ?? ''} ${first.adminArea ?? ''} ${first.subAdminArea ?? ''}');
        originPlace = Place();
        originPlace.lng = _userPosition.longitude;
        originPlace.lat = _userPosition.latitude;
        originPlace.name = from;
        loadMap = true;
        setState(() {});
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (taxiBloc.vehickeTypes.value != null) {
      if (!gotVehicles) {
        vehicles = List<Vehicles>();
        taxiBloc.vehickeTypes.value.data.forEach(
          (element) {
            vehicles.add(
              Vehicles(
                image: element.image,
                title: element.title,
                vehicleId: element.id,
              ),
            );
          },
        );
      }
    }

    return Scaffold(
      appBar: myAppBar(
        translate(context, 'request_a_ride'),
        context,
        actions: [
          IconButton(
            icon: Icon(
              Icons.history,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (_) => AllTripsPage(),
                ),
              );
            },
          ),
        ],
        onBackBtnClicked: () {
          if (mounted) {
            driverStateBloc.setState(1);
            setState(() {});
          }
          stopTimer();
          Provider.of<PageProvider>(context, listen: false)
              .setPage(HomeContents.pageIndex, ServicesPage());
        },
      ),
      body: WillPopScope(
        child: !loadMap
            ? SpringEffect()
            : StreamBuilder<int>(
          stream: driverStateBloc.state.stream,
                  builder: (context, snapshot) => StreamBuilder<BaseRideResponse>(
                  stream: taxiBloc.ride.stream,
                  builder: (context, snapshot) {
                    print(driverStateBloc.state.value);
                    return Container(
                      width: double.infinity,
                      child: Stack(
                        children: [
                          GoogleMap(
                            zoomControlsEnabled: false,
                            markers: Set.of(markers != null ? [markers] : []),
                            mapType: MapType.normal,
                            circles: Set.of(circles != null ? [circles] : []),
                            polylines: Set.of(polyline != null ? [polyline] : []),
                            initialCameraPosition: initialCameraPosition,
                            onMapCreated: (GoogleMapController controller) {
                              _controller = controller;
                              rootBundle
                                  .loadString('assets/styles/map_style.txt')
                                  .then((string) {
                                _controller.setMapStyle(string);
                                if (mounted) setState(() {});
                              });
                              goToUserLocation();
                            },
                          ),
                          driverStateBloc.state.value == 1 ||
                                  driverStateBloc.state.value == 3 ||
                                  driverStateBloc.state.value == 6 ||
                                  driverStateBloc.state.value == 5 ||
                                  driverStateBloc.state.value == 8 ||
                                  driverStateBloc.state.value == 7
                              ? topSearchBox()
                              : driverStateBloc.state.value == 2
                                  ? destinationBox()
                                  : null,
                          // myLocationBtn(),
                          cancelTripBtn(),
                          confirmTripBtn(),
                          driverStateBloc.state.value == 3 || driverStateBloc.state.value == 6 ? selectVehiclePart() : null,
                          driverStateBloc.state.value == 5 ? waitingDialog(snapshot) : null,
                          driverStateBloc.state.value == 7 ? requestTimeoutDialog() : null,
                          driverStateBloc.state.value == 8 ? responsesDialog() : null,
                          driverStateBloc.state.value == 19 ? tripStartedDialog() : null,
                          driverStateBloc.state.value == 9 || driverStateBloc.state.value == 20 ? chatDialog() : null,
                          driverStateBloc.state.value == 10 ? rateDriverWidget() : null,
                        ].where((element) => element != null).toList(),
                      ),
                    );
                  },
                ),
            ),
        onWillPop: () async {
          if (mounted) {
            driverStateBloc.setState(1);
            setState(() {});
          }
          stopTimer();
          Provider.of<PageProvider>(context, listen: false).setPage(
            HomeContents.pageIndex,
            HomeContents(),
          );
          return false;
        },
      ),
    );
  }

  Widget readyCircle() {
    return Container(
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        border: Border.all(color: mainColor, width: 1.5),
        shape: BoxShape.circle,
      ),
      child: Center(
        child: Container(
          padding: EdgeInsets.all(4),
          decoration: BoxDecoration(
            color: mainColor,
            shape: BoxShape.circle,
          ),
        ),
      ),
    );
  }

  Widget notReadyCircle() {
    return Container(
      padding: EdgeInsets.all(4),
      decoration: BoxDecoration(
        border: Border.all(color: deepBlueColor, width: 1.5),
        shape: BoxShape.circle,
      ),
    );
  }

  Widget topSearchBox() {
    return Positioned(
      left: 0,
      right: 0,
      top: driverStateBloc.state.value == 1 ||
              driverStateBloc.state.value == 3 ||
              driverStateBloc.state.value == 6 ||
              driverStateBloc.state.value == 5 ||
              driverStateBloc.state.value == 8 ||
              driverStateBloc.state.value == 9 ||
              driverStateBloc.state.value == 7
          ? ScreenUtil().setHeight(10)
          : -100,
      child: GestureDetector(
        onTap: () {
          driverStateBloc.setState(2);
          setState(() {});
        },
        child: Container(
          width: double.infinity,
          child: Card(
            elevation: 4,
            margin: EdgeInsets.all(14),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                children: [
                  isReadyForRide() ? readyCircle() : notReadyCircle(),
                  Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(14.0),
                      child: Text(
                        isReadyForRide()
                            ? to ?? ''
                            : AppUtils.translate(context, 'ready_to_go_for'),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Future<Place> showPlacePicker() async {
    var place = await PluginGooglePlacePicker.showAutocomplete(
      mode: PlaceAutocompleteMode.MODE_OVERLAY,
      typeFilter: TypeFilter.ESTABLISHMENT,
    );

    if (place != null) {
      Place _place = Place(
        id: place.id,
        lat: place.latitude,
        lng: place.longitude,
        name: place.name,
      );
      print(_place.toString());
      return _place;
    }

    return null;
  }

  void startTheTimer() {
    startTimer = true;
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      if (timer.tick == 121) {
        timer.cancel();
        startTimer = false;
        driverStateBloc.setState(7);
        setState(() {});
      } else {
        time = '${121 - timer.tick}';
        setState(() {});
      }
    });
  }

  void goToUserLocation() async {
    // move camera to user location
    _controller.animateCamera(
      CameraUpdate.newCameraPosition(
        CameraPosition(
          zoom: zoomLevel,
          bearing: 130.54521545,
          target: LatLng(
            _userPosition.latitude,
            _userPosition.longitude,
          ),
        ),
      ),
    );

    final coordinates =
        new Coordinates(_userPosition.latitude, _userPosition.longitude);
    var addresses = await Geocoder.google(MAP_KEY, language: AppUtils.language)
        .findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    from =
        ('${first.countryName}, ${first.adminArea ?? ''} ${first.subAdminArea ?? ''}');
    originPlace = Place();
    originPlace.lng = _userPosition.longitude;
    originPlace.lat = _userPosition.latitude;
    originPlace.name = from;

    // calculate radius
    double radius = _circleRadius + _circleRadius / 2;
    double scale = radius / 800;
    zoomLevel = (18 - scale / 2);

    circles = Circle(
      circleId: CircleId(
        '${DateTime.now()}',
      ),
      center: LatLng(_userPosition.latitude, _userPosition.longitude),
      radius: zoomLevel,
      strokeColor: deepBlueColor,
      visible: true,
      strokeWidth: 1,
      fillColor: deepBlueColor.withAlpha(70),
    );

    markers = Marker(
      markerId: MarkerId(
        '${DateTime.now()}',
      ),
      visible: true,
      position: LatLng(_userPosition.latitude, _userPosition.longitude),
      infoWindow: InfoWindow(
        title: translate(context, 'your_current_location'),
      ),
    );

    setState(() {});
  }

  Widget destinationBox() {
    return Positioned(
      left: 0,
      right: 0,
      top: ScreenUtil().setHeight(10),
      child: Container(
        width: double.infinity,
        child: Card(
          elevation: 4,
          margin: EdgeInsets.all(14),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            child: Row(
              children: [
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                        border: Border.all(color: deepBlueColor, width: 1.5),
                        shape: BoxShape.circle,
                      ),
                      child: Center(
                        child: Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            color: deepBlueColor,
                            shape: BoxShape.circle,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      width: 2,
                      height: 60,
                      color: deepBlueColor,
                    ),
                    notReadyCircle(),
                  ],
                ),
                SizedBox(
                  width: ScreenUtil().setWidth(20),
                ),
                Expanded(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              from == null || from == ''
                                  ? AppUtils.translate(context, 'from')
                                  : from,
                            ),
                          ),
                          onTap: () async {
                            Place place = await showPlacePicker();

                            if (place != null) {
                              originPlace = place;
                              from = place.name;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[200],
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: GestureDetector(
                          child: Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(10),
                            child: Text(
                              to == null || to == ''
                                  ? AppUtils.translate(context, 'to')
                                  : to,
                            ),
                          ),
                          onTap: () async {
                            Place place = await showPlacePicker();
                            if (place != null) {
                              destinationPlace = place;
                              to = place.name;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  bool isReadyForRide() {
    if (from != null && from != '' && to != null && to != '') {
      return true;
    }
    return false;
  }

  Widget confirmTripBtn() {
    return AnimatedPositioned(
      duration: duration,
      bottom: driverStateBloc.state.value == 2 ? 30 : -70,
      left: 14,
      right: 14,
      child: Card(
        child: myButton(
          translate(context, 'confirm'),
          onTap: isReadyForRide()
              ? () async {
                  AppUtils.hideKeyboard(context);
                  driverStateBloc.setState(6);
                  setState(() {});
                  PolylinePoints polylinePoints = PolylinePoints();
                  PolylineResult result =
                      await polylinePoints.getRouteBetweenCoordinates(
                    MAP_KEY,
                    PointLatLng(originPlace?.lat ?? _userPosition.latitude,
                        originPlace?.lng ?? _userPosition.longitude),
                    PointLatLng(destinationPlace.lat, destinationPlace.lng),
                    travelMode: TravelMode.driving,
                  );

                  List<LatLng> points = [];
                  result.points.forEach((element) {
                    points.add(LatLng(element.latitude, element.longitude));
                  });

                  polyline = null;
                  polyline = Polyline(
                    polylineId: PolylineId(
                      AppUtils.getRandomId(),
                    ),
                    visible: true,
                    points: points,
                    color: deepBlueColor,
                    width: 4,
                    startCap: Cap.buttCap,
                  );

                  markers = Marker(
                    markerId: MarkerId(
                      '${DateTime.now()}',
                    ),
                    visible: true,
                    position: LatLng(originPlace?.lat ?? _userPosition.latitude,
                        originPlace?.lng ?? _userPosition.longitude),
                    infoWindow: InfoWindow(
                      title: translate(context, 'your_current_location'),
                    ),
                  );

                  setState(() {});

                  _controller.animateCamera(
                    CameraUpdate.newCameraPosition(
                      CameraPosition(
                        target: LatLng(
                            originPlace?.lat ?? _userPosition.latitude,
                            originPlace?.lng ?? _userPosition.longitude),
                        zoom: 14.4746,
                      ),
                    ),
                  );

                  setState(() {});
                }
              : null,
          btnColor: isReadyForRide() ? mainColor : Colors.grey[300],
          textStyle: TextStyle(
            color: isReadyForRide() ? Colors.white : Colors.grey,
            fontSize: 15,
          ),
        ),
      ),
    );
  }

  Widget cancelTripBtn() {
    return AnimatedPositioned(
      duration: duration,
      top: driverStateBloc.state.value == 3 ||
              driverStateBloc.state.value == 6 ||
              driverStateBloc.state.value == 5 ||
              driverStateBloc.state.value == 8 ||
              driverStateBloc.state.value == 7
          ? 100
          : -70,
      left: 8,
      child: GestureDetector(
        onTap: () {
          cancelRequest();
        },
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: 8),
          padding: EdgeInsets.symmetric(vertical: 4, horizontal: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.red,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cancel,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                translate(context, 'cancel_request'),
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget selectVehiclePart() {
    return Positioned(
      child: Container(
        decoration: BoxDecoration(
          color: deepBlueColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(8.0),
              child: Text(
                translate(context, 'select_a_type_of_vehicle'),
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: ScreenUtil().setHeight(15),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .2,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: List.generate(
                        vehicles.length,
                        (index) => GestureDetector(
                          onTap: () {
                            _selectedVehicle = vehicles[index];
                            selectedVehicle = index;
                            setState(() {});
                          },
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: 6),
                            width: ScreenUtil().setWidth(80),
                            height: ScreenUtil().setHeight(
                                Localizations.localeOf(context).languageCode ==
                                        'en'
                                    ? 85
                                    : 120),
                            decoration: BoxDecoration(
                              color: selectedVehicle == index
                                  ? mainColor
                                  : Colors.grey[300],
                              borderRadius: BorderRadius.circular(10),
                            ),
                            padding: EdgeInsets.all(10),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Text(
                                  vehicles[index].title,
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 13,
                                    color: selectedVehicle == index
                                        ? Colors.white
                                        : Colors.black,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                CachedNetworkImage(
                                  imageUrl: vehicles[index].image,
                                  height: 30,
                                  width: 30,
                                  placeholder: (_, __) {
                                    return Loader(
                                      size: 30,
                                    );
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ).toList(),
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                  Padding(
                    padding: EdgeInsets.all(15.0),
                    child: myButton(
                      translate(context, 'send_request'),
                      onTap: () {
                        // send request
                        sendRequestToServer();
                        driverStateBloc.setState(5);
                        setState(() {});
                        Future.delayed(Duration(milliseconds: 200), () {
                          selectedVehicle = -1;
                        });
                      },
                      btnColor:
                          selectedVehicle != -1 ? mainColor : Colors.grey,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(8),
                  ),
                ],
              ),
            ),
          ],
        ),
        width: double.infinity,
      ),
      bottom: 10,
      left: 14,
      right: 14,
    );
  }

  bool t = false;

  Widget waitingDialog(AsyncSnapshot<BaseRideResponse> snapshot) {
    if (driverStateBloc.state.value == 5) {
      if (!startTimer) {
        startTheTimer();
      }
    }

    if (taxiBloc.ride.value.data != null &&
        taxiBloc.ride.value.data.ride != null &&
        taxiBloc.ride.value.data.ride.rideReply.isNotEmpty &&
        !t) {
      stopTimer();
      t = true;
      driverStateBloc.setState(8);
      showResponse = true;
    }

    return AnimatedPositioned(
      duration: duration,
      bottom: driverStateBloc.state.value == 5 ? 10 : -500,
      left: 14,
      right: 14,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(10),
        child: Card(
          child: Column(
            children: [
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: deepBlueColor,
                  borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Center(
                    child: GestureDetector(
                      onTap: () {},
                      child: Text(
                        '${translate(context, 'you_will_receive_offers_within_a_period')} $time ${translate(context, 'sec')}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Container(
                        height: MediaQuery.of(context).size.height * .25,
                        width: double.infinity,
                        child: Icon(
                          FontAwesomeIcons.searchLocation,
                          size: 100,
                          color: mainColor,
                        ),
                      ),
                    ),
                    Text(
                      translate(context, 'please_wait_while_your_request_send'),
                      style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(
                      height: ScreenUtil().setHeight(20),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget responsesDialog() {
    return AnimatedPositioned(
      duration: duration,
      bottom: 10 ,
      left: 14,
      right: 14,
      child: taxiBloc.ride?.value?.data == null
          ? SizedBox.shrink()
          : Container(
              decoration: BoxDecoration(
                color: Colors.transparent,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: deepBlueColor,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(10.0),
                      child: Center(
                        child: Text(
                          translate(context, 'the_responses'),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ),
                  Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.height * .4,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Padding(
                      padding: EdgeInsets.all(8.0),
                      child: taxiBloc.ride?.value?.data == null ||
                              taxiBloc
                                  .ride?.value?.data?.ride?.rideReply.isEmpty
                          ? Center(
                              child: Text(AppUtils.translate(
                                context,
                                'no_responses',
                              )),
                            )
                          : ListView.builder(
                              physics: bouncingScrollPhysics,
                              itemBuilder: (context, index) {
                                return ResponseCartItem(
                                  currentRequest: taxiBloc
                                      .ride.value.data.ride.rideReply[index],
                                  onRejectBtntapped: () async {
                                    await taxiBloc.changeRideReply(
                                        ChangeRideStatusRequest(
                                            userId: AppUtils.userData.id,
                                            status: "rejected",
                                            id: taxiBloc.ride.value.data.ride
                                                .rideReply[index].id,
                                            user_comment: "no comments"));
                                    startTimer = false;
                                    setState(() {});
                                  },
                                  onAcceptOfferBtnClicked:
                                      (PolylineResult points) async {
                                    driverStateBloc.setState(9);
                                    startTimer = false;
                                    setState(() {});
                                    await taxiBloc.changeRideReply(
                                        ChangeRideStatusRequest(
                                            userId: AppUtils.userData.id,
                                            status: "accepted",
                                            id: taxiBloc.ride.value.data.ride
                                                .rideReply[index].id,
                                            user_comment: "no comments"));
                                  },
                                );
                              },
                              itemCount: taxiBloc
                                  .ride.value.data.ride.rideReply.length,
                            ),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget chatDialog() {
    return Positioned(
      bottom: 10,
      left: 14,
      right: 14,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: deepBlueColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(10),
                  topRight: Radius.circular(10),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      translate(context, 'ongoing'),
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    FlatButton(
                      onPressed: () {
                        driverStateBloc.setState(0);
                        setState(() {});
                      },
                      child: Text(
                        translate(context, 'hide'),
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
            ListTile(
              title: Text(
                'Ahmad Magdi',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Row(
                children: [
                  Text(
                    '4.7',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(
                    Icons.star,
                    color: goldColor,
                    size: 20,
                  ),
                ],
              ),
              trailing: Column(
                children: [
                  Text(
                    'Nissan',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                  Text(
                    'AEO 125',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/avatar.png'),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(12),
            ),
            Center(
              child: FloatingActionButton(
                heroTag: 'phone call btn',
                mini: true,
                onPressed: () {
                  launch("tel://+2001099020814");
                },
                child: Icon(
                  Icons.phone,
                  color: Colors.white,
                ),
                backgroundColor: Color(0xff38B194),
              ),
            ),
            SizedBox(
              height: ScreenUtil().setHeight(8),
            ),
          ],
        ),
      ),
    );
  }

  Widget requestTimeoutDialog() {
    return Positioned(
      bottom: 10,
      left: 14,
      right: 14,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: deepBlueColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Padding(
                padding: EdgeInsets.all(8.0),
                child: Center(
                  child: Text(
                    translate(context, 'request_time_out'),
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),
            ),
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: SvgPicture.asset(
                      'assets/images/error.svg',
                      height: MediaQuery.of(context).size.height * .17,
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    translate(context, 'your_request_has_been_end'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    translate(context, 'no_responses'),
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: ScreenUtil().setHeight(20),
                  ),
                  Padding(
                    padding: EdgeInsets.all(8.0),
                    child: myButton(
                      translate(context, 'try_again'),
                      textStyle: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 15,
                        color: Colors.white,
                      ),
                      onTap: () {
                        driverStateBloc.setState(5);
                        setState(() {});
                        sendRequestToServer();
                      },
                      btnColor: mainColor,
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

  Widget tripStartedDialog() {
    return Positioned(
      left: 0,
      right: 0,
      bottom: MediaQuery.of(context).size.height * .38,
      child: Container(
        height: ScreenUtil().setHeight(60),
        child: Card(
          margin: EdgeInsets.symmetric(horizontal: 30),
          child: Center(
            child: Text(AppUtils.translate(context, 'trip started')),
          ),
        ),
      ),
    );
  }

  void cancelRequest() {
    taxiBloc.changeRideStatus(ChangeRideStatusRequest(
      userId: AppUtils.userData.id,
      status: 'canceled',
      id: rideId,
    ));
    polyline = null;
    showResponse = true;
    goToUserLocation();
    driverStateBloc.setState(1);
    from = null;
    to = null;
    originPlace = null;
    destinationPlace = null;
    t = false;
    selectedVehicle = -1;
    stopTimer();
    if (mounted) setState(() {});
  }

  void stopTimer() {
    time = '121';
    if (timer != null) {
      if (timer.isActive) {
        timer.cancel();
      }
    }
  }

  void sendRequestToServer() async {
    var request = MakeRideRequest(
      userId: AppUtils.userData.id.toString(),
      carTypeId: _selectedVehicle.vehicleId.toString(),
      distance: AppUtils.calculateDistanceBetween2Points(
              originPlace?.lat ?? _userPosition.latitude,
              originPlace?.lng ?? _userPosition.longitude,
              destinationPlace.lat,
              destinationPlace.lng,
      )
          .toString(),
      endLat: destinationPlace.lat.toString(),
      endLong: destinationPlace.lng.toString(),
      startLat:
          originPlace?.lat.toString() ?? _userPosition.latitude.toString(),
      startLong:
          originPlace?.lng.toString() ?? _userPosition.longitude.toString(),
      endLocation: destinationPlace.name,
      startLocation: originPlace.name,
    );
    var response = await taxiBloc.makeRide(request);

    rideId = response.data.ride.id;

    await taxiBloc.initPusher();
    await taxiBloc.subscribeRideID(rideId);
    await taxiBloc.bind();
    if (mounted) setState(() {});
  }

  Widget rateDriverWidget() {
    return Container(
      height: 300,
      child: Card(
        margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      AppUtils.translate(context, 'rate_driver'),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                        icon: Icon(
                          Icons.cancel,
                          color: Colors.red,
                        ),
                        onPressed: () {
                          driverStateBloc.setState(1);
                          setState(() {});
                        }),
                  ],
                ),
              ),
              SizedBox(
                height: 10,
              ),
              ListTile(
                title: Text(
                  'Ahmad Magdi',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Row(
                  children: [
                    Text(
                      '4.7',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Icon(
                      Icons.star,
                      color: goldColor,
                      size: 20,
                    ),
                  ],
                ),
                trailing: Column(
                  children: [
                    Text(
                      'Nissan',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                    Text(
                      'AEO 125',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: Colors.grey,
                        fontSize: 13,
                      ),
                    ),
                  ],
                ),
                leading: CircleAvatar(
                  backgroundImage: AssetImage('assets/images/avatar.png'),
                ),
              ),
              SizedBox(
                height: 10,
              ),
              MyRatingBar(
                rate: 0,
                ignoreGestures: false,
                onRatingUpdate: (double newRate) {
                  userRate = newRate;
                  setState(() {});
                  return 0;
                },
                itemSize: 45,
              ),
              SizedBox(
                height: 10,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child:
                    myButton(AppUtils.translate(context, 'submit'), onTap: () {
                  taxiBloc.makeRate(MakeRateRequest(
                      'comment',
                      int.parse(taxiBloc.rides.value.data.rides.first.driverId
                          .toString()),
                      'driver',
                      userRate,
                      AppUtils.userData.id));
                  userRate = 0;
                  driverStateBloc.setState(1);
                  setState(() {});
                }),
              ),
            ],
          ),
        ),
      ),
      width: double.infinity,
    );
  }
}

class Vehicles {
  final String title;
  final String image;
  final int vehicleId;

  Vehicles({this.title, this.image, this.vehicleId});
}

class Place {
  String name;
  String id;
  double lat;
  double lng;

  Place({this.name, this.id, this.lat, this.lng});

  @override
  String toString() {
    return 'Place{name: $name, id: $id, lat: $lat, lng: $lng}';
  }
}
