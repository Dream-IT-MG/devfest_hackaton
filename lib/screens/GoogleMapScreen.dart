// ignore_for_file: file_names

import 'package:devfest_hackaton/directions_repository.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../directions_model.dart';

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // State
  bool isLoading = true;

  // Map Controller
  late GoogleMapController mapController;
  Marker? _origin = null;
  Marker? _destination = null;
  Directions? _info = null;

  // Custom Marker
  BitmapDescriptor marketIcon = BitmapDescriptor.defaultMarker;

  //
  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(-18.8741133030216, 47.49958330784587),
    zoom: 14,
  );

  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    final hasPermission = await _handleLocationPermission();
    if (!hasPermission) return;
    try {
      await Geolocator.getCurrentPosition(
              desiredAccuracy: LocationAccuracy.high)
          .then((Position position) {
        setState(() => _currentPosition = position);
      }).catchError((e) {
        debugPrint(e);
      });
    } catch (er) {
      debugPrint(er.toString());
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.fromAssetImage(
            ImageConfiguration.empty, "assets/market_icon.png")
        .then(
      (icon) {
        marketIcon = icon;
      },
    );
  }

  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Le service de localisation est désactiver. Activer le service.')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'La localisation a été désactiver. Nous ne pouvos pas afficher votre position actuelle.'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Le service de location est désactiver en permance. Nous ne pouvons pas afficher votre position actuelle.'),
        ),
      );
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => mapController.animateCamera(
          _info != null
              ? CameraUpdate.newLatLngBounds(_info!.bounds, 100.0)
              : CameraUpdate.newCameraPosition(_initialPosition),
        ),
        child: const Icon(Icons.center_focus_strong),
      ),
      appBar: AppBar(
        centerTitle: false,
        title: const Text('Google map'),
        actions: [
          if (_origin != null)
            TextButton(
              child: Text("ORIGIN"),
              style: TextButton.styleFrom(
                  primary: Colors.green,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              onPressed: () => mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _origin!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
            ),
          if (_destination != null)
            TextButton(
              child: Text('DEST'),
              style: TextButton.styleFrom(
                  primary: Colors.blue,
                  textStyle: const TextStyle(fontWeight: FontWeight.w600)),
              onPressed: () => mapController.animateCamera(
                CameraUpdate.newCameraPosition(
                  CameraPosition(
                    target: _destination!.position,
                    zoom: 14.5,
                    tilt: 50.0,
                  ),
                ),
              ),
            )
        ],
      ),
      body: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          GoogleMap(
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            mapType: MapType.normal,
            initialCameraPosition: _initialPosition,
            padding: const EdgeInsets.only(
              top: 50,
              // bottom: MediaQuery.of(context).size.height / 2.5,
              right: 20,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _getCurrentPosition().then((value) {
                mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(
                      LatLng(
                          _currentPosition?.latitude ??
                              _initialPosition.target.latitude,
                          _currentPosition?.longitude ??
                              _initialPosition.target.longitude),
                      14.5),
                );
              });
            },
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },
            polylines: {
              if (_info != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _info!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                )
            },
            onLongPress: _addMarker,
          ),
          if (_info != null)
            Positioned(
              child: Container(
                padding: const EdgeInsets.symmetric(
                  vertical: 6.0,
                  horizontal: 12.0,
                ),
                decoration: BoxDecoration(
                    color: Colors.yellowAccent,
                    borderRadius: BorderRadius.circular(20.0),
                    boxShadow: const [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0, 2),
                        blurRadius: 6.0,
                      )
                    ]),
                child: Text(
                  '${_info!.totalDistance}, ${_info!.totalDuration}',
                  style: const TextStyle(
                    fontSize: 18.0,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          Container(
            alignment: Alignment.bottomLeft,
            width: double.maxFinite,
            height: MediaQuery.of(context).size.height,
            child: Column(mainAxisAlignment: MainAxisAlignment.end, children: [
              // const AppSearchBar(),
              const Expanded(child: SizedBox()),
              SizedBox(
                width: double.maxFinite,
                height: MediaQuery.of(context).size.height / 2.5,
              ),
            ]),
          ),
        ],
      ),
    );
  }

  void _addMarker(LatLng pos) async {
    if (_origin == null || (_origin != null && _destination != null)) {
      setState(() {
        _origin = Marker(
          markerId: const MarkerId("origin"),
          infoWindow: const InfoWindow(title: 'Origin'),
          icon:
              BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
          position: pos,
        );
        _destination = null;

        // Reset info
        _info = null;
      });
    } else {
      setState(() {
        _destination = Marker(
          markerId: const MarkerId('destination'),
          infoWindow: const InfoWindow(title: 'Destination'),
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          position: pos,
        );
      });

      // get directions

      final directions = await DirectionRepository()
          .getDirections(origin: _origin!.position, destination: pos);
      // return null;
      print("_______________________________");
      print(directions);
      print("__________________etoooooooooooooooooooo______________");
      setState(() {
        _info = directions;
      });
    }
  }
}
