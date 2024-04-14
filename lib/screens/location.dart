// String googleApiKey = "AIzaSyBZ9PuqBbQYs43j0liSLyC25_A4rTE92T4";

import 'package:courts_ecommerce/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:math';
import 'package:provider/provider.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  GoogleMapController? mapController;
  PolylinePoints polylinePoints = PolylinePoints();

  String googleApiKey =
      "AIzaSyBZ9PuqBbQYs43j0liSLyC25_A4rTE92T4"; // Replace with your Google Maps API key

  List<Map<String, dynamic>> courtsLocations = [
    {
      'name': 'Courts Gong Badak',
      'address':
          'Lot No. R142, Giant Mall Plentong, No.3, Jalan Masai Lama, Mukim Plentong, 81750 Masai, Johor',
    },
    {
      'name': 'Courts Nojima LaLaport Bukit Bintang City Centre',
      'address':
          'L3-10A, Level 3, Mitsui Shopping Park LaLaport Bukit Bintang, 2, Jalan Hang Tuah, Kuala Lumpur City Centre, 55100 Kuala Lumpur, Federal Territory of Kuala Lumpur.',
    },
    {
      'name': 'Courts Banting',
      'address':
          'No. 179 & 181, Jalan Sultan Abdul Samad,42700 Banting, Selangor',
    },
    {
      'name': 'Courts Bukit Tinggi',
      'address':
          'No.49 & 51, Jalan Batu Nilam 5, Bandar Bukit Tinggi 41200 Klang, Selangor',
    },
    {
      'name': 'Courts Bukit Tinggi',
      'address':
          'No.49 & 51, Jalan Batu Nilam 5, Bandar Bukit Tinggi 41200 Klang, Selangor',
    },
    {
      'name': 'Courts IOI City Mall',
      'address':
          'L2-30 & L2-31, Level 2, IOI City Mall, Lebuh IRC, IOI Resort City, 62502 Putrajaya',
    },

    {
      'name': 'Courts Cheras Sentral Mall',
      'address':
          'F30, First Floor, Cheras Sentral Mall, Jalan 2/142A, Taman Len Seng, 56000 Kuala Lumpur',
    },
    {
      'name': 'Courts Setia Alam',
      'address':
          'No. 2-1-3, Jalan Setia Prima (S), U13/S, Setia Alam, 40170 Shah Alam, Selangor',
    },

    // Add more Courts locations with accurate addresses here
  ];

  Set<Marker> markers = Set();
  Map<PolylineId, Polyline> polylines = {};

  String startAddress = '';
  LatLng startLocation =
      LatLng(3.150204013019715, 101.6787826300758); // Default coordinates

  double distance = 0.0;

  @override
  void initState() {
    super.initState();
    getCourtsLocations();
    getStartLocationCoordinates(); // Fetch coordinates for startAddress
  }

  void getCourtsLocations() async {
    for (var location in courtsLocations) {
      LatLng? latLng = await getLocationCoordinates(location['address']);
      if (latLng != null) {
        markers.add(
          Marker(
            markerId: MarkerId(location['name']),
            position: latLng,
            infoWindow: InfoWindow(
              title: location['name'],
              snippet: 'Courts Store',
            ),
            icon:
                BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          ),
        );
      }
    }
    setState(() {});
  }

  Future<void> getStartLocationCoordinates() async {
    final user = Provider.of<UserProvider>(context, listen: false).user;
    if (user != null) {
      // Use the user's homeAddress as the startAddress
      startAddress = user.homeAddress ?? '';
      LatLng? latLng = await getLocationCoordinates(startAddress);
      if (latLng != null) {
        setState(() {
          startLocation = latLng;
        });
        getDirections(); // After obtaining startLocation, calculate nearest court
      }
    }
  }

  Future<LatLng?> getLocationCoordinates(String address) async {
    final encodedAddress = Uri.encodeComponent(address);
    final url =
        'https://maps.googleapis.com/maps/api/geocode/json?address=$encodedAddress&key=$googleApiKey';

    try {
      final response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final results = data['results'] as List<dynamic>;
        if (results.isNotEmpty) {
          final location = results[0]['geometry']['location'];
          return LatLng(location['lat'], location['lng']);
        }
      }
    } catch (e) {
      print('Error fetching coordinates: $e');
    }
    return null;
  }

  void getDirections() async {
    List<LatLng> nearestPolylineCoordinates = [];
    LatLng? nearestLocation;
    double minDistance = double.infinity;

    for (var location in courtsLocations) {
      LatLng? latLng = await getLocationCoordinates(location['address']);
      if (latLng != null) {
        double distance = calculateDistance(
          startLocation.latitude,
          startLocation.longitude,
          latLng.latitude,
          latLng.longitude,
        );

        if (distance < minDistance) {
          minDistance = distance;
          nearestLocation = latLng;
        }
      }
    }

    if (nearestLocation != null) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        googleApiKey,
        PointLatLng(startLocation.latitude, startLocation.longitude),
        PointLatLng(nearestLocation.latitude, nearestLocation.longitude),
        travelMode: TravelMode.transit,
      );

      if (result.points.isNotEmpty) {
        result.points.forEach((PointLatLng point) {
          nearestPolylineCoordinates
              .add(LatLng(point.latitude, point.longitude));
        });
      } else {
        print(result.errorMessage);
      }

      // Calculate total distance to the nearest location
      double totalDistance = calculateTotalDistance(nearestPolylineCoordinates);
      print('Total Distance to Nearest Location: $totalDistance km');

      setState(() {
        distance = totalDistance;
      });

      // Add polyline to the map
      addPolyLine(nearestPolylineCoordinates);
    }
  }

  void addPolyLine(List<LatLng> polylineCoordinates) {
    PolylineId id = PolylineId("poly");
    Polyline polyline = Polyline(
      polylineId: id,
      color: Colors.deepPurpleAccent,
      points: polylineCoordinates,
      width: 8,
    );
    polylines[id] = polyline;
    setState(() {});
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    var p = 0.017453292519943295;
    var a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  @override
  Widget build(BuildContext context) {
    final user = Provider.of<UserProvider>(context).user;
    final adr = user != null ? user.homeAddress : 'guest';

    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
        backgroundColor: Colors.amber,
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Stack(
        children: [
          GoogleMap(
            initialCameraPosition: CameraPosition(
              target: startLocation,
              zoom: 14.0,
            ),
            markers: {
              ...markers,
              Marker(
                markerId: MarkerId('startLocation'),
                position: startLocation,
                infoWindow: InfoWindow(
                  title: 'Start Location',
                  snippet: adr,
                ),
                icon: BitmapDescriptor.defaultMarkerWithHue(
                    BitmapDescriptor.hueGreen),
              ),
            },
            polylines: Set<Polyline>.of(polylines.values),
            mapType: MapType.normal,
            onMapCreated: (controller) {
              setState(() {
                mapController = controller;
              });
            },
          ),
          Positioned(
            bottom: 50,
            left: 50,
            child: Container(
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Total Distance: ${distance.toStringAsFixed(2)} KM",
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        "Shipping Fee: RM ${(distance * 0.4).toStringAsFixed(1)}",
                        style: TextStyle(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  double calculateTotalDistance(List<LatLng> polylineCoordinates) {
    double totalDistance = 0.0;
    for (int i = 0; i < polylineCoordinates.length - 1; i++) {
      totalDistance += calculateDistance(
        polylineCoordinates[i].latitude,
        polylineCoordinates[i].longitude,
        polylineCoordinates[i + 1].latitude,
        polylineCoordinates[i + 1].longitude,
      );
    }
    return totalDistance;
  }
}
