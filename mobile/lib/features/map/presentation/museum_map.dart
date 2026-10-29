import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

/// Published location of the Adwa 00KM Museum in Arada, Addis Ababa.
/// Source: the museum's Wikipedia coordinates, 9°02′00″N 38°45′12″E.
const adwaMuseumLocation = LatLng(9.0332, 38.7533);

class MuseumMap extends StatelessWidget {
  const MuseumMap({required this.title, super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: const CameraPosition(
        target: adwaMuseumLocation,
        zoom: 16,
      ),
      markers: {
        Marker(
          markerId: const MarkerId('adwa-museum'),
          position: adwaMuseumLocation,
          infoWindow: InfoWindow(title: title),
        ),
      },
      myLocationButtonEnabled: false,
      zoomControlsEnabled: false,
      mapToolbarEnabled: false,
      compassEnabled: false,
    );
  }
}
