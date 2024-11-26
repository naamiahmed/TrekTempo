// map.dart
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;

class MapSample extends StatefulWidget {
  final String userId;
  final String partnerId;

  const MapSample({
    super.key,
    required this.userId,
    required this.partnerId,
  });

  @override
  State<MapSample> createState() => MapSampleState();
}

class MapSampleState extends State<MapSample> {
  final Completer<GoogleMapController> _controller = Completer<GoogleMapController>();
  LatLng? _currentPosition;
  LatLng? _partnerPosition;
  late IO.Socket socket;
  bool _isLoading = true;
  String? _error;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polylines = {};
  StreamSubscription<Position>? _positionStreamSubscription;

  @override
  void initState() {
    super.initState();
    _initializeSocket();
    _getCurrentLocation();
  }

  void _initializeSocket() {
    try {
      socket = IO.io('http://192.168.1.5:5000', <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': true,
        'reconnection': true,
        'reconnectionDelay': 1000,
        'reconnectionAttempts': 5,
        'extraHeaders': {'Access-Control-Allow-Origin': '*'}
      });

      socket.onConnect((_) {
        debugPrint('Socket connected');
        socket.emit('joinRoom', {
          'userId': widget.userId,
          'partnerId': widget.partnerId,
        });
      });

      socket.onConnectError((data) {
        debugPrint('Connect error: $data');
        setState(() => _error = 'Connection error');
      });

      socket.on('locationUpdate', (data) {
        if (data['userId'] == widget.partnerId) {
          setState(() {
            _partnerPosition = LatLng(data['latitude'], data['longitude']);
            _updateMapElements();
          });
        }
      });

      socket.onDisconnect((_) => debugPrint('Socket disconnected'));
    } catch (e) {
      debugPrint('Socket initialization error: $e');
      setState(() => _error = 'Failed to initialize connection');
    }
  }

  void _updateMapElements() {
    if (!mounted) return;
    
    setState(() {
      _markers.clear();
      _polylines.clear();

      // Add current user marker
      if (_currentPosition != null) {
        _markers.add(Marker(
          markerId: MarkerId(widget.userId),
          position: _currentPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
          infoWindow: const InfoWindow(title: 'You'),
        ));
      }

      // Add partner marker
      if (_partnerPosition != null) {
        _markers.add(Marker(
          markerId: MarkerId(widget.partnerId),
          position: _partnerPosition!,
          icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRed),
          infoWindow: const InfoWindow(title: 'Partner'),
        ));
      }

      // Add polyline between users
      if (_currentPosition != null && _partnerPosition != null) {
        _polylines.add(Polyline(
          polylineId: const PolylineId('user_path'),
          points: [_currentPosition!, _partnerPosition!],
          color: Colors.blue,
          width: 3,
        ));
      }
    });

    _updateCameraPosition();
  }

  Future<void> _updateCameraPosition() async {
    if (!mounted) return;
    
    final GoogleMapController controller = await _controller.future;
    if (_currentPosition != null && _partnerPosition != null) {
      final LatLngBounds bounds = LatLngBounds(
        southwest: LatLng(
          _currentPosition!.latitude < _partnerPosition!.latitude
              ? _currentPosition!.latitude
              : _partnerPosition!.latitude,
          _currentPosition!.longitude < _partnerPosition!.longitude
              ? _currentPosition!.longitude
              : _partnerPosition!.longitude,
        ),
        northeast: LatLng(
          _currentPosition!.latitude > _partnerPosition!.latitude
              ? _currentPosition!.latitude
              : _partnerPosition!.latitude,
          _currentPosition!.longitude > _partnerPosition!.longitude
              ? _currentPosition!.longitude
              : _partnerPosition!.longitude,
        ),
      );
      controller.animateCamera(CameraUpdate.newLatLngBounds(bounds, 50.0));
    }
  }

  Future<void> _getCurrentLocation() async {
    try {
      bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
      if (!serviceEnabled) {
        setState(() => _error = 'Location services are disabled');
        return;
      }

      LocationPermission permission = await Geolocator.checkPermission();
      if (permission == LocationPermission.denied) {
        permission = await Geolocator.requestPermission();
        if (permission == LocationPermission.denied) {
          setState(() => _error = 'Location permissions are denied');
          return;
        }
      }

      if (permission == LocationPermission.deniedForever) {
        setState(() => _error = 'Location permissions are permanently denied');
        return;
      }

      final Position position = await Geolocator.getCurrentPosition();
      setState(() {
        _currentPosition = LatLng(position.latitude, position.longitude);
        _isLoading = false;
        _updateMapElements();
      });

      // Start location stream
      _positionStreamSubscription = Geolocator.getPositionStream(
        locationSettings: const LocationSettings(
          accuracy: LocationAccuracy.high,
          distanceFilter: 10,
        ),
      ).listen((Position position) {
        setState(() {
          _currentPosition = LatLng(position.latitude, position.longitude);
          _updateMapElements();
        });

        socket.emit('locationUpdate', {
          'userId': widget.userId,
          'partnerId': widget.partnerId,
          'latitude': position.latitude,
          'longitude': position.longitude,
        });
      });
    } catch (e) {
      setState(() {
        _error = 'Error getting location: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_error != null) {
      return Scaffold(
        appBar: AppBar(title: const Text('Live Location')),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.error_outline, size: 48, color: Colors.red),
              const SizedBox(height: 16),
              Text(_error!, style: const TextStyle(color: Colors.red)),
              const SizedBox(height: 16),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _error = null;
                    _isLoading = true;
                  });
                  _getCurrentLocation();
                },
                child: const Text('Retry'),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Live Location'),
        actions: [
          IconButton(
            icon: const Icon(Icons.my_location),
            onPressed: _updateCameraPosition,
          ),
        ],
      ),
      body: _isLoading 
        ? const Center(child: CircularProgressIndicator())
        : GoogleMap(
            mapType: MapType.normal,
            initialCameraPosition: CameraPosition(
              target: _currentPosition ?? const LatLng(7.8731, 80.7718),
              zoom: 15,
            ),
            markers: _markers,
            polylines: _polylines,
            myLocationEnabled: true,
            myLocationButtonEnabled: true,
            onMapCreated: (GoogleMapController controller) {
              _controller.complete(controller);
            },
          ),
    );
  }

  @override
  void dispose() {
    _positionStreamSubscription?.cancel();
    socket.disconnect();
    super.dispose();
  }
}