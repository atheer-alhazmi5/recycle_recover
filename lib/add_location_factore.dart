import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'LocationService.dart';
import 'new_request_factor.dart';

class add_Location extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return add_Location_State();
  }
}

class add_Location_State extends State<add_Location> {
  Completer<GoogleMapController> _controller = Completer();

  static final CameraPosition _initialCameraposition =
      CameraPosition(target: LatLng(33.515343, 36.289590), zoom: 17.4746);
  LatLng CurrentPosition = _initialCameraposition.target;
  BitmapDescriptor? _locationIcon;
  late String Name = "",material;
  late double lat=0.0;
  late double lng=0.0;
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('factores')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          print("=============================$userid");
          Name = element.get('username');
          material=element.get('material');
          print("$Name");
        });
      });
    });
  }
void addMarker () async
{
  final userid = await FirebaseAuth.instance.currentUser!.uid;
  FirebaseFirestore.instance.collection("Location_Factor").add(
      {
        'id': userid,
        'lat':lat,
        'lng': lng,
        'name': Name,
        'material' : material
      }

  );
}
  var markers = HashSet<Marker>();

  void initState() {
    getData();
    _buildMarkerFromAssets();
    _getMyLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Location",
          style: TextStyle(
              color: Color(0xf0115228),
              fontWeight: FontWeight.bold,
              fontSize: 25),
        ),
        centerTitle: true,
        leading: Padding(
          padding: EdgeInsets.only(left: 1),
          child: IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
            Icons.keyboard_backspace,
            color: Colors.black,
          ),)
        ),
      ),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Container(
              width: width,
              height: height * 0.5,
              child: GoogleMap(
                initialCameraPosition: _initialCameraposition,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    _controller.complete(controller);
                  });
                },
                markers: markers,
                onCameraMove: (CameraPosition newpos) {
                  setState(() {
                    CurrentPosition = newpos.target;
                  });
                },
                // markers: ,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 100),
              child: Center(
                child: Container(
                  width: 35,
                  color: Colors.white,
                  child: ElevatedButton(
                    onPressed: () {
                      setState(() {
                        setMarker(CurrentPosition);
                      });
                    },
                    child: Image.asset(
                      'image/img.png',
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: height * 0.7, left: width * 0.1),
              child: Container(
                width: width * 0.8,
                height: height * 0.07,
                child: ElevatedButton(
                    child: Text(
                      "Next ",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold),
                    ),
                    style: ButtonStyle(
                        backgroundColor:
                            MaterialStateProperty.resolveWith((states) {
                          if (states.contains(MaterialState.pressed))
                            return Colors.black26;
                          else
                            return Color(0xf0115228);
                        }),
                        shape:
                            MaterialStateProperty.all<RoundedRectangleBorder>(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20)))),
                    onPressed: () {
                      addMarker();
                      Navigator.of(context)
                          .push(MaterialPageRoute(builder: (_) {
                        return new_Req();
                      }));
                    }),
              ),
            ),
          ],
        ),
      ),
    );
  }

  setMarker(LatLng _Location) {
    markers.add(Marker(
        markerId: MarkerId(CurrentPosition.toString()),
        position: CurrentPosition,
     infoWindow: InfoWindow(
         title: "$Name",
         snippet: "$material"),
        ),

    );
    lat = _Location.latitude;
    lng =_Location.longitude;


  }

  Future<void> _buildMarkerFromAssets() async {
    if (_locationIcon == null) {
      _locationIcon = await BitmapDescriptor.fromAssetImage(
          ImageConfiguration(size: Size(48, 48)), 'image/img.png');
      setState(() {});
    }
  }

  Future<void> _getMyLocation() async {
    LocationData _myLocation = await LocationService().getLocation();
    _animateCamera(LatLng(_myLocation.latitude!, _myLocation.longitude!));
  }

  Future<void> _animateCamera(LatLng _location) async {
    final GoogleMapController controller = await _controller.future;
    CameraPosition _cameraPosition = CameraPosition(
      target: _location,
      zoom: 17.00,
    );
    controller.animateCamera(CameraUpdate.newCameraPosition(_cameraPosition));
  }
}
