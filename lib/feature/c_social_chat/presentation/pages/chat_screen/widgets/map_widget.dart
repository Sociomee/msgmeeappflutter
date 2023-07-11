import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatefulWidget {
  const MapViewWidget({super.key});

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  // final Map<String, Marker> _markers = {};
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GoogleMap(
        zoomGesturesEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        initialCameraPosition:
            CameraPosition(target: initialLocation, zoom: 14),
      ),
    );
  }
}
