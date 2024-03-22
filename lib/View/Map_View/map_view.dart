import 'dart:async';

import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../Controllers/address_controller.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({
    super.key,
  });
  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  final Completer<GoogleMapController> _controller =
      Completer<GoogleMapController>();
  final addressController = Get.find<AddressController>();
  var lat = null;
  var long = null;
  List<LatLng> polylineCoordinates = [];
  List<Marker> marker = [];
  late Timer _timer;

  BitmapDescriptor myHomeIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor employeeIcon = BitmapDescriptor.defaultMarker;

  Future<Position> _getCurrentLocation() async {
    bool serviceEnabled = false;
    LocationPermission permission;
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          return Future.error('Location permissions are denied');
        }
      }

      if (permission == LocationPermission.deniedForever) {
        return Future.error(
            'Location permissions are permanently denied, we cannot request permissions.');
      }
    }

    return await Geolocator.getCurrentPosition();
  }

  @override
  void initState() {
    _getCurrentLocation().then((value) {
      setState(() {
        lat = value.latitude;
        long = value.longitude;
      });
      _timer = Timer.periodic(const Duration(seconds: 5), (timer) {});
      marker.add(
        Marker(
          markerId: const MarkerId('current-location'),
          position: LatLng(lat, long),
          infoWindow: const InfoWindow(title: 'Selected Location'),
        ),
      );
      // print('Lat${value.latitude} Long ${value.longitude}');
      // _liveLocation();
    });
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  void _focusOnLocation(LatLng position) async {
    final GoogleMapController controller = await _controller.future;
    controller.animateCamera(CameraUpdate.newLatLng(position));
    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);

    var first = placemarks.first;
    addressController.stateController.text = '${first.administrativeArea}';
    addressController.cityController.text = '${first.locality}';
    addressController.pinCodeController.text = '${first.postalCode}';
    addressController.addressController.text =
        "${first.name}, ${first.subThoroughfare}, ${first.thoroughfare}, ${first.subLocality}, ${first.locality}, ${first.administrativeArea} ${first.postalCode}, ${first.country}";
    addressController.coordinatesController.text =
        '${double.parse('${position.latitude}').toStringAsFixed(3)}, ${double.parse('${position.longitude}').toStringAsFixed(3)}';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: lat == null
            ? SizedBox(
                height: Get.height,
                child: const Center(
                  child: CircularProgressIndicator(
                    color: Colors.orange,
                  ),
                ),
              )
            : GoogleMap(
                mapType: MapType.normal,
                polylines: {
                  Polyline(
                      polylineId: const PolylineId('source'),
                      points: polylineCoordinates,
                      color: Colors.blue,
                      width: 6)
                },
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat, long),
                  zoom: 14.4746,
                ),
                markers: {
                  Marker(
                      markerId: const MarkerId('Home'),
                      position: LatLng(lat, long),
                      infoWindow: const InfoWindow(title: 'Current Location')),
                },
                onTap: (LatLng position) {
                  // _addMarker(position);
                  lat = position.latitude;
                  long = position.longitude;
                  _focusOnLocation(position);

                  setState(() {});
                },
                onMapCreated: (controller) {
                  _controller.complete(controller);
                },
              ),
      ),
    );
  }
}
