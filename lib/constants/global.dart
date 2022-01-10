import 'package:get_storage/get_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

var storage = GetStorage();

String truncateStringWithPoint(String text, int length) {
  return (text.length >= length) ? "${text.substring(0, length)}..." : text;
}

String truncateString(String text, int length) {
  return (text.length >= length) ? text.substring(0, length) : text;
}

List<String> strSpliter(String date) {
  var strList = date.split(RegExp(r"[,| ]"));
  return strList;
}

Future<PickedFile> takePhoto({ImageSource src}) async {
  final ImagePicker _picker = ImagePicker();
  // ignore: deprecated_member_use
  final pickedFile = await _picker.getImage(
    source: src,
    maxHeight: 400,
    maxWidth: 400,
    imageQuality: 70,
  );

  if (pickedFile != null) {
    return pickedFile;
  } else {
    return null;
  }
}

String dateFromString(DateTime date) {
  final DateFormat formatter = DateFormat('dd/MM/yyyy');
  String formatted = formatter.format(date);
  return formatted;
}

DateTime strTodate(String date) {
  final DateFormat formatter = (date.contains("-"))
      ? DateFormat('dd-MM-yyyy')
      : DateFormat('dd/MM/yyyy');
  DateTime d = formatter.parse(date);
  return d;
}

String strDateLong(String value) {
  var date = strTodate(value);
  String converted = DateFormat.yMMMd().format(date);
  return converted;
}

String strDateLongFr(String value) {
  var date = strTodate(value);
  String converted = DateFormat.yMMMd("fr_FR").format(date);
  return converted;
}
