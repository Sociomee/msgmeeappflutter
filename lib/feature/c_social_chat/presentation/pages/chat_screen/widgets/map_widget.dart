import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapViewWidget extends StatefulWidget {
  const MapViewWidget({super.key});

  @override
  State<MapViewWidget> createState() => _MapViewWidgetState();
}

class _MapViewWidgetState extends State<MapViewWidget> {
  LatLng currentlocation = const LatLng(22.572645, 88.363892);
  LatLng initialLocation = const LatLng(37.422131, -122.084801);
  Set<Marker> markers = {
    Marker(
      markerId: MarkerId("myCustomMarker"),
      position: LatLng(37.422131, -122.084801),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
    ),
  };
  @override
  Widget build(BuildContext context) {
    return InkWell(
      child: GoogleMap(
        markers: markers,
        zoomGesturesEnabled: false,
        zoomControlsEnabled: false,
        myLocationButtonEnabled: true,
        initialCameraPosition:
            CameraPosition(target: initialLocation, zoom: 14),
      ),
    );
  }
}
