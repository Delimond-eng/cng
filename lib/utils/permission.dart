import 'package:location/location.dart';
import 'package:permission_handler/permission_handler.dart';
export 'package:permission_handler/permission_handler.dart';

Future<void> handlePermission(Permission permission) async {
  final status = await permission.request();
  print(status);
}

Future<LocationData> getUserLocate() async {
  var location = Location();
  var _locationData = await location.getLocation();
  if (_locationData != null) {
    return _locationData;
  } else {
    return null;
  }
}
