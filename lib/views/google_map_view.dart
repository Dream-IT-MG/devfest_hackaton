// ignore_for_file: file_names

import 'package:devfest_hackaton/models/itineraire.dart';
import 'package:devfest_hackaton/repository/directions_repository.dart';
import 'package:devfest_hackaton/utils/colors.dart';
import 'package:devfest_hackaton/utils/fontsize.dart';
import 'package:devfest_hackaton/utils/show_app_modal_bottom_sheet.dart';
import 'package:devfest_hackaton/viewmodels/google_map_viewmodels.dart';
import 'package:devfest_hackaton/widgets/bus_card.dart';
import 'package:devfest_hackaton/widgets/text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:devfest_hackaton/models/directions_model.dart';
import 'package:iconsax/iconsax.dart';
import 'package:provider/provider.dart';

import '../models/directions_model.dart';

double INITIAL_LATITUDE = -18.8741133030216;
double INITIAL_LONGITUDE = 47.49958330784587;
double INITIAL_ZOOM = 12;
double FOCUS_ZOOM = 14.5;
double VITESSE_DE_DEPLACEMENT_ZOOM = 50.0;
double CONTENU_HEIGHT_DIVIDER = 2.5;

class GoogleMapView extends StatefulWidget {
  const GoogleMapView({super.key});

  @override
  State<GoogleMapView> createState() => _GoogleMapViewState();
}

class _GoogleMapViewState extends State<GoogleMapView> {
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

  // verifie la permission à la localisation
  Future<bool> _handleLocationPermission() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text(
              'Le service de localisation est désactivé. Activez le service.')));
      return false;
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
                'La localisation a été désactivé. Nous ne pouvos pas afficher votre position actuelle.'),
          ),
        );
        return false;
      }
    }
    if (permission == LocationPermission.deniedForever) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
              'Le service de location est désactivé en permance. Nous ne pouvons pas afficher votre position actuelle.'),
        ),
      );
      return false;
    }
    return true;
  }

  List itineraireIcon = [
    [Iconsax.flash, "Le plus rapide"],
    [Iconsax.clock, "Moyen"],
    [CupertinoIcons.slowmo, "La plus lente"],
  ];

  @override
  Widget build(BuildContext context) {
    GoogleMapViewModels googleMapViewModels = Provider.of(context);
    Itineraire itineraire =
        googleMapViewModels.itineraires[googleMapViewModels.selectedItineraire];
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButton: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FloatingActionButton(
            onPressed: () {
              showAppModalBottomSheet(
                  context: context,
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  color: AppColors.white,
                                  borderRadius: BorderRadius.circular(10)),
                              padding: const EdgeInsets.all(10),
                              child: const Icon(
                                Iconsax.clock,
                                color: AppColors.secondary,
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            AppText(
                              "Durée totale du trajet : ${itineraire.heureTotalDuTrajet}",
                              isBold: true,
                              color: AppColors.secondary,
                              fontSize: AppFontSize.large,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        ...itineraire.listDesPointAParcourir.map(
                          (point) => BusCard(
                            name: "Arrêt à ${point.station.name}",
                            heureArrivee:
                                "Heure d'arrivée sur les lieux vers ${point.heureArriverSurLieu}",
                            prochaineArrivee:
                                "Prochaine passage de bus prévu vers ${point.station.heureArrive}",
                            id: point.bus.id,
                            i: int.parse(point.bus.id),
                            onSelect: (int id) {
                              setState(() {
                                selectedBusId = id;
                              });
                            },
                            isSelected:
                                selectedBusId == int.parse(point.bus.id),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ));
            },
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.white,
            child: const Icon(Iconsax.note),
          ),
          const SizedBox(
            width: 10,
          ),
          FloatingActionButton(
            onPressed: () {
              showAppModalBottomSheet(
                  context: context,
                  child: Consumer<GoogleMapViewModels>(
                    builder: (context, model, child) => SingleChildScrollView(
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 30),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Container(
                                  decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(10)),
                                  padding: const EdgeInsets.all(10),
                                  child: Icon(
                                    itineraireIcon[googleMapViewModels
                                        .selectedItineraire][0],
                                    color: AppColors.secondary,
                                  ),
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                AppText(
                                  "Choix du trajet : ${itineraireIcon[googleMapViewModels.selectedItineraire][1]}",
                                  isBold: true,
                                  color: AppColors.secondary,
                                  fontSize: AppFontSize.large,
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ...List.generate(
                                  itineraireIcon.length,
                                  (index) => GestureDetector(
                                    onTap: () {
                                      googleMapViewModels
                                          .updateSelecteItineraire(index);
                                    },
                                    child: Container(
                                      width: 90,
                                      height: 90,
                                      decoration: BoxDecoration(
                                        color: googleMapViewModels
                                                    .selectedItineraire ==
                                                index
                                            ? Colors.white
                                            : AppColors.primary,
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Icon(itineraireIcon[index][0],
                                              color: googleMapViewModels
                                                          .selectedItineraire ==
                                                      index
                                                  ? AppColors.primary
                                                  : Colors.white),
                                          AppText(itineraireIcon[index][1],
                                              color: googleMapViewModels
                                                          .selectedItineraire ==
                                                      index
                                                  ? AppColors.primary
                                                  : Colors.white)
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ));
            },
            backgroundColor: AppColors.secondary,
            foregroundColor: AppColors.white,
            child: const Icon(Iconsax.location),
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerTop,
      appBar: AppBar(
        elevation: 0,
        bottomOpacity: 0,
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: false,
        actions: [
          if (_origin != null)
            // boutton pour zommer à la position actuelle
            ButtonFocus(
              mapController: mapController,
              origin: _origin,
              text: "ORIGIN",
              colors: Colors.blue,
            ),
          if (_destination != null)
            // boutton pour zommer vers la destination
            ButtonFocus(
              mapController: mapController,
              origin: _origin,
              text: "DEST",
              colors: Colors.blue,
            ),
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
            // ne montrer les markers que si il n'y a pas encore de position d'origine ou de destination
            markers: {
              if (_origin != null) _origin!,
              if (_destination != null) _destination!
            },

            // lignes entre l'origine et la destination
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

          // on affiche la disstance entre les deux points
          if (_infoDirection != null)
            PointsDistance(infoDirection: _infoDirection),
        ],
      ),
    );
  }

// faire apparaitre des markers sur l'écran
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

class PointsDistance extends StatelessWidget {
  const PointsDistance({
    super.key,
    required Directions? infoDirection,
  }) : _infoDirection = infoDirection;

  final Directions? _infoDirection;

  @override
  Widget build(BuildContext context) {
    return Positioned(
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
    );
  }
}

// bouton pour zoomer sur la carte
class ButtonFocus extends StatelessWidget {
  const ButtonFocus({
    super.key,
    required this.mapController,
    required Marker? origin,
    required this.text,
    this.colors = Colors.green,
  }) : _origin = origin;

  final GoogleMapController mapController;
  final Marker? _origin;
  final Color colors;
  final String text;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      child: Text(text),
      style: TextButton.styleFrom(
          primary: colors,
          textStyle: const TextStyle(fontWeight: FontWeight.w600)),
      onPressed: () => mapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            target: _origin!.position,
            zoom: FOCUS_ZOOM,
            tilt: VITESSE_DE_DEPLACEMENT_ZOOM,
          ),
        ),
      ),
    );
  }
}
