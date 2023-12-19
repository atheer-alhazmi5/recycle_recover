import 'dart:async';
import 'dart:collection';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'LocationService.dart';
import 'Select_Factories.dart';

class location extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return location_State();
  }
}

class location_State extends State<location> {
  late String address ="";
  late double wood =1.0;
  late double plastic=1.0;
  late double clothes =1.0;
  late double glass=1.0;
  late String w="";
  late String p="";
  late String g="";
  late String c="";
  Completer<GoogleMapController> _controller = Completer();
  static final CameraPosition _initialCameraposition =
  CameraPosition(target: LatLng(33.515343, 36.289590), zoom: 17.4746);
  LatLng CurrentPosition = _initialCameraposition.target;
  List namefactor=[],material=[];
  late GoogleMapController mapController;
  var markers = HashSet<Marker>();
  List lat=[],lng = [];
  BitmapDescriptor? _locationIcon;
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
  void getMarker() async {
    await FirebaseFirestore.instance
        .collection('Location_Factor')
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          lat.add(element.get('lat'));
          lng.add(element.get('lng'));
          namefactor.add(element.get('name'));
          material.add(element.get('material'));
          print("${lat}");
        });
      });
    });

  }
  void getData() async {
    final userid = await FirebaseAuth.instance.currentUser!.uid;
    await FirebaseFirestore.instance
        .collection('user')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          address = element.data()['address'];
        });
      });
    });
    await FirebaseFirestore.instance
        .collection('material')
        .where('id', isEqualTo: userid)
        .get()
        .then((value) {
      value.docs.forEach((element) {
        setState(() {
          wood =element.get('wood');
          plastic =element.get('plastic');
          glass =element.get('glass');
          clothes =element.get('clothes');
          print("$wood $clothes $plastic $glass");
          if(wood!=1.0)
            w="Wood";
         if(plastic!=1.0)
            p="Plastic";
         if(clothes!=1.0)
            c="Clothes";
       if(glass!=1.0)
            g="Glass";
        });
      });
    });
  }
  void initState() {
    _getMyLocation();
    getData();
    getMarker();
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
            child:  IconButton(onPressed: () { Navigator.of(context).pop(); },icon :Icon(
              Icons.keyboard_backspace,
              color: Colors.black,
            ),)
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
              width: width,
              height: height * 0.4,
              child:  GoogleMap(
                initialCameraPosition: _initialCameraposition,
                mapType: MapType.normal,
                onMapCreated: (GoogleMapController controller) {
                  setState(() {
                    _controller.complete(controller);
                  });
                },
               markers: Set<Marker>.of(
                 <Marker>[
                   for(int i=0;i<namefactor.length;i++)
                   Marker(
                     draggable: true,
                     markerId: MarkerId(i.toString()),
                     position: LatLng((lat[i]), (lng[i])),
                     icon: BitmapDescriptor.defaultMarker,
                     infoWindow: InfoWindow(
                       title: "${namefactor[i]}",
                         snippet: "${material[i]}"
                     ),
                   )
                 ],
               ),
                onCameraMove: (CameraPosition newpos) {
                  setState(() {
                    CurrentPosition = newpos.target;
                  });
                },
                // markers: ,
              ),),
          Padding(
              padding: EdgeInsets.only(top: height * 0.05),
              child: Text(
                " $address \n $w | $g | $c | $p",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
              )),
          Padding(
            padding: EdgeInsets.only(top: height * 0.2, left: width * 0.1),
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
                      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                          RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)))),
                  onPressed: () {
                    Navigator.of(context).push(MaterialPageRoute(builder: (_) {
                      return Select_Factories();
                    }));
                  }),
            ),
          )
        ],
      ),
    );
  }
}
