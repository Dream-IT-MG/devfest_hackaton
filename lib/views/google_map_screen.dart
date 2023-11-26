import 'package:devfest_hackaton/repository/directions_repository.dart';
import 'package:devfest_hackaton/widgets/StoreCard.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:devfest_hackaton/models/directions_model.dart';

double INITIAL_LATITUDE = -18.8741133030216;
double INITIAL_LONGITUDE = 47.49958330784587;
double INITIAL_ZOOM = 12;

class GoogleMapScreen extends StatefulWidget {
  const GoogleMapScreen({super.key});

  @override
  State<GoogleMapScreen> createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  // State
  bool isLoading = true;
  int selectedBusId = 0;

  // Map Controller
  late GoogleMapController mapController;

  // Marker pour le point de départ
  Marker? _origin;

  // Marker pour le point d'arrivée
  Marker? _destination;

  // informations sur la direction a prendre
  Directions? _infoDirection;
  List busList = [
    {
      "i": 0,
      "id": "139",
      "arret": "Analakely",
      "heureArrivee": "13h40",
      "prochaineArrivee": "14h",
    },
    {
      "i": 1,
      "id": "127",
      "arret": "Mahamasina",
      "heureArrivee": "13h36",
      "prochaineArrivee": "13h55",
    },
    {
      "i": 2,
      "id": "015",
      "arret": "Ambohijatovo",
      "heureArrivee": "13h55",
      "prochaineArrivee": "13h59",
    }
  ];

  // Custom Marker
  BitmapDescriptor marketIcon = BitmapDescriptor.defaultMarker;

  // init the camera position
  static CameraPosition INITIAL_POSITION = CameraPosition(
    target: LatLng(INITIAL_LATITUDE, INITIAL_LONGITUDE),
    zoom: INITIAL_ZOOM,
  );

  Position? _currentPosition;

  Future<void> _getCurrentPosition() async {
    // demande autorisation d'acceder a la localisation de l'utilisateur
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
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0x44000000),
        centerTitle: false,
        title: const Text(''),
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
            initialCameraPosition: INITIAL_POSITION,
            padding: EdgeInsets.only(
              top: 50,
              bottom: MediaQuery.of(context).size.height / 2.5,
              right: 20,
            ),
            onMapCreated: (GoogleMapController controller) {
              mapController = controller;
              _getCurrentPosition().then((value) {
                mapController.animateCamera(
                  CameraUpdate.newLatLngZoom(
                      LatLng(
                          _currentPosition?.latitude ??
                              INITIAL_POSITION.target.latitude,
                          _currentPosition?.longitude ??
                              INITIAL_POSITION.target.longitude),
                      14.5),
                );
              });
            },
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },
            polylines: {
              if (_infoDirection != null)
                Polyline(
                  polylineId: const PolylineId('overview_polyline'),
                  color: Colors.red,
                  width: 5,
                  points: _infoDirection!.polylinePoints
                      .map((e) => LatLng(e.latitude, e.longitude))
                      .toList(),
                )
            },
            onLongPress: _addMarker,
          ),
          if (_infoDirection != null)
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
                  '${_infoDirection!.totalDistance}, ${_infoDirection!.totalDuration}',
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
                child: ListView(
                  children: [
                    ...busList.map(
                      (bus) => StoreCard(
                        name: "arrêt : ${bus['arret']}",
                        heureOuverture:
                            "heure d'arrivée : ${bus['heureArrivee']}",
                        dateOuverture:
                            "prochaine arrivée : ${bus['prochaineArrivee']}",
                        contact: "",
                        image: bus['id'],
                        longlat: "",
                        id: 1,
                        onSelect: (int id) {
                          setState(() {
                            selectedBusId = id;
                          });
                        },
                        isSelected: selectedBusId == bus['i'],
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                  ],
                ),
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
        _infoDirection = null;
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

      final directions = await DirectionRepository()
          .getDirections(origin: _origin!.position, destination: pos);
      setState(() {
        _infoDirection = directions;
      });
    }
  }
}
