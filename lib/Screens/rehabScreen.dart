import 'dart:async';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:location/location.dart';
//import 'package:place_picker_google/place_picker_google.dart';
//import 'package:sizer/sizer.dart';


class RehabMap extends StatefulWidget {
  const RehabMap({super.key});

  @override
  State<RehabMap> createState() => RehabMapState();
}

class RehabMapState extends State<RehabMap> {

  late LocationData locationData;
  Set<Marker> _markers = {};

  bool position = false;

  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();

  static CameraPosition _kpos = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(15.82323, 22.8183),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);

  Future currentLocation() async {
    bool serviceEnabled;
    PermissionStatus permissionGranted;

    Location location = Location();

    serviceEnabled = await location.serviceEnabled();
    if (!serviceEnabled) {
      serviceEnabled = await location.requestService();
      if (!serviceEnabled) {
        return;
      }
    }

    permissionGranted = await location.hasPermission();
    if (permissionGranted == PermissionStatus.denied) {
      permissionGranted = await location.requestPermission();
      if (permissionGranted != PermissionStatus.granted) {
        return;
      }
    }

    locationData = await location.getLocation();
    _kpos = CameraPosition(
      bearing: 192.8334901395799,
      target: LatLng(locationData.latitude!, locationData.longitude!),
      tilt: 59.440717697143555,
      zoom: 19.151926040649414);
      setState(() {
        
      });
    fetchNearbyPlaces(locationData.latitude!, locationData.longitude!);
  }

  @override
  void initState() {
    super.initState();
    currentLocation();
  }

  Future<void> fetchNearbyPlaces(double latitude, double longitude) async {
    final url = Uri.parse(
        'https://maps.googleapis.com/maps/api/place/textsearch/json?query=rehabilitation+centers&location=$latitude,$longitude&radius=10&key=)');
    final response = await http.get(url);
    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      var places = data['results'] as List;
      log("$places");
      for (var i = 0 ; i <= 5; i++) {
        var place = places[i];
        var lat = place['geometry']['location']['lat'];
        var lng = place['geometry']['location']['lng'];
        var name = place['name'];
        var address = place['formatted_address'];
        var marker = Marker(
          markerId: MarkerId('$i'),
          position: LatLng(lat, lng),
          infoWindow: InfoWindow(title: name, snippet: address),
        );
        setState(() {
          _markers.add(marker);
        });
      }
    } else {
      throw Exception('Failed to load places');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GoogleMap(
        mapType: MapType.hybrid,
        initialCameraPosition: _kpos,
        onMapCreated: (GoogleMapController controller) {
          _controller.complete(controller);
        },
        myLocationEnabled: true,
        markers: _markers,
      ),
      
    );
  }
}